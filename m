Received: from eggs.gnu.org ([2001:4830:134:3::10]:57852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fahzU-0001kt-8w
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fahzQ-0001Ja-7T
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:38:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fahzQ-0001J1-1y
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:38:36 -0400
References: <1530709942-87947-1-git-send-email-jingqi.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfe2a879-d038-f80f-cbec-ae247afde702@redhat.com>
Date: Wed, 4 Jul 2018 15:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <1530709942-87947-1-git-send-email-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: x86: Add support for -machine
 split-lock-ac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jingqi Liu <jingqi.liu@intel.com>
Cc: rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, "Hu, Robert" <robert.hu@intel.com>

On 04/07/2018 15:12, Jingqi Liu wrote:
> Add the option split-lock-ac to control whether the #AC
> exception is generated for split locked accesses, which
> is introduced for the machine, there is an example to enable it:
> -machine split-lock-ac=3Don
> It is disabled on default.
>=20
> When bit 29 of the MSR (33H) is set, the processor
> causes an #AC exception to be issued instead of suppressing LOCK on
> bus(during split lock access).

This should be a CPU feature, not a machine feature.  As mentioned in
the review of the kernel patch, please work with Robert to use the same
infrastructure for both MSR_TEST_CTL and MSR_IA32_ARCH_CAPABILITIES.

(Robert, does IceLake have this feature?  If so, we cannot create the
CPU model until everything is in place).

BTW, why is the availability of the feature not exposed with a CPUID
bit?  It doesn't make much sense.

Paolo

> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  accel/kvm/kvm-all.c       | 10 ++++++++++
>  hw/core/machine.c         | 19 +++++++++++++++++++
>  include/hw/boards.h       |  1 +
>  linux-headers/linux/kvm.h |  1 +
>  qemu-options.hx           |  3 +++
>  5 files changed, 34 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index eb7db92..e960a4d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1699,6 +1699,16 @@ static int kvm_init(MachineState *ms)
> =20
>      s->sync_mmu =3D !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_M=
MU);
> =20
> +    if (ms->split_lock_ac &&
> +        kvm_check_extension(s, KVM_CAP_X86_SPLIT_LOCK_AC)) {
> +        ret =3D kvm_vm_enable_cap(s, KVM_CAP_X86_SPLIT_LOCK_AC, 0);
> +        if (ret) {
> +            fprintf(stderr, "Could not enable the feature that #AC exc=
eption"
> +                    "will be generated for split lock accesses!\n");
> +            goto err;
> +        }
> +    }
> +
>      return 0;
> =20
>  err:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 617e5f8..e054119 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -350,6 +350,22 @@ static void machine_set_memory_encryption(Object *=
obj, const char *value,
>      ms->memory_encryption =3D g_strdup(value);
>  }
> =20
> +static void machine_set_split_lock_ac(Object *obj, bool value,
> +                                      Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    ms->split_lock_ac =3D value;
> +}
> +
> +static bool machine_get_split_lock_ac(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return ms->split_lock_ac;
> +}
> +
> +
>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const ch=
ar *type)
>  {
>      strList *item =3D g_new0(strList, 1);
> @@ -634,6 +650,9 @@ static void machine_class_init(ObjectClass *oc, voi=
d *data)
>          &error_abort);
>      object_class_property_set_description(oc, "memory-encryption",
>          "Set memory encyption object to use", &error_abort);
> +    object_class_property_add_bool(oc, "split-lock-ac",
> +        machine_get_split_lock_ac, machine_set_split_lock_ac,
> +        &error_abort);
>  }
> =20
>  static void machine_class_base_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 79069dd..9c1e2c0 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -256,6 +256,7 @@ struct MachineState {
>      bool suppress_vmdesc;
>      bool enforce_config_section;
>      bool enable_graphics;
> +    bool split_lock_ac;
>      char *memory_encryption;
>      DeviceMemoryState *device_memory;
> =20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 98f389a..4bfa879 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_X86_SPLIT_LOCK_AC 156
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 81b1e99..935cefe 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                nvdimm=3Don|off controls NVDIMM support (default=3D=
off)\n"
>      "                enforce-config-section=3Don|off enforce configura=
tion section migration (default=3Doff)\n"
>      "                s390-squash-mcss=3Don|off (deprecated) controls s=
upport for squashing into default css (default=3Doff)\n"
> +    "                split-lock-ac=3Don|off controls support #AC excep=
tion for split locked accesses (default=3Doff)\n"
>      "                memory-encryption=3D@var{} memory encryption obje=
ct to use (default=3Dnone)\n",
>      QEMU_ARCH_ALL)
>  STEXI
> @@ -113,6 +114,8 @@ NOTE: this parameter is deprecated. Please use @opt=
ion{-global}
>  @option{migration.send-configuration}=3D@var{on|off} instead.
>  @item memory-encryption=3D@var{}
>  Memory encryption object to use. The default is none.
> +@item split-lock-ac=3Don|off
> +Enables or disables #AC exception for split locked accesses.
>  @end table
>  ETEXI
> =20
>=20
