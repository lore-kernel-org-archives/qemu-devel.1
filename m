Received: from eggs.gnu.org ([2001:4830:134:3::10]:53767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLnG-000060-2U
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLnC-0005sI-RK
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:08:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbLnC-0005oS-Jn
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:08:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id t6-v6so3248187wrn.7
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 01:08:38 -0700 (PDT)
References: <20180705191929.30773-1-richard.henderson@linaro.org>
	<20180705191929.30773-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180705191929.30773-2-richard.henderson@linaro.org>
Date: Fri, 06 Jul 2018 09:08:36 +0100
Message-ID: <87k1q8946z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tcg: Restrict check_size_impl to
 multiples of the line size
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

> Normally this is automatic in the size restrictions that are placed
> on vector sizes coming from the implementation.  However, for the
> legitimate size tuple [oprsz=3D8, maxsz=3D32], we need to clear the final
> 24 bytes of the vector register.  Without this check, do_dup selects
> TCG_TYPE_V128 and clears only 16 bytes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-gvec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 22db1590d5..61c25f5784 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -287,8 +287,11 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs=
, uint32_t bofs,
>     in units of LNSZ.  This limits the expansion of inline code.  */
>  static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
>  {
> -    uint32_t lnct =3D oprsz / lnsz;
> -    return lnct >=3D 1 && lnct <=3D MAX_UNROLL;
> +    if (oprsz % lnsz =3D=3D 0) {
> +        uint32_t lnct =3D oprsz / lnsz;
> +        return lnct >=3D 1 && lnct <=3D MAX_UNROLL;
> +    }
> +    return false;
>  }
>
>  static void expand_clr(uint32_t dofs, uint32_t maxsz);


--
Alex Benn=C3=A9e
