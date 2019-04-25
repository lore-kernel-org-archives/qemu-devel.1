Received: from eggs.gnu.org ([209.51.188.92]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6p-0003va-6r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6n-0008Rf-Be
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJV6n-0008Qq-5i
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id f6so10423836pgs.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 20:31:37 -0700 (PDT)
Date: Wed, 24 Apr 2019 20:31:34 -0700 (PDT)
In-Reply-To: <20190401031155.21293-3-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-d8a9c6b1-6c19-45a3-ba27-f8fc88bdc933@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/8] target/riscv: Use
 --static-decode for decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:49 PDT (-0700), richard.henderson@linaro.org wrote:
> The generated functions are only used within translate.c
> and do not need to be global, or declared.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/translate.c   | 2 --
>  target/riscv/Makefile.objs | 8 ++++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index dd763647ea..7ebd590486 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -538,7 +538,6 @@ static int ex_rvc_register(int reg)
>      return 8 + reg;
>  }
>
> -bool decode_insn32(DisasContext *ctx, uint32_t insn);
>  /* Include the auto-generated decoder for 32 bit insn */
>  #include "decode_insn32.inc.c"
>
> @@ -667,7 +666,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
> -bool decode_insn16(DisasContext *ctx, uint16_t insn);
>  /* auto-generated decoder*/
>  #include "decode_insn16.inc.c"
>  #include "insn_trans/trans_rvc.inc.c"
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index 9c6c109327..c7a1b063ed 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -7,14 +7,14 @@ decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
>
>  target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
>  	$(call quiet-command, \
> -	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
> -	  "GEN", $(TARGET_DIR)$@)
> +	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
> +          $(decode32-y), "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/decode_insn16.inc.c: \
>    $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
>  	$(call quiet-command, \
> -	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
> -	  "GEN", $(TARGET_DIR)$@)
> +	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
> +          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
>  	target/riscv/decode_insn16.inc.c

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
