Received: from eggs.gnu.org ([2001:4830:134:3::10]:60911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYukf-0005bG-Pw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYuka-0007pr-Rb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:51:57 -0400
Date: Fri, 29 Jun 2018 16:51:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180629165146.424b93da@redhat.com>
In-Reply-To: <20180628121417.1980-4-david@redhat.com>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] pc: drop memory region alignment
 check for 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 28 Jun 2018 14:14:16 +0200
David Hildenbrand <david@redhat.com> wrote:

> All applicable memory regions always have an alignment > 0. All memory
> backends result in file_ram_alloc() or qemu_anon_ram_alloc() getting
> called, setting the alignment to > 0.
> 
> So a PCDIMM memory region always has an alignment > 0. NVDIMM copy the
> alignment of the original memory memory region into the handcrafted memory
> region that will be used at this place.
> 
> So the check for 0 can be dropped and we can reduce the special
> handling.
> 
> Dropping this check makes factoring out of alignment handling easier as
> compat handling only has to look at pcmc->enforce_aligned_dimm and not
> care about the alignment of the memory region.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bf986baf91..934b7155b1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1712,7 +1712,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>      uint64_t align = TARGET_PAGE_SIZE;
>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>  
> -    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
> +    if (pcmc->enforce_aligned_dimm) {
>          align = memory_region_get_alignment(mr);
>      }
>  
