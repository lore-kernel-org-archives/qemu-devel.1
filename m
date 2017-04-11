Received: from eggs.gnu.org ([2001:4830:134:3::10]:34228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlge-0005v0-5x
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlgc-0005Tt-VV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:37:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-4-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d7d9d70-1842-7911-6854-571b3cb04d19@amsat.org>
Date: Mon, 10 Apr 2017 23:37:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170411011718.9152-4-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 03/13] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Hi Eric,

On 04/10/2017 10:17 PM, Eric Blake wrote:
> For the 'alloc' command, accepting an offset in bytes but a length
> in sectors, and reporting output in sectors, is confusing.  Do
> everything in bytes, and adjust the expected output accordingly.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-io-cmds.c                    | 30 ++++++++++++++++++------------
>  tests/qemu-iotests/019.out        |  8 ++++----
>  tests/qemu-iotests/179            |  4 ++--
>  tests/qemu-iotests/179.out        |  4 ++--
>  tests/qemu-iotests/common.pattern |  2 +-
>  5 files changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 9e023a4..df7297f 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1760,7 +1760,7 @@ out:
>  static int alloc_f(BlockBackend *blk, int argc, char **argv)
>  {
>      BlockDriverState *bs = blk_bs(blk);
> -    int64_t offset, sector_num, nb_sectors, remaining;
> +    int64_t offset, sector_num, nb_sectors, remaining, bytes;
>      char s1[64];
>      int num, ret;
>      int64_t sum_alloc;
> @@ -1776,18 +1776,24 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if (argc == 3) {
> -        nb_sectors = cvtnum(argv[2]);
> -        if (nb_sectors < 0) {
> -            print_cvtnum_err(nb_sectors, argv[2]);
> +        bytes = cvtnum(argv[2]);
> +        if (bytes < 0) {
> +            print_cvtnum_err(bytes, argv[2]);
>              return 0;
> -        } else if (nb_sectors > INT_MAX) {
> -            printf("length argument cannot exceed %d, given %s\n",
> -                   INT_MAX, argv[2]);
> +        } else if (bytes > INT_MAX * BDRV_SECTOR_SIZE) {
> +            printf("length argument cannot exceed %llu, given %s\n",
> +                   INT_MAX * BDRV_SECTOR_SIZE, argv[2]);
>              return 0;
>          }
>      } else {
> -        nb_sectors = 1;
> +        bytes = BDRV_SECTOR_SIZE;
>      }
> +    if (bytes & 0x1ff) {

This macro is self-explanatory:

if(!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE))

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        printf("bytes %" PRId64 " is not sector aligned\n",
> +               bytes);
> +        return 0;
> +    }
> +    nb_sectors = bytes >> BDRV_SECTOR_BITS;
>
>      remaining = nb_sectors;
>      sum_alloc = 0;
> @@ -1811,8 +1817,8 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
>
>      cvtstr(offset, s1, sizeof(s1));
>
> -    printf("%"PRId64"/%"PRId64" sectors allocated at offset %s\n",
> -           sum_alloc, nb_sectors, s1);
> +    printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
> +           sum_alloc << BDRV_SECTOR_BITS, nb_sectors << BDRV_SECTOR_BITS, s1);
>      return 0;
>  }
>
> @@ -1822,8 +1828,8 @@ static const cmdinfo_t alloc_cmd = {
>      .argmin     = 1,
>      .argmax     = 2,
>      .cfunc      = alloc_f,
> -    .args       = "off [sectors]",
> -    .oneline    = "checks if a sector is present in the file",
> +    .args       = "offset [bytes]",
> +    .oneline    = "checks if offset is allocated in the file",
>  };
>
>
> diff --git a/tests/qemu-iotests/019.out b/tests/qemu-iotests/019.out
> index 0124264..17a7c03 100644
> --- a/tests/qemu-iotests/019.out
> +++ b/tests/qemu-iotests/019.out
> @@ -542,8 +542,8 @@ Testing conversion with -B TEST_DIR/t.IMGFMT.base
>
>  Checking if backing clusters are allocated when they shouldn't
>
> -0/128 sectors allocated at offset 1 MiB
> -0/128 sectors allocated at offset 4.001 GiB
> +0/65536 bytes allocated at offset 1 MiB
> +0/65536 bytes allocated at offset 4.001 GiB
>  Reading
>
>  === IO: pattern 42
> @@ -1086,8 +1086,8 @@ Testing conversion with -o backing_file=TEST_DIR/t.IMGFMT.base
>
>  Checking if backing clusters are allocated when they shouldn't
>
> -0/128 sectors allocated at offset 1 MiB
> -0/128 sectors allocated at offset 4.001 GiB
> +0/65536 bytes allocated at offset 1 MiB
> +0/65536 bytes allocated at offset 4.001 GiB
>  Reading
>
>  === IO: pattern 42
> diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
> index 338a45d..44541e1 100755
> --- a/tests/qemu-iotests/179
> +++ b/tests/qemu-iotests/179
> @@ -62,12 +62,12 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
>  # But not requesting unmap must result in allocation (whether a cluster
>  # allocation in compat=0.10 or a flag allocation in compat=1.1).
>  $QEMU_IO -c "write -z 5M 1M" "$TEST_IMG.base" | _filter_qemu_io
> -$QEMU_IO -c "alloc 5M $((1024*1024 / 512))" "$TEST_IMG.base" | _filter_qemu_io
> +$QEMU_IO -c "alloc 5M 1M" "$TEST_IMG.base" | _filter_qemu_io
>
>  # Presence of a backing file overrides permission to unmap.  Again,
>  # compat=0.10 images allocate, while compat=1.1 images set zero flag.
>  $QEMU_IO -c "write -z -u 7M 1M" "$TEST_IMG" | _filter_qemu_io
> -$QEMU_IO -c "alloc 7M $((1024 * 1024 / 512))" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "alloc 7M 1M" "$TEST_IMG" | _filter_qemu_io
>
>  # Final check that images are still sane.
>  TEST_IMG="$TEST_IMG.base" _check_test_img
> diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
> index fc97b19..18ecf0f 100644
> --- a/tests/qemu-iotests/179.out
> +++ b/tests/qemu-iotests/179.out
> @@ -13,10 +13,10 @@ wrote 1048576/1048576 bytes at offset 3145728
>  [{ "start": 0, "length": 16777216, "depth": 1, "zero": true, "data": false}]
>  wrote 1048576/1048576 bytes at offset 5242880
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -2048/2048 sectors allocated at offset 5 MiB
> +1048576/1048576 bytes allocated at offset 5 MiB
>  wrote 1048576/1048576 bytes at offset 7340032
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -2048/2048 sectors allocated at offset 7 MiB
> +1048576/1048576 bytes allocated at offset 7 MiB
>  No errors were found on the image.
>  No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.pattern
> index ddfbca1..34f4a8d 100644
> --- a/tests/qemu-iotests/common.pattern
> +++ b/tests/qemu-iotests/common.pattern
> @@ -18,7 +18,7 @@
>
>  function do_is_allocated() {
>      local start=$1
> -    local size=$(( $2 / 512))
> +    local size=$2
>      local step=$3
>      local count=$4
>
