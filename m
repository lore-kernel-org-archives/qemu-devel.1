Received: from eggs.gnu.org ([2001:4830:134:3::10]:51451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwp5Q-00054G-Fg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwp5N-0007qK-AN
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:40:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fwp5N-0007q6-4l
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:40:09 -0400
Date: Mon, 3 Sep 2018 15:40:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180903154000.5efe1e57@redhat.com>
In-Reply-To: <20180829153624.12299-5-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/20] memory-device:
 get_region_size()/get_plugged_size() might fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

On Wed, 29 Aug 2018 17:36:08 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's properly forward the error, so errors from get_region_size() /
> get_plugged_size(), can be handled.
> 
> Users right now call both functions after the device has been realized,
> which is guaranteed to no fail (we'll document this behavior in a
> follow-up patch).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c         | 6 +++---
>  hw/mem/pc-dimm.c               | 5 +++--
>  include/hw/mem/memory-device.h | 4 ++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 0d9892b715..d87599c280 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -60,7 +60,7 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
>          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
>  
>          if (dev->realized) {
> -            *size += mdc->get_region_size(md);
> +            *size += mdc->get_region_size(md, &error_abort);
>          }
>      }
>  
> @@ -167,7 +167,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>          uint64_t md_size, md_addr;
>  
>          md_addr = mdc->get_addr(md);
> -        md_size = mdc->get_region_size(md);
> +        md_size = mdc->get_region_size(md, &error_abort);
s/error_abort/errp/, so it won't crash on hotplug?

>          if (*errp) {
>              goto out;
is this ever reachable?

>          }
> @@ -233,7 +233,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
>          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
>  
>          if (dev->realized) {
> -            *size += mdc->get_plugged_size(md);
> +            *size += mdc->get_plugged_size(md, &error_abort);
>          }
>      }
>  
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index fb6bcaedc4..4bf1a0acc9 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -236,14 +236,15 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>      return dimm->addr;
>  }
>  
> -static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
> +static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
> +                                           Error **errp)
>  {
>      /* dropping const here is fine as we don't touch the memory region */
>      PCDIMMDevice *dimm = PC_DIMM(md);
>      const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
>      MemoryRegion *mr;
>  
> -    mr = ddc->get_memory_region(dimm, &error_abort);
> +    mr = ddc->get_memory_region(dimm, errp);
>      if (!mr) {
>          return 0;
>      }
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 2853b084b5..f02b229837 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -33,8 +33,8 @@ typedef struct MemoryDeviceClass {
>      InterfaceClass parent_class;
>  
>      uint64_t (*get_addr)(const MemoryDeviceState *md);
> -    uint64_t (*get_plugged_size)(const MemoryDeviceState *md);
> -    uint64_t (*get_region_size)(const MemoryDeviceState *md);
> +    uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
> +    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
>      void (*fill_device_info)(const MemoryDeviceState *md,
>                               MemoryDeviceInfo *info);
>  } MemoryDeviceClass;
