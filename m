Received: from eggs.gnu.org ([2001:4830:134:3::10]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM26-0001DF-Ff
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM25-0003dV-7l
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:58 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEM24-0003cp-VV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:57 -0400
Received: by mail-lf0-x242.google.com with SMTP id w8-v6so28159943lfe.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-18-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-18-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:44:29 +0000
Message-ID: <CAKmqyKNyXyL_5JWsbNHY_3GmDUBWBDHDwhTnB55iaOHmsmLALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 17/29] target-microblaze: dec_msr: Use
 bool and extract32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:32 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Use bool and extract32 to represent the to, clr and
> clrset flags.

> No functional change.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/translate.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 3029e0e873..d2788451fe 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -458,17 +458,20 @@ static void dec_msr(DisasContext *dc)
>   {
>       CPUState *cs = CPU(dc->cpu);
>       TCGv_i32 t0, t1;
> -    unsigned int sr, to, rn;
> +    unsigned int sr, rn;
> +    bool to, clrset;

> -    sr = dc->imm & ((1 << 14) - 1);
> -    to = dc->imm & (1 << 14);
> +    sr = extract32(dc->imm, 0, 14);
> +    to = extract32(dc->imm, 14, 1);
> +    clrset = extract32(dc->imm, 15, 1) == 0;
>       dc->type_b = 1;
> -    if (to)
> +    if (to) {
>           dc->cpustate_changed = 1;
> +    }

>       /* msrclr and msrset.  */
> -    if (!(dc->imm & (1 << 15))) {
> -        unsigned int clr = dc->ir & (1 << 16);
> +    if (clrset) {
> +        bool clr = extract32(dc->ir, 16, 1);

>           LOG_DIS("msr%s r%d imm=%x\n", clr ? "clr" : "set",
>                   dc->rd, dc->imm);
> --
> 2.14.1
