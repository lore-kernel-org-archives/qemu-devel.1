Received: from eggs.gnu.org ([2001:4830:134:3::10]:48575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyNtS-0007bX-A9
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyNtO-0008Di-PZ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:02:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fyNtO-0008DW-Il
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:02:14 -0400
Date: Fri, 7 Sep 2018 17:02:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907170136-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535706305-118115-5-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-4-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-3-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-2-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 1/4] target-i386: introduce
 coalesced_pio kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Fri, Aug 31, 2018 at 05:05:02PM +0800, Peng Hao wrote:
> add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

I can merge ths together with q35 patch, but pls
get acks from kvm folks, to this end fix up
commit logs and subjects to match reality and repost.

> ---
>  accel/kvm/kvm-all.c       |  4 ++--
>  linux-headers/linux/kvm.h | 11 +++++++++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index eb7db92..4a3909d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -536,7 +536,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
>  
>          zone.addr = start;
>          zone.size = size;
> -        zone.pad = 0;
> +        zone.pio = 0;
>  
>          (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
>      }
> @@ -553,7 +553,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
>  
>          zone.addr = start;
>          zone.size = size;
> -        zone.pad = 0;
> +        zone.pio = 0;
>  
>          (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
>      }
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 98f389a..1cb0d41 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -420,13 +420,19 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 pio;
> +	};
>  };
>  
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 pio;
> +	};
>  	__u8  data[8];
>  };
>  
> @@ -949,6 +955,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_COALESCED_PIO 156
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 1.8.3.1

On Fri, Aug 31, 2018 at 05:05:03PM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  accel/kvm/kvm-all.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
>  include/exec/memory.h |  4 ++--
>  memory.c              |  4 ++--
>  3 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4a3909d..11d8d78 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -78,6 +78,7 @@ struct KVMState
>      int fd;
>      int vmfd;
>      int coalesced_mmio;
> +    int coalesced_pio;
>      struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
>      bool coalesced_flush_in_progress;
>      int vcpu_events;
> @@ -559,6 +560,45 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
>      }
>  }
>  
> +static void kvm_coalesce_pio_add(MemoryListener *listener,
> +                                MemoryRegionSection *section,
> +                                hwaddr start, hwaddr size)
> +{
> +    KVMState *s = kvm_state;
> +
> +    if (s->coalesced_pio) {
> +        struct kvm_coalesced_mmio_zone zone;
> +
> +        zone.addr = start;
> +        zone.size = size;
> +        zone.pio = 1;
> +
> +        (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
> +    }
> +}
> +
> +static void kvm_coalesce_pio_del(MemoryListener *listener,
> +                                MemoryRegionSection *section,
> +                                hwaddr start, hwaddr size)
> +{
> +    KVMState *s = kvm_state;
> +
> +    if (s->coalesced_pio) {
> +        struct kvm_coalesced_mmio_zone zone;
> +
> +        zone.addr = start;
> +        zone.size = size;
> +        zone.pio = 1;
> +
> +        (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
> +     }
> +}
> +
> +static MemoryListener kvm_coalesced_pio_listener = {
> +    .coalesced_io_add = kvm_coalesce_pio_add,
> +    .coalesced_io_del = kvm_coalesce_pio_del,
> +};
> +
>  int kvm_check_extension(KVMState *s, unsigned int extension)
>  {
>      int ret;
> @@ -1615,6 +1655,8 @@ static int kvm_init(MachineState *ms)
>      }
>  
>      s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
> +    s->coalesced_pio = s->coalesced_mmio &&
> +                       kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
>  
>  #ifdef KVM_CAP_VCPU_EVENTS
>      s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
> @@ -1687,13 +1729,15 @@ static int kvm_init(MachineState *ms)
>          s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
>          s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
>      }
> -    s->memory_listener.listener.coalesced_mmio_add = kvm_coalesce_mmio_region;
> -    s->memory_listener.listener.coalesced_mmio_del = kvm_uncoalesce_mmio_region;
> +    s->memory_listener.listener.coalesced_io_add = kvm_coalesce_mmio_region;
> +    s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
>  
>      kvm_memory_listener_register(s, &s->memory_listener,
>                                   &address_space_memory, 0);
>      memory_listener_register(&kvm_io_listener,
>                               &address_space_io);
> +    memory_listener_register(&kvm_coalesced_pio_listener,
> +                             &address_space_io);
>  
>      s->many_ioeventfds = kvm_check_many_ioeventfds();
>  
> @@ -1775,8 +1819,13 @@ void kvm_flush_coalesced_mmio_buffer(void)
>              struct kvm_coalesced_mmio *ent;
>  
>              ent = &ring->coalesced_mmio[ring->first];
> -
> -            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
> +            if (ent->pio == 1) {
> +                address_space_rw(&address_space_io, ent->phys_addr,
> +                                 MEMTXATTRS_UNSPECIFIED, ent->data,
> +                                 ent->len, true);
> +            } else {
> +                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
> +            }
>              smp_wmb();
>              ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
>          }
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 448d41a..4600fa3 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -410,9 +410,9 @@ struct MemoryListener {
>                          bool match_data, uint64_t data, EventNotifier *e);
>      void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
>                          bool match_data, uint64_t data, EventNotifier *e);
> -    void (*coalesced_mmio_add)(MemoryListener *listener, MemoryRegionSection *section,
> +    void (*coalesced_io_add)(MemoryListener *listener, MemoryRegionSection *section,
>                                 hwaddr addr, hwaddr len);
> -    void (*coalesced_mmio_del)(MemoryListener *listener, MemoryRegionSection *section,
> +    void (*coalesced_io_del)(MemoryListener *listener, MemoryRegionSection *section,
>                                 hwaddr addr, hwaddr len);
>      /* Lower = earlier (during add), later (during del) */
>      unsigned priority;
> diff --git a/memory.c b/memory.c
> index e9cd446..8b0311e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2126,7 +2126,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
>                  .size = fr->addr.size,
>              };
>  
> -            MEMORY_LISTENER_CALL(as, coalesced_mmio_del, Reverse, &section,
> +            MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section,
>                                   int128_get64(fr->addr.start),
>                                   int128_get64(fr->addr.size));
>              QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
> @@ -2137,7 +2137,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
>                      continue;
>                  }
>                  tmp = addrrange_intersection(tmp, fr->addr);
> -                MEMORY_LISTENER_CALL(as, coalesced_mmio_add, Forward, &section,
> +                MEMORY_LISTENER_CALL(as, coalesced_io_add, Forward, &section,
>                                       int128_get64(tmp.start),
>                                       int128_get64(tmp.size));
>              }
> -- 
> 1.8.3.1

