Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df9YL-0008CL-9X
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df9YH-0001nr-CR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:48:29 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:33054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df9YG-0001nG-SR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:48:25 -0400
Received: by mail-ua0-x243.google.com with SMTP id q25so2699724uah.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 11:48:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
Date: Tue, 8 Aug 2017 15:48:20 -0300
MIME-Version: 1.0
In-Reply-To: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn

Hi Greg,

is this also related to CVE-2016-9602?

On 08/08/2017 02:28 PM, Greg Kurz wrote:
> This function has to ensure it doesn't follow a symlink that could be used
> to escape the virtfs directory. This could be easily achieved if fchmodat()
> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
> it doesn't.
> 
> The current implementation covers most use-cases, but it notably fails if:
> - the target path has access rights equal to 0000 (openat() returns EPERM),
>    => once you've done chmod(0000) on a file, you can never chmod() again
> - the target path is UNIX domain socket (openat() returns ENXIO)
>    => bind() of UNIX domain sockets fails if the file is on 9pfs
> 
> The solution is to use O_PATH: openat() now succeeds in both cases, and we
> can ensure the path isn't a symlink with fstat(). The associated entry in
> "/proc/self/fd" can hence be safely passed to the regular chmod() syscall.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p-local.c |   44 ++++++++++++++++++++++++++++----------------
>   hw/9pfs/9p-util.h  |   10 +++++++---
>   2 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 6e478f4765ef..b178d627c764 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -333,30 +333,42 @@ update_map_file:
>   
>   static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
>   {
> +    struct stat stbuf;
>       int fd, ret;
> +    char *proc_path;
>   
>       /* FIXME: this should be handled with fchmodat(AT_SYMLINK_NOFOLLOW).
> -     * Unfortunately, the linux kernel doesn't implement it yet. As an
> -     * alternative, let's open the file and use fchmod() instead. This
> -     * may fail depending on the permissions of the file, but it is the
> -     * best we can do to avoid TOCTTOU. We first try to open read-only
> -     * in case name points to a directory. If that fails, we try write-only
> -     * in case name doesn't point to a directory.
> +     * Unfortunately, the linux kernel doesn't implement it yet.
>        */
> -    fd = openat_file(dirfd, name, O_RDONLY, 0);
> -    if (fd == -1) {
> -        /* In case the file is writable-only and isn't a directory. */
> -        if (errno == EACCES) {
> -            fd = openat_file(dirfd, name, O_WRONLY, 0);
> -        }
> -        if (fd == -1 && errno == EISDIR) {
> -            errno = EACCES;
> -        }
> +    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW)) {
> +        return -1;
>       }
> +
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno = ELOOP;
> +        return -1;
> +    }
> +
> +    fd = openat_file(dirfd, name, O_RDONLY | O_PATH, 0);

since you use O_PATH, you can drop O_RDONLY.

>       if (fd == -1) { >           return -1;
>       }
> -    ret = fchmod(fd, mode);
> +
> +    ret = fstat(fd, &stbuf);
> +    if (ret) {
> +        goto out;
> +    }
> +
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno = ELOOP;
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    proc_path = g_strdup_printf("/proc/self/fd/%d", fd);
> +    ret = chmod(proc_path, mode);
> +    g_free(proc_path);
> +out:
>       close_preserve_errno(fd);
>       return ret;
>   }
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 91299a24b8af..7c1c8fb1e35c 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -43,9 +43,13 @@ static inline int openat_file(int dirfd, const char *name, int flags,
>       }
>   
>       serrno = errno;
> -    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
> -    ret = fcntl(fd, F_SETFL, flags);
> -    assert(!ret);
> +    /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
> +     * do that with O_PATH since it ignores O_NONBLOCK.
> +     */

thinking about if someone uses openat_file(d, O_PATH|O_CLOEXEC, ...), 
why not set the fd flags always? like:

        ret = fcntl(fd, F_SETFL, flags);
        assert((flags & O_PATH) || !ret);

>       errno = serrno;
>       return fd;
>   }
> 
>
