Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykIc-0005fu-1I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykIa-0000S9-UB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:25:30 -0400
Date: Wed, 21 Mar 2018 21:25:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321202501.GJ3898@localhost.localdomain>
References: <20180321200114.10981-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321200114.10981-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 21.03.2018 um 21:01 hat John Snow geschrieben:
> Adjust each caller of raw_open_common to specify if they are expecting
> host and character devices or not. Tighten expectations of file types upon
> open in the common code and refuse types that are not expected.
> 
> This has two effects:
> 
> (1) Character and block devices are now considered deprecated for the
>     'file' driver, which expects only S_IFREG, and
> (2) no file-posix driver (file, host_cdrom, or host_device) can open
>     directories now.
> 
> I don't think there's a legitimate reason to open directories as if
> they were files. This prevents QEMU from opening and attempting to probe
> a directory inode, which can break in exciting ways. One of those ways
> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> size instead of EISDIR. This can coax QEMU into responding with a
> confusing "file too big" instead of "Hey, that's not a file".
> 
> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> 
> v5: rebase for 2.12.0-rc0
> 
>  block/file-posix.c | 37 +++++++++++++++++++++++++++++--------
>  qemu-doc.texi      |  6 ++++++
>  2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index d7fb772c14..31d9afe026 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -420,7 +420,8 @@ static QemuOptsList raw_runtime_opts = {
>  };
>  
>  static int raw_open_common(BlockDriverState *bs, QDict *options,
> -                           int bdrv_flags, int open_flags, Error **errp)
> +                           int bdrv_flags, int open_flags,
> +                           bool device, Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>      QemuOpts *opts;
> @@ -558,10 +559,30 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          error_setg_errno(errp, errno, "Could not stat file");
>          goto fail;
>      }
> -    if (S_ISREG(st.st_mode)) {
> -        s->discard_zeroes = true;
> -        s->has_fallocate = true;
> +
> +    if (!device) {
> +        if (S_ISBLK(st.st_mode)) {
> +            warn_report("Opening a block device as file using 'file' "
> +                        "driver is deprecated");
> +        } else if (S_ISCHR(st.st_mode)) {
> +            warn_report("Opening a character device as file using the 'file' "
> +                        "driver is deprecated");
> +        } else if (!S_ISREG(st.st_mode)) {
> +            error_setg(errp, "A regular file was expected by the 'file' driver, "
> +                       "but something else was given");
> +            goto fail;

ret needs to be set here, otherwise we return success. In my test, I
still got the wrong message: "Could not refresh total sector count:
Invalid argument"

> +        } else {
> +            s->discard_zeroes = true;
> +            s->has_fallocate = true;
> +        }
> +    } else {
> +        if (!(S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode))) {
> +            error_setg(errp, "host_device/host_cdrom driver expects either "
> +                       "a character or block device");
> +            goto fail;

Same here.

> +        }
>      }

Do we want a qemu-iotests case for this?

Kevin
