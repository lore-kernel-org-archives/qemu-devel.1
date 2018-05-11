Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fHB1d-0000Ry-78
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fHB1Y-0005UL-8B
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:36:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fHB1Y-0005UB-3c
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A10400E9BA
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 16:36:03 +0000 (UTC)
Date: Fri, 11 May 2018 17:36:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180511163600.GF2720@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-12-quintela@redhat.com>
	<20180502180447.GM2679@work-vm> <87bmdp5bmv.fsf@secure.laptop>
	<20180509111258.GE2527@work-vm> <87h8ng394z.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8ng394z.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v12 11/21] migration: Create multifd packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >> > * Juan Quintela (quintela@redhat.com) wrote:
> >> > I think that needs validating to ensure that the source didn't
> >> > send us junk and cause us to overwrite after the end of block->host
> >> 
> >>         if (offset > block->used_length) {
> >>             error_setg(errp, "multifd: offest too long %" PRId64
> >>                        " (max %" PRId64 ")",
> >>                        offset, block->max_length);
> >>             return -1;
> >>         }
> >> ??
> >
> > It's probably  (offset + TARGET_PAGE_SIZE) that needs checking
> > but it needs doing in a wrap-safe way.
> >
> 
>         if ((offset + TARGET_PAGE_SIZE) < offset) {
>             error_setg(errp, "multifd: offset %" PRId64 " wraps around"
>                        " with offset: %" PRId64, offset, block->max_length);
>             return -1;
>         }
>         if ((offset + TARGET_PAGE_SIZE) > block->used_length) {
>             error_setg(errp, "multifd: offset too long %" PRId64
>                        " (max %" PRId64 ")",
>                        offset, block->max_length);
>             return -1;
>         }

How about:
   if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
    ....
   }
  (*assuming that block->used_length is always at least a
TARGET_PAGE_SIZE ?)

Dave

> Sometimes I wonder how is that we don't have
> 
> ramblock_contains_range(ramblock, start, size);
> 
> But well, c'est la vie.
> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
