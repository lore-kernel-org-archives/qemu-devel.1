Received: from eggs.gnu.org ([2001:4830:134:3::10]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eblEH-0001v8-1N
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eblEG-00069f-2K
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:46:01 -0500
Date: Wed, 17 Jan 2018 11:45:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180117104542.GA3860@localhost.localdomain>
References: <20180115225047.28607-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115225047.28607-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 15.01.2018 um 23:50 hat John Snow geschrieben:
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
> v2: Is something like this what you had in mind, Kevin?
>     I couldn't make the hdev/cdrom checks more specific
>     as I'm not sure which environments expect which, but
>     if you know I can tighten it.

This should do. We could in theory be more specific about which OS
expects block devices and which one uses character devices, but there's
probably no point in doing that. And without further research I couldn't
say much more than that Linux uses block devices and FreeBSD character
devices.

>  block/file-posix.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)

As Eric said, it would be good to add a deprecation note to
qemu-doc.texi (and probably also the changelog in the wiki).

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..fe06cdb8f8 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -417,7 +417,8 @@ static QemuOptsList raw_runtime_opts = {
>  };
>  
>  static int raw_open_common(BlockDriverState *bs, QDict *options,
> -                           int bdrv_flags, int open_flags, Error **errp)
> +                           int bdrv_flags, int open_flags,
> +                           bool device, Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
>      QemuOpts *opts;
> @@ -556,10 +557,30 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          error_setg_errno(errp, errno, "Could not stat file");
>          goto fail;
>      }
> -    if (S_ISREG(st.st_mode)) {
> -        s->discard_zeroes = true;
> -        s->has_fallocate = true;
> +
> +    if (!device) {
> +        if (S_ISBLK(st.st_mode)) {
> +            warn_report("Opening a block device as file using 'file'"
> +                        "driver is deprecated");

All your line-wrapped strings are missing a space at the end of the
first line.

Kevin
