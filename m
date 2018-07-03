Received: from eggs.gnu.org ([2001:4830:134:3::10]:41590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faERD-0008RD-Hg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faER8-0003et-7T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faER7-0003ec-SZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 600BEB5C7
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:05:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-6-armbru@redhat.com>
	<b1f4dfe6-fff5-84e6-eee7-6c45acd86bbe@redhat.com>
Date: Tue, 03 Jul 2018 08:05:11 +0200
In-Reply-To: <b1f4dfe6-fff5-84e6-eee7-6c45acd86bbe@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 16:08:14 -0500")
Message-ID: <87efgk7t2g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/32] qmp: Get rid of x-oob-test command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 11:21 AM, Markus Armbruster wrote:
>> tests/qmp-test tests an out-of-band command overtaking a slow in-band
>> command.  To do that, it needs:
>>
>> 1. An in-band command that *reliably* takes long enough to be
>>     overtaken.
>>
>> 2. An out-of-band command to do the overtaking.
>>
>> 3. To avoid delays, a way to make the in-band command complete quickly
>>     after it was overtaken.
>>
>> To satisfy these needs, commit 469638f9cb3 provides the rather
>> peculiar oob-capable QMP command x-oob-test:
>>
>> * With "lock": true, it waits for a global semaphore.
>>
>> * With "lock": false, it signals the global semaphore.
>>
>> To satisfy 1., the test runs x-oob-test in-band with "lock": true.
>> To satisfy 2. and 3., it runs x-oob-test out-of-band with "lock": false.
>>
>> Note that waiting for a semaphore violates the rules for oob-capable
>> commands.  Running x-oob-test with "lock": true hangs the monitor
>> until you run x-oob-test with "lock": false on another monitor (which
>> you might not have set up).
>>
>> Having an externally visible QMP command that may hang the monitor is
>> not nice.  Let's apply a little more ingenuity to the problem.  Idea:
>> have an existing command block on reading a FIFO special file, unblock
>> it by opening the FIFO for writing.
>>
>> For 1., use
>>
>>      {"execute": "blockdev-add",  "id": ID1,
>>       "arguments": {
>>          "driver": "blkdebug", "node-name": ID1, "config": FIFO,
>>          "image": { "driver": "null-co"}}}
>
> I like it!
>
>>
>> where ID1 is an arbitrary string, and FIFO is the name of the FIFO.
>>
>> For 2., use
>>
>>      {"execute": "migrate-pause", "id": ID2, "control": {"run-oob": true}}
>>
>> where ID2 is a different arbitrary string.  Since there's no migration
>> to pause, the command will fail, but that's fine.
>
> Maybe add:
>
> that's fine, since instant failure is still a test of out-of-band
> responses overtaking in-band commands.

Sold.

>>
>> For 3., open FIFO for writing.
>>
>> Drop QMP command x-oob-test.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/misc.json   | 18 ----------
>>   qmp.c            | 16 ---------
>>   tests/qmp-test.c | 93 ++++++++++++++++++++++++++++++++----------------
>>   3 files changed, 63 insertions(+), 64 deletions(-)
>
> And in about the same lines of code.

/me bows :)

> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/tests/qmp-test.c
>> @@ -135,16 +135,64 @@ static void test_qmp_protocol(void)
>>       qtest_quit(qts);
>>   }
>>   -/* Tests for out-of-band support. */
>> +/* Out-of-band tests */
>> +
>> +char tmpdir[] = "/tmp/qmp-test-XXXXXX";
>> +char *fifo_name;
>> +
>> +static void setup_blocking_cmd(void)
>> +{
>> +    if (!mkdtemp(tmpdir)) {
>> +        g_error("mkdtemp: %s", strerror(errno));
>> +    }
>> +    fifo_name = g_strdup_printf("%s/fifo", tmpdir);
>> +    g_assert(!mkfifo(fifo_name, 0666));
>
> g_assert() can be compiled out; should the side-effect mkfifo() call
> be done separately from asserting that its return code is expected?

We don't support compiling them out (see the note in osdep.h), but
you're right, we should do this properly.

>> +
>> +static void send_oob_cmd(QTestState *s, const char *id)
>> +{
>> +    qtest_async_qmp(s, "{ 'execute': 'migrate-pause', 'id': %s,"
>> +                    "  'control': { 'run-oob': true } }", id);
>> +}
>
> Worth a comment here that we expect this to fail, and really only care
> that the response overtakes the in-band message?

Yes.

> With those nits addressed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
