Received: from eggs.gnu.org ([2001:4830:134:3::10]:47111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlgt-0003fh-PI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlgs-0005Mz-Vz
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTlgs-0005MM-QS
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:02 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so11579639wrt.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:43:02 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-14-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-14-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:43:00 +0000
Message-ID: <87y3963n7v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/16] tcg/aarch64: Return false on
 failure from patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This does require an extra two checks within the slow paths
> to replace the assert that we're moving.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 16f08c59c4..77f0ca4d5e 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -78,20 +78,26 @@ static const int tcg_target_call_oarg_regs[1] =3D {
>  #define TCG_REG_GUEST_BASE TCG_REG_X28
>  #endif
>
> -static inline void reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
> +static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
>  {
>      ptrdiff_t offset =3D target - code_ptr;
> -    tcg_debug_assert(offset =3D=3D sextract64(offset, 0, 26));
> -    /* read instruction, mask away previous PC_REL26 parameter contents,
> -       set the proper offset, then write back the instruction. */
> -    *code_ptr =3D deposit32(*code_ptr, 0, 26, offset);
> +    if (offset =3D=3D sextract64(offset, 0, 26)) {
> +        /* read instruction, mask away previous PC_REL26 parameter conte=
nts,
> +           set the proper offset, then write back the instruction. */
> +        *code_ptr =3D deposit32(*code_ptr, 0, 26, offset);
> +        return true;
> +    }
> +    return false;
>  }
>
> -static inline void reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
> +static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
>  {
>      ptrdiff_t offset =3D target - code_ptr;
> -    tcg_debug_assert(offset =3D=3D sextract64(offset, 0, 19));
> -    *code_ptr =3D deposit32(*code_ptr, 5, 19, offset);
> +    if (offset =3D=3D sextract64(offset, 0, 19)) {
> +        *code_ptr =3D deposit32(*code_ptr, 5, 19, offset);
> +        return true;
> +    }
> +    return false;
>  }
>
>  static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> @@ -101,15 +107,12 @@ static inline bool patch_reloc(tcg_insn_unit *code_=
ptr, int type,
>      switch (type) {
>      case R_AARCH64_JUMP26:
>      case R_AARCH64_CALL26:
> -        reloc_pc26(code_ptr, (tcg_insn_unit *)value);
> -        break;
> +        return reloc_pc26(code_ptr, (tcg_insn_unit *)value);
>      case R_AARCH64_CONDBR19:
> -        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
> -        break;
> +        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>      default:
>          tcg_abort();
>      }
> -    return true;

nit: the default leg could return false for the same effect

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e
