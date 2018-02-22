Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eozVx-0004m6-RS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eozVv-0006SF-Bw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:38:57 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eozVu-0006QI-V3
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:38:55 -0500
Received: by mail-lf0-x244.google.com with SMTP id 70so9705169lfw.2
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 14:38:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222222844.7109-2-frasse.iglesias@gmail.com>
References: <20180222222844.7109-1-frasse.iglesias@gmail.com>
	<20180222222844.7109-2-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Feb 2018 14:38:23 -0800
Message-ID: <CAKmqyKN+_vdSVUn92Te-6DP4bP33ZE+OQ_HSe3erC4B7mtM70Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] xilinx_spips: Enable only two slaves
 when reading/writing with stripe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se

On Thu, Feb 22, 2018 at 2:28 PM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Assert only the lower cs on bus 0 and upper cs on bus 1 when both buses and
> chip selects are enabled (e.g reading/writing with stripe).
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>  hw/ssi/xilinx_spips.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8af36ca3d4..e566d179fe 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -223,7 +223,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
>  {
>      int i;
>
> -    for (i = 0; i < s->num_cs; i++) {
> +    for (i = 0; i < s->num_cs * s->num_busses; i++) {
>          bool old_state = s->cs_lines_state[i];
>          bool new_state = field & (1 << i);
>
> @@ -234,7 +234,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
>          }
>          qemu_set_irq(s->cs_lines[i], !new_state);
>      }
> -    if (!(field & ((1 << s->num_cs) - 1))) {
> +    if (!(field & ((1 << (s->num_cs * s->num_busses)) - 1))) {
>          s->snoop_state = SNOOP_CHECKING;
>          s->cmd_dummies = 0;
>          s->link_state = 1;
> @@ -248,7 +248,41 @@ static void xlnx_zynqmp_qspips_update_cs_lines(XlnxZynqMPQSPIPS *s)
>  {
>      if (s->regs[R_GQSPI_GF_SNAPSHOT]) {
>          int field = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, CHIP_SELECT);
> -        xilinx_spips_update_cs(XILINX_SPIPS(s), field);
> +        bool both_buses_enabled;
> +        uint8_t buses;
> +        int cs = 0;
> +
> +        buses = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_BUS_SELECT);
> +        both_buses_enabled = (buses & 0x3) == 0x3;
> +
> +        if (both_buses_enabled) {
> +            /* Bus 0 lower cs */
> +            if (field & 1) {
> +                cs |= 1;
> +            }
> +            /* Bus 1 upper cs */
> +            if (field & (1 << 1)) {
> +                cs |= 1 << 3;
> +            }
> +        } else {
> +            /* Bus 0 lower cs */
> +            if (buses & 1 && field & 1) {
> +                cs |= 1;
> +            }
> +            /* Bus 0 upper cs */
> +            if (buses & 1 && field & (1 << 1)) {
> +                cs |= 1 << 1;
> +            }
> +            /* Bus 1 lower cs */
> +            if (buses & (1 << 1) && field & 1) {
> +                cs |= 1 << 2;
> +            }
> +            /* Bus 1 upper cs */
> +            if (buses & (1 << 1) && field & (1 << 1)) {
> +                cs |= 1 << 3;
> +            }

It might make more sense to have the buses & 1 in it's own if
statement and have nested if statements here. Just to be easier to
follow.

Tested-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> +        }
> +        xilinx_spips_update_cs(XILINX_SPIPS(s), cs);
>      }
>  }
>
> @@ -260,7 +294,7 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
>      if (num_effective_busses(s) == 2) {
>          /* Single bit chip-select for qspi */
>          field &= 0x1;
> -        field |= field << 1;
> +        field |= field << 3;
>      /* Dual stack U-Page */
>      } else if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_TWO_MEM &&
>                 s->regs[R_LQSPI_STS] & LQSPI_CFG_U_PAGE) {
> --
> 2.11.0
>
>
