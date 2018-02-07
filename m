Received: from eggs.gnu.org ([2001:4830:134:3::10]:35542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRAD-0004Jh-TI
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRA8-000203-Pp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:57:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejRA8-0001zt-Fj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:57:28 -0500
Received: by mail-wm0-x242.google.com with SMTP id g1so3666102wmg.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 06:57:28 -0800 (PST)
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
	<20180207111729.15737-6-ard.biesheuvel@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180207111729.15737-6-ard.biesheuvel@linaro.org>
Date: Wed, 07 Feb 2018 14:57:25 +0000
Message-ID: <87372cx2y2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/5] target/arm: enable user-mode SHA-3,
 SM3, SM4 and SHA-512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instructions =
to
> AArch64 user mode emulation.

So another problem I've come across is I can't turn this off. I ended up
doing that in my FP16 series because otherwise existing RISU tests get
broken. However having an optional flag for each little set of
instructions seems overkill.

Have you run any RISU tests? If you want you can add this to the
aarch64.risu to generate some test patterns.

# These are optional ARMv8.2 cryptographic extensions
@v8.2,Cryptographic,CryptographicSHA

# Cryptographic three-register SHA 512
# 31       21 20  16 15 14 13 12 11    10 9  5 4  0
# 11001110011   Rm    1  O  0 0   opcode   Rn   Rd

SHA512H   A64_V 1100 1110 011 rm:5 1 0 00 00 rn:5 rd:5
SHA512H2  A64_V 1100 1110 011 rm:5 1 0 00 01 rn:5 rd:5
SHA512SUI A64_V 1100 1110 011 rm:5 1 0 00 10 rn:5 rd:5
RAX1      A64_V 1100 1110 011 rm:5 1 0 00 11 rn:5 rd:5
SM3PARTW1 A64_V 1100 1110 011 rm:5 1 1 00 00 rn:5 rd:5
SM3PARTW2 A64_V 1100 1110 011 rm:5 1 1 00 01 rn:5 rd:5
SM4       A64_V 1100 1110 011 rm:5 1 1 00 10 rn:5 rd:5

# Cryptographic four-register
# 31       23 22 21 20  16 15 14  10 9  5 4  0
# 1100 1110 0  Op0    Rm    0   Ra    Rn   Rd

EOR3      A64_V 1110 1110 0 00 rm:5 0 ra:5 rn:5 rd:5
BCAX      A64_V 1110 1110 0 01 rm:5 0 ra:5 rn:5 rd:5
SM3SS1    A64_V 1110 1110 0 10 rm:5 0 ra:5 rn:5 rd:5

# Cryptographic two-register SHA 512
# 31                    12 11  10 9  5 4  0
# 1100 1110 1100 0000 1000   op    Rn   Rd

SHA512SU0 A64_V 1100 1110 1100 0000 1000 00 rn:5 rd:5
SM4E      A64_V 1100 1110 1100 0000 1000 01 rn:5 rd:5

@


>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  linux-user/elfload.c | 19 +++++++++++++++++++
>  target/arm/cpu64.c   |  4 ++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 20f3d8c2c373..7922ab8eab79 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -512,6 +512,21 @@ enum {
>      ARM_HWCAP_A64_SHA1          =3D 1 << 5,
>      ARM_HWCAP_A64_SHA2          =3D 1 << 6,
>      ARM_HWCAP_A64_CRC32         =3D 1 << 7,
> +    ARM_HWCAP_A64_ATOMICS       =3D 1 << 8,
> +    ARM_HWCAP_A64_FPHP          =3D 1 << 9,
> +    ARM_HWCAP_A64_ASIMDHP       =3D 1 << 10,
> +    ARM_HWCAP_A64_CPUID         =3D 1 << 11,
> +    ARM_HWCAP_A64_ASIMDRDM      =3D 1 << 12,
> +    ARM_HWCAP_A64_JSCVT         =3D 1 << 13,
> +    ARM_HWCAP_A64_FCMA          =3D 1 << 14,
> +    ARM_HWCAP_A64_LRCPC         =3D 1 << 15,
> +    ARM_HWCAP_A64_DCPOP         =3D 1 << 16,
> +    ARM_HWCAP_A64_SHA3          =3D 1 << 17,
> +    ARM_HWCAP_A64_SM3           =3D 1 << 18,
> +    ARM_HWCAP_A64_SM4           =3D 1 << 19,
> +    ARM_HWCAP_A64_ASIMDDP       =3D 1 << 20,
> +    ARM_HWCAP_A64_SHA512        =3D 1 << 21,
> +    ARM_HWCAP_A64_SVE           =3D 1 << 22,
>  };
>
>  #define ELF_HWCAP get_elf_hwcap()
> @@ -532,6 +547,10 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP_A64_SHA1);
>      GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
>      GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
> +    GET_FEATURE(ARM_FEATURE_V8_SHA3, ARM_HWCAP_A64_SHA3);
> +    GET_FEATURE(ARM_FEATURE_V8_SM3, ARM_HWCAP_A64_SM3);
> +    GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
> +    GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
>  #undef GET_FEATURE
>
>      return hwcaps;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 670c07ab6ed4..1c330adc281b 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -224,6 +224,10 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_AES);
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT ica=
che */


--
Alex Benn=C3=A9e
