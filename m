Received: from eggs.gnu.org ([2001:4830:134:3::10]:56978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6yG9-0001Ql-Jh
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6yG8-0001vY-B9
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:52:25 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6yG8-0001uA-2E
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:52:24 -0400
Date: Sat, 6 May 2017 13:52:19 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170506115219.wghazxetxvqooyy3@aurel32.net>
References: <20170502192300.2124-1-rth@twiddle.net>
	<20170502192300.2124-14-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502192300.2124-14-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v6 13/25] tcg/aarch64: Implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 2017-05-02 12:22, Richard Henderson wrote:
> Measurements:
> 
>                       SPECint06 (test set), x86_64-linux-user. Host: APM 64-bit ARMv8 (Atlas/A57) @ 2.4 GHz
> 
>  1.45x +-+-------------------------------------------------------------------------------------------------------------+-+
>        |                                      *****                                                                      |
>        |      +++                             *   *                                                    +goto-ptr         |
>   1.4x +-+...*****............................*...*....................................................................+-+
>        |     *+++*                            *   *                            +++                                       |
>  1.35x +-+...*...*............................*...*...........................*****....................................+-+
>        |     *   *                            *   *                           *+++*                                      |
>        |     *   *                            *   *                           *   *                                      |
>   1.3x +-+...*...*............................*...*...........................*...*....................................+-+
>        |     *   *                            *   *                           *   *                                      |
>        |     *   *                            *   *                           *   *                    *****             |
>  1.25x +-+...*...*...........*****............*...*...........................*...*............*****...*...*...........+-+
>        |     *   *           *   *            *   *                           *   *            *+++*   *   *             |
>   1.2x +-+...*...*...........*...*............*...*...........................*...*............*...*...*...*...........+-+
>        |     *   *           *   *            *   *                           *   *            *   *   *   *             |
>        |     *   *           *   *            *   *                           *   *            *   *   *   *   *****     |
>  1.15x +-+...*...*...........*...*............*...*...........................*...*............*...*...*...*...*...*...+-+
>        |     *   *           *   *            *   *                           *   *    +++     *   *   *   *   *   *     |
>        |     *   *           *   *            *   *                           *   *   *****    *   *   *   *   *   *     |
>   1.1x +-+...*...*...........*...*....*****...*...*...*****...................*...*...*...*....*...*...*...*...*...*...+-+
>        |     *   *           *   *    *   *   *   *   *   *                   *   *   *   *    *   *   *   *   *   *     |
>  1.05x +-+...*...*...........*...*....*...*...*...*...*...*...................*...*...*...*....*...*...*...*...*...*...+-+
>        |     *   *   *****   *   *    *   *   *   *   *   *                   *   *   *   *    *   *   *   *   *   *     |
>        |     *   *   *   *   *   *    *   *   *   *   *   *   *****   *****   *   *   *   *    *   *   *   *   *   *     |
>     1x +-+---*****---*****---*****----*****---*****---*****---*****---*****---*****---*****----*****---*****---*****---+-+
>           astar   bzip2     gcc    gobmk h264ref   hmmlibquantum     mcf omnetpperlbench    sjenxalancbmk   hmean
>   png: http://imgur.com/en9HE8L
> 
> Tested-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/aarch64/tcg-target.h     |  2 +-
>  tcg/aarch64/tcg-target.inc.c | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index b82eac4..55a46ac 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -77,7 +77,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_mulsh_i32        0
>  #define TCG_TARGET_HAS_extrl_i64_i32    0
>  #define TCG_TARGET_HAS_extrh_i64_i32    0
> -#define TCG_TARGET_HAS_goto_ptr         0
> +#define TCG_TARGET_HAS_goto_ptr         1
>  
>  #define TCG_TARGET_HAS_div_i64          1
>  #define TCG_TARGET_HAS_rem_i64          1
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 290de6d..5f18545 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1357,8 +1357,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>  
>      switch (opc) {
>      case INDEX_op_exit_tb:
> -        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
> -        tcg_out_goto(s, tb_ret_addr);
> +        /* Reuse the zeroing that exists for goto_ptr.  */
> +        if (a0 == 0) {
> +            tcg_out_goto(s, s->code_gen_epilogue);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
> +            tcg_out_goto(s, tb_ret_addr);
> +        }
>          break;
>  
>      case INDEX_op_goto_tb:
> @@ -1374,6 +1379,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
>          break;
>  
> +    case INDEX_op_goto_ptr:
> +        tcg_out_insn(s, 3207, BR, a0);
> +        break;
> +
>      case INDEX_op_br:
>          tcg_out_goto_label(s, arg_label(a0));
>          break;
> @@ -1735,6 +1744,7 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
>      { INDEX_op_exit_tb, { } },
>      { INDEX_op_goto_tb, { } },
>      { INDEX_op_br, { } },
> +    { INDEX_op_goto_ptr, { "r" } },
>  
>      { INDEX_op_ld8u_i32, { "r", "r" } },
>      { INDEX_op_ld8s_i32, { "r", "r" } },
> @@ -1942,6 +1952,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>      tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
>      tcg_out_insn(s, 3207, BR, tcg_target_call_iarg_regs[1]);
>  
> +    /*
> +     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
> +     * and fall through to the rest of the epilogue.
> +     */
> +    s->code_gen_epilogue = s->code_ptr;
> +    tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
> +
> +    /* TB epilogue */
>      tb_ret_addr = s->code_ptr;
>  
>      /* Remove TCG locals stack space.  */

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
