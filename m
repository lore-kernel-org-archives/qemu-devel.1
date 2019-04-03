Received: from eggs.gnu.org ([209.51.188.92]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hBeLf-00004t-RG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hBeLZ-0002P4-DX
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:46:27 -0400
References: <20190401214847.27600-1-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <77d41944-2ed2-bcdd-c434-faea3ec28486@redhat.com>
Date: Wed, 3 Apr 2019 13:46:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190401214847.27600-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390: diagnose 318 info reset and
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com

On 01.04.19 23:48, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> be intercepted by SIE and handled via KVM. Let's introduce some
> functions to communicate between QEMU and KVM via ioctls. These
> will be used to get/set the diag318 related information (also known
> as the "Control Program Code" or "CPC"), as well as check the system
> if KVM supports handling this instruction.
>=20
> Diag318 must also be reset on a load normal and modified clear, so
> we use the set function (wrapped in a reset function) to explicitly
> set the diag318 info to 0 for these cases.
>=20
> Lastly, we want to ensure the diag318 info is migrated. The diag318
> info migration is handled via a VMStateDescription. This feature is
> only supported on QEMU machines 4.0 and later.

This has to become 4.1

>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>=20
> This version is posted in tandem with a new kernel patch that changes
> how the execution of the diag 0x318 instruction is handled. A link to
> this series will be attached as a reply to this series for convenience.
>=20
> Changelog:
>=20
>     v3
>         - removed CPU model code
>         - removed RSCPI and SCLP code
>         - reverted max cpus back to 248 (previous patches limited this
>             to 247)
>         - introduced VMStateDescription handlers for migration
>         - disabled migration of diag318 info for machines 3.1 and older
>             - a warning is printed if migration is disabled and KVM
>               supports handling this instruction
>=20
> ---
>  hw/s390x/s390-virtio-ccw.c   |  6 ++++
>  linux-headers/asm-s390/kvm.h |  4 +++
>  target/s390x/diag.c          | 63 ++++++++++++++++++++++++++++++++++++
>  target/s390x/internal.h      |  5 ++-
>  target/s390x/kvm-stub.c      | 15 +++++++++
>  target/s390x/kvm.c           | 32 ++++++++++++++++++
>  target/s390x/kvm_s390x.h     |  3 ++
>  7 files changed, 127 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b860..2a50868496 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -36,6 +36,7 @@
>  #include "cpu_models.h"
>  #include "hw/nmi.h"
>  #include "hw/s390x/tod.h"
> +#include "internal.h"
> =20
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -302,6 +303,8 @@ static void ccw_init(MachineState *machine)
> =20
>      /* init the TOD clock */
>      s390_init_tod();
> +
> +    diag318_register_migration();
>  }
> =20
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> @@ -352,6 +355,7 @@ static void s390_machine_reset(void)
>          }
>          subsystem_reset();
>          s390_crypto_reset();
> +        diag318_reset();

Shouldn't this go into subsystem_reset?

Aren't you missing resets during external/reipl resets?

Also, I was wondering if this would be worth creating a fake device like
diag288. The resets can be handled similar to diag288. Resets during
external/reipl reset would come natural.
> =20
>  static void ccw_machine_3_1_class_options(MachineClass *mc)
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.=
h
> index 0265482f8f..735f5a46e8 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>  #define KVM_S390_VM_CRYPTO		2
>  #define KVM_S390_VM_CPU_MODEL		3
>  #define KVM_S390_VM_MIGRATION		4
> +#define KVM_S390_VM_MISC		5
> =20
>  /* kvm attributes for mem_ctrl */
>  #define KVM_S390_VM_MEM_ENABLE_CMMA	0
> @@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
>  #define KVM_S390_VM_MIGRATION_START	1
>  #define KVM_S390_VM_MIGRATION_STATUS	2
> =20
> +/* kvm attributes for KVM_S390_VM_MISC */
> +#define KVM_S390_VM_MISC_CPC		0
> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  	/* general purpose regs for s390 */
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index aafa740f61..bbb151e3eb 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -20,6 +20,8 @@
>  #include "sysemu/cpus.h"
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
> +#include "kvm_s390x.h"
> +#include "sysemu/kvm.h"
> =20
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
> @@ -134,3 +136,64 @@ out:
>          break;
>      }
>  }
> +
> +typedef struct Diag318Data {
> +    uint64_t cpc;
> +} Diag318Data;
> +static Diag318Data diag318data;
> +
> +void diag318_reset(void)
> +{
> +    if (kvm_s390_has_diag318()) {
> +        kvm_s390_set_cpc(0);
> +    }
> +}
> +
> +static int diag318_post_load(void *opaque, int version_id)
> +{
> +    Diag318Data *d =3D opaque;
> +
> +    kvm_s390_set_cpc(d->cpc);
> +    return 0;
> +}
> +
> +static int diag318_pre_save(void *opaque)
> +{
> +    Diag318Data *d =3D opaque;
> +
> +    kvm_s390_get_cpc(&d->cpc);
> +    return 0;
> +}
> +
> +static bool diag318_needed(void *opaque)
> +{
> +    return kvm_s390_has_diag318();
> +}
> +
> +VMStateDescription vmstate_diag318 =3D {
> +    .name =3D "diag318",
> +    .post_load =3D diag318_post_load,
> +    .pre_save =3D diag318_pre_save,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .unmigratable =3D 0,
> +    .needed =3D diag318_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(cpc, Diag318Data),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +void diag318_register_migration(void)
> +{
> +    if (!vmstate_diag318.unmigratable)
> +        vmstate_register(NULL, 0, &vmstate_diag318, &diag318data);
> +    else if (kvm_s390_has_diag318())
> +        printf("warning: diag318 info lacks migration support, this da=
ta "
> +               "will be lost if migrated.\n");
> +}
> +
> +void diag318_disable_migration(void)
> +{
> +    vmstate_diag318.unmigratable =3D 1;
> +}

I somewhat dislike registering/unregistering vmstates manually here.
This would look better on an actual device. Opinions?

--=20

Thanks,

David / dhildenb
