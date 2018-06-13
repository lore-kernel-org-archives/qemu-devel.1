Received: from eggs.gnu.org ([2001:4830:134:3::10]:53997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT5YK-0006Xm-0m
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT5YG-0002NQ-Mi
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:11:07 -0400
Date: Wed, 13 Jun 2018 15:10:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613151056.6ebbccc2@redhat.com>
In-Reply-To: <20180611121655.19616-11-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/11] pc-dimm: introduce and use
 pc_dimm_memory_pre_plug()
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
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Jun 2018 14:16:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> We'll be factoring out some pc-dimm specific and some memory-device
> checks next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c             | 2 ++
>  hw/mem/pc-dimm.c         | 5 +++++
>  hw/ppc/spapr.c           | 1 +
>  include/hw/mem/pc-dimm.h | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 017396fe84..dc8e7b033b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1695,6 +1695,8 @@ static void pc_dimm_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
keeping                              ^^^^^
similar to newly introduced pc_dimm_memory_pre_plug()
and I have no clue what to suggest as alternative

>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>          return;
>      }
> +
> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  }
>  
>  static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index bc79dd04d8..995ce22d8d 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,6 +27,11 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
>  
> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
> +                             Error **errp)
> +{
> +}
why introducing shim without anything?
I'd just merge it with following patch and clarify (in commit message)
why the rest of pre_plug code isn't moved here as well.

>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 214286fd2f..54eddc0069 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3202,6 +3202,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          goto out;
>      }
>  
> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  out:
>      g_free(mem_dev);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index f0e6867803..7d46a0a0cb 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -80,6 +80,8 @@ typedef struct PCDIMMDeviceClass {
>  
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
>  
> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
> +                             Error **errp);
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
