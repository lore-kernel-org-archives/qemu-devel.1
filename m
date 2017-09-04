Received: from eggs.gnu.org ([2001:4830:134:3::10]:37733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotXX-0004eJ-OF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotXT-00016d-32
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:55 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotXS-00016H-VU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:51 -0400
Received: by mail-qt0-x242.google.com with SMTP id p55so501454qtc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 08:43:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150450989314.1143.5582306195355968158.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a962aafb-309d-84e8-550d-9f33c8569fb3@amsat.org>
Date: Mon, 4 Sep 2017 12:43:46 -0300
MIME-Version: 1.0
In-Reply-To: <150450989314.1143.5582306195355968158.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: clarify fchmodat_nofollow()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 09/04/2017 04:24 AM, Greg Kurz wrote:
> Since fchmodat(2) on Linux doesn't support AT_SYMLINK_NOFOLLOW, we have to
> implement it using workarounds. There are two different ways, depending on
> whether the system supports O_PATH or not.
> 
> In the case O_PATH is supported, we rely on the behavhior of openat(2)
> when passing O_NOFOLLOW | O_PATH and the file is a symbolic link. Even
> if openat_file() already adds O_NOFOLLOW to the flags, this patch makes
> it explicit that we need both creation flags to obtain the expected
> behavior.
> 
> This is only cleanup, no functional change.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/9pfs/9p-local.c |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index efb0b79a74bf..e51af87309c6 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -349,11 +349,11 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
>           return -1;
>       }
>   
> -    /* Access modes are ignored when O_PATH is supported. We try O_RDONLY and
> -     * O_WRONLY for old-systems that don't support O_PATH.
> -     */
> -    fd = openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
> +    fd = openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
>   #if O_PATH_9P_UTIL == 0
> +    /* Fallback for systems that don't support O_PATH: we depend on the file
> +     * being readable or writable.
> +     */
>       if (fd == -1) {
>           /* In case the file is writable-only and isn't a directory. */
>           if (errno == EACCES) {
> @@ -368,6 +368,10 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
>       }
>       ret = fchmod(fd, mode);
>   #else
> +    /* Access modes are ignored when O_PATH is supported. If name is a symbolic
> +     * link, O_PATH | O_NOFOLLOW causes openat(2) to return a file descriptor
> +     * referring to the symbolic link.
> +     */
>       if (fd == -1) {
>           return -1;
>       }
> 
> 
