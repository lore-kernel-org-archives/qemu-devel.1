Received: from eggs.gnu.org ([2001:4830:134:3::10]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmpDr-00014C-8c
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 19:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmpDn-0007xt-6T
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 19:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fmpDm-0007wc-SW
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 19:47:31 -0400
Date: Mon, 6 Aug 2018 20:47:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180806234726.GA4465@localhost.localdomain>
References: <1531360857-32374-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531360857-32374-1-git-send-email-wanpengli@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target-i386: coalesced PIO support for
 RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>

Hi,

On Thu, Jul 12, 2018 at 10:00:57AM +0800, Wanpeng Li wrote:
> From: Peng Hao <peng.hao2@zte.com.cn>
>=20
> Windows I/O, such as the real-time clock. The address register (port
> 0x70 in the RTC case) can use coalesced I/O, cutting the number of
> userspace exits by half when reading or writing the RTC.
>=20
> Guest access rtc like this: write register index to 0x70, then write or=
=20
> read data from 0x71. writing 0x70 port is just as index and do nothing=20
> else. So we can use coalesced mmio to handle this scene to reduce VM-EX=
IT=20
> time.
>=20
> In our environment, 12 windows guest running on a Skylake server:
>=20
> Before patch:
>=20
> IO Port Access  Samples  Samples%   Time%    Avg time
>=20
> 0x70:POUT        20675    46.04%    92.72%   67.15us ( +-   7.93% )
>=20
> After patch:
>=20
> IO Port Access  Samples  Samples%   Time%    Avg time
>=20
> 0x70:POUT        17509    45.42%    42.08%   6.37us ( +-  20.37% )
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Thanks for the patch, and sorry for taking so long to review it.
Comments below:


> ---
> v1 -> v2:
>  * add the original author
>=20
>  accel/kvm/kvm-all.c       | 56 +++++++++++++++++++++++++++++++++++++++=
++++----
>  hw/timer/mc146818rtc.c    |  8 +++++++
>  include/exec/memattrs.h   |  1 +
>  include/exec/memory.h     |  5 +++++
>  include/sysemu/kvm.h      |  8 +++++++
>  linux-headers/linux/kvm.h |  5 +++--
>  memory.c                  |  5 +++++
>  7 files changed, 82 insertions(+), 6 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index eb7db92..7a12341 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -128,6 +128,7 @@ bool kvm_direct_msi_allowed;
>  bool kvm_ioeventfd_any_length_allowed;
>  bool kvm_msi_use_devid;
>  static bool kvm_immediate_exit;
> +bool kvm_coalesced_pio_allowed;

I suggest following the same pattern used for coalesced MMIO: a
KVMState::coalesced_pio field.

> =20
>  static const KVMCapabilityInfo kvm_required_capabilites[] =3D {
>      KVM_CAP_INFO(USER_MEMORY),
> @@ -536,7 +537,7 @@ static void kvm_coalesce_mmio_region(MemoryListener=
 *listener,
> =20
>          zone.addr =3D start;
>          zone.size =3D size;
> -        zone.pad =3D 0;
> +        zone.pio =3D 0;

I'm not sure the KVM header update will really be done in a way
that would break existing code (see Radim's reply on the KVM
patch).  But if this happens, please do the header update in a
separate patch, and implement PIO coalescing in another one.
This makes the patches easier to review.


> =20
>          (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
>      }
> @@ -553,7 +554,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListen=
er *listener,
> =20
>          zone.addr =3D start;
>          zone.size =3D size;
> -        zone.pad =3D 0;
> +        zone.pio =3D 0;
> =20
>          (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
>      }
> @@ -877,6 +878,45 @@ static void kvm_io_ioeventfd_del(MemoryListener *l=
istener,
>      }
>  }
> =20
> +static void kvm_coalesce_io_add(MemoryListener *listener,
> +                                MemoryRegionSection *section,
> +                                hwaddr start, hwaddr size)
> +{
> +    KVMState *s =3D kvm_state;
> +
> +    if (kvm_coalesced_pio_allowed) {
> +        struct kvm_coalesced_mmio_zone zone;
> +
> +        zone.addr =3D start;
> +        zone.size =3D size;
> +        zone.pio =3D 1;
> +
> +        (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
> +    }
> +}
> +
> +static void kvm_coalesce_io_del(MemoryListener *listener,
> +                                MemoryRegionSection *section,
> +                                hwaddr start, hwaddr size)
> +{
> +    KVMState *s =3D kvm_state;
> +
> +    if (kvm_coalesced_pio_allowed) {
> +        struct kvm_coalesced_mmio_zone zone;
> +
> +        zone.addr =3D start;
> +        zone.size =3D size;
> +        zone.pio =3D 1;
> +
> +        (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
> +    }
> +}
> +
> +static MemoryListener kvm_coalesced_io_listener =3D {
> +    .coalesced_mmio_add =3D kvm_coalesce_io_add,
> +    .coalesced_mmio_del =3D kvm_coalesce_io_del,
> +    .priority =3D 10,

Why exactly we need .priority=3D10 here?  Maybe this could be
explained in a comment?  (Or even better, by macros that explain
the priority levels?)


> +};
>  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>                                    AddressSpace *as, int as_id)
>  {
> @@ -1615,6 +1655,8 @@ static int kvm_init(MachineState *ms)
>      }
> =20
>      s->coalesced_mmio =3D kvm_check_extension(s, KVM_CAP_COALESCED_MMI=
O);
> +    kvm_coalesced_pio_allowed =3D s->coalesced_mmio &&
> +                        kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
> =20
>  #ifdef KVM_CAP_VCPU_EVENTS
>      s->vcpu_events =3D kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
> @@ -1694,6 +1736,8 @@ static int kvm_init(MachineState *ms)
>                                   &address_space_memory, 0);
>      memory_listener_register(&kvm_io_listener,
>                               &address_space_io);
> +    memory_listener_register(&kvm_coalesced_io_listener,
> +                             &address_space_io);
> =20
>      s->many_ioeventfds =3D kvm_check_many_ioeventfds();
> =20
> @@ -1775,8 +1819,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
>              struct kvm_coalesced_mmio *ent;
> =20
>              ent =3D &ring->coalesced_mmio[ring->first];
> -
> -            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->=
len);
> +            if (ent->pio) {
> +                address_space_rw(&address_space_io, ent->phys_addr,
> +                                 MEMTXATTRS_NONE, ent->data, ent->len,=
 true);
> +            } else {
> +                cpu_physical_memory_write(ent->phys_addr, ent->data, e=
nt->len);
> +            }

If the coalesced_mmio structs are going to be reused for PIO too,
I would suggest renaming them to "coalesced_io" to avoid
confusion.


>              smp_wmb();
>              ring->first =3D (ring->first + 1) % KVM_COALESCED_MMIO_MAX=
;
>          }
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6f1f723..8bd8682 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -70,6 +70,7 @@ typedef struct RTCState {
>      ISADevice parent_obj;
> =20
>      MemoryRegion io;
> +    MemoryRegion coalesced_io;
>      uint8_t cmos_data[128];
>      uint8_t cmos_index;
>      int32_t base_year;
> @@ -990,6 +991,13 @@ static void rtc_realizefn(DeviceState *dev, Error =
**errp)
>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
>      isa_register_ioport(isadev, &s->io, base);
> =20
> +    if (memory_allow_coalesced_pio()) {
> +        memory_region_set_flush_coalesced(&s->io);
> +        memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
> +                              s, "rtc1", 1);
> +        isa_register_ioport(isadev, &s->coalesced_io, base);
> +        memory_region_add_coalescing(&s->coalesced_io, 0, 1);
> +    }

