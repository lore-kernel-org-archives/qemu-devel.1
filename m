Received: from eggs.gnu.org ([2001:4830:134:3::10]:52751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdsLq-0008DO-4r
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdsLO-0005zI-VX
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:18:50 -0400
Date: Fri, 13 Jul 2018 09:17:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180713071743.GB3896@localhost.localdomain>
References: <1531422529-30153-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531422529-30153-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: avoid overflow of min_sparse
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, qemu-stable@nongnu.org

Am 12.07.2018 um 21:08 hat Peter Lieven geschrieben:
> the min_sparse convert parameter can overflow (e.g. -S 1024G)
> in the conversion from int64_t to int resulting in a negative
> min_sparse parameter. Avoid this by limiting the valid parameters
> to sane values. In fact anything exceeding the convert buffer size
> is also pointless. While at it also forbid values that are non
> multiple of 512 to avoid undesired behaviour. Values between 1 and
> 511 were legal, but resulted in full allocation.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 4a7ce43..2896746 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2005,6 +2005,8 @@ static int convert_do_copy(ImgConvertState *s)
>      return s->ret;
>  }
>  
> +#define MAX_BUF_SECTORS 32768
> +
>  static int img_convert(int argc, char **argv)
>  {
>      int c, bs_i, flags, src_flags = 0;
> @@ -2100,8 +2102,12 @@ static int img_convert(int argc, char **argv)
>              int64_t sval;
>  
>              sval = cvtnum(optarg);
> -            if (sval < 0) {
> -                error_report("Invalid minimum zero buffer size for sparse output specified");
> +            if (sval < 0 || sval & BDRV_SECTOR_BITS ||

BDRV_SECTOR_BITS is 9 (because 1 << 9 == BDRV_SECTOR_SIZE), not a bit
mask to be used with &. I think what you want is BDRV_SECTOR_SIZE - 1.

Kevin
