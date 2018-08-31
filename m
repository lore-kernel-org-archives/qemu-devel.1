Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fvfpY-0000mC-V8
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fvfpT-0005Ig-5B
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:35:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33104)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fvfpP-0005Gw-5H
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:34:57 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1535031462-15030-1-git-send-email-ivanovrkasha@gmail.com>
In-Reply-To: <1535031462-15030-1-git-send-email-ivanovrkasha@gmail.com>
Date: Fri, 31 Aug 2018 12:34:52 +0300
Message-ID: <000001d4410d$de71d790$9b5586b0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH V2] block: increased maximum size of vvfat
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Arkasha' <ivanovrkasha@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru

I've tried this patch and it worked for me.
Small disk was created for the small folder, and it worked in MS-DOS.
Larger disk was automatically selected for the folder larger than 504Mb. It worked only under
Windows.

Pavel Dovgalyuk

> -----Original Message-----
> From: Arkasha [mailto:ivanovrkasha@gmail.com]
> Sent: Thursday, August 23, 2018 4:38 PM
> To: qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; mreitz@redhat.com; pavel.dovgaluk@ispras.ru; Arkasha
> Subject: [PATCH V2] block: increased maximum size of vvfat devices
> 
> This fixes the problem of the impossibility to create
> FAT16 disks larger than 504 mb:
> The change CHS made it possible to obtain a larger disk.
> Also, auto-detection of disk parameters was added depending
> on the volume of the connected files:
> The size of all folders and files on the created disk is calculated
> and the size of the FAT table is added.
> This size allows to choose the future size of the FAT drive
> from the standard limitations.
> 
> Signed-off-by: Arkasha <ivanovrkasha@gmail.com>
> ---
>  block/vvfat.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 10 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841..4409233 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -77,6 +77,47 @@ static void checkpoint(void);
>  #define DIR_KANJI_FAKE 0x05
>  #define DIR_FREE 0x00
> 
> +static bool check_size(uint32_t offset_to_bootsector, int cyls, int heads,
> +                      int secs, uint8_t sectors_per_cluster, int fat_type,
> +                      long int sum, long int size_disk)
> +{
> +    uint32_t sector_count = cyls * heads * secs - offset_to_bootsector;
> +    int i = 1 + sectors_per_cluster * 0x200 * 8 / fat_type;
> +    uint16_t sectors_per_fat = (sector_count + i) / i;
> +    /*size + FAT1 and FAT2 table size*/
> +    if ((sum + sectors_per_fat * 512 * 2) < size_disk) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static long int find_size(const char *dirname, unsigned int cluster)
> +{
> +    long int sum = 0;
> +    DIR *dir = opendir(dirname);
> +    struct dirent *entry;
> +    while ((entry = readdir(dir))) {
> +        unsigned int length = strlen(dirname) + 2 + strlen(entry->d_name);
> +        char *buffer;
> +        struct stat st;
> +        buffer = g_malloc(length);
> +        snprintf(buffer, length, "%s/%s", dirname, entry->d_name);
> +        if (stat(buffer, &st) < 0) {
> +            g_free(buffer);
> +            continue;
> +        }
> +        if (strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")
> +                                            && S_ISDIR(st.st_mode)) {
> +            sum += find_size(buffer, cluster);
> +        }
> +        g_free(buffer);
> +        sum += (st.st_size + cluster - 1) / (cluster) * (cluster);
> +    }
> +    closedir(dir);
> +    return sum;
> +}
> +
> +
>  /* dynamic array functions */
>  typedef struct array_t {
>      char* pointer;
> @@ -948,8 +988,6 @@ static int init_directories(BDRVVVFATState* s,
>      /* Now build FAT, and write back information into directory */
>      init_fat(s);
> 
> -    /* TODO: if there are more entries, bootsector has to be adjusted! */
> -    s->root_entries = 0x02 * 0x10 * s->sectors_per_cluster;
>      s->cluster_count=sector2cluster(s, s->sector_count);
> 
>      mapping = array_get_next(&(s->mapping));
> @@ -1154,12 +1192,12 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>  {
>      BDRVVVFATState *s = bs->opaque;
>      int cyls, heads, secs;
> +    long int size_disk;
>      bool floppy;
>      const char *dirname, *label;
>      QemuOpts *opts;
>      Error *local_err = NULL;
>      int ret;
> -
>  #ifdef DEBUG
>      vvv = s;
>  #endif
> @@ -1181,6 +1219,29 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
> 
>      s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
>      floppy = qemu_opt_get_bool(opts, "floppy", false);
> +    unsigned int cluster;
> +    long int sum = 0;
> +    if (floppy) {
> +        if (!s->fat_type) {
> +            s->sectors_per_cluster = 2;
> +        } else {
> +            s->sectors_per_cluster = 1;
> +        }
> +    } else if (s->fat_type == 12) {
> +        s->offset_to_bootsector = 0x3f;
> +        s->sectors_per_cluster = 0x10;
> +    } else {
> +        s->offset_to_bootsector = 0x3f;
> +        /* LATER TODO: if FAT32, adjust */
> +        s->sectors_per_cluster = 0x80;
> +    }
> +
> +    cluster = s->sectors_per_cluster * 0x200;
> +    sum += find_size(dirname, cluster);
> +    /* TODO: if there are more entries, bootsector has to be adjusted! */
> +    s->root_entries = 0x02 * 0x10 * s->sectors_per_cluster;
> +    /*File size + boot sector size + root directory size*/
> +    sum += 512 + s->root_entries * 32;
> 
>      memset(s->volume_label, ' ', sizeof(s->volume_label));
>      label = qemu_opt_get(opts, "label");
> @@ -1201,24 +1262,41 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          if (!s->fat_type) {
>              s->fat_type = 12;
>              secs = 36;
> -            s->sectors_per_cluster = 2;
>          } else {
>              secs = s->fat_type == 12 ? 18 : 36;
> -            s->sectors_per_cluster = 1;
>          }
>          cyls = 80;
>          heads = 2;
>      } else {
> -        /* 32MB or 504MB disk*/
>          if (!s->fat_type) {
>              s->fat_type = 16;
>          }
> -        s->offset_to_bootsector = 0x3f;
> +        size_disk = 528482304;
>          cyls = s->fat_type == 12 ? 64 : 1024;
>          heads = 16;
>          secs = 63;
> -    }
> +        if (!check_size(s->offset_to_bootsector, cyls, heads,
> +                               secs, s->sectors_per_cluster,
> +                               s->fat_type, sum, size_disk)) {
> +            if (s->fat_type > 12) {
> +                size_disk = 4294950912;
> +                cyls = 8322;
> +                heads = 16;
> +                secs = 63;
> 
> +            } else {
> +                fprintf(stderr, "Requires Fat16 or Fat32\n");
> +                return -2;
> +            }
> +            if (!check_size(s->offset_to_bootsector, cyls, heads,
> +                                   secs, s->sectors_per_cluster,
> +                                   s->fat_type, sum, size_disk)) {
> +                fprintf(stderr, "Folder is larger than %f GB\n",
> +                                (float)size_disk / 1073741824);
> +                return -2;
> +            }
> +        }
> +    }
>      switch (s->fat_type) {
>      case 32:
>          warn_report("FAT32 has not been tested. You are welcome to do so!");
> @@ -1235,8 +1313,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
> 
>      s->bs = bs;
> 
> -    /* LATER TODO: if FAT32, adjust */
> -    s->sectors_per_cluster=0x10;
> 
>      s->current_cluster=0xffffffff;
> 
> --
> 2.7.4
