Received: from eggs.gnu.org ([2001:4830:134:3::10]:49580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWqV6-0000kR-3M
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWqV2-0006In-2M
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWqV1-0006I8-SS
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:22:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13EB049035
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 21:22:59 +0000 (UTC)
References: <20180103183336.27709-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f455464-a32b-b709-1e0e-70dd16274efe@redhat.com>
Date: Wed, 3 Jan 2018 22:22:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180103183336.27709-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, wei@redhat.com, quintela@redhat.com
Cc: peterx@redhat.com

On 03/01/2018 19:33, Dr. David Alan Gilbert (git) wrote:
> The optimised version operates on 'longs' dealing with (typically) 64
> pages at a time, replacing the whole long by a 0 and counting the bits.
> If the Ramblock is less than 64bits in length that long can contain bits
> representing two different RAMBlocks, but the code will update the
> bmap belinging to the 1st RAMBlock only while having updated the total
> dirty page count for both.

The patch is obviously correct, but would it make sense also to align
the RAMBlocks' initial ram_addr_t to a multiple of BITS_PER_LONG <<
TARGET_PAGE_BITS?

Thanks,

Paolo
