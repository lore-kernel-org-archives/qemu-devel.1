Received: from eggs.gnu.org ([2001:4830:134:3::10]:56973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7EL-0000ug-9I
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7EK-0004E4-21
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:39:49 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee7EJ-0004DC-LF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:39:47 -0500
Received: by mail-lf0-x241.google.com with SMTP id k19so2690681lfj.1
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 14:39:47 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-6-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:39:15 -0800
Message-ID: <CAKmqyKObg+PnXNMp2CwpkYOOsa46cYZ44Eo59BAacWUu=mYHBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 05/14] sdhci: implement UHS-I voltage
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sd.h    | 16 ++++++++++++++++
>  include/hw/sd/sdhci.h |  1 +
>  hw/sd/core.c          | 13 +++++++++++++
>  hw/sd/sd.c            | 13 +++++++++++++
>  hw/sd/sdhci.c         | 12 +++++++++++-
>  hw/sd/trace-events    |  1 +
>  6 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 96caefe373..f086679493 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -55,6 +55,20 @@
>  #define AKE_SEQ_ERROR          (1 << 3)
>  #define OCR_CCS_BITN        30
>
> +typedef enum {
> +    SD_VOLTAGE_0_4V     =3D 400,  /* currently not supported */
> +    SD_VOLTAGE_1_8V     =3D 1800,
> +    SD_VOLTAGE_3_0V     =3D 3000,
> +    SD_VOLTAGE_3_3V     =3D 3300,
> +} sd_voltage_mv_t;
> +
> +typedef enum  {
> +    UHS_NOT_SUPPORTED   =3D 0,
> +    UHS_I               =3D 1,
> +    UHS_II              =3D 2,    /* currently not supported */
> +    UHS_III             =3D 3,    /* currently not supported */
> +} sd_uhs_mode_t;
> +
>  typedef enum {
>      sd_none =3D -1,
>      sd_bc =3D 0, /* broadcast -- no response */
> @@ -88,6 +102,7 @@ typedef struct {
>      void (*write_data)(SDState *sd, uint8_t value);
>      uint8_t (*read_data)(SDState *sd);
>      bool (*data_ready)(SDState *sd);
> +    void (*set_voltage)(SDState *sd, uint16_t millivolts);
>      void (*enable)(SDState *sd, bool enable);
>      bool (*get_inserted)(SDState *sd);
>      bool (*get_readonly)(SDState *sd);
> @@ -134,6 +149,7 @@ void sd_enable(SDState *sd, bool enable);
>  /* Functions to be used by qdevified callers (working via
>   * an SDBus rather than directly with SDState)
>   */
> +void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
>  int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
>  void sdbus_write_data(SDBus *sd, uint8_t value);
>  uint8_t sdbus_read_data(SDBus *sd);
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 0fff941a98..06e3784e54 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -93,6 +93,7 @@ typedef struct SDHCIState {
>      /* Configurable properties */
>      bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int=
 */
>      uint8_t sd_spec_version;
> +    uint8_t uhs_mode;
>  } SDHCIState;
>
>  #define TYPE_PCI_SDHCI "sdhci-pci"
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 498284f109..6d198ea775 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -41,6 +41,19 @@ static SDState *get_card(SDBus *sdbus)
>      return SD_CARD(kid->child);
>  }
>
> +void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
> +{
> +    SDState *card =3D get_card(sdbus);
> +
> +    trace_sdbus_set_voltage(sdbus_name(sdbus), millivolts);
> +    if (card) {
> +        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +
> +        assert(sc->set_voltage);
> +        sc->set_voltage(card, millivolts);
> +    }
> +}
> +
>  int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
>  {
>      SDState *card =3D get_card(sdbus);
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 35347a5bbc..609b2da14f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -128,6 +128,18 @@ struct SDState {
>      bool enable;
>  };
>
> +static void sd_set_voltage(SDState *sd, uint16_t millivolts)
> +{
> +    switch (millivolts) {
> +    case 3001 ... 3600: /* SD_VOLTAGE_3_3V */
> +    case 2001 ... 3000: /* SD_VOLTAGE_3_0V */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "SD card voltage not supported: %=
.3fV",
> +                      millivolts / 1000.f);
> +    }
> +}
> +
>  static void sd_set_mode(SDState *sd)
>  {
>      switch (sd->state) {
> @@ -1925,6 +1937,7 @@ static void sd_class_init(ObjectClass *klass, void =
*data)
>      dc->reset =3D sd_reset;
>      dc->bus_type =3D TYPE_SD_BUS;
>
> +    sc->set_voltage =3D sd_set_voltage;
>      sc->do_command =3D sd_do_command;
>      sc->write_data =3D sd_write_data;
>      sc->read_data =3D sd_read_data;
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index b7e69fbc22..aec6ca4d14 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1255,7 +1255,16 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>          sdhci_update_irq(s);
>          break;
>      case SDHC_ACMD12ERRSTS:
> -        MASKED_WRITE(s->acmd12errsts, mask, value);
> +        MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
> +        if (s->uhs_mode >=3D UHS_I) {
> +            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
> +
> +            if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
> +                sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
> +            } else {
> +                sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
> +            }
> +        }
>          break;
>
>      case SDHC_CAPAB:
> @@ -1310,6 +1319,7 @@ static void sdhci_init_readonly_registers(SDHCIStat=
e *s, Error **errp)
>
>  #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>      DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
> +    DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
>      \
>      /* Capabilities registers provide information on supported
>       * features of this specific host controller implementation */ \
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index ea2746c8b7..84d2f398b1 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -4,6 +4,7 @@
>  sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t c=
rc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
>  sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
>  sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
> +sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV=
)"
>
>  # hw/sd/sdhci.c
>  sdhci_set_inserted(const char *level) "card state changed: %s"
> --
> 2.15.1
>
>
