Received: from eggs.gnu.org ([2001:4830:134:3::10]:44174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpyPZ-0004LW-MK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpyPQ-0001jf-8K
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:08:09 -0400
Date: Thu, 7 Sep 2017 17:07:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907150739.GH4461@dhcp-200-186.str.redhat.com>
References: <20170811080939.22304-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811080939.22304-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 11.08.2017 um 10:09 hat Fam Zheng geschrieben:
> People get surprised when, after "qemu-img create -f raw /dev/sdX", they
> still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
> header. While this is natural because raw doesn't need to write any
> magic bytes during creation, hdev_create is free to clear out the first
> sector to make sure the stale qcow2 header doesn't cause such confusion.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v2: Use stack allocated buffer. [Eric]
>     Fix return value.
>     (Keep qemu_write_full instead of switching to qemu_pwritev because
>     the former handles short writes.)
>     Fix typo "qemu-img". [Changlong]
> ---
>  block/file-posix.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f4de022ae0..a63bbf2b90 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2703,6 +2703,16 @@ static int hdev_create(const char *filename, QemuOpts *opts,
>          ret = -ENOSPC;
>      }

So the error paths above only set ret, but don't actually return or jump
to the end of the function.

> +    if (total_size) {
> +        uint8_t buf[BDRV_SECTOR_SIZE] = { 0 };
> +        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> +        if (lseek(fd, 0, SEEK_SET) == -1) {
> +            ret = -errno;
> +        } else {
> +            ret = qemu_write_full(fd, buf, zero_size);
> +            ret = ret == zero_size ? 0 : -errno;

Which means that an error above (like a too small block device or using
a regular file) can be overwritten with a success value if clearing the
first sector works. That's probably not quite right.

> +        }
> +    }
>      qemu_close(fd);
>      return ret;
>  }

Kevin
