Received: from eggs.gnu.org ([2001:4830:134:3::10]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dyJgl-000128-Ge
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dyJgh-0000Tm-Ug
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:28:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dyJgh-0000ST-LT
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:28:19 -0400
References: <1506784985-4107-1-git-send-email-zhuoweizhang@yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1ae4e3b7-e3d0-e58b-ca11-db5ba8e0f438@vivier.eu>
Date: Sat, 30 Sep 2017 17:28:06 +0200
MIME-Version: 1.0
In-Reply-To: <1506784985-4107-1-git-send-email-zhuoweizhang@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] syscall: fix special case of write(fd,
 NULL, 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: zhuoweizhang@yahoo.com, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi
List-ID: <qemu-devel.nongnu.org>

Le 30/09/2017 à 17:23, zhuoweizhang@yahoo.com a écrit :
> From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> 
> Linux returns success for the special case of calling write with a zero-length
> NULL buffer: compiling and running
> 
> ```
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> 
> int main() {
>    ssize_t ret = write(STDOUT_FILENO, NULL, 0);
>    fprintf(stderr, "write returned %ld\n", ret);
>    return 0;
> }
> ```
> gives "write returned 0" when run directly, but "write returned -1" in QEMU.
> 
> This commit checks for this situation and calls the real syscall with a NULL
> buffer and zero length, which gives the correct return value.
> 
> Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> ---
>  linux-user/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a..60769c0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7783,6 +7783,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          }
>          break;
>      case TARGET_NR_write:
> +        if (arg2 == 0 && arg3 == 0) {
> +            /* special case: write(fd, NULL, 0) returns success. */
> +            ret = get_errno(safe_write(arg1, NULL, 0));
> +            break;
> +        }
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
>              goto efault;
>          if (fd_trans_target_to_host_data(arg1)) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Could you change the NR_read too, for consistency?

Thanks,
Laurent
