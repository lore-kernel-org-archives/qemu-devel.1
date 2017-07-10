Received: from eggs.gnu.org ([2001:4830:134:3::10]:43757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUYhG-0001R6-1o
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUYhF-0007nD-8m
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:25:54 -0400
Date: Mon, 10 Jul 2017 15:25:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170710132546.GG5772@noname.redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-6-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498733831-15254-6-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com

Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
> we now read the extension on open and write it on update, but
> do not yet use it.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  block/qcow2.h |  23 +++++++++++---
>  2 files changed, 104 insertions(+), 19 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 308121a..39a8afc 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -63,6 +63,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_END 0
>  #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> +#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
>  
>  static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>  {
> @@ -76,6 +77,26 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>          return 0;
>  }
>  
> +static int qcow2_compress_format_from_name(char *fmt)
> +{
> +    if (!fmt || !fmt[0]) {
> +        return QCOW2_COMPRESS_ZLIB_COMPAT;
> +    } else if (g_str_equal(fmt, "zlib")) {
> +        return QCOW2_COMPRESS_ZLIB;
> +    } else {
> +        return -EINVAL;
> +    }
> +}

It might make sense to allow specifying the old compression format in
the compression header. But I'm not so sure about using the empty string
rather than a proper name for it, and even less about not documenting
it.

Kevin
