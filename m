Received: from eggs.gnu.org ([209.51.188.92]:59466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1WKk-00068a-8T
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1WKj-0005kb-Jy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:11:42 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1WKj-0005k1-8p
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:11:41 -0500
References: <mvm5zsxz2we.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <be7edb45-9fbe-68b6-6fc0-e4cd987a93e2@vivier.eu>
Date: Wed, 6 Mar 2019 14:11:26 +0100
MIME-Version: 1.0
In-Reply-To: <mvm5zsxz2we.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: don't short-circuit read with
 zero length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/03/2019 17:45, Andreas Schwab wrote:
> A zero-length read still needs to do the usual checks, thus it may return
> errors like EBADF.  This makes the read syscall emulation consistent with
> the pread64 syscall emulation.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ff912e89e1..7fac8e318f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7047,8 +7047,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          _exit(arg1);
>          return 0; /* avoid warning */
>      case TARGET_NR_read:
> -        if (arg3 == 0) {
> -            return 0;
> +        if (arg2 == 0 && arg3 == 0) {
> +            return get_errno(safe_read(arg1, 0, 0));
>          } else {
>              if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
>                  return -TARGET_EFAULT;
> 

Applied to my linux-user branch.

Thanks,
Laurent
