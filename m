Received: from eggs.gnu.org ([2001:4830:134:3::10]:44778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNdM-0006BY-Pf
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNdK-0004NI-Te
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:10:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-6-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6add2c4b-d8fb-8abb-d2ea-474c8383bbad@amsat.org>
Date: Wed, 24 May 2017 01:10:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-6-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/13] vvfat: introduce
 offset_to_bootsector, offset_to_fat and offset_to_root_dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Hervé,

On 05/22/2017 06:11 PM, Hervé Poussineau wrote:
> - offset_to_bootsector is the number of sectors up to FAT bootsector
> - offset_to_fat is the number of sectors up to first File Allocation Table
> - offset_to_root_dir is the number of sectors up to root directory sector

Eventually your commit description can end here, adding the 3 following 
lines below the "---" separator.

> Replace first_sectors_number - 1 by offset_to_bootsector.
> Replace first_sectors_number by offset_to_fat.
> Replace faked_sectors by offset_to_rootdir.

This is "offset_to_root_dir"

>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---

   ^-- separator

>  block/vvfat.c | 70 ++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 6a36d4f7fa..e694d82df4 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -320,22 +320,24 @@ static void print_mapping(const struct mapping_t* mapping);
>  typedef struct BDRVVVFATState {
>      CoMutex lock;
>      BlockDriverState* bs; /* pointer to parent */
> -    unsigned int first_sectors_number; /* 1 for a single partition, 0x40 for a disk with partition table */
>      unsigned char first_sectors[0x40*0x200];
>
>      int fat_type; /* 16 or 32 */
>      array_t fat,directory,mapping;
>      char volume_label[11];
>
> +    uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
> +
>      unsigned int cluster_size;
>      unsigned int sectors_per_cluster;
>      unsigned int sectors_per_fat;
>      unsigned int sectors_of_root_directory;
>      uint32_t last_cluster_of_root_directory;
> -    unsigned int faked_sectors; /* how many sectors are faked before file data */
>      uint32_t sector_count; /* total number of sectors of the partition */
>      uint32_t cluster_count; /* total number of clusters of this partition */
>      uint32_t max_fat_value;
> +    uint32_t offset_to_fat;
> +    uint32_t offset_to_root_dir;
>
>      int current_fd;
>      mapping_t* current_mapping;
> @@ -394,15 +396,15 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
>      partition->attributes=0x80; /* bootable */
>
>      /* LBA is used when partition is outside the CHS geometry */
> -    lba  = sector2CHS(&partition->start_CHS, s->first_sectors_number - 1,
> +    lba  = sector2CHS(&partition->start_CHS, s->offset_to_bootsector,
>                       cyls, heads, secs);
>      lba |= sector2CHS(&partition->end_CHS,   s->bs->total_sectors - 1,
>                       cyls, heads, secs);
>
>      /*LBA partitions are identified only by start/length_sector_long not by CHS*/
> -    partition->start_sector_long  = cpu_to_le32(s->first_sectors_number - 1);
> +    partition->start_sector_long  = cpu_to_le32(s->offset_to_bootsector);
>      partition->length_sector_long = cpu_to_le32(s->bs->total_sectors
> -                                                - s->first_sectors_number + 1);
> +                                                - s->offset_to_bootsector);
>
>      /* FAT12/FAT16/FAT32 */
>      /* DOS uses different types when partition is LBA,
> @@ -823,12 +825,12 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
>
>  static inline uint32_t sector2cluster(BDRVVVFATState* s,off_t sector_num)
>  {
> -    return (sector_num-s->faked_sectors)/s->sectors_per_cluster;
> +    return (sector_num - s->offset_to_root_dir) / s->sectors_per_cluster;
>  }
>
>  static inline off_t cluster2sector(BDRVVVFATState* s, uint32_t cluster_num)
>  {
> -    return s->faked_sectors + s->sectors_per_cluster * cluster_num;
> +    return s->offset_to_root_dir + s->sectors_per_cluster * cluster_num;
>  }
>
>  static int init_directories(BDRVVVFATState* s,
> @@ -855,6 +857,9 @@ static int init_directories(BDRVVVFATState* s,
>      i = 1+s->sectors_per_cluster*0x200*8/s->fat_type;
>      s->sectors_per_fat=(s->sector_count+i)/i; /* round up */
>
> +    s->offset_to_fat = s->offset_to_bootsector + 1;
> +    s->offset_to_root_dir = s->offset_to_fat + s->sectors_per_fat * 2;
> +
>      array_init(&(s->mapping),sizeof(mapping_t));
>      array_init(&(s->directory),sizeof(direntry_t));
>
> @@ -868,7 +873,6 @@ static int init_directories(BDRVVVFATState* s,
>      /* Now build FAT, and write back information into directory */
>      init_fat(s);
>
> -    s->faked_sectors=s->first_sectors_number+s->sectors_per_fat*2;
>      s->cluster_count=sector2cluster(s, s->sector_count);
>
>      mapping = array_get_next(&(s->mapping));
> @@ -946,7 +950,8 @@ static int init_directories(BDRVVVFATState* s,
>
>      s->current_mapping = NULL;
>
> -    bootsector=(bootsector_t*)(s->first_sectors+(s->first_sectors_number-1)*0x200);
> +    bootsector = (bootsector_t *)(s->first_sectors
> +                                  + s->offset_to_bootsector * 0x200);
>      bootsector->jump[0]=0xeb;
>      bootsector->jump[1]=0x3e;
>      bootsector->jump[2]=0x90;
> @@ -957,16 +962,18 @@ static int init_directories(BDRVVVFATState* s,
>      bootsector->number_of_fats=0x2; /* number of FATs */
>      bootsector->root_entries=cpu_to_le16(s->sectors_of_root_directory*0x10);
>      bootsector->total_sectors16=s->sector_count>0xffff?0:cpu_to_le16(s->sector_count);
> -    bootsector->media_type=(s->first_sectors_number>1?0xf8:0xf0); /* media descriptor (f8=hd, f0=3.5 fd)*/
> +    /* media descriptor: hard disk=0xf8, floppy=0xf0 */

Can you move this comment in the struct BDRVVVFATState definition, and 
add defines/enum for the values? Maybe use an inline function like 
"media_type(BDRVVVFATState *)".

> +    bootsector->media_type = (s->offset_to_bootsector > 0 ? 0xf8 : 0xf0);
>      s->fat.pointer[0] = bootsector->media_type;
>      bootsector->sectors_per_fat=cpu_to_le16(s->sectors_per_fat);
>      bootsector->sectors_per_track = cpu_to_le16(secs);
>      bootsector->number_of_heads = cpu_to_le16(heads);
> -    bootsector->hidden_sectors=cpu_to_le32(s->first_sectors_number==1?0:0x3f);
> +    bootsector->hidden_sectors = cpu_to_le32(s->offset_to_bootsector);

I understood this change after reading backward:
"uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */"

>      bootsector->total_sectors=cpu_to_le32(s->sector_count>0xffff?s->sector_count:0);
>
>      /* LATER TODO: if FAT32, this is wrong */
> -    bootsector->u.fat16.drive_number=s->first_sectors_number==1?0:0x80; /* fda=0, hda=0x80 */
> +    /* drive_number: fda=0, hda=0x80 */
> +    bootsector->u.fat16.drive_number = s->offset_to_bootsector == 0 ? 0 : 0x80;
>      bootsector->u.fat16.current_head=0;
>      bootsector->u.fat16.signature=0x29;
>      bootsector->u.fat16.id=cpu_to_le32(0xfabe1afd);
> @@ -1123,7 +1130,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>              secs = s->fat_type == 12 ? 18 : 36;
>              s->sectors_per_cluster = 1;
>          }
> -        s->first_sectors_number = 1;
>          cyls = 80;
>          heads = 2;
>      } else {
> @@ -1131,7 +1137,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          if (!s->fat_type) {
>              s->fat_type = 16;
>          }
> -        s->first_sectors_number = 0x40;
> +        s->offset_to_bootsector = 0x3f;
>          cyls = s->fat_type == 12 ? 64 : 1024;
>          heads = 16;
>          secs = 63;
> @@ -1167,7 +1173,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>      fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
>              dirname, cyls, heads, secs);
>
> -    s->sector_count = cyls * heads * secs - (s->first_sectors_number - 1);
> +    s->sector_count = cyls * heads * secs - s->offset_to_bootsector;
>
>      if (qemu_opt_get_bool(opts, "rw", false)) {
>          if (!bdrv_is_read_only(bs)) {
> @@ -1197,7 +1203,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>
> -    s->sector_count = s->faked_sectors + s->sectors_per_cluster*s->cluster_count;
> +    s->sector_count = s->offset_to_root_dir
> +                    + s->sectors_per_cluster * s->cluster_count;
>
>      /* Disable migration when vvfat is used rw */
>      if (s->qcow) {
> @@ -1213,7 +1220,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          }
>      }
>
> -    if (s->first_sectors_number == 0x40) {
> +    if (s->offset_to_bootsector > 0) {
>          init_mbr(s, cyls, heads, secs);
>      }
>
> @@ -1426,15 +1433,24 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
>              }
>  DLOG(fprintf(stderr, "sector %d not allocated\n", (int)sector_num));
>          }
> -        if(sector_num<s->faked_sectors) {
> -            if(sector_num<s->first_sectors_number)
> -                memcpy(buf+i*0x200,&(s->first_sectors[sector_num*0x200]),0x200);
> -            else if(sector_num-s->first_sectors_number<s->sectors_per_fat)
> -                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first_sectors_number)*0x200]),0x200);
> -            else if(sector_num-s->first_sectors_number-s->sectors_per_fat<s->sectors_per_fat)
> -                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first_sectors_number-s->sectors_per_fat)*0x200]),0x200);
> +        if (sector_num < s->offset_to_root_dir) {
> +            if (sector_num < s->offset_to_fat) {
> +                memcpy(buf + i * 0x200,
> +                       &(s->first_sectors[sector_num * 0x200]),
> +                       0x200);
> +            } else if (sector_num < s->offset_to_fat + s->sectors_per_fat) {
> +                memcpy(buf + i * 0x200,
> +                       &(s->fat.pointer[(sector_num
> +                                       - s->offset_to_fat) * 0x200]),
> +                       0x200);
> +            } else if (sector_num < s->offset_to_root_dir) {
> +                memcpy(buf + i * 0x200,
> +                       &(s->fat.pointer[(sector_num - s->offset_to_fat
> +                                       - s->sectors_per_fat) * 0x200]),
> +                       0x200);
> +            }
>          } else {
> -            uint32_t sector=sector_num-s->faked_sectors,
> +            uint32_t sector = sector_num - s->offset_to_root_dir,
>              sector_offset_in_cluster=(sector%s->sectors_per_cluster),
>              cluster_num=sector/s->sectors_per_cluster;
>              if(cluster_num > s->cluster_count || read_cluster(s, cluster_num) != 0) {
> @@ -2046,7 +2062,7 @@ DLOG(checkpoint());
>          memcpy(s->fat2, s->fat.pointer, size);
>      }
>      check = vvfat_read(s->bs,
> -            s->first_sectors_number, s->fat2, s->sectors_per_fat);
> +            s->offset_to_fat, s->fat2, s->sectors_per_fat);
>      if (check) {
>          fprintf(stderr, "Could not copy fat\n");
>          return 0;
> @@ -2865,7 +2881,7 @@ DLOG(checkpoint());
>       * - do not allow to write non-ASCII filenames
>       */
>
> -    if (sector_num < s->first_sectors_number)
> +    if (sector_num < s->offset_to_fat)
>          return -1;
>
>      for (i = sector2cluster(s, sector_num);
>

Except those style comment, this patch is Ok to me.

Regards,

Phil.
