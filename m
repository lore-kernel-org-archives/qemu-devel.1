Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eED0s-00069h-2O
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eED0o-00019L-VX
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:34:50 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:50272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eED0o-00018v-JQ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:34:46 -0500
Received: by mail-wr0-x241.google.com with SMTP id p96so14104807wrb.7
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:34:46 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-3-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 11:34:44 +0000
Message-ID: <87h8tytnsb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 02/12] target/arm: Add
 ARM_FEATURE_V8_1_SIMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

"...and enable it for the 'any' CPUs used by linux-user"?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     | 1 +
>  linux-user/elfload.c | 9 +++++++++
>  target/arm/cpu.c     | 1 +
>  target/arm/cpu64.c   | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 69cb49acc3..c5c9cef834 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1312,6 +1312,7 @@ enum arm_features {
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
> +    ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 79062882ba..003d9420b7 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -512,6 +512,14 @@ enum {
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
>  };
>
>  #define ELF_HWCAP get_elf_hwcap()
> @@ -532,6 +540,7 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP_A64_SHA1);
>      GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
>      GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
> +    GET_FEATURE(ARM_FEATURE_V8_1_SIMD, ARM_HWCAP_A64_ASIMDRDM);
>  #undef GET_FEATURE
>
>      return hwcaps;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 4300de66e2..276c996e9f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1603,6 +1603,7 @@ static void arm_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
>      cpu->midr =3D 0xffffffff;
>  }
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 670c07ab6e..b05c904ad2 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -226,6 +226,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
>      cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT ica=
che */
>      cpu->dcz_blocksize =3D 7; /*  512 bytes */
>  }


--
Alex Benn=C3=A9e
