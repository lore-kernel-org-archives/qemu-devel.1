Received: from eggs.gnu.org ([209.51.188.92]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpLN-0007Hq-4t
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpLL-0000pR-82
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:30:56 -0400
MIME-Version: 1.0
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-3-richard.henderson@linaro.org>
In-Reply-To: <20190401031155.21293-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Apr 2019 16:29:21 -0700
Message-ID: <CAKmqyKNZZGQnPy3hw6DWEif7Oe2Jz=owMTbGa9atnqu_tZwENw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Sun, Mar 31, 2019 at 8:15 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The generated functions are only used within translate.c
> and do not need to be global, or declared.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>         $(call quiet-command, \
> -         $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
> -         "GEN", $(TARGET_DIR)$@)
> +         $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
> +          $(decode32-y), "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/decode_insn16.inc.c: \
>    $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
>         $(call quiet-command, \
> -         $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
> -         "GEN", $(TARGET_DIR)$@)
> +         $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
> +          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
>         target/riscv/decode_insn16.inc.c
> --
> 2.17.1
>
>
