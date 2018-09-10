Received: from eggs.gnu.org ([2001:4830:134:3::10]:55451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIKV-0003Ty-Vl
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIKS-0005pI-RS
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:18:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzIKS-0005ob-C2
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:17:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id s14-v6so12108901wrw.6
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 02:17:56 -0700 (PDT)
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180903171831.15446-6-cota@braap.org>
Date: Mon, 10 Sep 2018 10:17:53 +0100
Message-ID: <87d0tld83i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Needed for MTTCG.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 1f9d1d9b24..9a6a72e205 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -71,26 +71,34 @@
>=20=20
>  //#define MACRO_TEST   1
>=20=20
> +/* we need thread-local storage for mttcg */
> +#ifdef CONFIG_USER_ONLY
> +#define I386_THREAD
> +#else
> +#define I386_THREAD __thread
> +#endif
> +

I'm confused - as we can have multi-threaded user space don't the same
requirements apply?

>  /* global register indexes */
> -static TCGv cpu_A0;
> -static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2, cpu_cc_srcT;
> +static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
>  static TCGv_i32 cpu_cc_op;
>  static TCGv cpu_regs[CPU_NB_REGS];
>  static TCGv cpu_seg_base[6];
>  static TCGv_i64 cpu_bndl[4];
>  static TCGv_i64 cpu_bndu[4];
>  /* local temps */
> -static TCGv cpu_T0, cpu_T1;
> +static I386_THREAD TCGv cpu_cc_srcT;
> +static I386_THREAD TCGv cpu_A0;
> +static I386_THREAD TCGv cpu_T0, cpu_T1;
>  /* local register indexes (only used inside old micro ops) */
> -static TCGv cpu_tmp0, cpu_tmp4;
> -static TCGv_ptr cpu_ptr0, cpu_ptr1;
> -static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
> -static TCGv_i64 cpu_tmp1_i64;
> +static I386_THREAD TCGv cpu_tmp0, cpu_tmp4;
> +static I386_THREAD TCGv_ptr cpu_ptr0, cpu_ptr1;
> +static I386_THREAD TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
> +static I386_THREAD TCGv_i64 cpu_tmp1_i64;
>=20=20
>  #include "exec/gen-icount.h"
>=20=20
>  #ifdef TARGET_X86_64
> -static int x86_64_hregs;
> +static I386_THREAD int x86_64_hregs;
>  #endif
>=20=20
>  typedef struct DisasContext {


--=20
Alex Benn=C3=A9e
