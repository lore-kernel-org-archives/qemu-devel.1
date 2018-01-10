Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGyc-0001Li-Ry
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGyU-0000FP-Pa
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:03:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZGyU-0000El-Gz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:03:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 928FE5D5EB
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:03:25 +0000 (UTC)
References: <20180105170138.23357-1-dgilbert@redhat.com>
	<20180105170138.23357-3-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <134955b3-3c5e-9c49-7af3-7f012cc738c8@redhat.com>
Date: Wed, 10 Jan 2018 15:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180105170138.23357-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] find_ram_offset: Align ram_addr_t
 allocation on long boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 05/01/2018 18:01, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The dirty bitmaps are built from 'long'sand there is fast-path code
> for synchronising the case where the RAMBlock is aligned to the start
> of a long boundary.  Align the allocation to this boundary
> to cause the fast path to be used.
> 
> Offsets before change:
> 11398@1515169675.018566:find_ram_offset size: 0x1e0000 @ 0x8000000
> 11398@1515169675.020064:find_ram_offset size: 0x20000 @ 0x81e0000
> 11398@1515169675.020244:find_ram_offset size: 0x20000 @ 0x8200000
> 11398@1515169675.024343:find_ram_offset size: 0x1000000 @ 0x8220000
> 11398@1515169675.025154:find_ram_offset size: 0x10000 @ 0x9220000
> 11398@1515169675.027682:find_ram_offset size: 0x40000 @ 0x9230000
> 11398@1515169675.032921:find_ram_offset size: 0x200000 @ 0x9270000
> 11398@1515169675.033307:find_ram_offset size: 0x1000 @ 0x9470000
> 11398@1515169675.033601:find_ram_offset size: 0x1000 @ 0x9471000
> 
> after change:
> 10923@1515169108.818245:find_ram_offset size: 0x1e0000 @ 0x8000000
> 10923@1515169108.819410:find_ram_offset size: 0x20000 @ 0x8200000
> 10923@1515169108.819587:find_ram_offset size: 0x20000 @ 0x8240000
> 10923@1515169108.823708:find_ram_offset size: 0x1000000 @ 0x8280000
> 10923@1515169108.824503:find_ram_offset size: 0x10000 @ 0x9280000
> 10923@1515169108.827093:find_ram_offset size: 0x40000 @ 0x92c0000
> 10923@1515169108.833045:find_ram_offset size: 0x200000 @ 0x9300000
> 10923@1515169108.833504:find_ram_offset size: 0x1000 @ 0x9500000
> 10923@1515169108.833787:find_ram_offset size: 0x1000 @ 0x9540000
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 7966570231..644603f05e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1694,6 +1694,11 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>              }
>          }
>  
> +        /* Align blocks to start on a 'long' in the bitmap
> +         * which makes the bitmap sync'ing take the fast path.
> +         */
> +        end = ROUND_UP(end, BITS_PER_LONG << TARGET_PAGE_BITS);

I think this should be done before the nested loop.  Otherwise, "next -
end" can become negative, which is always going to be >= size.  It's
also very large, so it's likely to fail the mingap test, but it's buggy
nevertheless.

In fact "end" could be renamed to "candidate" which explains more
clearly what's going on.  I'll post a v2 shortly...

Thanks,

Paolo


>          /* If it fits remember our place and remember the size
>           * of gap, but keep going so that we might find a smaller
>           * gap to fill so avoiding fragmentation.
> 
