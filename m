Received: from eggs.gnu.org ([209.51.188.92]:56942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4o0-0006Xw-1G
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4nz-0005kw-Ac
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:10:20 -0500
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-3-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-3-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 12:10:27 +0100
Message-ID: <CABoDooM4=pTLvdVB9=uOz8n93qMGfR0poq==SfbfvYMfvWGy8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/7] target/arm/translate-a64: Don't
 underdecode PRFM
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
> The PRFM prefetch insn in the load/store with imm9 encodings
> requires idx field 0b00; we were underdecoding this by
> only checking !is_unpriv (which is equivalent to idx != 2).
> Correctly UNDEF the unallocated encodings where idx == 0b01
> and 0b11 as well as 0b10.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index e6df303e321..8e081758e03 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -2803,7 +2803,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
>      } else {
>          if (size == 3 && opc == 2) {
>              /* PRFM - prefetch */
> -            if (is_unpriv) {
> +            if (idx != 0) {
>                  unallocated_encoding(s);
>                  return;
>              }
> --
> 2.20.1
>
