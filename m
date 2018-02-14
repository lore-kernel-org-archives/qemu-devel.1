Received: from eggs.gnu.org ([2001:4830:134:3::10]:39034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ollieparanoid@bitmessage.ch>) id 1em73M-0003Eh-V5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ollieparanoid@bitmessage.ch>) id 1em72f-0004cG-2a
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:05:32 -0500
Received: from mail.bitmessage.ch ([146.228.112.252]:62657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ollieparanoid@bitmessage.ch>)
	id 1em72e-0004YX-Hg
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:04:49 -0500
From: Oliver Smith <ollieparanoid@bitmessage.ch>
Message-ID: <faca1d54-8c99-cece-b427-b994307516dd@bitmessage.ch>
Date: Wed, 14 Feb 2018 23:33:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, carenas@sajinet.com.pe, laurent@vivier.eu, peter.maydell@linaro.org
Cc: zhuoweizhang@yahoo.com

Hello there,

I'm a little late to the party. But what is necessary to get this
upstreamed, and how can I help?

PS: Sorry if I picked the wrong e-mail addresses, I wasn't subscribed to
the ML at that point and used the addresses I could find for the people
who answered to the original thread here:

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08073.html

Thanks,
Oliver


From: Zhuowei Zhang <address@hidden>
> Linux returns success for the special case of calling write with a
> zero-length NULL buffer: compiling and running
>
> ```
>
> int main() {
>    ssize_t ret = write(STDOUT_FILENO, NULL, 0);
>    fprintf(stderr, "write returned %ld\n", ret);
>    return 0;
> }
> ```
> gives "write returned 0" when run directly, but "write returned -1" in
> QEMU.
>
> This commit checks for this situation and returns success if found.
>
> Signed-off-by: Zhuowei Zhang <address@hidden>
> ---
>  linux-user/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a..ecadf49 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7783,6 +7783,11 @@ abi_long do_syscall(void *cpu_env, int num,
abi_long
> arg1,
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
> --
> 1.9.1
