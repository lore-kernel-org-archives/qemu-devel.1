Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3KGC-0002zF-Tn
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3KG8-0006gz-HM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:24 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3KG8-0006g5-AM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:20 -0400
Received: by mail-wr0-x232.google.com with SMTP id l50so49242874wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:33:20 -0700 (PDT)
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-4-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1493187803-4510-4-git-send-email-cota@braap.org>
Date: Wed, 26 Apr 2017 11:33:46 +0100
Message-ID: <87d1bz8nlh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tcg: export
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Instead of exporting goto_ptr directly to TCG frontends, export
> tcg_gen_lookup_and_goto_ptr(), which calls goto_ptr with the pointer
> returned by the lookup_tb_ptr() helper. This is the only use case
> we have for goto_ptr and lookup_tb_ptr, so having this function is
> very convenient. Furthermore, it trivially allows us to avoid calling
> the lookup helper if goto_ptr is not implemented by the backend.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/README   |  8 ++++++++
>  tcg/tcg-op.c | 13 +++++++++++++
>  tcg/tcg-op.h | 11 +++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/tcg/README b/tcg/README
> index a9858c2..bf49e82 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -477,6 +477,14 @@ current TB was linked to this TB. Otherwise execute the next
>  instructions. Only indices 0 and 1 are valid and tcg_gen_goto_tb may be issued
>  at most once with each slot index per TB.
>
> +* lookup_and_goto_ptr tb_addr
> +
> +Look up a TB address ('tb_addr') and jump to it if valid. If not valid,
> +jump to the TCG epilogue to go back to the exec loop.
> +
> +This operation is optional. If the TCG backend does not implement the
> +goto_ptr opcode, emitting this op is equivalent to emitting exit_tb(0).
> +
>  * qemu_ld_i32/i64 t0, t1, flags, memidx
>  * qemu_st_i32/i64 t0, t1, flags, memidx
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 95a39b7..8ff1eaf 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2587,6 +2587,19 @@ void tcg_gen_goto_tb(unsigned idx)
>      tcg_gen_op1i(INDEX_op_goto_tb, idx);
>  }
>
> +void tcg_gen_lookup_and_goto_ptr(TCGv addr)
> +{
> +    if (TCG_TARGET_HAS_goto_ptr) {
> +        TCGv_ptr ptr = tcg_temp_new_ptr();
> +
> +        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env, addr);
> +        tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
> +        tcg_temp_free_ptr(ptr);
> +    } else {
> +        tcg_gen_exit_tb(0);
> +    }
> +}
> +
>  static inline TCGMemOp tcg_canonicalize_memop(TCGMemOp op, bool is64, bool st)
>  {
>      /* Trigger the asserts within as early as possible.  */
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index c68e300..5d3278f 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -796,6 +796,17 @@ static inline void tcg_gen_exit_tb(uintptr_t val)
>   */
>  void tcg_gen_goto_tb(unsigned idx);
>
> +/**
> + * tcg_gen_lookup_and_goto_ptr() - look up a TB and jump to it if valid
> + * @addr: Guest address of the target TB
> + *
> + * If the TB is not valid, jump to the epilogue.
> + *
> + * This operation is optional. If the TCG backend does not implement goto_ptr,
> + * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
> + */
> +void tcg_gen_lookup_and_goto_ptr(TCGv addr);
> +
>  #if TARGET_LONG_BITS == 32
>  #define tcg_temp_new() tcg_temp_new_i32()
>  #define tcg_global_reg_new tcg_global_reg_new_i32


--
Alex Bennée
