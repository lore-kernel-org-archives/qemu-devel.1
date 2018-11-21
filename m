Received: from eggs.gnu.org ([2001:4830:134:3::10]:36806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gPNG3-00017i-0U
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gPNFz-0006bx-RY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:49:10 -0500
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:37064
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gPNFz-0006HV-HG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:49:07 -0500
From: balducci@units.it
In-reply-to: Your message of "Tue, 20 Nov 2018 23:28:59 -0500."
	<jpgd0qz3vg4.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17003.1542786544.1@dschgrazlin2.units.it>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Nov 2018 08:48:40 +0100
Message-ID: <17004.1542786544@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

> Sorry Gabriele, Eduardo and Paolo pointed out that the patch was incompl=
ete.
> I am not sure however how you are getting non zero data with the rdmsr o=
n an =

> AMD.
> Can you please try this instead ?
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..cfec559aa3 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -95,6 +95,7 @@ static bool has_msr_xss;
>  static bool has_msr_spec_ctrl;
>  static bool has_msr_virt_ssbd;
>  static bool has_msr_smi_count;
> +static bool has_msr_arch_capabs;
>  =

>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -1481,6 +1482,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>                  case MSR_VIRT_SSBD:
>                      has_msr_virt_ssbd =3D true;
>                      break;
> +                case MSR_IA32_ARCH_CAPABILITIES:
> +                    has_msr_arch_capabs =3D true;
> +                    break;
>                  }
>              }
>          }
> @@ -2002,14 +2006,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>  #endif
>  =

>      /* If host supports feature MSR, write down. */
> -    if (kvm_feature_msrs) {
> -        int i;
> -        for (i =3D 0; i < kvm_feature_msrs->nmsrs; i++)
> -            if (kvm_feature_msrs->indices[i] =3D=3D MSR_IA32_ARCH_CAPAB=
ILITIES) =

> {
> +    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAP=
ABILI
> TIES)
> +        && has_msr_arch_capabs) {
>                  kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>                                env->features[FEAT_ARCH_CAPABILITIES]);
> -                break;
> -            }
>      }
>  =

>      /*

this one works: qemu starts without any complaint and behaves as usual
(AFAICS)

thank you very much for working on this

ciao
gabriele
