Received: from eggs.gnu.org ([2001:4830:134:3::10]:56344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee931-0002XP-7D
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee92Y-0005DB-GF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:36:15 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee92X-0005Ai-Sy
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:35:46 -0500
Received: by mail-lf0-x242.google.com with SMTP id k19so2959157lfj.1
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:35:45 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123032135.28863-6-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
	<20180123032135.28863-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 16:35:13 -0800
Message-ID: <CAKmqyKN4BXvM=icr+A+4tUiSd7aABQu_sebOTYL4hR3WyqCO-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/12] sdcard: add more trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:21 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c         | 32 ++++++++++++++++++++++++++------
>  hw/sd/trace-events | 13 +++++++++++++
>  2 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 03263e08ae..dc4b2329e4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -177,6 +177,8 @@ static bool sd_get_cmd_line(SDState *sd)
>
>  static void sd_set_voltage(SDState *sd, uint16_t millivolts)
>  {
> +    trace_sdcard_set_voltage(millivolts);
> +
>      switch (millivolts) {
>      case 3001 ... 3600: /* SD_VOLTAGE_3_3V */
>      case 2001 ... 3000: /* SD_VOLTAGE_3_0V */
> @@ -272,6 +274,7 @@ static void sd_ocr_powerup(void *opaque)
>  {
>      SDState *sd =3D opaque;
>
> +    trace_sdcard_powerup();
>      /* Set powered up bit in OCR */
>      assert(!(sd->ocr & OCR_POWER_UP));
>      sd->ocr |=3D OCR_POWER_UP;
> @@ -475,6 +478,7 @@ static void sd_reset(DeviceState *dev)
>      uint64_t size;
>      uint64_t sect;
>
> +    trace_sdcard_reset();
>      if (sd->blk) {
>          blk_get_geometry(sd->blk, &sect);
>      } else {
> @@ -528,7 +532,10 @@ static void sd_cardchange(void *opaque, bool load, E=
rror **errp)
>      bool readonly =3D sd_get_readonly(sd);
>
>      if (inserted) {
> +        trace_sdcard_inserted(readonly);
>          sd_reset(dev);
> +    } else {
> +        trace_sdcard_ejected();
>      }
>
>      /* The IRQ notification is for legacy non-QOM SD controller devices;
> @@ -660,6 +667,7 @@ static void sd_erase(SDState *sd)
>      uint64_t erase_start =3D sd->erase_start;
>      uint64_t erase_end =3D sd->erase_end;
>
> +    trace_sdcard_erase();
>      if (!sd->erase_start || !sd->erase_end) {
>          sd->card_status |=3D ERASE_SEQ_ERROR;
>          return;
> @@ -749,6 +757,11 @@ static void sd_lock_command(SDState *sd)
>      else
>          pwd_len =3D 0;
>
> +    if (lock) {
> +        trace_sdcard_lock();
> +    } else {
> +        trace_sdcard_unlock();
> +    }
>      if (erase) {
>          if (!(sd->card_status & CARD_IS_LOCKED) || sd->blk_len > 1 ||
>                          set_pwd || clr_pwd || lock || sd->wp_switch ||
> @@ -1075,10 +1088,12 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d,
>      case 16:   /* CMD16:  SET_BLOCKLEN */
>          switch (sd->state) {
>          case sd_transfer_state:
> -            if (req.arg > (1 << HWBLOCK_SHIFT))
> +            if (req.arg > (1 << HWBLOCK_SHIFT)) {
>                  sd->card_status |=3D BLOCK_LEN_ERROR;
> -            else
> +            } else {
> +                trace_sdcard_set_blocklen(req.arg);
>                  sd->blk_len =3D req.arg;
> +            }
>
>              return sd_r1;
>
> @@ -1450,10 +1465,13 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>                  if ((req.arg & ACMD41_ENQUIRY_MASK) !=3D 0) {
>                      timer_del(sd->ocr_power_timer);
>                      sd_ocr_powerup(sd);
> -                } else if (!timer_pending(sd->ocr_power_timer)) {
> -                    timer_mod_ns(sd->ocr_power_timer,
> -                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> -                                  + OCR_POWER_DELAY_NS));
> +                } else {
> +                    trace_sdcard_inquiry_cmd41();
> +                    if (!timer_pending(sd->ocr_power_timer)) {
> +                        timer_mod_ns(sd->ocr_power_timer,
> +                                     (qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL)
> +                                      + OCR_POWER_DELAY_NS));
> +                    }
>                  }
>              }
>
> @@ -1666,6 +1684,7 @@ void sd_write_data(SDState *sd, uint8_t value)
>      if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
>          return;
>
> +    trace_sdcard_write_data(sd->current_cmd, value);
>      switch (sd->current_cmd) {
>      case 24:   /* CMD24:  WRITE_SINGLE_BLOCK */
>          sd->data[sd->data_offset ++] =3D value;
> @@ -1803,6 +1822,7 @@ uint8_t sd_read_data(SDState *sd)
>
>      io_len =3D (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
>
> +    trace_sdcard_read_data(sd->current_cmd, io_len);
>      switch (sd->current_cmd) {
>      case 6:    /* CMD6:   SWITCH_FUNCTION */
>          ret =3D sd->data[sd->data_offset ++];
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index b2aa19ec0d..3040d32560 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -27,8 +27,21 @@ sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
>  sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD=
%d arg 0x%08x (state %s)"
>  sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
>  sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
> +sdcard_powerup(void) ""
> +sdcard_inquiry_cmd41(void) ""
> +sdcard_set_enable(bool current_state, bool new_state) "%u -> %u"
> +sdcard_reset(void) ""
> +sdcard_set_blocklen(uint16_t length) "0x%04x"
> +sdcard_inserted(bool readonly) "read_only: %u"
> +sdcard_ejected(void) ""
> +sdcard_erase(void) ""
> +sdcard_lock(void) ""
> +sdcard_unlock(void) ""
>  sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size =
0x%x"
>  sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size=
 0x%x"
> +sdcard_write_data(uint8_t cmd, uint8_t value) "CMD%02d value 0x%02x"
> +sdcard_read_data(uint8_t cmd, int length) "CMD%02d len %d"
> +sdcard_set_voltage(uint16_t millivolts) "%u mV"
>
>  # hw/sd/milkymist-memcard.c
>  milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08=
x value 0x%08x"
> --
> 2.15.1
>
>
