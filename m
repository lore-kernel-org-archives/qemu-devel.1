Received: from eggs.gnu.org ([2001:4830:134:3::10]:43372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMx2-0006Ko-On
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMwt-0004w5-9j
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:01:23 -0500
Date: Fri, 22 Dec 2017 14:00:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222130018.GE3763@localhost.localdomain>
References: <20171221224411.8901-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221224411.8901-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: refuse to open directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

Am 21.12.2017 um 23:44 hat John Snow geschrieben:
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
>  block/file-posix.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..bd29bdada6 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -589,6 +589,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          s->needs_alignment = true;
>      }
>  #endif
> +    if (S_ISDIR(st.st_mode)) {
> +        ret = -EISDIR;
> +        error_setg_errno(errp, errno, "Cannot open directory as file");
> +        goto fail;
> +    }

I think instead of blacklisting directories, the callers should somehow
pass the file types they expect. Which would probably initially be
something like:

file:
    S_IFREG: expected
    S_IFBLK or S_IFCHR: deprecation warning
    else: error

host_device / host_cdrom:
    S_IFBLK or S_IFCHR: expected (which one depends on the OS)
    else: error

Kevin
