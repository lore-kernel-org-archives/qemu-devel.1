Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dYViA-0001Ol-03
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dYVi5-0003Ht-4H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dYVi4-0003HU-UR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:03:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7D35883A5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 10:53:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170721060338.GA1595@pxdev.xzpeter.org> (Peter Xu's message of
	"Fri, 21 Jul 2017 14:03:38 +0800")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-18-quintela@redhat.com>
	<20170721060338.GA1595@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Fri, 21 Jul 2017 12:53:47 +0200
Message-ID: <87inimhxhg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 17/17] migration: Flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jul 17, 2017 at 03:42:38PM +0200, Juan Quintela wrote:
>> Each time that we sync the bitmap, it is a possiblity that we receive
>> a page that is being processed by a different thread.  We fix this
>> problem just making sure that we wait for all receiving threads to
>> finish its work before we procedeed with the next stage.
>> 
>> We are low on page flags, so we use a combination that is not valid to
>> emit that message:  MULTIFD_PAGE and COMPRESSED.
>
> Btw, would it be possible that we introduce a new QEMU_VM_COMMAND for
> this flush operation?  Like: MIG_CMD_MULTIFD_FLUSH?

>From the commit message:

> I tried to make a migration command for it, but it don't work because
> we sync the bitmap sometimes when we have already sent the beggining
> of the section, so I just added a new page flag.

Yeap, I found that much better dessign, but without further surgery, it
is not trivial.  There are two places where we can sync the bitmap, and
in one of them, we have already sent the beggining of the section, so
too late to send a command.

Later, Juan.
