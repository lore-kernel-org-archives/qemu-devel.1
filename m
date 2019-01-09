Received: from eggs.gnu.org ([209.51.188.92]:38075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBCR-0006Di-6o
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBCP-0004pp-5c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:35:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghBCO-0004pP-Vz
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:35:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so7072071wrt.11
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 02:35:00 -0800 (PST)
References: <20190108184900.9654-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85b11940-88b8-9a8e-aa8c-f3e2a60a3d2c@redhat.com>
Date: Wed, 9 Jan 2019 11:34:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190108184900.9654-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: make pwrite64/pread64(fd, NULL,
 0, offset) return 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 1/8/19 7:49 PM, Peter Maydell wrote:
> Linux returns success if pwrite64() or pread64() are called with a
> zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.
> 
> This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
> for the write syscall, and long before that in 38d840e6790c29f59
> for the read syscall.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1810433
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I chose to fix this by setting p to NULL and falling through
> to the normal-case codepath rather than having a call to
> pread/pwrite in the special-case if like 58cfa6c2e6eb5,
> because here the normal-case is a bit more complicated as
> it has the target_offset64() call in it.
> 38d840e6790c29f59 has "just return 0" for the NULL buffer
> case, but we can't do that here as that would not get the
> "negative offset should return -EINVAL" case write.
> ---
>  linux-user/syscall.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 280137da8c2..b13a170e52e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9677,8 +9677,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              arg4 = arg5;
>              arg5 = arg6;
>          }
> -        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
> -            return -TARGET_EFAULT;
> +        if (arg2 == 0 && arg3 == 0) {
> +            /* Special-case NULL buffer and zero length, which should succeed */
> +            p = 0;
> +        } else {
> +            p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
> +            if (!p) {

And this if() is now more readable, thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +                return -TARGET_EFAULT;
> +            }
> +        }
>          ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
>          unlock_user(p, arg2, ret);
>          return ret;
> @@ -9687,8 +9694,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              arg4 = arg5;
>              arg5 = arg6;
>          }
> -        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
> -            return -TARGET_EFAULT;
> +        if (arg2 == 0 && arg3 == 0) {
> +            /* Special-case NULL buffer and zero length, which should succeed */
> +            p = 0;
> +        } else {
> +            p = lock_user(VERIFY_READ, arg2, arg3, 1);
> +            if (!p) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
>          ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
>          unlock_user(p, arg2, 0);
>          return ret;
> 
