Received: from eggs.gnu.org ([2001:4830:134:3::10]:43840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwjjQ-0004kh-Bl
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwjjM-0002NR-Et
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:57:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwjjM-0002NA-7y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE17C8575B
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 07:57:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-4-peterx@redhat.com>
	<87pnxv9gkn.fsf@dusky.pond.sub.org>
Date: Mon, 03 Sep 2018 09:56:58 +0200
In-Reply-To: <87pnxv9gkn.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 03 Sep 2018 09:38:00 +0200")
Message-ID: <874lf79fp1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/7] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

One more thing: we need test coverage for "suspend on full queue, resume
when the logjam clears".  qmp-test.c got the building blocks.  Something
like this:

    send_cmd_that_blocks() eight times
    send_oob_cmd_that_fails()
    unblock_blocked_cmd()
    recv_cmd_id() for the 1st in-band command
    recv_cmd_id() for the oob command
    unblock_blocked_cmd()
    recv_cmd_id() for the 2nd in-band command
    ... repeat for the remaining six in-band commands ...
