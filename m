Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufbw-0007ZH-3T
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufRS-0005BA-Gj
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:58:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:11076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufRR-0005Aa-U5
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:58:02 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 14:52:43 +0000
Message-ID: <f1e8408730884947a0fc8ebfc762a4b4@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-2-jancraig@amazon.com>
	<BN7PR08MB4868C81C6F690B26EA79F18EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868C81C6F690B26EA79F18EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/mips: Introduce MXU registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

Where is the definition of MXU control register (MXU_CR)?
MXU_CR is the last element in this array.


Before sending patches, it is obligatory to run scripts/checkpatch.pl <path=
-to-your-patches> - this (missing braces) will be reported by this script.
I did run checkpath before sending a patch. This was not reported.

./scripts/checkpatch.pl patch/v3/v3-0001-target-mips-Introduce-MXU-register=
s.patch=20
total: 0 errors, 0 warnings, 41 lines checked

patch/v3/v3-0001-target-mips-Introduce-MXU-registers.patch has no obvious s=
tyle problems and is ready for submission.

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Tuesday, August 28, 2018 10:49 AM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Petar Jovanovic <pjovanovic@wavecomp.com>; Richar=
d Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 1/8] target/mips: Introduce MXU registers


> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v3 1/8] target/mips: Introduce MXU registers
>=20
> Define and initialize the 16 MXU registers.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - NA
>  v2
>     - NA
>  v3
>     - Initial patch, split out from prior first patch
>=20
>  target/mips/cpu.h       |  1 +
>  target/mips/translate.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h index=20
> 009202cf64..4b2948a2c8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -170,6 +170,7 @@ struct TCState {
>          MSACSR_FS_MASK)
>=20
>      float_status msa_fp_status;
> +    target_ulong mxu_gpr[16];
>  };
>=20

Where is the definition of MXU control register (MXU_CR)?

This may be placed in a separate patch, but must be includes in the series.

>  typedef struct CPUMIPSState CPUMIPSState; diff --git=20
> a/target/mips/translate.c b/target/mips/translate.c index=20
> bdd880bb77..416488b383 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1398,6 +1398,9 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;  static=20
> TCGv_i64 fpu_f64[32];  static TCGv_i64 msa_wr_d[64];
>=20
> +/* MXU registers */
> +static TCGv mxu_gpr[16];
> +
>  #include "exec/gen-icount.h"
>=20
>  #define gen_helper_0e0i(name, arg) do {                           \
> @@ -1517,6 +1520,13 @@ static const char * const msaregnames[] =3D {
>      "w30.d0", "w30.d1", "w31.d0", "w31.d1",  };
>=20
> +static const char * const mxuregnames[] =3D {
> +    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",
> +    "XR6",  "XR7",  "XR8",  "XR9",  "XR10",
> +    "XR11", "XR12", "XR13", "XR14", "XR15",
> +    "XR16",
> +};

Better alignment:

    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
    "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XR16",

> +
>  #define LOG_DISAS(...)                                                  =
      \
>      do {                                                                =
      \
>          if (MIPS_DEBUG_DISAS) {                                         =
      \
> @@ -20742,6 +20752,12 @@ void mips_tcg_init(void)
>      fpu_fcr31 =3D tcg_global_mem_new_i32(cpu_env,
>                                         offsetof(CPUMIPSState, active_fpu=
.fcr31),
>                                         "fcr31");
> +
> +    for (i =3D 0; i < 16; i++)
> +        mxu_gpr[i] =3D tcg_global_mem_new(cpu_env,
> +                                        offsetof(CPUMIPSState,
> +                                                 active_tc.mxu_gpr[i]),
> +                                        mxuregnames[i]);

The body of the for loop must be enclosed in { and } (QEMU code style guide=
lines).

Before sending patches, it is obligatory to run scripts/checkpatch.pl <path=
-to-your-patches> - this (missing braces) will be reported by this script.

>  }
>=20
>  #include "translate_init.inc.c"
>=20
