Received: from eggs.gnu.org ([2001:4830:134:3::10]:42978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXQGG-0000py-Mx
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXQGB-0007ke-R1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:06:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXQGB-0007kO-LZ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:06:19 -0400
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
Date: Mon, 25 Jun 2018 14:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com

On 25/06/2018 05:39, Robert Hoo wrote:
> Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
> SPEC_CTRL.
>=20
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e69e68..3134af4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -896,7 +896,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", NULL,
> -            NULL, NULL, NULL, "ssbd",
> +            NULL, "arch-capabilities", NULL, "ssbd",
>          },
>          .cpuid_eax =3D 7,
>          .cpuid_needs_ecx =3D true, .cpuid_ecx =3D 0,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 734a73e..1ef2040 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network=
 Instructions */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accum=
ulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control =
*/
> +#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilitie=
s of RDCL_NO and IBRS_ALL*/
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store =
Bypass Disable */
> =20
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Pred=
iction Barrier */
>=20

For migration to work, you need to add new "features" corresponding to
the bits in the MSR, and include them in the Icelake-Server and
Icelake-Client models.  Unfortunately there is no code for this in QEMU
yet, though the API is there in KVM.

I have just sent the KVM patch to pass the MSR value down to QEMU ("KVM:
VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR").

Paolo
