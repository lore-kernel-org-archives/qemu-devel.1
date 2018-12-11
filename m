Received: from eggs.gnu.org ([2001:4830:134:3::10]:58458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1gWfgW-00019J-D0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1gWfgS-00062F-6t
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:54:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:58505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@intel.com>) id 1gWfgQ-0005sf-9b
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:54:34 -0500
From: "Hu, Robert" <robert.hu@intel.com>
Date: Tue, 11 Dec 2018 10:54:21 +0000
Message-ID: <9E79D1C9A97CFD4097BCE431828FDD3116286E36@SHSMSX103.ccr.corp.intel.com>
References: <7280.1542702495@dschgrazlin2.units.it>
	<jpgd0qz3vg4.fsf@linux.bootlegged.copy>	<20181121125008.GV4755@habkost.net>
	<jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
In-Reply-To: <jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] kvm: Use KVM_GET_MSR_INDEX_LIST for
 MSR_IA32_ARCH_CAPABILITIES support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "balducci@units.it" <balducci@units.it>, Cole Robinson <crobinso@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>

Thanks for fixing. Sorry I missed the whole discussion for I hadn't checked=
 my
linux.intel.com account for a long time.

Best Regards,
Robert Hoo

> -----Original Message-----
> From: Qemu-devel <qemu-devel-bounces+robert.hu=3Dintel.com@nongnu.org>
> On Behalf Of Bandan Das
> Sent: Monday, November 26, 2018 12:17
> To: Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Cc: balducci@units.it; Cole Robinson <crobinso@redhat.com>; qemu-
> devel@nongnu.org; Laine Stump <laine@redhat.com>; David Alan Gilbert
> <dgilbert@redhat.com>
> Subject: [Qemu-devel] [PATCH] kvm: Use KVM_GET_MSR_INDEX_LIST for
> MSR_IA32_ARCH_CAPABILITIES support
>=20
>=20
> When writing to guest's MSR_IA32_ARCH_CAPABILITIES, check whether it's
> supported in the guest using the KVM_GET_MSR_INDEX_LIST ioctl.
>=20
> Fixes: d86f963694df27f11b3681ffd225c9362de1b634
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Tested-by: balducci@units.it
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  target/i386/kvm.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c index
> f524e7d929..3d6739a2b2 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -95,6 +95,7 @@ static bool has_msr_xss;  static bool has_msr_spec_ctrl=
;
> static bool has_msr_virt_ssbd;  static bool has_msr_smi_count;
> +static bool has_msr_arch_capabs;
>=20
>  static uint32_t has_architectural_pmu_version;  static uint32_t
> num_architectural_pmu_gp_counters;
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
> @@ -2002,14 +2006,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> #endif
>=20
>      /* If host supports feature MSR, write down. */
> -    if (kvm_feature_msrs) {
> -        int i;
> -        for (i =3D 0; i < kvm_feature_msrs->nmsrs; i++)
> -            if (kvm_feature_msrs->indices[i] =3D=3D MSR_IA32_ARCH_CAPABI=
LITIES) {
> -                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
> -                              env->features[FEAT_ARCH_CAPABILITIES]);
> -                break;
> -            }
> +    if (has_msr_arch_capabs) {

[Robert Hoo]=20
Why not as your original "if (kvm_arch_get_supported_msr_feature(kvm_state,=
 MSR_IA32_ARCH_CAPABILITIES))"?
checking if there is the MSR feature?

> +        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
> +                          env->features[FEAT_ARCH_CAPABILITIES]);
>      }
>=20
>      /*
> --
> 2.14.5
>=20
