Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg1Nj-000584-PG
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg1Nf-0006yP-IE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dg1Nf-0006xf-Cr
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 00:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C2AB34A6
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 04:17:01 +0000 (UTC)
Date: Fri, 11 Aug 2017 12:16:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170811041649.GG26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-20-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-20-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 19/19] migration: Flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Tue, Aug 08, 2017 at 06:26:29PM +0200, Juan Quintela wrote:
> Each time that we sync the bitmap, it is a possiblity that we receive
> a page that is being processed by a different thread.  We fix this
> problem just making sure that we wait for all receiving threads to
> finish its work before we procedeed with the next stage.
> 
> We are low on page flags, so we use a combination that is not valid to
> emit that message:  MULTIFD_PAGE and COMPRESSED.
> 
> I tried to make a migration command for it, but it don't work because
> we sync the bitmap sometimes when we have already sent the beggining
> of the section, so I just added a new page flag.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Oh, I just pop up an idea on whether we can just avoid introduing the
new flush command...

Can we just hash the page address into the channel number we send?
Then if we are sending the same page, it will always be on the same
channel. Since it's on the same channel, the order of arrival is also
deterministic.

It may affect performance, at least in two ways:

- it can be slower, considering we may need to wait on specific
  channel when send. But it may not be a big problem since we have a
  local IOV array buffer, then when the array buffer is full, the old
  send() should mostly be completed I guess.

- it can be faster, considering that we don't need the flush any more,
  so receiving is faster (no need to wait for all the channels to
  complete on flush).

Makes any sense?

-- 
Peter Xu
