Received: from eggs.gnu.org ([2001:4830:134:3::10]:37911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfVb-0001Kl-CT
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfVa-0007g8-Am
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:36:51 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eHfVa-0007fg-4V
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:36:50 -0500
Received: by mail-wm0-x241.google.com with SMTP id y80so13423458wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 16:36:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171103000109.28244-7-frasse.iglesias@gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<20171103000109.28244-7-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Nov 2017 16:36:18 -0800
Message-ID: <CAKmqyKNqi40S_mEuiJMQDW2F=pX6yPnb0F88PfD6y28xpb3O=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 06/13] xilinx_spips: Update striping to
 be big-endian bit order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se, "mar.krzeminski" <mar.krzeminski@gmail.com>

On Thu, Nov 2, 2017 at 5:01 PM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Update striping functionality to be big-endian bit order (as according to
> the Zynq-7000 Technical Reference Manual). Output thereafter the even bits
> into the flash memory connected to the lower QSPI bus and the odd bits into
> the flash memory connected to the upper QSPI bus.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>  hw/ssi/xilinx_spips.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 559fa79..7accf5d 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -208,14 +208,14 @@ static void xilinx_spips_reset(DeviceState *d)
>      xilinx_spips_update_cs_lines(s);
>  }
>
> -/* N way (num) in place bit striper. Lay out row wise bits (LSB to MSB)
> +/* N way (num) in place bit striper. Lay out row wise bits (MSB to LSB)
>   * column wise (from element 0 to N-1). num is the length of x, and dir
>   * reverses the direction of the transform. Best illustrated by example:
>   * Each digit in the below array is a single bit (num == 3):
>   *
> - * {{ 76543210, }  ----- stripe (dir == false) -----> {{ FCheb630, }
> - *  { hgfedcba, }                                      { GDAfc741, }
> - *  { HGFEDCBA, }} <---- upstripe (dir == true) -----  { HEBgda52, }}
> + * {{ 76543210, }  ----- stripe (dir == false) -----> {{ 741gdaFC, }
> + *  { hgfedcba, }                                      { 630fcHEB, }
> + *  { HGFEDCBA, }} <---- upstripe (dir == true) -----  { 52hebGDA, }}
>   */
>
>  static inline void stripe8(uint8_t *x, int num, bool dir)
> @@ -223,15 +223,15 @@ static inline void stripe8(uint8_t *x, int num, bool dir)
>      uint8_t r[num];
>      memset(r, 0, sizeof(uint8_t) * num);
>      int idx[2] = {0, 0};
> -    int bit[2] = {0, 0};
> +    int bit[2] = {0, 7};
>      int d = dir;
>
>      for (idx[0] = 0; idx[0] < num; ++idx[0]) {
> -        for (bit[0] = 0; bit[0] < 8; ++bit[0]) {
> -            r[idx[d]] |= x[idx[!d]] & 1 << bit[!d] ? 1 << bit[d] : 0;
> +        for (bit[0] = 7; bit[0] != -1; bit[0] += -1) {

I think this is easier to read:
for (bit[0] = 7; bit[0] >= 0; bit[0]--)

> +            r[idx[!d]] |= x[idx[d]] & 1 << bit[d] ? 1 << bit[!d] : 0;
>              idx[1] = (idx[1] + 1) % num;
>              if (!idx[1]) {
> -                bit[1]++;
> +                bit[1] += -1;

bit[1]--

Otherwise:

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

>              }
>          }
>      }
> @@ -266,8 +266,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>          }
>
>          for (i = 0; i < num_effective_busses(s); ++i) {
> +            int bus = num_effective_busses(s) - 1 - i;
>              DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
> -            tx_rx[i] = ssi_transfer(s->spi[i], (uint32_t)tx_rx[i]);
> +            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
>              DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
>          }
>
> --
> 2.9.3
>
>
