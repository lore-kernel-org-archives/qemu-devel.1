Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX5JX-0003kU-3B
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX5JU-0001RS-IR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:12:07 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-2-hpoussin@reactos.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c981ce38-69fb-8eea-67a3-154fd2cc047f@redhat.com>
Date: Thu, 4 Jan 2018 15:11:40 +0200
MIME-Version: 1.0
In-Reply-To: <20171229142922.31701-2-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/16] fdc: move object structures to
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 29/12/2017 16:29, Herv=C3=A9 Poussineau wrote:
> We are now able to embed floppy controllers in another object.
>=20

Hi Herv=C3=A9,

Are you sure we need to move all the struct definitions to the header fil=
e?

I looked at patch 11/16 and it seems only FDCtrlISABus definition is need=
ed.
And also only the typedef is needed and not the fields.

It may worth a look also patches 2/16 and 3/16.

Thanks,
Marcel

> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>   hw/block/fdc.c         | 102 ----------------------------------------=
--------
>   include/hw/block/fdc.h | 103 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   2 files changed, 103 insertions(+), 102 deletions(-)
>=20
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 7b7dd41296..c81e0313c8 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -60,15 +60,8 @@
>   #define TYPE_FLOPPY_BUS "floppy-bus"
>   #define FLOPPY_BUS(obj) OBJECT_CHECK(FloppyBus, (obj), TYPE_FLOPPY_BU=
S)
>  =20
> -typedef struct FDCtrl FDCtrl;
> -typedef struct FDrive FDrive;
>   static FDrive *get_drv(FDCtrl *fdctrl, int unit);
>  =20
> -typedef struct FloppyBus {
> -    BusState bus;
> -    FDCtrl *fdc;
> -} FloppyBus;
> -
>   static const TypeInfo floppy_bus_info =3D {
>       .name =3D TYPE_FLOPPY_BUS,
>       .parent =3D TYPE_BUS,
> @@ -178,36 +171,6 @@ static FDriveSize drive_size(FloppyDriveType drive=
)
>   #define FD_SECTOR_SC           2   /* Sector size code */
>   #define FD_RESET_SENSEI_COUNT  4   /* Number of sense interrupts on R=
ESET */
>  =20
> -/* Floppy disk drive emulation */
> -typedef enum FDiskFlags {
> -    FDISK_DBL_SIDES  =3D 0x01,
> -} FDiskFlags;
> -
> -struct FDrive {
> -    FDCtrl *fdctrl;
> -    BlockBackend *blk;
> -    BlockConf *conf;
> -    /* Drive status */
> -    FloppyDriveType drive;    /* CMOS drive type        */
> -    uint8_t perpendicular;    /* 2.88 MB access mode    */
> -    /* Position */
> -    uint8_t head;
> -    uint8_t track;
> -    uint8_t sect;
> -    /* Media */
> -    FloppyDriveType disk;     /* Current disk type      */
> -    FDiskFlags flags;
> -    uint8_t last_sect;        /* Nb sector per track    */
> -    uint8_t max_track;        /* Nb of tracks           */
> -    uint16_t bps;             /* Bytes per sector       */
> -    uint8_t ro;               /* Is read-only           */
> -    uint8_t media_changed;    /* Is media changed       */
> -    uint8_t media_rate;       /* Data rate of medium    */
> -
> -    bool media_validated;     /* Have we validated the media? */
> -};
> -
> -
>   static FloppyDriveType get_fallback_drive_type(FDrive *drv);
>  =20
>   /* Hack: FD_SEEK is expected to work on empty drives. However, QEMU
> @@ -819,60 +782,6 @@ enum {
>   #define FD_MULTI_TRACK(state) ((state) & FD_STATE_MULTI)
>   #define FD_FORMAT_CMD(state) ((state) & FD_STATE_FORMAT)
>  =20
> -struct FDCtrl {
> -    MemoryRegion iomem;
> -    qemu_irq irq;
> -    /* Controller state */
> -    QEMUTimer *result_timer;
> -    int dma_chann;
> -    uint8_t phase;
> -    IsaDma *dma;
> -    /* Controller's identification */
> -    uint8_t version;
> -    /* HW */
> -    uint8_t sra;
> -    uint8_t srb;
> -    uint8_t dor;
> -    uint8_t dor_vmstate; /* only used as temp during vmstate */
> -    uint8_t tdr;
> -    uint8_t dsr;
> -    uint8_t msr;
> -    uint8_t cur_drv;
> -    uint8_t status0;
> -    uint8_t status1;
> -    uint8_t status2;
> -    /* Command FIFO */
> -    uint8_t *fifo;
> -    int32_t fifo_size;
> -    uint32_t data_pos;
> -    uint32_t data_len;
> -    uint8_t data_state;
> -    uint8_t data_dir;
> -    uint8_t eot; /* last wanted sector */
> -    /* States kept only to be returned back */
> -    /* precompensation */
> -    uint8_t precomp_trk;
> -    uint8_t config;
> -    uint8_t lock;
> -    /* Power down config (also with status regB access mode */
> -    uint8_t pwrd;
> -    /* Floppy drives */
> -    FloppyBus bus;
> -    uint8_t num_floppies;
> -    FDrive drives[MAX_FD];
> -    struct {
> -        BlockBackend *blk;
> -        FloppyDriveType type;
> -    } qdev_for_drives[MAX_FD];
> -    int reset_sensei;
> -    uint32_t check_media_rate;
> -    FloppyDriveType fallback; /* type=3Dauto failure fallback */
> -    /* Timers state */
> -    uint8_t timer0;
> -    uint8_t timer1;
> -    PortioList portio_list;
> -};
> -
>   static FloppyDriveType get_fallback_drive_type(FDrive *drv)
>   {
>       return drv->fdctrl->fallback;
> @@ -891,17 +800,6 @@ typedef struct FDCtrlSysBus {
>  =20
>   #define ISA_FDC(obj) OBJECT_CHECK(FDCtrlISABus, (obj), TYPE_ISA_FDC)
>  =20
> -typedef struct FDCtrlISABus {
> -    ISADevice parent_obj;
> -
> -    uint32_t iobase;
> -    uint32_t irq;
> -    uint32_t dma;
> -    struct FDCtrl state;
> -    int32_t bootindexA;
> -    int32_t bootindexB;
> -} FDCtrlISABus;
> -
>   static uint32_t fdctrl_read (void *opaque, uint32_t reg)
>   {
>       FDCtrl *fdctrl =3D opaque;
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index 1749dabf25..d076b2fc1a 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -2,12 +2,115 @@
>   #define HW_FDC_H
>  =20
>   #include "qemu-common.h"
> +#include "hw/block/block.h"
> +#include "hw/isa/isa.h"
>  =20
>   /* fdc.c */
>   #define MAX_FD 2
>  =20
> +typedef struct FDCtrl FDCtrl;
> +
> +/* Floppy disk drive emulation */
> +typedef enum FDiskFlags {
> +    FDISK_DBL_SIDES  =3D 0x01,
> +} FDiskFlags;
> +
> +typedef struct FDrive {
> +    FDCtrl *fdctrl;
> +    BlockBackend *blk;
> +    BlockConf *conf;
> +    /* Drive status */
> +    FloppyDriveType drive;    /* CMOS drive type        */
> +    uint8_t perpendicular;    /* 2.88 MB access mode    */
> +    /* Position */
> +    uint8_t head;
> +    uint8_t track;
> +    uint8_t sect;
> +    /* Media */
> +    FloppyDriveType disk;     /* Current disk type      */
> +    FDiskFlags flags;
> +    uint8_t last_sect;        /* Nb sector per track    */
> +    uint8_t max_track;        /* Nb of tracks           */
> +    uint16_t bps;             /* Bytes per sector       */
> +    uint8_t ro;               /* Is read-only           */
> +    uint8_t media_changed;    /* Is media changed       */
> +    uint8_t media_rate;       /* Data rate of medium    */
> +
> +    bool media_validated;     /* Have we validated the media? */
> +} FDrive;
> +
> +typedef struct FloppyBus {
> +    BusState bus;
> +    FDCtrl *fdc;
> +} FloppyBus;
> +
> +struct FDCtrl {
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    /* Controller state */
> +    QEMUTimer *result_timer;
> +    int dma_chann;
> +    uint8_t phase;
> +    IsaDma *dma;
> +    /* Controller's identification */
> +    uint8_t version;
> +    /* HW */
> +    uint8_t sra;
> +    uint8_t srb;
> +    uint8_t dor;
> +    uint8_t dor_vmstate; /* only used as temp during vmstate */
> +    uint8_t tdr;
> +    uint8_t dsr;
> +    uint8_t msr;
> +    uint8_t cur_drv;
> +    uint8_t status0;
> +    uint8_t status1;
> +    uint8_t status2;
> +    /* Command FIFO */
> +    uint8_t *fifo;
> +    int32_t fifo_size;
> +    uint32_t data_pos;
> +    uint32_t data_len;
> +    uint8_t data_state;
> +    uint8_t data_dir;
> +    uint8_t eot; /* last wanted sector */
> +    /* States kept only to be returned back */
> +    /* precompensation */
> +    uint8_t precomp_trk;
> +    uint8_t config;
> +    uint8_t lock;
> +    /* Power down config (also with status regB access mode */
> +    uint8_t pwrd;
> +    /* Floppy drives */
> +    FloppyBus bus;
> +    uint8_t num_floppies;
> +    FDrive drives[MAX_FD];
> +    struct {
> +        BlockBackend *blk;
> +        FloppyDriveType type;
> +    } qdev_for_drives[MAX_FD];
> +    int reset_sensei;
> +    uint32_t check_media_rate;
> +    FloppyDriveType fallback; /* type=3Dauto failure fallback */
> +    /* Timers state */
> +    uint8_t timer0;
> +    uint8_t timer1;
> +    PortioList portio_list;
> +};
> +
>   #define TYPE_ISA_FDC "isa-fdc"
>  =20
> +typedef struct FDCtrlISABus {
> +    ISADevice parent_obj;
> +
> +    uint32_t iobase;
> +    uint32_t irq;
> +    uint32_t dma;
> +    struct FDCtrl state;
> +    int32_t bootindexA;
> +    int32_t bootindexB;
> +} FDCtrlISABus;
> +
>   ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds);
>   void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
>                           hwaddr mmio_base, DriveInfo **fds);
>=20
