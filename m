Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eWpQL-0005dy-KB
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eWpQG-0007Cw-L4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:14:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1eWpQG-0007C8-EO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:14:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AE35C0587FC
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 20:13:59 +0000 (UTC)
References: <20180103183336.27709-1-dgilbert@redhat.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <5237fe93-dc8e-7f78-468d-d5214f09463b@redhat.com>
Date: Wed, 3 Jan 2018 14:13:54 -0600
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, quintela@redhat.com
Cc: peterx@redhat.com



On 01/03/2018 12:33 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This code has an optimised, word aligned version, and a boring
> unaligned version. My commit f70d345 fixed one alignment issue, but
> there's another.
> 
> The optimised version operates on 'longs' dealing with (typically) 64
> pages at a time, replacing the whole long by a 0 and counting the bits.
> If the Ramblock is less than 64bits in length that long can contain bits
> representing two different RAMBlocks, but the code will update the
> bmap belinging to the 1st RAMBlock only while having updated the total
> dirty page count for both.
> 
> This probably didn't matter prior to 6b6712ef which split the dirty
> bitmap by RAMBlock, but now they're separate RAMBlocks we end up
> with a count that doesn't match the state in the bitmaps.
> 
> Symptom:
>   Migration showing a few dirty pages left to be sent constantly
>   Seen on aarch64 and x86 with x86+ovmf
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Wei Huang <wei@redhat.com>
> Fixes: 6b6712efccd383b48a909bee0b29e079a57601ec

This solves the failure I saw in the migration test case.

Acked-by: Wei Huang <wei@redhat.com>

> ---
>  include/exec/ram_addr.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 6cbc02aa0f..7633ef6342 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -391,9 +391,10 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
>  
> -    /* start address is aligned at the start of a word? */
> +    /* start address and length is aligned at the start of a word? */
>      if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
> -         (start + rb->offset)) {
> +         (start + rb->offset) &&
> +        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
>          int k;
>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>          unsigned long * const *src;
> 
