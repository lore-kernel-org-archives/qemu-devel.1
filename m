Received: from eggs.gnu.org ([2001:4830:134:3::10]:48282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjr0u-0001aR-0v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjr0q-0007zq-A8
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjr0q-0007za-3z
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:29:04 -0500
Date: Fri, 3 Mar 2017 17:28:58 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170303172858.GL13631@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148856193073.554.6631259860971664030.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148856193073.554.6631259860971664030.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Fri, Mar 03, 2017 at 06:25:30PM +0100, Greg Kurz wrote:
> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and make
> QEMU vulnerable.
> 
> O_PATH was used as an optimization: the fd returned by openat_dir() is only
> passed to openat() actually, so we don't really need to reach the underlying
> filesystem.
> 
> O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() will
> return a fd, forcing us to do some other syscall to detect we have a
> symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.
> 
> The only sane thing to do is hence to drop O_PATH, and only pass O_NOFOLLOW.
> 
> While here, we also fix local_unlinkat_common() to use openat_dir() for
> the same reasons (it was a leftover in the original patchset actually).
> 
> This fixes CVE-2016-9602.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    2 +-
>  hw/9pfs/9p-util.h  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 5db7104334d6..e31309a29c58 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -959,7 +959,7 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>          if (flags == AT_REMOVEDIR) {
>              int fd;
>  
> -            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
> +            fd = openat_dir(dirfd, name);
>              if (fd == -1) {
>                  goto err_out;
>              }
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 091f3ce88e15..4001d1fd8398 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -22,7 +22,7 @@ static inline void close_preserve_errno(int fd)
>  
>  static inline int openat_dir(int dirfd, const char *name)
>  {
> -    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
> +    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_NOFOLLOW);
>  }
>  
>  static inline int openat_file(int dirfd, const char *name, int flags,

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