On Fri, Aug 31, 2018 at 05:05:04PM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/timer/mc146818rtc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6f1f723..b19ef51 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -70,6 +70,7 @@ typedef struct RTCState {
>      ISADevice parent_obj;
>  
>      MemoryRegion io;
> +    MemoryRegion coalesced_io;
>      uint8_t cmos_data[128];
>      uint8_t cmos_index;
>      int32_t base_year;
> @@ -990,6 +991,13 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
>      isa_register_ioport(isadev, &s->io, base);
>  
> +    /* register rtc 0x70 port as coalesced_pio */
> +    memory_region_set_flush_coalesced(&s->io);
> +    memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
> +                          s, "rtc1", 1);
> +    isa_register_ioport(isadev, &s->coalesced_io, base);
> +    memory_region_add_coalescing(&s->coalesced_io, 0, 1);
> +
>      qdev_set_legacy_instance_id(dev, base, 3);
>      qemu_register_reset(rtc_reset, s);
>  
> -- 
> 1.8.3.1

On Fri, Aug 31, 2018 at 05:05:05PM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/pci-host/piix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e60834..da73743 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -327,6 +327,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
>  
>      sysbus_add_io(sbd, 0xcfc, &s->data_mem);
>      sysbus_init_ioports(sbd, 0xcfc, 4);
> +
> +    /* register i440fx 0xcf8 port as coalesced pio */
> +    memory_region_set_flush_coalesced(&s->data_mem);
> +    memory_region_add_coalescing(&s->conf_mem, 0, 4);
>  }
>  
>  static void i440fx_realize(PCIDevice *dev, Error **errp)
> -- 
> 1.8.3.1
