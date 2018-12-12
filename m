Received: from eggs.gnu.org ([2001:4830:134:3::10]:51611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gXAYm-00081c-4N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gXAYh-000814-88
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:52:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gXAYg-0007zq-JW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:52:38 -0500
Date: Wed, 12 Dec 2018 17:52:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181212195235.GX7141@habkost.net>
References: <20181210183730.GJ4669@habkost.net> <20181210184153.GB5482@zn.tnic>
	<20181210190600.GK4669@habkost.net> <20181210194258.GD5482@zn.tnic>
	<20181210200843.GN4669@habkost.net>
	<20181211103839.GC921@redhat.com>
	<20181211115546.GQ4669@habkost.net>
	<e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
	<20181211153017.GN921@redhat.com> <20181211161440.GG27375@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181211161440.GG27375@zn.tnic>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: Reenable RDTSCP support on
 Opteron_G[345] CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Andre Przywara <andre.przywara@arm.com>, kvm ML <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 11, 2018 at 05:14:40PM +0100, Borislav Petkov wrote:
> + qemu-devel.
>=20
> On Tue, Dec 11, 2018 at 03:30:17PM +0000, Daniel P. Berrang=E9 wrote:
> > Great, then, this is a non-issue - we just need to mention that fact
> > in the commit that sets the min version for the kernel
>=20
> Ok, here's a first draft ontop of Eduardo's machine-next branch from
> http://github.com/ehabkost/qemu
>=20
> Also, thanks for the help Eduardo! :-)
>=20
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 11 Dec 2018 17:01:00 +0100
>=20
> The missing functionality was added ~3 years ago with the Linux commit
>=20
>   46896c73c1a4 ("KVM: svm: add support for RDTSCP")
>=20
> so reenable RDTSCP support on those CPU models.
>=20
> Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
> (the real hardware doesn't have it. K8 got RDTSCP support with the NPT
> models, i.e., models >=3D 0x40).
>=20
> Document the host's minimum required kernel version, while at it.
>=20
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  include/hw/i386/pc.h | 17 +++++++++++++----
>  qemu-doc.texi        | 13 +++++++++++++
>  target/i386/cpu.c    | 11 ++++-------
>  3 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9d29c4b1df2a..ebc28e816b04 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -296,6 +296,19 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uin=
t64_t *);
> =20
>  #define PC_COMPAT_3_1 \
>      HW_COMPAT_3_1 \
> +    {\
> +        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
> +        .property =3D "rdtscp",\
> +        .value    =3D "off",\
> +    },{\
> +        .driver   =3D "Opteron_G4" "-" TYPE_X86_CPU,\
> +        .property =3D "rdtscp",\
> +        .value    =3D "off",\
> +    },{\
> +        .driver   =3D "Opteron_G5" "-" TYPE_X86_CPU,\
> +        .property =3D "rdtscp",\
> +        .value    =3D "off",\
> +    },

This looks correct.

> =20
>  #define PC_COMPAT_3_0 \
>      HW_COMPAT_3_0 \
> @@ -527,10 +540,6 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uin=
t64_t *);
>          .driver   =3D "qemu32" "-" TYPE_X86_CPU,\
>          .property =3D "popcnt",\
>          .value    =3D "on",\
> -    },{\
> -        .driver   =3D "Opteron_G2" "-" TYPE_X86_CPU,\
> -        .property =3D "rdtscp",\
> -        .value    =3D "on",\

Why did you remove this entry from PC_COMPAT_2_4?

We must keep compatibility with old behavior of Opteron_G2 on
pc-2.4, even if the old behavior was incorrect.


>      },{\
>          .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
>          .property =3D "rdtscp",\
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7ad1dfe4b69..16b955cbf985 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -37,6 +37,7 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
> +* System requirements::
>  * Implementation notes::
>  * Deprecated features::
>  * Supported build platforms::
> @@ -2813,6 +2814,18 @@ Act as if the host page size was 'pagesize' byte=
s
>  Run the emulation in single step mode.
>  @end table
> =20
> +@node System requirements
> +@chapter System requirements
> +
> +@section KVM kernel module
> +
> +On x86_64 hosts, the default set of CPU features enabled by the KVM ac=
celerator
> +require the host to be running Linux v4.5 or newer.
> +
> +The OpteronG[345] CPU models require KVM support for RDTSCP, which was
> +added with Linux 4.5 which is supported by the major distros. And even
> +if RHEL7 has kernel 3.10, KVM there has the required functionality the=
re
> +to make it close to a 4.5 or newer kernel.
> =20
>  @include qemu-tech.texi
> =20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f914..a7def11b27cd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_DE | CPUID_FP87,
>          .features[FEAT_1_ECX] =3D
>              CPUID_EXT_CX16 | CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */

This is Opteron_G2, and feature is not being added.  Looks
correct.

>          .features[FEAT_8000_0001_EDX] =3D
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>          .features[FEAT_8000_0001_ECX] =3D
> @@ -2730,9 +2729,9 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>          .features[FEAT_1_ECX] =3D
>              CPUID_EXT_POPCNT | CPUID_EXT_CX16 | CPUID_EXT_MONITOR |
>              CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =3D
> -            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL |
> +            CPUID_EXT2_RDTSCP,

This is Opteron_G3.  Looks correct.

>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
>              CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> @@ -2757,10 +2756,9 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
>              CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
>              CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =3D
>              CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
> -            CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,

This is Opteron_G4.  Looks correct.


>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
>              CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
> @@ -2788,10 +2786,9 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
>              CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_FMA |
>              CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =3D
>              CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
> -            CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,

This is Opteron_G5.  Looks correct.

>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
>              CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
> --=20
> 2.19.1
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Good mailing practices for 400: avoid top-posting and trim the reply.

--=20
Eduardo
