Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceQ0t-0007Su-9v
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceQ0r-0002Bs-Rq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:38:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170203195037.4238-1-nirsof@gmail.com>
References: <20170203195037.4238-1-nirsof@gmail.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 16 Feb 2017 19:38:24 +0200
Message-ID: <CAMr-obvrGhP=S9ovxk2okPbeVy817+Z-vpk0b_d5KHRj3o-qpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Do not truncate before
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

Ping

On Fri, Feb 3, 2017 at 9:50 PM, Nir Soffer <nirsof@gmail.com> wrote:
> When using file system that does not support fallocate() (e.g. NFS <
> 4.2), truncating the file only when preallocation=OFF speeds up creating
> raw file.
>
> Here is example run, tested on Fedora 24 machine, creating raw file on
> NFS version 3 server.
>
> $ time ./qemu-img-master create -f raw -o preallocation=falloc mnt/test 1g
> Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc
>
> real    0m21.185s
> user    0m0.022s
> sys     0m0.574s
>
> $ time ./qemu-img-fix create -f raw -o preallocation=falloc mnt/test 1g
> Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc
>
> real    0m11.601s
> user    0m0.016s
> sys     0m0.525s
>
> $ time dd if=/dev/zero of=mnt/test bs=1M count=1024 oflag=direct
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 15.6627 s, 68.6 MB/s
>
> real    0m16.104s
> user    0m0.009s
> sys     0m0.220s
>
> Running with strace we can see that without this change we do one
> pread() and one pwrite() for each block. With this change, we do only
> one pwrite() per block.
>
> $ strace ./qemu-img-master create -f raw -o preallocation=falloc mnt/test 8192
> ...
> pread64(9, "\0", 1, 4095)               = 1
> pwrite64(9, "\0", 1, 4095)              = 1
> pread64(9, "\0", 1, 8191)               = 1
> pwrite64(9, "\0", 1, 8191)              = 1
>
> $ strace ./qemu-img-fix create -f raw -o preallocation=falloc mnt/test 8192
> ...
> pwrite64(9, "\0", 1, 4095)              = 1
> pwrite64(9, "\0", 1, 8191)              = 1
>
> This happens because posix_fallocate is checking if each block is
> allocated before writing a byte to the block, and when truncating the
> file before preallocation, all blocks are unallocated.
>
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>
> I sent this a week ago:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg06123.html
>
> Sending again with improved commit message.
>
>  block/file-posix.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2134e0e..442f080 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1591,12 +1591,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>  #endif
>      }
>
> -    if (ftruncate(fd, total_size) != 0) {
> -        result = -errno;
> -        error_setg_errno(errp, -result, "Could not resize file");
> -        goto out_close;
> -    }
> -
>      switch (prealloc) {
>  #ifdef CONFIG_POSIX_FALLOCATE
>      case PREALLOC_MODE_FALLOC:
> @@ -1636,6 +1630,10 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>          break;
>      }
>      case PREALLOC_MODE_OFF:
> +        if (ftruncate(fd, total_size) != 0) {
> +            result = -errno;
> +            error_setg_errno(errp, -result, "Could not resize file");
> +        }
>          break;
>      default:
>          result = -EINVAL;
> @@ -1644,7 +1642,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>          break;
>      }
>
> -out_close:
>      if (qemu_close(fd) != 0 && result == 0) {
>          result = -errno;
>          error_setg_errno(errp, -result, "Could not close the new file");
> --
> 2.9.3
>
