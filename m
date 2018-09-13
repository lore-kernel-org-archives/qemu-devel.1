Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0QVy-00030f-UN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0QVt-0002iB-6Q
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:14:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0QVp-0002aU-MV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:14:23 -0400
Date: Thu, 13 Sep 2018 14:14:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180913141409.1a86d7d4@redhat.com>
In-Reply-To: <20180829153624.12299-9-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/20] pc-dimm: implement memory device
 class function set_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 29 Aug 2018 17:36:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> Keep it simple for now and simply set the static property, that will
> fail once realized.
I'd merge this with previous patch and mention that set_addr will replace
'addr' property setting in the next patch where preliminary steps during
memory hotplug are factored out into _preplug handler

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/pc-dimm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index a208b17c64..d4e8a415bf 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -236,6 +236,12 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>      return dimm->addr;
>  }
>  
> +static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                                Error **errp)
> +{
> +    object_property_set_uint(OBJECT(md), addr, PC_DIMM_ADDR_PROP, errp);
> +}
> +
>  static uint64_t pc_dimm_md_get_plugged_size(const MemoryDeviceState *md,
>                                              Error **errp)
>  {
> @@ -307,6 +313,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
>      ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
>  
>      mdc->get_addr = pc_dimm_md_get_addr;
> +    mdc->set_addr = pc_dimm_md_set_addr;
>      mdc->get_plugged_size = pc_dimm_md_get_plugged_size;
>      mdc->get_memory_region = pc_dimm_md_get_memory_region;
>      mdc->fill_device_info = pc_dimm_md_fill_device_info;
