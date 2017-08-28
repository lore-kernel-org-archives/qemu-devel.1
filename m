Received: from eggs.gnu.org ([2001:4830:134:3::10]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTY8-0003Jk-SP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTY6-0005IC-Sv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:34:32 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-2-jsnow@redhat.com>
	<8e580b70-3b68-10b2-6f7b-8eddfbed0519@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <b50a5fe3-550e-cf5f-ad82-d2c204f0313c@redhat.com>
Date: Mon, 28 Aug 2017 19:34:20 -0400
MIME-Version: 1.0
In-Reply-To: <8e580b70-3b68-10b2-6f7b-8eddfbed0519@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 08/25/2017 09:33 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi John,
>=20
> On 08/08/2017 03:32 PM, John Snow wrote:
>> Out with the old, in with the new.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   Makefile.objs             |  1 +
>>   hw/ide/cmd646.c           | 10 +++-----
>>   hw/ide/core.c             | 65
>> +++++++++++++++++++----------------------------
>>   hw/ide/pci.c              | 17 ++++---------
>>   hw/ide/piix.c             | 11 ++++----
>>   hw/ide/trace-events       | 33 ++++++++++++++++++++++++
>>   hw/ide/via.c              | 10 +++-----
>>   include/hw/ide/internal.h |  1 -
>>   8 files changed, 78 insertions(+), 70 deletions(-)
>>   create mode 100644 hw/ide/trace-events
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 24a4ea0..967c092 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -153,6 +153,7 @@ trace-events-subdirs +=3D hw/acpi
>>   trace-events-subdirs +=3D hw/arm
>>   trace-events-subdirs +=3D hw/alpha
>>   trace-events-subdirs +=3D hw/xen
>> +trace-events-subdirs +=3D hw/ide
>>   trace-events-subdirs +=3D ui
>>   trace-events-subdirs +=3D audio
>>   trace-events-subdirs +=3D net
>> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
>> index 9ebb8d4..86b2a8f 100644
>> --- a/hw/ide/cmd646.c
>> +++ b/hw/ide/cmd646.c
>> @@ -32,6 +32,7 @@
>>   #include "sysemu/dma.h"
>>     #include "hw/ide/pci.h"
>> +#include "trace.h"
>>     /* CMD646 specific */
>>   #define CFR        0x50
>> @@ -195,9 +196,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr ad=
dr,
>>           val =3D 0xff;
>>           break;
>>       }
>> -#ifdef DEBUG_IDE
>> -    printf("bmdma: readb " TARGET_FMT_plx " : 0x%02x\n", addr, val);
>> -#endif
>> +
>> +    trace_bmdma_read_cmd646(addr, val);
>>       return val;
>>   }
>>   @@ -211,9 +211,7 @@ static void bmdma_write(void *opaque, hwaddr add=
r,
>>           return;
>>       }
>>   -#ifdef DEBUG_IDE
>> -    printf("bmdma: writeb " TARGET_FMT_plx " : 0x%" PRIx64 "\n",
>> addr, val);
>> -#endif
>> +    trace_bmdma_write_cmd646(addr, val);
>>       switch(addr & 3) {
>>       case 0:
>>           bmdma_cmd_writeb(bm, val);
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 0b48b64..53fa084 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -36,6 +36,7 @@
>>   #include "qemu/cutils.h"
>>     #include "hw/ide/internal.h"
>> +#include "trace.h"
>>     /* These values were based on a Seagate ST3500418AS but have been
>> modified
>>      to make more sense in QEMU */
>> @@ -656,10 +657,7 @@ void ide_cancel_dma_sync(IDEState *s)
>>        * write requests) pending and we can avoid to drain. */
>>       QLIST_FOREACH(req, &s->buffered_requests, list) {
>>           if (!req->orphaned) {
>> -#ifdef DEBUG_IDE
>> -            printf("%s: invoking cb %p of buffered request %p with"
>> -                   " -ECANCELED\n", __func__, req->original_cb, req);
>> -#endif
>> +            trace_ide_cancel_dma_sync_buffered(req->original_cb, req)=
;
>>               req->original_cb(req->original_opaque, -ECANCELED);
>>           }
>>           req->orphaned =3D true;
>> @@ -678,9 +676,7 @@ void ide_cancel_dma_sync(IDEState *s)
>>        * aio operation with preadv/pwritev.
>>        */
>>       if (s->bus->dma->aiocb) {
>> -#ifdef DEBUG_IDE
>> -        printf("%s: draining all remaining requests", __func__);
>> -#endif
>> +        trace_ide_cancel_dma_sync_remaining();
>>           blk_drain(s->blk);
>>           assert(s->bus->dma->aiocb =3D=3D NULL);
>>       }
>> @@ -741,9 +737,7 @@ static void ide_sector_read(IDEState *s)
>>           n =3D s->req_nb_sectors;
>>       }
>>   -#if defined(DEBUG_IDE)
>> -    printf("sector=3D%" PRId64 "\n", sector_num);
>> -#endif
>> +    trace_ide_sector_read(sector_num, n);
>>         if (!ide_sect_range_ok(s, sector_num, n)) {
>>           ide_rw_error(s);
>> @@ -1005,14 +999,14 @@ static void ide_sector_write(IDEState *s)
>>         s->status =3D READY_STAT | SEEK_STAT | BUSY_STAT;
>>       sector_num =3D ide_get_sector(s);
>> -#if defined(DEBUG_IDE)
>> -    printf("sector=3D%" PRId64 "\n", sector_num);
>> -#endif
>> +
>>       n =3D s->nsector;
>>       if (n > s->req_nb_sectors) {
>>           n =3D s->req_nb_sectors;
>>       }
>>   +    trace_ide_sector_write(sector_num, n);
>> +
>>       if (!ide_sect_range_ok(s, sector_num, n)) {
>>           ide_rw_error(s);
>>           block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
>> @@ -1186,18 +1180,17 @@ static void ide_clear_hob(IDEBus *bus)
>>   void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>>   {
>>       IDEBus *bus =3D opaque;
>> +    IDEState *s =3D idebus_active_if(bus);
>> +    int reg_num =3D addr & 7;
>>   -#ifdef DEBUG_IDE
>> -    printf("IDE: write addr=3D0x%x val=3D0x%02x\n", addr, val);
>> -#endif
>> -
>> -    addr &=3D 7;
>> +    trace_ide_ioport_write(addr, val, bus, s);
>>         /* ignore writes to command block while busy with previous
>> command */
>> -    if (addr !=3D 7 && (idebus_active_if(bus)->status &
>> (BUSY_STAT|DRQ_STAT)))
>> +    if (reg_num !=3D 7 && (s->status & (BUSY_STAT|DRQ_STAT))) {
>>           return;
>> +    }
>>   -    switch(addr) {
>> +    switch(reg_num) {
>>       case 0:
>>           break;
>>       case 1:
>> @@ -1253,9 +1246,7 @@ void ide_ioport_write(void *opaque, uint32_t
>> addr, uint32_t val)
>>     static void ide_reset(IDEState *s)
>>   {
>> -#ifdef DEBUG_IDE
>> -    printf("ide: reset\n");
>> -#endif
>> +    trace_ide_reset(s);
>>         if (s->pio_aiocb) {
>>           blk_aio_cancel(s->pio_aiocb);
>> @@ -2013,10 +2004,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>>       IDEState *s;
>>       bool complete;
>>   -#if defined(DEBUG_IDE)
>> -    printf("ide: CMD=3D%02x\n", val);
>> -#endif
>>       s =3D idebus_active_if(bus);
>> +    trace_ide_exec_cmd(bus, s, val);
>> +
>>       /* ignore commands to non existent slave */
>>       if (s !=3D bus->ifs && !s->blk) {
>>           return;
>> @@ -2054,18 +2044,18 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>>       }
>>   }
>>   -uint32_t ide_ioport_read(void *opaque, uint32_t addr1)
>> +uint32_t ide_ioport_read(void *opaque, uint32_t addr)
>>   {
>>       IDEBus *bus =3D opaque;
>>       IDEState *s =3D idebus_active_if(bus);
>> -    uint32_t addr;
>> +    uint32_t reg_num;
>>       int ret, hob;
>>   -    addr =3D addr1 & 7;
>> +    reg_num =3D addr & 7;
>>       /* FIXME: HOB readback uses bit 7, but it's always set right now=
 */
>>       //hob =3D s->select & (1 << 7);
>>       hob =3D 0;
>> -    switch(addr) {
>> +    switch(reg_num) {
>>       case 0:
>>           ret =3D 0xff;
>>           break;
>> @@ -2133,9 +2123,8 @@ uint32_t ide_ioport_read(void *opaque, uint32_t
>> addr1)
>>           qemu_irq_lower(bus->irq);
>>           break;
>>       }
>> -#ifdef DEBUG_IDE
>> -    printf("ide: read addr=3D0x%x val=3D%02x\n", addr1, ret);
>> -#endif
>> +
>> +    trace_ide_ioport_read(addr, ret, bus, s);
>>       return ret;
>>   }
>>   @@ -2151,9 +2140,8 @@ uint32_t ide_status_read(void *opaque,
>> uint32_t addr)
>>       } else {
>>           ret =3D s->status;
>>       }
>> -#ifdef DEBUG_IDE
>> -    printf("ide: read status addr=3D0x%x val=3D%02x\n", addr, ret);
>> -#endif
>> +
>> +    trace_ide_status_read(addr, ret, bus, s);
>>       return ret;
>>   }
>>   @@ -2163,9 +2151,8 @@ void ide_cmd_write(void *opaque, uint32_t
>> addr, uint32_t val)
>>       IDEState *s;
>>       int i;
>>   -#ifdef DEBUG_IDE
>> -    printf("ide: write control addr=3D0x%x val=3D%02x\n", addr, val);
>> -#endif
>> +    trace_ide_cmd_write(addr, val, bus);
>> +
>>       /* common for both drives */
>>       if (!(bus->cmd & IDE_CMD_RESET) &&
>>           (val & IDE_CMD_RESET)) {
>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>> index 3cfb510..f2dcc0e 100644
>> --- a/hw/ide/pci.c
>> +++ b/hw/ide/pci.c
>> @@ -31,6 +31,7 @@
>>   #include "sysemu/dma.h"
>>   #include "qemu/error-report.h"
>>   #include "hw/ide/pci.h"
>> +#include "trace.h"
>>     #define BMDMA_PAGE_SIZE 4096
>>   @@ -196,9 +197,7 @@ static void bmdma_reset(IDEDMA *dma)
>>   {
>>       BMDMAState *bm =3D DO_UPCAST(BMDMAState, dma, dma);
>>   -#ifdef DEBUG_IDE
>> -    printf("ide: dma_reset\n");
>> -#endif
>> +    trace_bmdma_reset();
>>       bmdma_cancel(bm);
>>       bm->cmd =3D 0;
>>       bm->status =3D 0;
>> @@ -227,9 +226,7 @@ static void bmdma_irq(void *opaque, int n, int lev=
el)
>>     void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>>   {
>> -#ifdef DEBUG_IDE
>> -    printf("%s: 0x%08x\n", __func__, val);
>> -#endif
>> +    trace_bmdma_cmd_writeb(val);
>>         /* Ignore writes to SSBM if it keeps the old value */
>>       if ((val & BM_CMD_START) !=3D (bm->cmd & BM_CMD_START)) {
>> @@ -258,9 +255,7 @@ static uint64_t bmdma_addr_read(void *opaque,
>> hwaddr addr,
>>       uint64_t data;
>>         data =3D (bm->addr >> (addr * 8)) & mask;
>> -#ifdef DEBUG_IDE
>> -    printf("%s: 0x%08x\n", __func__, (unsigned)data);
>> -#endif
>> +    trace_bmdma_addr_read(data);
>>       return data;
>>   }
>>   @@ -271,9 +266,7 @@ static void bmdma_addr_write(void *opaque,
>> hwaddr addr,
>>       int shift =3D addr * 8;
>>       uint32_t mask =3D (1ULL << (width * 8)) - 1;
>>   -#ifdef DEBUG_IDE
>> -    printf("%s: 0x%08x\n", __func__, (unsigned)data);
>> -#endif
>> +    trace_bmdma_addr_write(data);
>>       bm->addr &=3D ~(mask << shift);
>>       bm->addr |=3D ((data & mask) << shift) & ~3;
>>   }
>> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
>> index 7e2d767..dfb21f6 100644
>> --- a/hw/ide/piix.c
>> +++ b/hw/ide/piix.c
>> @@ -33,6 +33,7 @@
>>   #include "sysemu/dma.h"
>>     #include "hw/ide/pci.h"
>> +#include "trace.h"
>>     static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned siz=
e)
>>   {
>> @@ -54,9 +55,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr
>> addr, unsigned size)
>>           val =3D 0xff;
>>           break;
>>       }
>> -#ifdef DEBUG_IDE
>> -    printf("bmdma: readb 0x%02x : 0x%02x\n", (uint8_t)addr, val);
>> -#endif
>> +
>> +    trace_bmdma_read(addr, val);
>>       return val;
>>   }
>>   @@ -69,9 +69,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
>>           return;
>>       }
>>   -#ifdef DEBUG_IDE
>> -    printf("bmdma: writeb 0x%02x : 0x%02x\n", (uint8_t)addr,
>> (uint8_t)val);
>> -#endif
>> +    trace_bmdma_write(addr, val);
>> +
>>       switch(addr & 3) {
>>       case 0:
>>           bmdma_cmd_writeb(bm, val);
>> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
>> new file mode 100644
>> index 0000000..68ad96a
>> --- /dev/null
>> +++ b/hw/ide/trace-events
>> @@ -0,0 +1,33 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>> +
>> +# hw/ide/core.c
>> +# portio
>> +ide_ioport_read(uint32_t addr, uint32_t val, void *bus, void *s)=20
>> "IDE PIO rd @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
>> +ide_ioport_write(uint32_t addr, uint32_t val, void *bus, void *s)
>> "IDE PIO wr @ 0x%"PRIx32"; val 0x%02"PRIx32"; bus %p IDEState %p"
>=20
> ide_ioport_access(char *access, uint32_t addr, uint32_t val, void *bus,
> void *s);
>=20
>> +ide_status_read(uint32_t addr, uint32_t val, void *bus, void
>> *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val
>> 0x%02"PRIx32"; bus %p; IDEState %p"
>> +ide_cmd_write(uint32_t addr, uint32_t val, void
>> *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device
>> Control); val 0x%02"PRIx32"; bus %p"
>> +# misc
>> +ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus
>> %p; state %p; cmd 0x%02x"
>> +ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of
>> buffered request %p with -ECANCELED"
>> +ide_cancel_dma_sync_remaining(void) "draining all remaining requests"
>> +ide_sector_read(int64_t sector_num, int nsectors) "sector=3D%"PRId64"
>> nsectors=3D%d"
>> +ide_sector_write(int64_t sector_num, int nsectors) "sector=3D%"PRId64=
"
>> nsectors=3D%d"
>=20
> ide_sector_access(char *access, int64_t sector_num, int nsectors) "%s
> sector=3D%"PRId64" nsectors=3D%d"
>=20
>> +ide_reset(void *s) "IDEstate %p"
>> +
>> +# hw/ide/pci.c
>> +bmdma_reset(void) ""
>> +bmdma_cmd_writeb(uint32_t val) "val: 0x%08x"
>> +bmdma_addr_read(uint64_t data) "data: 0x%016"PRIx64
>> +bmdma_addr_write(uint64_t data) "data: 0x%016"PRIx64
>=20
> bmdma_data_access(char *access, uint64_t data) "%s data: 0x%016"PRIx64
>=20
>> +
>> +# hw/ide/piix.c
>> +bmdma_read(uint64_t addr, uint8_t val) "bmdma: readb 0x%"PRIx64" :
>> 0x%02x"
>> +bmdma_write(uint64_t addr, uint8_t val) "bmdma: writeb 0x%"PRIx64" :
>> 0x%02x"
>=20
> bmdma_io_access(char *access, uint64_t addr, uint64_t val) "bmdma: %sb
> 0x%"PRIx64" : 0x%02x"
>=20
>> +
>> +# hw/ide/cmd646.c
>> +bmdma_read_cmd646(uint64_t addr, uint32_t val) "bmdma: readb
>> 0x%"PRIx64" : 0x%02x"
>> +bmdma_write_cmd646(uint64_t addr, uint64_t val) "bmdma: writeb
>> 0x%"PRIx64" : 0x%02"PRIx64
>=20
> use trace_bmdma_io_access()
>=20
>> +
>> +# hw/ide/via.c
>> +bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64"
>> : 0x%02x"
>> +bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb
>> 0x%"PRIx64" : 0x%02"PRIx64
>=20
> use trace_bmdma_io_access()
>=20
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index 5b32ecb..35c3059 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -33,6 +33,7 @@
>>   #include "sysemu/dma.h"
>>     #include "hw/ide/pci.h"
>> +#include "trace.h"
>>     static uint64_t bmdma_read(void *opaque, hwaddr addr,
>>                              unsigned size)
>> @@ -55,9 +56,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr=
,
>>           val =3D 0xff;
>>           break;
>>       }
>> -#ifdef DEBUG_IDE
>> -    printf("bmdma: readb 0x%02x : 0x%02x\n", addr, val);
>> -#endif
>> +
>> +    trace_bmdma_read_via(addr, val);
>>       return val;
>>   }
>>   @@ -70,9 +70,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
>>           return;
>>       }
>>   -#ifdef DEBUG_IDE
>> -    printf("bmdma: writeb 0x%02x : 0x%02x\n", addr, val);
>> -#endif
>> +    trace_bmdma_write_via(addr, val);
>>       switch (addr & 3) {
>>       case 0:
>>           bmdma_cmd_writeb(bm, val);
>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>> index 482a951..4a92f0a 100644
>> --- a/include/hw/ide/internal.h
>> +++ b/include/hw/ide/internal.h
>> @@ -14,7 +14,6 @@
>>   #include "block/scsi.h"
>>     /* debug IDE devices */
>> -//#define DEBUG_IDE
>>   //#define DEBUG_IDE_ATAPI
>>   //#define DEBUG_AIO
>>   #define USE_DMA_CDROM
>>
>=20
> If you agree you can add:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Regards,
>=20
> Phil.
No complaints with your suggested changes, but in practice we seem to
prefer names of functions first, followed by differentiators on those
functions.

docs/devel/tracing says only this:

"4. Name trace events after their function.  If there are multiple trace
events in one function, append a unique distinguisher at the end of the
name."

I'd be happy to deviate, but I don't immediately know what adverse
effect it might have w/r/t various tracing backends. The collapse may
not be favorable.

With the tracing already written, I'd rather not optimize for the sake
of optimizing.