[1]

Why is the memory_allow_coalesced_pio() call needed?  Won't the
coalesced memory regions be simply ignored if coalesced PIO is
unavailable on the host?

All the existing users of memory_region_add_coalescing() and
memory_region_set_flush_coalesced() seem to be unconditional, why
these ones need to be conditional?

I also suggest moving the RTC device changes to a separate patch,
so this patch could be split in 3 parts:

1/3: header update
2/3: new coalesced PIO API
3/3: use coalesced PIO support in RTC


>      qdev_set_legacy_instance_id(dev, base, 3);
>      qemu_register_reset(rtc_reset, s);
> =20
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d4a1642..97884d8 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -45,6 +45,7 @@ typedef struct MemTxAttrs {
>   * from "didn't specify" if necessary).
>   */
>  #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified =3D 1 })
> +#define MEMTXATTRS_NONE ((MemTxAttrs) { 0 })

Another reason to move the header updates to a separate patch.

> =20
>  /* New-style MMIO accessors can indicate that the transaction failed.
>   * A zero (MEMTX_OK) response means success; anything else is a failur=
e
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 448d41a..2854907 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1405,6 +1405,11 @@ void memory_region_set_flush_coalesced(MemoryReg=
ion *mr);
>  void memory_region_clear_flush_coalesced(MemoryRegion *mr);
> =20
>  /**
> + * memory_allow_coalesced_pio: Check whether coalesced pio allowed.
> + */
> +bool memory_allow_coalesced_pio(void);

