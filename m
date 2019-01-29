Received: from eggs.gnu.org ([209.51.188.92]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goR34-0003EL-Mh
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goR32-0006vc-CY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:55:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:26384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1goR2y-0006q2-2S
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:55:18 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Tue, 29 Jan 2019 10:55:00 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD4D02@SHSMSX101.ccr.corp.intel.com>
References: <1548805979-12321-1-git-send-email-luwei.kang@intel.com>
In-Reply-To: <1548805979-12321-1-git-send-email-luwei.kang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V2] i386: extended the cpuid_level when
 Intel PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Kang, Luwei
> Sent: Wednesday, January 30, 2019 7:53 AM
> To: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@=
twiddle.net; ehabkost@redhat.com
> Cc: qemu-devel@nongnu.org; Kang, Luwei <luwei.kang@intel.com>
> Subject: [PATCH V2] i386: extended the cpuid_level when Intel PT is enabl=
ed
>=20
> Intel Processor Trace required CPUID[0x14] but the cpuid_level have no ch=
ange when create a kvm guest with e.g. "-cpu qemu64,+intel-pt".
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

Resend this patch to add " Signed-off-by: Eduardo Habkost <ehabkost@redhat.=
com>" and fix a typo.

Thanks,
Luwei Kang

> ---
>  hw/i386/pc.c      | 1 +
>  target/i386/cpu.c | 9 +++++++++
>  target/i386/cpu.h | 3 +++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c index 73d688f..72a0a70 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -122,6 +122,7 @@ GlobalProperty pc_compat_3_1[] =3D {
>      { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
>      { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
>      { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
> +    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
>  };
>  const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c index 2f54125..6dddd99=
 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5023,6 +5023,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, E=
rror **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> +
> +        /* Intel Processor Trace requires CPUID[0x14] */
> +        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> +             kvm_enabled() && cpu->intel_pt_auto_level) {
> +            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
> +        }
> +
>          /* SVM requires CPUID[0x8000000A] */
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A=
); @@ -5816,6 +5823,8 @@ static Property x86_cpu_properties[] =3D
> {
>      DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
>      DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_onl=
y,
>                       false),
> +    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_leve=
l,
> +                     true),
>      DEFINE_PROP_END_OF_LIST()
>  };
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h index 59656a7..090baa4=
 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1455,6 +1455,9 @@ struct X86CPU {
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>=20
> +    /* Enable auto level-increase for Intel Processor Trace leave */
> +    bool intel_pt_auto_level;
> +
>      /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
>      bool fill_mtrr_mask;
>=20
> --
> 1.8.3.1
