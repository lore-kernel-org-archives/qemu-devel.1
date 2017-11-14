Received: from eggs.gnu.org ([2001:4830:134:3::10]:52976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdmI-0000j9-S7
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdmD-0005G8-68
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:34 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEdmD-0005Fe-01
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:29 -0500
Received: by mail-wm0-x242.google.com with SMTP id l8so16950001wmg.4
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 08:09:28 -0800 (PST)
References: <20171114094203.28030-1-richard.henderson@linaro.org>
	<20171114125304.854-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171114125304.854-1-richard.henderson@linaro.org>
Date: Tue, 14 Nov 2017 16:09:26 +0000
Message-ID: <87h8twall5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/1] target/arm: Use helper_retaddr in stxp
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> We use raw memory primitives along the !parallel_cpus paths in order to
> simplify the endianness handling.  Because of that, we did not benefit
> from the generic changes to cpu_ldst_user_only_template.h.
>
> The simplest fix is to manipulate helper_retaddr here.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index d0e435ca4b..96a3ecf707 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -456,6 +456,8 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *e=
nv, uint64_t addr,
>  #ifdef CONFIG_USER_ONLY
>          /* ??? Enforce alignment.  */
>          uint64_t *haddr =3D g2h(addr);
> +
> +        helper_retaddr =3D ra;
>          o0 =3D ldq_le_p(haddr + 0);
>          o1 =3D ldq_le_p(haddr + 1);
>          oldv =3D int128_make128(o0, o1);
> @@ -465,6 +467,7 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *e=
nv, uint64_t addr,
>              stq_le_p(haddr + 0, int128_getlo(newv));
>              stq_le_p(haddr + 1, int128_gethi(newv));
>          }
> +        helper_retaddr =3D 0;
>  #else
>          int mem_idx =3D cpu_mmu_index(env, false);
>          TCGMemOpIdx oi0 =3D make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx=
);
> @@ -523,6 +526,8 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *e=
nv, uint64_t addr,
>  #ifdef CONFIG_USER_ONLY
>          /* ??? Enforce alignment.  */
>          uint64_t *haddr =3D g2h(addr);
> +
> +        helper_retaddr =3D ra;
>          o1 =3D ldq_be_p(haddr + 0);
>          o0 =3D ldq_be_p(haddr + 1);
>          oldv =3D int128_make128(o0, o1);
> @@ -532,6 +537,7 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *e=
nv, uint64_t addr,
>              stq_be_p(haddr + 0, int128_gethi(newv));
>              stq_be_p(haddr + 1, int128_getlo(newv));
>          }
> +        helper_retaddr =3D 0;
>  #else
>          int mem_idx =3D cpu_mmu_index(env, false);
>          TCGMemOpIdx oi0 =3D make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx=
);


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
