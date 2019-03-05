Received: from eggs.gnu.org ([209.51.188.92]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Duo-00026f-4q
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Duh-000845-8p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:31:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1Dud-0007pV-B2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:31:33 -0500
References: <mvm5zsxz2we.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c7e637a3-8567-839a-7bb1-d081139ce18f@vivier.eu>
Date: Tue, 5 Mar 2019 18:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <mvm5zsxz2we.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Le 05/03/2019 à 17:45, Andreas Schwab a écrit :
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
