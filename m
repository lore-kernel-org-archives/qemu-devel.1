Received: from eggs.gnu.org ([209.51.188.92]:57207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4pQ-0007jg-73
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4pP-0006Hl-Ak
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:11:48 -0500
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-4-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-4-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 12:11:44 +0100
Message-ID: <CABoDooPjnoh86VMwmq6CcOs1e5-ddBCfSp7aCvQGkTY9AAQauA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/7] target/arm/translate-a64: Don't
 underdecode SIMD ld/st multiple
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Fri, Jan 25, 2019 at 7:26 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the AdvSIMD load/store multiple structures encodings,
> the non-post-indexed case should have zeroes in [20:16]
> (which is the Rm field for the post-indexed case).
> Correctly UNDEF the currently unallocated encodings which
> have non-zeroes in those bits.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8e081758e03..c1f0cad7691 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3249,6 +3249,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
>  {
>      int rt = extract32(insn, 0, 5);
>      int rn = extract32(insn, 5, 5);
> +    int rm = extract32(insn, 16, 5);
>      int size = extract32(insn, 10, 2);
>      int opcode = extract32(insn, 12, 4);
>      bool is_store = !extract32(insn, 22, 1);
> @@ -3268,6 +3269,11 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
>          return;
>      }
>
> +    if (!is_postidx && rm != 0) {
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
>      /* From the shared decode logic */
>      switch (opcode) {
>      case 0x0:
> @@ -3367,7 +3373,6 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
>      }
>
>      if (is_postidx) {
> -        int rm = extract32(insn, 16, 5);
>          if (rm == 31) {
>              tcg_gen_mov_i64(tcg_rn, tcg_addr);
>          } else {
> --
> 2.20.1
>
