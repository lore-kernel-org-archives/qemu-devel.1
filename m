Received: from eggs.gnu.org ([2001:4830:134:3::10]:42062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdVs4-000251-TM
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdVs1-0002VY-Nj
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:18:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fdVs1-0002T7-E4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:18:33 -0400
References: <cover.1467138806.git.riku.voipio@linaro.org>
	<435da5e7092aa54e12044b9401b42c4a9333c74d.1467138806.git.riku.voipio@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6233d484-ebfd-3225-92b5-c1c1e07b047e@vivier.eu>
Date: Thu, 12 Jul 2018 09:18:29 +0200
MIME-Version: 1.0
In-Reply-To: <435da5e7092aa54e12044b9401b42c4a9333c74d.1467138806.git.riku.voipio@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 03/24] linux-user: Use safe_syscall
 wrapper for fcntl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: riku.voipio@linaro.org, qemu-devel@nongnu.org

Le 28/06/2016 à 21:12, riku.voipio@linaro.org a écrit :
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> Use the safe_syscall wrapper for fcntl. This is straightforward now
> that we always use 'struct fcntl64' on the host, as we don't need
> to select whether to call the host's fcntl64 or fcntl syscall
> (a detail that the libc previously hid for us).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> ---
>  linux-user/syscall.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
...
> @@ -10252,7 +10264,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              if (ret) {
>                  break;
>              }
> -            ret = get_errno(fcntl(arg1, cmd, &fl));
> +            ret = get_errno(safe_fcntl(arg1, cmd, &fl));
>  	    break;
>          default:
>              ret = do_fcntl(arg1, arg2, arg3);
> 

Peter,

435da5e709 linux-user: Use safe_syscall wrapper for fcntl

do you remember why you only convert to safe_fcntl() the
TARGET_F_SETLK64 and TARGET_F_SETLKW64 cases and not the
TARGET_F_GETLK64 one (in TARGET_NR_fcntl64)?

Thanks,
Laurent
