Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpDgh-0004Xm-Ux
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpDgb-00063d-R6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:19:15 -0400
Date: Mon, 13 Aug 2018 16:18:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813141858.GJ4323@localhost.localdomain>
References: <20180810040743.25424-1-jcfaracco@gmail.com>
	<20180810040743.25424-5-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810040743.25424-5-jcfaracco@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] dmg: exchanging hardcoded dmg UDIF
 block types to enum.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Am 10.08.2018 um 06:07 hat Julio Faracco geschrieben:
> This change is better to understand what kind of block type is being
> handled by the code. Using a syntax similar to the DMG documentation is
> easier than tracking all hex values assigned to a block type.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  block/dmg.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index 390ab67e53..ae379adb20 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -44,6 +44,19 @@ enum {
>      DMG_SECTORCOUNTS_MAX = DMG_LENGTHS_MAX / 512,
>  };
>  
> +enum {
> +    /* DMG Block Type */
> +    UDZE=0, /* Zeroes */
> +    UDRW,   /* RAW type */
> +    UDIG,   /* Ignore */
> +    UDCO=0x80000004,

Note that 0x80000004 didn't exist in the code previously, so UDCO
shouldn't occur anywhere else in this patch.

> +    UDZO,
> +    UDBZ,
> +    ULFO,
> +    UDCM=0x7ffffffe, /* Comments */
> +    UDLE             /* Last Entry */
> +};
> +
>  static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
>  {
>      int len;
> @@ -108,16 +121,16 @@ static void update_max_chunk_size(BDRVDMGState *s, uint32_t chunk,
>      uint32_t uncompressed_sectors = 0;
>  
>      switch (s->types[chunk]) {
> -    case 0x80000005: /* zlib compressed */
> -    case 0x80000006: /* bzip2 compressed */
> -    case 0x80000007: /* lzfse compressed */
> +    case UDCO: /* zlib compressed */

Oops, should this be UDZO?

> +    case UDBZ: /* bzip2 compressed */
> +    case ULFO: /* lzfse compressed */
>          compressed_size = s->lengths[chunk];
>          uncompressed_sectors = s->sectorcounts[chunk];
>          break;
> -    case 1: /* copy */
> +    case UDRW: /* copy */
>          uncompressed_sectors = DIV_ROUND_UP(s->lengths[chunk], 512);
>          break;
> -    case 2: /* zero */
> +    case UDIG: /* zero */
>          /* as the all-zeroes block may be large, it is treated specially: the
>           * sector is not copied from a large buffer, a simple memset is used
>           * instead. Therefore uncompressed_sectors does not need to be set. */
> @@ -186,13 +199,13 @@ typedef struct DmgHeaderState {
>  static bool dmg_is_known_block_type(uint32_t entry_type)
>  {
>      switch (entry_type) {
> -    case 0x00000001:    /* uncompressed */
> -    case 0x00000002:    /* zeroes */
> -    case 0x80000005:    /* zlib */
> +    case UDRW:    /* uncompressed */
> +    case UDIG:    /* zeroes */
> +    case UDCO:    /* zlib */

And this one, too?

>          return true;
> -    case 0x80000006:    /* bzip2 */
> +    case UDBZ:    /* bzip2 */
>          return !!dmg_uncompress_bz2;
> -    case 0x80000007:    /* lzfse */
> +    case ULFO:    /* lzfse */
>  	return !!dmg_uncompress_lzfse;
>      default:
>          return false;

Kevin
