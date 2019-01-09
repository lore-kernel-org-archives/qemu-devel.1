Received: from eggs.gnu.org ([209.51.188.92]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBTT-0005ye-Ab
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBTS-0005Yy-2p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:52:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghBTR-0005Yd-Tf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:52:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so7049773wmc.5
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 02:52:37 -0800 (PST)
References: <cover.1546532844.git.balaton@eik.bme.hu>
	<a977bd81f7c1f2896837671545fbb01ebf286f4a.1546532844.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c6cdb4b-b15c-0152-2cfe-4ac813d15111@redhat.com>
Date: Wed, 9 Jan 2019 11:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <a977bd81f7c1f2896837671545fbb01ebf286f4a.1546532844.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] smbus: Add a helper to generate SPD
 EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Zoltan,

On 1/3/19 5:27 PM, BALATON Zoltan wrote:
> There are several boards with SPD EEPROMs that are now using
> duplicated or slightly different hard coded data. Add a helper to
> generate SPD data for a memory module of given type and size that
> could be used by these boards (either as is or with further changes if
> needed) which should help cleaning this up and avoid further duplication.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v3: Fixed a tab indent
> v2: Added errp parameter to pass errors back to caller
> 
>  hw/i2c/smbus_eeprom.c  | 130 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/i2c/smbus.h |   3 ++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3de35..bef24a1ca4 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -23,6 +23,9 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus.h"
> @@ -162,3 +165,130 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>          smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
>      }
>  }
> +
> +/* Generate SDRAM SPD EEPROM data describing a module of type and size */
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size,
> +                           Error **errp)
> +{
> +    uint8_t *spd;
> +    uint8_t nbanks;
> +    uint16_t density;
> +    uint32_t size;
> +    int min_log2, max_log2, sz_log2;
> +    int i;
> +
> +    switch (type) {
> +    case SDR:
> +        min_log2 = 2;
> +        max_log2 = 9;
> +        break;
> +    case DDR:
> +        min_log2 = 5;
> +        max_log2 = 12;
> +        break;
> +    case DDR2:
> +        min_log2 = 7;
> +        max_log2 = 14;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    size = ram_size >> 20; /* work in terms of megabytes */
> +    if (size < 4) {
> +        error_setg(errp, "SDRAM size is too small");
> +        return NULL;
> +    }
> +    sz_log2 = 31 - clz32(size);
> +    size = 1U << sz_log2;
> +    if (ram_size > size * MiB) {
> +        error_setg(errp, "SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, "
> +                   "truncating to %u MB", ram_size, size);
> +    }
> +    if (sz_log2 < min_log2) {
> +        error_setg(errp,
> +                   "Memory size is too small for SDRAM type, adjusting type");
> +        if (size >= 32) {
> +            type = DDR;
> +            min_log2 = 5;
> +            max_log2 = 12;
> +        } else {
> +            type = SDR;
> +            min_log2 = 2;
> +            max_log2 = 9;
> +        }
> +    }
> +
> +    nbanks = 1;
> +    while (sz_log2 > max_log2 && nbanks < 8) {
> +        sz_log2--;
> +        nbanks++;
> +    }
> +
> +    if (size > (1ULL << sz_log2) * nbanks) {
> +        error_setg(errp, "Memory size is too big for SDRAM, truncating");
> +    }
> +
> +    /* split to 2 banks if possible to avoid a bug in MIPS Malta firmware */
> +    if (nbanks == 1 && sz_log2 > min_log2) {
> +        sz_log2--;
> +        nbanks++;
> +    }
> +
> +    density = 1ULL << (sz_log2 - 2);
> +    switch (type) {
> +    case DDR2:
> +        density = (density & 0xe0) | (density >> 8 & 0x1f);
> +        break;
> +    case DDR:
> +        density = (density & 0xf8) | (density >> 8 & 0x07);
> +        break;
> +    case SDR:
> +    default:
> +        density &= 0xff;
> +        break;
> +    }
> +
> +    spd = g_malloc0(256);

I think this buffer is eeprom-dependant, not SPD related.
Wouldn't it be cleaner to pass the (previously created) buffer as
argument such:

  /* return true on success */
  bool spd_data_fill(void *buf, size_t bufsize,
                     enum sdram_type type, ram_addr_t ram_size,
                     Error **errp);

or return something else like ssize_t.

> +    spd[0] = 128;   /* data bytes in EEPROM */
> +    spd[1] = 8;     /* log2 size of EEPROM */
> +    spd[2] = type;
> +    spd[3] = 13;    /* row address bits */
> +    spd[4] = 10;    /* column address bits */
> +    spd[5] = (type == DDR2 ? nbanks - 1 : nbanks);
> +    spd[6] = 64;    /* module data width */
> +                    /* reserved / data width high */
> +    spd[8] = 4;     /* interface voltage level */
> +    spd[9] = 0x25;  /* highest CAS latency */
> +    spd[10] = 1;    /* access time */
> +                    /* DIMM configuration 0 = non-ECC */
> +    spd[12] = 0x82; /* refresh requirements */
> +    spd[13] = 8;    /* primary SDRAM width */
> +                    /* ECC SDRAM width */
> +    spd[15] = (type == DDR2 ? 0 : 1); /* reserved / delay for random col rd */
> +    spd[16] = 12;   /* burst lengths supported */
> +    spd[17] = 4;    /* banks per SDRAM device */
> +    spd[18] = 12;   /* ~CAS latencies supported */
> +    spd[19] = (type == DDR2 ? 0 : 1); /* reserved / ~CS latencies supported */
> +    spd[20] = 2;    /* DIMM type / ~WE latencies */
> +                    /* module features */
> +                    /* memory chip features */
> +    spd[23] = 0x12; /* clock cycle time @ medium CAS latency */
> +                    /* data access time */
> +                    /* clock cycle time @ short CAS latency */
> +                    /* data access time */
> +    spd[27] = 20;   /* min. row precharge time */
> +    spd[28] = 15;   /* min. row active row delay */
> +    spd[29] = 20;   /* min. ~RAS to ~CAS delay */
> +    spd[30] = 45;   /* min. active to precharge time */
> +    spd[31] = density;
> +    spd[32] = 20;   /* addr/cmd setup time */
> +    spd[33] = 8;    /* addr/cmd hold time */
> +    spd[34] = 20;   /* data input setup time */
> +    spd[35] = 8;    /* data input hold time */
> +
> +    /* checksum */
> +    for (i = 0; i < 63; i++) {
> +        spd[63] += spd[i];
> +    }
> +    return spd;
> +}
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index d8b1b9ee81..d3dd0fcb14 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -93,4 +93,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                         const uint8_t *eeprom_spd, int size);
>  
> +enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size, Error **errp);
> +
>  #endif
> 
