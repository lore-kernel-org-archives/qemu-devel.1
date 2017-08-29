Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmUMo-0002wZ-HS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmUMn-0003nJ-At
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:26:54 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-6-jsnow@redhat.com>
	<d305c256-9916-c272-d536-d1f32d2d908b@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <d1e8ee60-f558-91b1-7c10-020496147d59@redhat.com>
Date: Mon, 28 Aug 2017 20:26:46 -0400
MIME-Version: 1.0
In-Reply-To: <d305c256-9916-c272-d536-d1f32d2d908b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] IDE: replace DEBUG_AIO with trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/25/2017 09:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi John,
>=20
> On 08/08/2017 03:33 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   hw/ide/atapi.c            |  5 +----
>>   hw/ide/core.c             | 17 ++++++++++-------
>>   hw/ide/trace-events       |  3 +++
>>   include/hw/ide/internal.h |  7 +++++--
>>   4 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
>> index 37fa699..b8fc51e 100644
>> --- a/hw/ide/atapi.c
>> +++ b/hw/ide/atapi.c
>> @@ -416,10 +416,7 @@ static void ide_atapi_cmd_read_dma_cb(void
>> *opaque, int ret)
>>           s->io_buffer_size =3D n * 2048;
>>           data_offset =3D 0;
>>       }
>> -#ifdef DEBUG_AIO
>> -    printf("aio_read_cd: lba=3D%u n=3D%d\n", s->lba, n);
>> -#endif
>> -
>> +    trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
>>       s->bus->dma->iov.iov_base =3D (void *)(s->io_buffer + data_offse=
t);
>>       s->bus->dma->iov.iov_len =3D n * ATAPI_SECTOR_SIZE;
>>       qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov, =
1);
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 29848ff..1358029 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -58,6 +58,13 @@ static const int smart_attributes[][12] =3D {
>>       { 190,  0x03, 0x00, 0x45, 0x45, 0x1f, 0x00, 0x1f, 0x1f, 0x00,
>> 0x00, 0x32},
>>   };
>>   +const char *IDE_DMA_CMD_lookup[IDE_DMA__END] =3D {
>> +    [IDE_DMA_READ] =3D "DMA_READ",
>> +    [IDE_DMA_WRITE] =3D "DMA_WRITE",
>> +    [IDE_DMA_TRIM] =3D "DMA TRIM",
>> +    [IDE_DMA_ATAPI] =3D "DMA ATAPI"
>> +};
>> +
>>   static void ide_dummy_transfer_stop(IDEState *s);
>>     static void padstr(char *str, const char *src, int len)
>> @@ -860,10 +867,8 @@ static void ide_dma_cb(void *opaque, int ret)
>>           goto eot;
>>       }
>>   -#ifdef DEBUG_AIO
>> -    printf("ide_dma_cb: sector_num=3D%" PRId64 " n=3D%d, cmd_cmd=3D%d=
\n",
>> -           sector_num, n, s->dma_cmd);
>> -#endif
>> +    trace_ide_dma_cb(s, sector_num, n,
>> +                     IDE_DMA_CMD_lookup[s->dma_cmd]);
>>         if ((s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D
>> IDE_DMA_WRITE) &&
>>           !ide_sect_range_ok(s, sector_num, n)) {
>> @@ -2383,9 +2388,7 @@ void ide_bus_reset(IDEBus *bus)
>>         /* pending async DMA */
>>       if (bus->dma->aiocb) {
>> -#ifdef DEBUG_AIO
>> -        printf("aio_cancel\n");
>> -#endif
>> +        trace_ide_bus_reset_aio();
>>           blk_aio_cancel(bus->dma->aiocb);
>>           bus->dma->aiocb =3D NULL;
>>       }
>> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
>> index ade1e76..6e33cb3 100644
>> --- a/hw/ide/trace-events
>> +++ b/hw/ide/trace-events
>> @@ -17,6 +17,8 @@ ide_cancel_dma_sync_remaining(void) "draining all
>> remaining requests"
>>   ide_sector_read(int64_t sector_num, int nsectors) "sector=3D%"PRId64=
"
>> nsectors=3D%d"
>>   ide_sector_write(int64_t sector_num, int nsectors) "sector=3D%"PRId6=
4"
>> nsectors=3D%d"
>>   ide_reset(void *s) "IDEstate %p"
>> +ide_bus_reset_aio(void) "aio_cancel"
>> +ide_dma_cb(void *s, int64_t sector_num, int n, const char *dma)
>> "IDEState %p; sector_num=3D%"PRId64" n=3D%d cmd=3D%s"
>>     # hw/ide/pci.c
>>   bmdma_reset(void) ""
>> @@ -48,5 +50,6 @@ ide_atapi_cmd_reply_end_new(void *s, int status)
>> "IDEState: %p; new transfer sta
>>   ide_atapi_cmd_check_status(void *s) "IDEState: %p"
>>   ide_atapi_cmd_read(void *s, const char *method, int lba, int
>> nb_sectors) "IDEState: %p; read %s: LBA=3D%d nb_sectors=3D%d"
>>   ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
>> +ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p;
>> aio read: lba=3D%d n=3D%d"
>>   # Warning: Verbose
>>   ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet)
>> "IDEState: %p; limit=3D0x%x packet: %s"
>> \ No newline at end of file
>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>> index 74efe8a..97e97a2 100644
>> --- a/include/hw/ide/internal.h
>> +++ b/include/hw/ide/internal.h
>> @@ -14,7 +14,6 @@
>>   #include "block/scsi.h"
>>     /* debug IDE devices */
>> -//#define DEBUG_AIO
>>   #define USE_DMA_CDROM
>>     typedef struct IDEBus IDEBus;
>> @@ -333,12 +332,16 @@ struct unreported_events {
>>   };
>>     enum ide_dma_cmd {
>> -    IDE_DMA_READ,
>> +    IDE_DMA__BEGIN =3D 0,
>> +    IDE_DMA_READ =3D IDE_DMA__BEGIN,
>=20
> not that useful, you can use directly:
>=20
>     IDE_DMA_READ =3D 0,
>=20

I could do lots of things; one of the things I like to do out of habit
is to name an enumerator after the beginning so that if I were to ever
loop over the items contained within, I can write a loop that looks like
this:

for (i =3D IDE_DMA__BEGIN; i < IDE_DMA__END; i++) {
	...foo...;
}

instead of having to name a specific constant in the beginning.

Why?

Because, heaven help us, someone reorders the enum for whatever reason,
the program is still going to compile and nobody will notice this change
halfway across the globe.

Having a distinct __START __END (or even COUNT as you suggest) clues us
in to the notion that there are users that don't care about the order,
per se, but do care that the enum is iterable.

"Cool story John, but do you use that feature here?"

Nope ...

I'll remove it! I only really needed the COUNT as you say, and the rest
came along by habit.

>>       IDE_DMA_WRITE,
>>       IDE_DMA_TRIM,
>>       IDE_DMA_ATAPI,
>> +    IDE_DMA__END
>=20
> IDE_DMA__COUNT sounds better.
>=20

I'll take both suggestions.

>>   };
>>   +extern const char *IDE_DMA_CMD_lookup[IDE_DMA__END];
>> +
>>   #define ide_cmd_is_read(s) \
>>       ((s)->dma_cmd =3D=3D IDE_DMA_READ)
>> =20
>=20
> removing IDE_DMA__BEGIN and using IDE_DMA__COUNT:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks.
