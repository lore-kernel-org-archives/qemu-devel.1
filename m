Received: from eggs.gnu.org ([2001:4830:134:3::10]:54815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dy0kZ-0004I4-76
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dy0kW-0005De-2W
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:15:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dy0kV-0005Cw-Ov
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:14:59 -0400
References: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
Date: Fri, 29 Sep 2017 21:14:46 +0200
MIME-Version: 1.0
In-Reply-To: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
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

Le 29/09/2017 à 18:50, zhuoweizhang@yahoo.com a écrit :
> From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> 
> Linux returns success for the special case of calling write with a zero-length
> NULL buffer: compiling and running
> 
> ```
> 
> int main() {
>    ssize_t ret = write(STDOUT_FILENO, NULL, 0);
>    fprintf(stderr, "write returned %ld\n", ret);
>    return 0;
> }
> ```
> gives "write returned 0" when run directly, but "write returned -1" in QEMU.
> 
> This commit checks for this situation and returns success if found.
> 
> Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> ---
>  linux-user/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a..ecadf49 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7783,6 +7783,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          }
>          break;
>      case TARGET_NR_write:
> +        if (arg2 == 0 && arg3 == 0) {
> +            /* special case: write(fd, NULL, 0) returns success. */
> +            ret = 0;
> +            break;
> +        }
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
>              goto efault;
>          if (fd_trans_target_to_host_data(arg1)) {
> 

I think we should keep the call to the kernel write() as the behavior
depends on the driver behind the syscall. Moreover, calling write() with
(NULL, 0) can triggers "something" at kernel level.

Thanks,
Laurent
