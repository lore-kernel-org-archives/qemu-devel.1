Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa63Y-0008HW-2d
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa63U-0003R5-0y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:08:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa63T-0003Qj-QU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:08:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80E3E406E8CB
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 21:08:15 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1f4dfe6-fff5-84e6-eee7-6c45acd86bbe@redhat.com>
Date: Mon, 2 Jul 2018 16:08:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/32] qmp: Get rid of x-oob-test command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> tests/qmp-test tests an out-of-band command overtaking a slow in-band
> command.  To do that, it needs:
> 
> 1. An in-band command that *reliably* takes long enough to be
>     overtaken.
> 
> 2. An out-of-band command to do the overtaking.
> 
> 3. To avoid delays, a way to make the in-band command complete quickly
>     after it was overtaken.
> 
> To satisfy these needs, commit 469638f9cb3 provides the rather
> peculiar oob-capable QMP command x-oob-test:
> 
> * With "lock": true, it waits for a global semaphore.
> 
> * With "lock": false, it signals the global semaphore.
> 
> To satisfy 1., the test runs x-oob-test in-band with "lock": true.
> To satisfy 2. and 3., it runs x-oob-test out-of-band with "lock": false.
> 
> Note that waiting for a semaphore violates the rules for oob-capable
> commands.  Running x-oob-test with "lock": true hangs the monitor
> until you run x-oob-test with "lock": false on another monitor (which
> you might not have set up).
> 
> Having an externally visible QMP command that may hang the monitor is
> not nice.  Let's apply a little more ingenuity to the problem.  Idea:
> have an existing command block on reading a FIFO special file, unblock
> it by opening the FIFO for writing.
> 
> For 1., use
> 
>      {"execute": "blockdev-add",  "id": ID1,
>       "arguments": {
>          "driver": "blkdebug", "node-name": ID1, "config": FIFO,
>          "image": { "driver": "null-co"}}}

I like it!

> 
> where ID1 is an arbitrary string, and FIFO is the name of the FIFO.
> 
> For 2., use
> 
>      {"execute": "migrate-pause", "id": ID2, "control": {"run-oob": true}}
> 
> where ID2 is a different arbitrary string.  Since there's no migration
> to pause, the command will fail, but that's fine.

Maybe add:

that's fine, since instant failure is still a test of out-of-band 
responses overtaking in-band commands.

> 
> For 3., open FIFO for writing.
> 
> Drop QMP command x-oob-test.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/misc.json   | 18 ----------
>   qmp.c            | 16 ---------
>   tests/qmp-test.c | 93 ++++++++++++++++++++++++++++++++----------------
>   3 files changed, 63 insertions(+), 64 deletions(-)

And in about the same lines of code.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qmp-test.c
> @@ -135,16 +135,64 @@ static void test_qmp_protocol(void)
>       qtest_quit(qts);
>   }
>   
> -/* Tests for out-of-band support. */
> +/* Out-of-band tests */
> +
> +char tmpdir[] = "/tmp/qmp-test-XXXXXX";
> +char *fifo_name;
> +
> +static void setup_blocking_cmd(void)
> +{
> +    if (!mkdtemp(tmpdir)) {
> +        g_error("mkdtemp: %s", strerror(errno));
> +    }
> +    fifo_name = g_strdup_printf("%s/fifo", tmpdir);
> +    g_assert(!mkfifo(fifo_name, 0666));

g_assert() can be compiled out; should the side-effect mkfifo() call be 
done separately from asserting that its return code is expected?


> +
> +static void send_oob_cmd(QTestState *s, const char *id)
> +{
> +    qtest_async_qmp(s, "{ 'execute': 'migrate-pause', 'id': %s,"
> +                    "  'control': { 'run-oob': true } }", id);
> +}

Worth a comment here that we expect this to fail, and really only care 
that the response overtakes the in-band message?

With those nits addressed,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
