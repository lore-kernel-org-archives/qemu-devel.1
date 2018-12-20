Received: from eggs.gnu.org ([2001:4830:134:3::10]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gZzLX-0007jM-Ss
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gZzAF-000246-JG
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:19:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gZzAF-00022g-8S
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:19:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64CFCC05AA54
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:19:02 +0000 (UTC)
References: <20181220121100.21554-1-pbonzini@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <490cbc41-0076-659a-9745-29881b9c95cc@redhat.com>
Date: Thu, 20 Dec 2018 12:18:54 -0200
MIME-Version: 1.0
In-Reply-To: <20181220121100.21554-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: Disable MPX support on named
 CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com


On 12/20/2018 10:11 AM, Paolo Bonzini wrote:
> MPX support is being phased out by Intel; GCC has dropped it, Linux
> is also going to do that.  Even though KVM will have special code
> to support MPX after the kernel proper stops enabling it in XCR0,
> we probably also want to deprecate that in a few years.  As a start,
> do not enable it by default for any named CPU model starting with
> the 4.0 machine types; this include Skylake, Icelake and Cascadelake.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/i386/pc.h | 29 +++++++++++++++++++++++++++++
>   target/i386/cpu.c    | 14 +++++++-------
>   2 files changed, 36 insertions(+), 7 deletions(-)

Side question: I didn't find on QEMU's user manual any reference to=20
deprecated features for CPU models. Does that information exists=20
somewhere? If not, should it be documented for the users?

Anyway,
Reviewed-by:=C2=A0 Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9d29c4b1df..39619e9c01 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -296,6 +296,35 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uin=
t64_t *);
>  =20
>   #define PC_COMPAT_3_1 \
>       HW_COMPAT_3_1 \
> +    {\
> +        .driver   =3D "Skylake-Client" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Skylake-Client-IBRS" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Skylake-Server-IBRS" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Cascadelake-Server" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Icelake-Client" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },{\
> +        .driver   =3D "Icelake-Server" "-" TYPE_X86_CPU,\
> +        .property =3D "mpx",\
> +        .value    =3D "on",\
> +    },
>  =20
>   #define PC_COMPAT_3_0 \
>       HW_COMPAT_3_0 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 677a3bd5fb..1dc1f569da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2296,7 +2296,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
> +            CPUID_7_0_EBX_SMAP,
>           /* Missing: XSAVES (not supported by some Linux versions,
>            * including v4.1 to v4.12).
>            * KVM doesn't yet expose any XSAVES state save component,
> @@ -2343,7 +2343,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
> +            CPUID_7_0_EBX_SMAP,
>           /* Missing: XSAVES (not supported by some Linux versions,
>            * including v4.1 to v4.12).
>            * KVM doesn't yet expose any XSAVES state save component,
> @@ -2388,7 +2388,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLW=
B |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>               CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>               CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
> @@ -2440,7 +2440,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLW=
B |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>               CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>               CPUID_7_0_EBX_AVX512VL,
> @@ -2490,7 +2490,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLW=
B |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>               CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>               CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
> @@ -2546,7 +2546,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_INT=
EL_PT,
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
>           .features[FEAT_7_0_ECX] =3D
>               CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_P=
KU |
>               CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX=
_GFNI |
> @@ -2601,7 +2601,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>               CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>               CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLW=
B |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>               CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>               CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
