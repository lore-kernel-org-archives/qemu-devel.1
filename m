Received: from eggs.gnu.org ([2001:4830:134:3::10]:45071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faGOs-0003r1-0R
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faGOr-0008QY-45
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:11:01 -0400
References: <20180702093755.7384-1-david@redhat.com>
	<20180702093755.7384-4-david@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <edd967e7-28f9-4d7f-564c-5343f69a663d@redhat.com>
Date: Tue, 3 Jul 2018 10:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180702093755.7384-4-david@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] pc: drop memory region alignment
 check for 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

Hi David,

On 07/02/2018 11:37 AM, David Hildenbrand wrote:
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
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
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
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
