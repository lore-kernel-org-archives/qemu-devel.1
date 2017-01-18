Received: from eggs.gnu.org ([2001:4830:134:3::10]:49897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTroM-0006UL-JY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTroJ-0003ic-Cc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:06:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTroJ-0003iK-3o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:06:03 -0500
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
Date: Wed, 18 Jan 2017 16:05:59 +0100
MIME-Version: 1.0
In-Reply-To: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86-KVM: Supply TSC and APIC clock rates
 to guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org



On 18/01/2017 15:24, Phil Dennis-Jordan wrote:
> ---
>  target/i386/cpu.c |  1 +
>  target/i386/cpu.h |  4 ++++
>  target/i386/kvm.c | 40 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index aba11ae..e5523d4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3677,6 +3677,7 @@ static Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> +    DEFINE_PROP_BOOL("vmware-tsc-apic-clocks", X86CPU, vmware_clock_ra=
tes, false),

Maybe just vmware-cpuid-freq instead?  Whatever the choice, please make
the bool field in struct X86CPU consistent with the property name (e.g.
enable_vmware_cpuid_freq).

One issue is that the TSC frequency can change, for example on
migration.  Telling the guest about the TSC frequency makes little sense
if it can change.

So the leaf should be conditional on the INVTSC feature
(CPUID[0x80000007].EDX bit 8).  You can enable this unconditionally for
new machine types (i.e. making it true here, and turning it off in
include/hw/i386/pc.h's PC_COMPAT_2_8 macro), but only expose it if that
bit is also set.

>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6c1902b..1d8590b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1213,6 +1213,10 @@ struct X86CPU {
>      bool host_features;
>      uint32_t apic_id;
> =20
> +    /* Enables publishing of TSC increment and Local APIC bus frequenc=
ies to
> +     * the guest OS in CPUID page 0x40000010, the same way that VMWare=
 does. */
> +    bool vmware_clock_rates;
> +
>      /* if true the CPUID code directly forward host cache leaves to th=
e guest */
>      bool cache_info_passthrough;
> =20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 10a9cd8..7830b3a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -778,10 +778,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
> =20
>      if (cpu->expose_kvm) {
> +        uint32_t kvm_max_page =3D KVM_CPUID_FEATURES | kvm_base;

s/page/leaf/

> +        if (cpu->vmware_clock_rates && kvm_base =3D=3D KVM_CPUID_SIGNA=
TURE) {
> +            kvm_max_page =3D MAX(kvm_max_page, KVM_CPUID_SIGNATURE | 0=
x10);
> +        }
>          memcpy(signature, "KVMKVMKVM\0\0\0", 12);
>          c =3D &cpuid_data.entries[cpuid_i++];
>          c->function =3D KVM_CPUID_SIGNATURE | kvm_base;
> -        c->eax =3D KVM_CPUID_FEATURES | kvm_base;
> +        c->eax =3D kvm_max_page;
>          c->ebx =3D signature[0];
>          c->ecx =3D signature[1];
>          c->edx =3D signature[2];
> @@ -910,7 +914,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> -    cpuid_data.cpuid.nent =3D cpuid_i;
> =20
>      if (((env->cpuid_version >> 8)&0xF) >=3D 6
>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) =3D=3D
> @@ -973,12 +976,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          vmstate_x86_cpu.unmigratable =3D 1;
>      }
> =20
> -    cpuid_data.cpuid.padding =3D 0;
> -    r =3D kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
> -    if (r) {
> -        return r;
> -    }
> -
>      r =3D kvm_arch_set_tsc_khz(cs);
>      if (r < 0) {
>          return r;
> @@ -998,6 +995,33 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> +    if (cpu->vmware_clock_rates) {

^^ Here is where you should also check invtsc.

> +        if (cpu->expose_kvm

I think this should not depend on cpu->expose_kvm.  This is not a KVM
leaf, it's a vmware leaf; if it were a KVM leaf, it would obey kvm_base.
 Of course checking kvm_base is still a good idea, to avoid stomping on
Hyper-V's CPUID space.

Thanks,

Paolo

> +            && kvm_base =3D=3D KVM_CPUID_SIGNATURE
> +            && env->tsc_khz !=3D 0) {
> +            /* Publish TSC and LAPIC resolution on CPUID page 0x400000=
10
> +             * like VMWare for benefit of Darwin guests. */
> +            c =3D &cpuid_data.entries[cpuid_i++];
> +            c->function =3D KVM_CPUID_SIGNATURE | 0x10;
> +            c->eax =3D env->tsc_khz;
> +            /* LAPIC resolution of 1ns (freq: 1GHz) is hardcoded in KV=
M's
> +             * APIC_BUS_CYCLE_NS*/
> +            c->ebx =3D 1000000;
> +            c->ecx =3D c->edx =3D 0;
> +        } else {
> +            error_report(
> +                "Warning: VMWare-style TSC/LAPIC clock reporting impos=
sible.");


> +        }
> +    }
> +
> +    cpuid_data.cpuid.nent =3D cpuid_i;
> +
> +    cpuid_data.cpuid.padding =3D 0;
> +    r =3D kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
> +    if (r) {
> +        return r;
> +    }
> +
>      if (has_xsave) {
>          env->kvm_xsave_buf =3D qemu_memalign(4096, sizeof(struct kvm_x=
save));
>      }
>=20
