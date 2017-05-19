Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBZ62-0000k9-Te
	for qemu-devel@nongnu.org; Fri, 19 May 2017 00:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBZ5z-00027y-SF
	for qemu-devel@nongnu.org; Fri, 19 May 2017 00:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBZ5z-00027j-Mv
	for qemu-devel@nongnu.org; Fri, 19 May 2017 00:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 578668046C
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:00:54 +0000 (UTC)
Date: Fri, 19 May 2017 12:00:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170519040048.GF15294@pxdev.xzpeter.org>
References: <20170517165810.18164-1-dgilbert@redhat.com>
	<20170517165810.18164-3-dgilbert@redhat.com>
	<87bmqrb7ui.fsf@secure.mitica> <20170518080833.GA2079@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518080833.GA2079@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/2] postcopy: Require RAMBlocks that are
 whole pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

On Thu, May 18, 2017 at 09:08:34AM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > It turns out that it's legal to create a VM with RAMBlocks that aren't
> > > a multiple of the pagesize in use; e.g. a 1025M main memory using
> > > 2M host pages.  That breaks postcopy's atomic placement of pages,
> > > so disallow it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Thanks
> 
> > >      }
> > >  
> > >      /* We don't support postcopy with shared RAM yet */
> > > -    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
> > > +    if (qemu_ram_foreach_block(test_ramblock_postcopiable, NULL)) {
> > 
> > When I was looking at this code, I still don't know why
> > qemu_ram_foreach_block() don't pass the block directly.  It needs it
> > almost all callers.
> > 
> > When I saw it I was about to change it, but got sidetracked on other
> > things :-p
> 
> I think originally it passed very little information at all, and
> that RAMBlocks were these mystical things no one outside exec.c
> was really supposed to know about.

(Yeah I got the same question before. That's why I got
 RAMBLOCK_FOREACH() but didn't use qemu_ram_foreach_block() since I
 need at least page size info for the block...)

-- 
Peter Xu