See above[1].  I don't see why this function is necessary.


> +
> +/**
>   * memory_region_clear_global_locking: Declares that access processing=
 does
>   *                                     not depend on the QEMU global l=
ock.
>   *
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0b64b8e..08366b2 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -45,6 +45,7 @@ extern bool kvm_readonly_mem_allowed;
>  extern bool kvm_direct_msi_allowed;
>  extern bool kvm_ioeventfd_any_length_allowed;
>  extern bool kvm_msi_use_devid;
> +extern bool kvm_coalesced_pio_allowed;
> =20
>  #define kvm_enabled()           (kvm_allowed)
>  /**
> @@ -167,6 +168,12 @@ extern bool kvm_msi_use_devid;
>   */
>  #define kvm_msi_devid_required() (kvm_msi_use_devid)
> =20
> +/**
> + * kvm_coalesced_pio_enabled:
> + * Returns: true if KVM allow coalesced pio
> + */
> +#define kvm_coalesced_pio_enabled() (kvm_coalesced_pio_allowed)

See [1].


> +
>  #else
> =20
>  #define kvm_enabled()           (0)
> @@ -184,6 +191,7 @@ extern bool kvm_msi_use_devid;
>  #define kvm_direct_msi_enabled() (false)
>  #define kvm_ioeventfd_any_length_enabled() (false)
>  #define kvm_msi_devid_required() (false)
> +#define kvm_coalesced_pio_enabled() (false)
> =20
>  #endif  /* CONFIG_KVM_IS_POSSIBLE */
> =20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 98f389a..747b473 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -420,13 +420,13 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	__u32 pio;
>  };
> =20
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> -	__u32 pad;
> +	__u32 pio;
>  	__u8  data[8];
>  };
> =20
> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_COALESCED_PIO 156
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> diff --git a/memory.c b/memory.c
> index e9cd446..4a32817 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2211,6 +2211,11 @@ void memory_region_clear_global_locking(MemoryRe=
gion *mr)
>      mr->global_locking =3D false;
>  }
> =20
> +bool memory_allow_coalesced_pio(void)
> +{
> +    return kvm_enabled() && kvm_coalesced_pio_enabled();
> +}

See [1].

> +
>  static bool userspace_eventfd_warning;
> =20
>  void memory_region_add_eventfd(MemoryRegion *mr,
> --=20
> 2.7.4
>=20

--=20
Eduardo
