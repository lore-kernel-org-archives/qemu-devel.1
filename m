Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXAdM-0001OF-Br
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXAdI-0006fQ-EY
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:52:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXAdI-0006eh-8O
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 803079387B
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 18:52:50 +0000 (UTC)
Date: Thu, 4 Jan 2018 18:52:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180104185238.GB2635@work-vm>
References: <20180103183336.27709-1-dgilbert@redhat.com>
	<7f455464-a32b-b709-1e0e-70dd16274efe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f455464-a32b-b709-1e0e-70dd16274efe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpu_physical_memory_sync_dirty_bitmap:
 Another alignment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, wei@redhat.com, quintela@redhat.com, peterx@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 03/01/2018 19:33, Dr. David Alan Gilbert (git) wrote:
> > The optimised version operates on 'longs' dealing with (typically) 64
> > pages at a time, replacing the whole long by a 0 and counting the bits.
> > If the Ramblock is less than 64bits in length that long can contain bits
> > representing two different RAMBlocks, but the code will update the
> > bmap belinging to the 1st RAMBlock only while having updated the total
> > dirty page count for both.
> 
> The patch is obviously correct, but would it make sense also to align
> the RAMBlocks' initial ram_addr_t to a multiple of BITS_PER_LONG <<
> TARGET_PAGE_BITS?

Yes, I can do that as a separate patch.  The alignment starts getting
a little silly - say 4k target page, 64 bits long so aligning a 4k
RAMBlock to 256kb boundary - but I think it's OK.

Dave
P.S. I'd be careful of saying 'obviously correct' given how many small
fixes this function has had recently!

> Thanks,
> 
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
