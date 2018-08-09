Received: from eggs.gnu.org ([2001:4830:134:3::10]:40208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndUk-00031y-Ss
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndUj-0001wU-WC
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:28:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180809034033.10579-7-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-7-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 9 Aug 2018 07:28:20 +0200
Message-ID: <CABoDooPoFa1+UHHOwN+9DJrG7k=88sio6EFL+-Hz0tX1cLfyCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Fix sign-extension in
 sve do_ldr/do_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org

On Thu, Aug 9, 2018 at 5:40 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The expression (int) imm + (uint32_t) len_align turns into uint32_t
> and thus with negative imm produces a memory operation at the wrong
> offset.  None of the numbers involved are particularly large, so
> change everything to use int.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/translate-sve.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 89efc80ee7..9e63b5f8e5 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4372,12 +4372,11 @@ static bool trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
>   * The load should begin at the address Rn + IMM.
>   */
>
> -static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
> -                   int rn, int imm)
> +static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
>  {
> -    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
> -    uint32_t len_remain = len % 8;
> -    uint32_t nparts = len / 8 + ctpop8(len_remain);
> +    int len_align = QEMU_ALIGN_DOWN(len, 8);
> +    int len_remain = len % 8;
> +    int nparts = len / 8 + ctpop8(len_remain);
>      int midx = get_mem_index(s);
>      TCGv_i64 addr, t0, t1;
>
> @@ -4458,12 +4457,11 @@ static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
>  }
>
>  /* Similarly for stores.  */
> -static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
> -                   int rn, int imm)
> +static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
>  {
> -    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
> -    uint32_t len_remain = len % 8;
> -    uint32_t nparts = len / 8 + ctpop8(len_remain);
> +    int len_align = QEMU_ALIGN_DOWN(len, 8);
> +    int len_remain = len % 8;
> +    int nparts = len / 8 + ctpop8(len_remain);
>      int midx = get_mem_index(s);
>      TCGv_i64 addr, t0;
>
> --
> 2.17.1
>
