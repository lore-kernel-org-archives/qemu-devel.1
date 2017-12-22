Received: from eggs.gnu.org ([2001:4830:134:3::10]:50982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSJbB-0005U4-Fb
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSJbA-0000Ro-Gp
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:26:37 -0500
Date: Fri, 22 Dec 2017 09:26:25 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171222092625.GG30605@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171221224411.8901-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Dec 21, 2017 at 05:44:11PM -0500, John Snow wrote:
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

Should we also do the same for S_ISCHR & S_ISFIFO, because neither of
them allow seeking, which IIUC would prevent usage in the file driver
for random I/O.  It would be fine todo that in a followup patch though,
so from this patch pov

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
