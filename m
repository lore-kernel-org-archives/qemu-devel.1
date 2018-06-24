Received: from eggs.gnu.org ([2001:4830:134:3::10]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fX86t-0004ES-3z
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 12:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fX86r-0003Xd-Fg
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 12:43:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-12-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6bed73d5-7af4-7513-c714-4a25f3c7b489@amsat.org>
Date: Sun, 24 Jun 2018 13:43:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180621171257.14897-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/11] hw/block/pflash_cfi: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 06/21/2018 02:12 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/block/pflash_cfi01.c | 42 +++++++++++++++--------------------------
>  hw/block/pflash_cfi02.c | 18 +++++++++---------
>  hw/block/trace-events   | 13 +++++++++++++
>  3 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index e4b5b3c273..bffb4c40e7 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -47,6 +47,7 @@
>  #include "qemu/log.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
> +#include "trace.h"
>  
>  #define PFLASH_BUG(fmt, ...) \
>  do { \
> @@ -120,7 +121,7 @@ static void pflash_timer (void *opaque)
>  {
>      pflash_t *pfl = opaque;
>  
> -    DPRINTF("%s: command %02x done\n", __func__, pfl->cmd);
> +    trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
>      pfl->status ^= 0x80;
>      memory_region_rom_device_set_romd(&pfl->mem, true);
> @@ -218,15 +219,14 @@ static uint32_t pflash_devid_query(pflash_t *pfl, hwaddr offset)
>      switch (boff & 0xFF) {
>      case 0:
>          resp = pfl->ident0;
> -        DPRINTF("%s: Manufacturer Code %04x\n", __func__, resp);
> +        trace_pflash_manufacturer_id(resp);
>          break;
>      case 1:
>          resp = pfl->ident1;
> -        DPRINTF("%s: Device ID Code %04x\n", __func__, resp);
> +        trace_pflash_device_id(resp);
>          break;
>      default:
> -        DPRINTF("%s: Read Device Information offset=%x\n", __func__,
> -                (unsigned)offset);
> +        trace_pflash_device_info(offset);
>          return 0;
>          break;
>      }
> @@ -251,8 +251,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwaddr offset,
>      switch (width) {
>      case 1:
>          ret = p[offset];
> -        DPRINTF("%s: data offset " TARGET_FMT_plx " %02x\n",
> -                __func__, offset, ret);
> +        trace_pflash_data_read8(offset, ret);
>          break;
>      case 2:
>          if (be) {
> @@ -262,8 +261,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwaddr offset,
>              ret = p[offset];
>              ret |= p[offset + 1] << 8;
>          }
> -        DPRINTF("%s: data offset " TARGET_FMT_plx " %04x\n",
> -                __func__, offset, ret);
> +        trace_pflash_data_read16(offset, ret);
>          break;
>      case 4:
>          if (be) {
> @@ -277,8 +275,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwaddr offset,
>              ret |= p[offset + 2] << 16;
>              ret |= p[offset + 3] << 24;
>          }
> -        DPRINTF("%s: data offset " TARGET_FMT_plx " %08x\n",
> -                __func__, offset, ret);
> +        trace_pflash_data_read32(offset, ret);
>          break;
>      default:
>          DPRINTF("BUG in %s\n", __func__);
> @@ -294,11 +291,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>      uint32_t ret;
>  
>      ret = -1;
> -
> -#if 0
> -    DPRINTF("%s: reading offset " TARGET_FMT_plx " under cmd %02x width %d\n",
> -            __func__, offset, pfl->cmd, width);
> -#endif
> +    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>      switch (pfl->cmd) {
>      default:
>          /* This should never happen : reset state & treat it as a read */
> @@ -349,15 +342,14 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>              switch (boff) {
>              case 0:
>                  ret = pfl->ident0 << 8 | pfl->ident1;
> -                DPRINTF("%s: Manufacturer Code %04x\n", __func__, ret);
> +                trace_pflash_manufacturer_id(ret);
>                  break;
>              case 1:
>                  ret = pfl->ident2 << 8 | pfl->ident3;
> -                DPRINTF("%s: Device ID Code %04x\n", __func__, ret);
> +                trace_pflash_device_id(ret);
>                  break;
>              default:
> -                DPRINTF("%s: Read Device Information boff=%x\n", __func__,
> -                        (unsigned)boff);
> +                trace_pflash_device_info(boff);
>                  ret = 0;
>                  break;
>              }
> @@ -425,9 +417,7 @@ static inline void pflash_data_write(pflash_t *pfl, hwaddr offset,
>  {
>      uint8_t *p = pfl->storage;
>  
> -    DPRINTF("%s: block write offset " TARGET_FMT_plx
> -            " value %x counter %016" PRIx64 "\n",
> -            __func__, offset, value, pfl->counter);
> +    trace_pflash_data_write(offset, value, width, pfl->counter);
>      switch (width) {
>      case 1:
>          p[offset] = value;
> @@ -466,9 +456,7 @@ static void pflash_write(pflash_t *pfl, hwaddr offset,
>  
>      cmd = value;
>  
> -    DPRINTF("%s: writing offset " TARGET_FMT_plx " value %08x width %d wcycle 0x%x\n",
> -            __func__, offset, value, width, pfl->wcycle);
> -
> +    trace_pflash_write(offset, value, width, pfl->wcycle);
>      if (!pfl->wcycle) {
>          /* Set the device in I/O access mode */
>          memory_region_rom_device_set_romd(&pfl->mem, false);
> @@ -656,8 +644,8 @@ static void pflash_write(pflash_t *pfl, hwaddr offset,
>                    "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
>  
>   reset_flash:
> +    trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
> -
>      pfl->wcycle = 0;
>      pfl->cmd = 0;
>  }
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 6c18e5e578..0f8b7b8c7b 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -43,6 +43,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/host-utils.h"
>  #include "hw/sysbus.h"
> +#include "trace.h"
>  
>  //#define PFLASH_DEBUG
>  #ifdef PFLASH_DEBUG
> @@ -124,7 +125,7 @@ static void pflash_timer (void *opaque)
>  {
>      pflash_t *pfl = opaque;
>  
> -    DPRINTF("%s: command %02x done\n", __func__, pfl->cmd);
> +    trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
>      pfl->status ^= 0x80;
>      if (pfl->bypass) {
> @@ -143,8 +144,8 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>      uint32_t ret;
>      uint8_t *p;
>  
> -    DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
>      ret = -1;
> +    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>      /* Lazy reset to ROMD mode after a certain amount of read accesses */
>      if (!pfl->rom_mode && pfl->wcycle == 0 &&
>          ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
> @@ -172,7 +173,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>          switch (width) {
>          case 1:
>              ret = p[offset];
> -//            DPRINTF("%s: data offset %08x %02x\n", __func__, offset, ret);
> +            trace_pflash_data_read8(offset, ret);
>              break;
>          case 2:
>              if (be) {
> @@ -182,7 +183,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>                  ret = p[offset];
>                  ret |= p[offset + 1] << 8;
>              }
> -//            DPRINTF("%s: data offset %08x %04x\n", __func__, offset, ret);
> +            trace_pflash_data_read16(offset, ret);
>              break;
>          case 4:
>              if (be) {
> @@ -196,7 +197,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>                  ret |= p[offset + 2] << 16;
>                  ret |= p[offset + 3] << 24;
>              }
> -//            DPRINTF("%s: data offset %08x %08x\n", __func__, offset, ret);
> +            trace_pflash_data_read32(offset, ret);
>              break;
>          }
>          break;
> @@ -274,8 +275,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>  #endif
>          goto reset_flash;
>      }
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d %d\n", __func__,
> -            offset, value, width, pfl->wcycle);
> +    trace_pflash_write(offset, value, width, pfl->wcycle);
>      offset &= pfl->chip_len - 1;
>  
>      DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> @@ -345,8 +345,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              /* We need another unlock sequence */
>              goto check_unlock0;
>          case 0xA0:
> -            DPRINTF("%s: write data offset " TARGET_FMT_plx " %08x %d\n",
> -                    __func__, offset, value, width);
> +            trace_pflash_data_write(offset, value, width, 0);
>              p = pfl->storage;
>              if (!pfl->ro) {
>                  switch (width) {
> @@ -483,6 +482,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>  
>      /* Reset flash */
>   reset_flash:
> +    trace_pflash_reset();
>      pfl->bypass = 0;
>      pfl->wcycle = 0;
>      pfl->cmd = 0;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index d842c45409..f1017fac39 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -4,6 +4,19 @@
>  fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02x"
>  fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%02x"
>  
> +# hw/block/pflash_cfi0?.c
> +pflash_reset(void) "reset"
> +pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "offset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
> +pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle) "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
> +pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
> +pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"PRIx64" value:0x%02x"
> +pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"PRIx64" value:0x%04x"
> +pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"PRIx64" value:0x%08x"
> +pflash_data_write(uint64_t offset, uint32_t value, int width, uint64_t counter) "data offset:0x%04"PRIx64" value:0x%08x width:%d counter:0x%016"PRIx64
> +pflash_manufacturer_id(uint16_t id) "Read Manufacturer ID: 0x%04x"
> +pflash_device_id(uint16_t id) "Read Device ID: 0x%04x"
> +pflash_device_info(uint64_t offset) "Read Device Information offset:0x%04lx"

As noted by Thomas Huth in another review, this format is incorrect.

Correct (lx -> PRIx64):
pflash_device_info(uint64_t offset) "Read Device Information
offset:0x%04"PRIx64

> +
>  # hw/block/virtio-blk.c
>  virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req %p status %d"
>  virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p ret %d"
> 
