Received: from eggs.gnu.org ([2001:4830:134:3::10]:51342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faFDF-0005Ff-Ql
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faFDC-0000ic-OG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:54:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faFDC-0000iU-J6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1A9D40122BF
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:54:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-17-armbru@redhat.com>
	<20180703062055.GR2455@xz-mi>
Date: Tue, 03 Jul 2018 08:54:48 +0200
In-Reply-To: <20180703062055.GR2455@xz-mi> (Peter Xu's message of "Tue, 3 Jul
	2018 14:20:55 +0800")
Message-ID: <87sh504xmv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/32] tests/qmp-test: Demonstrate QMP
 errors jumping the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jul 02, 2018 at 06:22:02PM +0200, Markus Armbruster wrote:
>> When OOB is enabled, out-of-band commands are executed right away,
>> everything else is queued.  This lets out-of-band commands "jump the
>> queue".
>> 
>> However, certain errors are always reported right away, and therefore
>> can jump the queue even when the erroneous input does not request
>> out-of-band execution.  These errors are pretty unlikely to occur in
>> production, but it's wrong all the same.  Mark FIXME.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  monitor.c        | 1 +
>>  tests/qmp-test.c | 7 +++++++
>>  2 files changed, 8 insertions(+)
>> 
>> diff --git a/monitor.c b/monitor.c
>> index 51ba1485ad..28fa9b8d44 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4338,6 +4338,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>>      return;
>>  
>>  err:
>> +    /* FIXME overtakes queued in-band commands, wrong when !qmp_is_oob() */
>>      monitor_qmp_respond(mon, NULL, err, NULL);
>>      qobject_unref(req);
>>  }
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index dc30930201..fe5e5b548a 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -239,6 +239,13 @@ static void test_qmp_oob(void)
>>      unblock_blocked_cmd();
>>      recv_cmd_id(qts, "ib-blocks-1");
>>      recv_cmd_id(qts, "ib-quick-1");
>> +
>> +    /* FIXME certain in-band errors overtake slow in-band command */
>> +    send_cmd_that_blocks(qts, "blocks-2");
>> +    qtest_async_qmp(qts, "{ 'id': 'err-2' }");
>> +    recv_cmd_id(qts, NULL);
>
> (I thought the "id" will be passed in when reply with the error,
>  though in fact it's not)

It will be after the next patch :)

> Thanks for the test case.  I'll work upon it when fixing that up.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>> +    unblock_blocked_cmd();
>> +    recv_cmd_id(qts, "blocks-2");
>>      cleanup_blocking_cmd();
>>  
>>      qtest_quit(qts);
>> -- 
>> 2.17.1
>> 
