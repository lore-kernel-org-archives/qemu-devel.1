Received: from eggs.gnu.org ([2001:4830:134:3::10]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtn2x-00023q-BJ
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtn2w-0003fE-CR
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:48:35 -0400
Date: Mon, 18 Sep 2017 11:48:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918034825.GC15551@lemon.lan>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/18] block/mirror: Pull out
 mirror_perform()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, 09/13 20:18, Max Reitz wrote:
> When converting mirror's I/O to coroutines, we are going to need a point
> where these coroutines are created.  mirror_perform() is going to be
> that point.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c | 53 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 6531652d73..4664b0516f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -82,6 +82,12 @@ typedef struct MirrorOp {
>      uint64_t bytes;
>  } MirrorOp;
>  
> +typedef enum MirrorMethod {
> +    MIRROR_METHOD_COPY,
> +    MIRROR_METHOD_ZERO,
> +    MIRROR_METHOD_DISCARD,
> +} MirrorMethod;
> +
>  static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
>                                              int error)
>  {
> @@ -324,6 +330,22 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
>      }
>  }
>  
> +static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> +                               unsigned bytes, MirrorMethod mirror_method)
> +{
> +    switch (mirror_method) {
> +    case MIRROR_METHOD_COPY:
> +        return mirror_do_read(s, offset, bytes);
> +    case MIRROR_METHOD_ZERO:
> +    case MIRROR_METHOD_DISCARD:
> +        mirror_do_zero_or_discard(s, offset, bytes,
> +                                  mirror_method == MIRROR_METHOD_DISCARD);
> +        return bytes;
> +    default:
> +        abort();
> +    }
> +}
> +
>  static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>  {
>      BlockDriverState *source = s->source;
> @@ -395,11 +417,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          unsigned int io_bytes;
>          int64_t io_bytes_acct;
>          BlockDriverState *file;
> -        enum MirrorMethod {
> -            MIRROR_METHOD_COPY,
> -            MIRROR_METHOD_ZERO,
> -            MIRROR_METHOD_DISCARD
> -        } mirror_method = MIRROR_METHOD_COPY;
> +        MirrorMethod mirror_method = MIRROR_METHOD_COPY;
>  
>          assert(!(offset % s->granularity));
>          ret = bdrv_get_block_status_above(source, NULL,
> @@ -439,22 +457,11 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          }
>  
>          io_bytes = mirror_clip_bytes(s, offset, io_bytes);
> -        switch (mirror_method) {
> -        case MIRROR_METHOD_COPY:
> -            io_bytes = io_bytes_acct = mirror_do_read(s, offset, io_bytes);
> -            break;
> -        case MIRROR_METHOD_ZERO:
> -        case MIRROR_METHOD_DISCARD:
> -            mirror_do_zero_or_discard(s, offset, io_bytes,
> -                                      mirror_method == MIRROR_METHOD_DISCARD);
> -            if (write_zeroes_ok) {
> -                io_bytes_acct = 0;
> -            } else {
> -                io_bytes_acct = io_bytes;
> -            }
> -            break;
> -        default:
> -            abort();
> +        io_bytes = mirror_perform(s, offset, io_bytes, mirror_method);
> +        if (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok) {
> +            io_bytes_acct = 0;
> +        } else {
> +            io_bytes_acct = io_bytes;
>          }
>          assert(io_bytes);
>          offset += io_bytes;
> @@ -650,8 +657,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>                  continue;
>              }
>  
> -            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
> -                                      nb_sectors * BDRV_SECTOR_SIZE, false);
> +            mirror_perform(s, sector_num * BDRV_SECTOR_SIZE,
> +                           nb_sectors * BDRV_SECTOR_SIZE, MIRROR_METHOD_ZERO);
>              sector_num += nb_sectors;
>          }
>  
> -- 
> 2.13.5
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
