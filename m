Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdnv-0001y9-7b
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdnr-0007dv-6p
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:11:15 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:55426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEdnq-0007cI-Vr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:11:11 -0500
Received: by mail-wr0-x244.google.com with SMTP id l8so17933009wre.12
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 08:11:10 -0800 (PST)
References: <20171114094203.28030-1-richard.henderson@linaro.org>
	<20171114134153.11167-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171114134153.11167-1-richard.henderson@linaro.org>
Date: Tue, 14 Nov 2017 16:11:08 +0000
Message-ID: <87fu9galib.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/1] target/arm: Fix GETPC usage in
 do_paired_cmpxchg64_l/be
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

> Use of GETPC must be restricted to those functions that are
> directly called from TCG generated code.
>
> Fixes: 2399d4e7cec22ecf1c51062d2ebfd45220dbaace
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper-a64.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 96a3ecf707..b84ebcae6e 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -432,9 +432,8 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t val=
, uint32_t bytes)
>  /* Returns 0 on success; 1 otherwise.  */
>  static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
>                                         uint64_t new_lo, uint64_t new_hi,
> -                                       bool parallel)
> +                                       bool parallel, uintptr_t ra)
>  {
> -    uintptr_t ra =3D GETPC();
>      Int128 oldv, cmpv, newv;
>      bool success;
>
> @@ -491,20 +490,19 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState =
*env, uint64_t addr,
>  uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
>                                                uint64_t new_lo, uint64_t =
new_hi)
>  {
> -    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false);
> +    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false, GETP=
C());
>  }
>
>  uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t=
 addr,
>                                                uint64_t new_lo, uint64_t =
new_hi)
>  {
> -    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true);
> +    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true, GETPC=
());
>  }
>
>  static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
>                                         uint64_t new_lo, uint64_t new_hi,
> -                                       bool parallel)
> +                                       bool parallel, uintptr_t ra)
>  {
> -    uintptr_t ra =3D GETPC();
>      Int128 oldv, cmpv, newv;
>      bool success;
>
> @@ -561,11 +559,11 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState =
*env, uint64_t addr,
>  uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
>                                       uint64_t new_lo, uint64_t new_hi)
>  {
> -    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false);
> +    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false, GETP=
C());
>  }
>
>  uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t=
 addr,
>                                       uint64_t new_lo, uint64_t new_hi)
>  {
> -    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true);
> +    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC=
());
>  }


--
Alex Benn=C3=A9e
