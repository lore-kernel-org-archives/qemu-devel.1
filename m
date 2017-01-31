Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaav-0007ig-2a
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaar-0007uB-Vl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYaar-0007tT-CL
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:43:41 -0500
References: <1485857239-14296-1-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f9269e3-0cff-0916-cecf-f21a68337c0f@redhat.com>
Date: Tue, 31 Jan 2017 10:43:39 -0500
MIME-Version: 1.0
In-Reply-To: <1485857239-14296-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] kvm: log available guest crash
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 31/01/2017 05:07, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Windows reports BSOD parameters through Hyper-V crash MSRs. This
> information is very useful for initial crash analysis and thus
> it would be nice to see it in the QEMU log file. There is suitable
> log mask for the purpose.
>=20
> Linux guest does not provide this information, but still it would
> be nice to log that we have crashed.

We tell libvirt that the guest crashed through a QMP event, so I think
this should be passed as arguments of the QMP event.  You could add:

- a QAPI type GuestPanicInformation

{'union': 'GuestPanicInformation',
 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }

{'struct': 'GuestPanicInformationHyperV',
 'data': { 'arg1': 'uint64',
           'arg2': 'uint64',
           'arg3': 'uint64',
           'arg4': 'uint64' } }

- a QOM property on the CPU object, crash-information, whose getter
returns an error unless cpu->crash_occurred =3D true

- an optional GuestPanicInformation argument to the GUEST_PANICKED
event, which is passed if the QOM property returns a non-error value

Thanks,

Paolo

> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Marcelo Tosatti <mtosatti@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/misc/pvpanic.c    |  1 +
>  include/sysemu/kvm.h |  2 ++
>  kvm-all.c            |  1 +
>  stubs/Makefile.objs  |  1 +
>  stubs/kvm-crash.c    |  8 ++++++++
>  target/i386/kvm.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  6 files changed, 64 insertions(+)
>  create mode 100644 stubs/kvm-crash.c
>=20
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 0ac1e6a..221aa4e 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -42,6 +42,7 @@ static void handle_event(int event)
>      }
> =20
>      if (event & PVPANIC_PANICKED) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Guest panicked\n");
>          qemu_system_guest_panicked();
>          return;
>      }
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 3045ee7..70cab9d 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -527,4 +527,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void=
 *source);
>   */
>  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
>  int kvm_get_max_memslots(void);
> +
> +void kvm_arch_log_crash(CPUState *cpu);
>  #endif
> diff --git a/kvm-all.c b/kvm-all.c
> index 330219e..5f83389 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -2000,6 +2000,7 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret =3D EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_CRASH:
> +                kvm_arch_log_crash(cpu);
>                  qemu_mutex_lock_iothread();
>                  qemu_system_guest_panicked();
>                  qemu_mutex_unlock_iothread();
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index a187295..3b1632a 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -35,3 +35,4 @@ stub-obj-y +=3D qmp_pc_dimm_device_list.o
>  stub-obj-y +=3D target-monitor-defs.o
>  stub-obj-y +=3D target-get-monitor-def.o
>  stub-obj-y +=3D pc_madt_cpu_entry.o
> +stub-obj-y +=3D kvm-crash.o
> diff --git a/stubs/kvm-crash.c b/stubs/kvm-crash.c
> new file mode 100644
> index 0000000..36ab7f0
> --- /dev/null
> +++ b/stubs/kvm-crash.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "sysemu/kvm.h"
> +
> +void kvm_arch_log_crash(CPUState *cs)
> +{
> +    return;
> +}
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b52821..899a83c 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2020,6 +2020,36 @@ static int kvm_get_sregs(X86CPU *cpu)
>      return 0;
>  }
> =20
> +static int kvm_read_msr_hv_crash(X86CPU *cpu, uint64_t *buf)
> +{
> +    int i, ret;
> +    struct {
> +        struct kvm_msrs info;
> +        struct kvm_msr_entry entries[HV_X64_MSR_CRASH_PARAMS];
> +    } msr_data;
> +
> +    if (!has_msr_hv_crash) {
> +        return -ENOSYS;
> +    }
> +
> +    for (i =3D 0; i < HV_X64_MSR_CRASH_PARAMS; i++) {
> +        msr_data.entries[i].index =3D HV_X64_MSR_CRASH_P0 + i;
> +    }
> +    msr_data.info.nmsrs =3D HV_X64_MSR_CRASH_PARAMS;
> +
> +    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    for (i =3D 0; i < ret; i++) {
> +        const struct kvm_msr_entry *msr =3D msr_data.entries + i;
> +        buf[msr->index - HV_X64_MSR_CRASH_P0] =3D msr->data;
> +    }
> +
> +    return 0;
> +}
> +
>  static int kvm_get_msrs(X86CPU *cpu)
>  {
>      CPUX86State *env =3D &cpu->env;
> @@ -2767,6 +2797,27 @@ int kvm_arch_get_registers(CPUState *cs)
>      return ret;
>  }
> =20
> +void kvm_arch_log_crash(CPUState *cs)
> +{
> +    uint64_t msrs[HV_X64_MSR_CRASH_PARAMS];
> +    int ret;
> +    X86CPU *cpu =3D X86_CPU(cs);
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
> +    if (!has_msr_hv_crash) {
> +        return;
> +    }
> +
> +    ret =3D kvm_read_msr_hv_crash(cpu, msrs);
> +    if (ret < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Failed to get HV crash paramet=
ers\n");
> +        return;
> +    }
> +    qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
> +                  " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
> +                  msrs[0], msrs[1], msrs[2], msrs[3], msrs[4]);
> +}
> +
>  void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>  {
>      X86CPU *x86_cpu =3D X86_CPU(cpu);
>=20
