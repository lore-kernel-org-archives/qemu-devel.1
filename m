Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dABv5-0000DN-7k
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dABv1-0003do-30
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:03:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dABv0-0003bI-Re
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:03:55 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-3-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c4a5786-0ac0-4e25-9398-cd233dce7c17@redhat.com>
Date: Mon, 15 May 2017 11:03:49 +0200
MIME-Version: 1.0
In-Reply-To: <1494838260-30439-3-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] exec: rename resolve_subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>



On 15/05/2017 10:50, Peter Xu wrote:
> It is not easy for people to know "what this parameter does" before
> knowing "what is subpage". Let's use "is_mmio" to make it easier to
> understand.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Maybe invert the direction and call it for_iotlb?

Paolo

> ---
>  exec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 1d76c63..0adae94 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -403,7 +403,7 @@ bool memory_region_is_unassigned(MemoryRegion *mr)
>  /* Called from RCU critical section */
>  static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
>                                                          hwaddr addr,
> -                                                        bool resolve_subpage)
> +                                                        bool is_mmio)
>  {
>      MemoryRegionSection *section = atomic_read(&d->mru_section);
>      subpage_t *subpage;
> @@ -416,7 +416,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
>          section = phys_page_find(d, addr);
>          update = true;
>      }
> -    if (resolve_subpage && section->mr->subpage) {
> +    if (is_mmio && section->mr->subpage) {
>          subpage = container_of(section->mr, subpage_t, iomem);
>          section = &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
>      }
> @@ -429,13 +429,13 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
>  /* Called from RCU critical section */
>  static MemoryRegionSection *
>  address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *xlat,
> -                                 hwaddr *plen, bool resolve_subpage)
> +                                 hwaddr *plen, bool is_mmio)
>  {
>      MemoryRegionSection *section;
>      MemoryRegion *mr;
>      Int128 diff;
>  
> -    section = address_space_lookup_region(d, addr, resolve_subpage);
> +    section = address_space_lookup_region(d, addr, is_mmio);
>      /* Compute offset within MemoryRegionSection */
>      addr -= section->offset_within_address_space;
>  
> 
