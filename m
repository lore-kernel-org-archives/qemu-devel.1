Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAim-0000Qv-1V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAih-0004Lm-CV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:07:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAih-0004Ki-50
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:07:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEC1F4078430
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:07:06 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7937d217-0330-96cb-a325-b580550e64ec@redhat.com>
Date: Mon, 2 Jul 2018 21:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> When OOB is enabled, out-of-band commands are executed right away,
> everything else is queued.  This lets out-of-band commands "jump the
> queue".
> 
> However, certain errors are always reported right away, and therefore
> can jump the queue even when the erroneous input does not request
> out-of-band execution.  These errors are pretty unlikely to occur in
> production, but it's wrong all the same.  Mark FIXME.

Ouch.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c        | 1 +
>   tests/qmp-test.c | 7 +++++++
>   2 files changed, 8 insertions(+)
> 

> +++ b/tests/qmp-test.c
> @@ -239,6 +239,13 @@ static void test_qmp_oob(void)
>       unblock_blocked_cmd();
>       recv_cmd_id(qts, "ib-blocks-1");
>       recv_cmd_id(qts, "ib-quick-1");
> +
> +    /* FIXME certain in-band errors overtake slow in-band command */
> +    send_cmd_that_blocks(qts, "blocks-2");
> +    qtest_async_qmp(qts, "{ 'id': 'err-2' }");

Since this has neither 'execute' nor 'exec-oob', we can't state whether 
it is in-band or out-of-band; back-compatibility says it should be 
treated as in-band.

> +    recv_cmd_id(qts, NULL);
> +    unblock_blocked_cmd();
> +    recv_cmd_id(qts, "blocks-2");

Thus, it should have been queued until after blocks-2 completed.

Useful test.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
