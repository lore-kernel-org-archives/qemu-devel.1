Received: from eggs.gnu.org ([209.51.188.92]:58157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4tm-0002fU-Vp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4tm-0008Hu-8F
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:16:18 -0500
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-6-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-6-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 12:16:21 +0100
Message-ID: <CABoDooO-8HDMU6u_+JZHJRSvSCNp6bWewVoorX8_ekDRsyqtew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm/translate-a64: Don't
 underdecode add/sub extended register
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
> In the "add/subtract (extended register)" encoding group, the "opt"
> field in bits [23:22] must be zero. Correctly UNDEF the unallocated
> encodings where this field is not zero.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-a64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2cade64ed25..efd2f6490b5 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -4204,12 +4204,13 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
>      bool setflags = extract32(insn, 29, 1);
>      bool sub_op = extract32(insn, 30, 1);
>      bool sf = extract32(insn, 31, 1);
> +    bool opt = extract32(insn, 22, 2);

I'd prefer an int to a bool.

Otherwise:

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

>      TCGv_i64 tcg_rm, tcg_rn; /* temps */
>      TCGv_i64 tcg_rd;
>      TCGv_i64 tcg_result;
>
> -    if (imm3 > 4) {
> +    if (imm3 > 4 || opt != 0) {
>          unallocated_encoding(s);
>          return;
>      }
> --
> 2.20.1
>
