Received: from eggs.gnu.org ([2001:4830:134:3::10]:46717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlEwe-00066x-Vm
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlEwZ-0004ux-Oc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:46:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d305c256-9916-c272-d536-d1f32d2d908b@amsat.org>
Date: Fri, 25 Aug 2017 10:46:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Hi John,

On 08/08/2017 03:33 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   hw/ide/atapi.c            |  5 +----
>   hw/ide/core.c             | 17 ++++++++++-------
>   hw/ide/trace-events       |  3 +++
>   include/hw/ide/internal.h |  7 +++++--
>   4 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index 37fa699..b8fc51e 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -416,10 +416,7 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, int ret)
>           s->io_buffer_size = n * 2048;
>           data_offset = 0;
>       }
> -#ifdef DEBUG_AIO
> -    printf("aio_read_cd: lba=%u n=%d\n", s->lba, n);
> -#endif
> -
> +    trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
>       s->bus->dma->iov.iov_base = (void *)(s->io_buffer + data_offset);
>       s->bus->dma->iov.iov_len = n * ATAPI_SECTOR_SIZE;
>       qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov, 1);
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 29848ff..1358029 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -58,6 +58,13 @@ static const int smart_attributes[][12] = {
>       { 190,  0x03, 0x00, 0x45, 0x45, 0x1f, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x32},
>   };
>   
> +const char *IDE_DMA_CMD_lookup[IDE_DMA__END] = {
> +    [IDE_DMA_READ] = "DMA_READ",
> +    [IDE_DMA_WRITE] = "DMA_WRITE",
> +    [IDE_DMA_TRIM] = "DMA TRIM",
> +    [IDE_DMA_ATAPI] = "DMA ATAPI"
> +};
> +
>   static void ide_dummy_transfer_stop(IDEState *s);
>   
>   static void padstr(char *str, const char *src, int len)
> @@ -860,10 +867,8 @@ static void ide_dma_cb(void *opaque, int ret)
>           goto eot;
>       }
>   
> -#ifdef DEBUG_AIO
> -    printf("ide_dma_cb: sector_num=%" PRId64 " n=%d, cmd_cmd=%d\n",
> -           sector_num, n, s->dma_cmd);
> -#endif
> +    trace_ide_dma_cb(s, sector_num, n,
> +                     IDE_DMA_CMD_lookup[s->dma_cmd]);
>   
>       if ((s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) &&
>           !ide_sect_range_ok(s, sector_num, n)) {
> @@ -2383,9 +2388,7 @@ void ide_bus_reset(IDEBus *bus)
>   
>       /* pending async DMA */
>       if (bus->dma->aiocb) {
> -#ifdef DEBUG_AIO
> -        printf("aio_cancel\n");
> -#endif
> +        trace_ide_bus_reset_aio();
>           blk_aio_cancel(bus->dma->aiocb);
>           bus->dma->aiocb = NULL;
>       }
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index ade1e76..6e33cb3 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -17,6 +17,8 @@ ide_cancel_dma_sync_remaining(void) "draining all remaining requests"
>   ide_sector_read(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
>   ide_sector_write(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
>   ide_reset(void *s) "IDEstate %p"
> +ide_bus_reset_aio(void) "aio_cancel"
> +ide_dma_cb(void *s, int64_t sector_num, int n, const char *dma) "IDEState %p; sector_num=%"PRId64" n=%d cmd=%s"
>   
>   # hw/ide/pci.c
>   bmdma_reset(void) ""
> @@ -48,5 +50,6 @@ ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new transfer sta
>   ide_atapi_cmd_check_status(void *s) "IDEState: %p"
>   ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors) "IDEState: %p; read %s: LBA=%d nb_sectors=%d"
>   ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
> +ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; aio read: lba=%d n=%d"
>   # Warning: Verbose
>   ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
> \ No newline at end of file
> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> index 74efe8a..97e97a2 100644
> --- a/include/hw/ide/internal.h
> +++ b/include/hw/ide/internal.h
> @@ -14,7 +14,6 @@
>   #include "block/scsi.h"
>   
>   /* debug IDE devices */
> -//#define DEBUG_AIO
>   #define USE_DMA_CDROM
>   
>   typedef struct IDEBus IDEBus;
> @@ -333,12 +332,16 @@ struct unreported_events {
>   };
>   
>   enum ide_dma_cmd {
> -    IDE_DMA_READ,
> +    IDE_DMA__BEGIN = 0,
> +    IDE_DMA_READ = IDE_DMA__BEGIN,

not that useful, you can use directly:

	IDE_DMA_READ = 0,

>       IDE_DMA_WRITE,
>       IDE_DMA_TRIM,
>       IDE_DMA_ATAPI,
> +    IDE_DMA__END

IDE_DMA__COUNT sounds better.

>   };
>   
> +extern const char *IDE_DMA_CMD_lookup[IDE_DMA__END];
> +
>   #define ide_cmd_is_read(s) \
>   	((s)->dma_cmd == IDE_DMA_READ)
>   
> 

removing IDE_DMA__BEGIN and using IDE_DMA__COUNT:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
