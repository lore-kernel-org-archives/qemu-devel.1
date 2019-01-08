Received: from eggs.gnu.org ([209.51.188.92]:44597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1ggtyi-0008Pt-UP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1ggtyh-00033M-TL
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:11:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdupontd@redhat.com>) id 1ggtyh-0002SC-N7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:11:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so4783342edx.2
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:11:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
Date: Tue, 8 Jan 2019 17:11:22 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <840FA547-E55B-4B91-AE92-43A6F1AF4461@redhat.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
	<cover.1545806972.git.weijiang.yang@intel.com>
	<7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] Add hepler functions for CPUID xsave
 area size calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, open list <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com, Zhang Yi <yi.z.zhang@linux.intel.com>

Typo in subject line (helper)

> On 26 Dec 2018, at 09:25, Yang Weijiang <weijiang.yang@intel.com> =
wrote:
>=20
> These functions are called when return CPUID xsave area
> size information.
>=20
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
> target/i386/cpu.c | 26 +++++++++++++++++++++++++-
> 1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3630c688d6..cf4f2798dc 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1281,12 +1281,34 @@ static inline bool accel_uses_host_cpuid(void)
>     return kvm_enabled() || hvf_enabled();
> }
>=20
> +static uint32_t xsave_area_size_compat(uint64_t mask)

Just curious, why =E2=80=9Ccompat=E2=80=9D?

> +{
> +    int i;
> +    uint64_t ret =3D 0;
> +    uint32_t offset;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
> +        const ExtSaveArea *esa =3D &x86_ext_save_areas[i];
> +        offset =3D i > 1 ? ret : esa->offset;

What about a named constant instead of =E2=80=981=E2=80=99?

(note that a loop around line 4657 starts at 2, so I guess it=E2=80=99s =
OK to use 1 here, or at least >=3D 2 ;-)


> +        if ((mask >> i) & 1) {
> +            ret =3D MAX(ret, offset + esa->size);
> +        }
> +    }
> +    return ret;
> +}
> +
> static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
> {
>     return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
>            cpu->env.features[FEAT_XSAVE_COMP_LO];
> }
>=20
> +static inline uint64_t x86_cpu_xsave_sv_components(X86CPU *cpu)
> +{
> +    return ((uint64_t)cpu->env.features[FEAT_XSAVE_SV_HI]) << 32 |
> +           cpu->env.features[FEAT_XSAVE_SV_LO];
> +}
> +
> const char *get_register_name_32(unsigned int reg)
> {
>     if (reg >=3D CPU_NB_REGS32) {
> @@ -4913,8 +4935,10 @@ static void =
x86_cpu_enable_xsave_components(X86CPU *cpu)
>         }
>     }
>=20
> -    env->features[FEAT_XSAVE_COMP_LO] =3D mask;
> +    env->features[FEAT_XSAVE_COMP_LO] =3D mask & =
CPUID_XSTATE_USER_MASK;
>     env->features[FEAT_XSAVE_COMP_HI] =3D mask >> 32;
> +    env->features[FEAT_XSAVE_SV_LO] =3D mask & =
CPUID_XSTATE_KERNEL_MASK;
> +    env->features[FEAT_XSAVE_SV_HI] =3D mask >> 32;
> }
>=20
> /***** Steps involved on loading and filtering CPUID data
> --=20
> 2.17.1
>=20
