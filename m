Received: from eggs.gnu.org ([2001:4830:134:3::10]:54370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2gRi-0001ui-GN
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2gRe-0004B6-In
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:34:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e2gRe-0004AN-9N
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:34:50 -0400
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-2-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <04f1d1d3-608b-adba-24cc-9e698f145cbd@vivier.eu>
Date: Thu, 12 Oct 2017 18:34:37 +0200
MIME-Version: 1.0
In-Reply-To: <1507822245-15748-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Fix target FS_IOC_GETFLAGS
 and FS_IOC_SETFLAGS numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, pgndev <pgnet.dev@gmail.com>

Le 12/10/2017 à 17:30, Peter Maydell a écrit :
> We were defining TARGET_FS_IOC_GETFLAGS and TARGET_FS_IOC_SETFLAGS
> using the host 'long' type in the size field, which meant that
> they had the wrong values if the host and guest had different
> sized longs. Switch to abi_long instead.
> 
> This fixes a bug where these ioctls don't work on 32-bit guests
> on 64-bit hosts (and makes the LTP test 'setxattr03' pass
> where it did not previously.)
> 
> Reported-by: pgndev <pgnet.dev@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 40c5027..f7cc9f9 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1101,8 +1101,8 @@ struct target_pollfd {
>  /* Note that the ioctl numbers claim type "long" but the actual type
>   * used by the kernel is "int".
>   */
> -#define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, long)
> -#define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, long)
> +#define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, abi_long)
> +#define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, abi_long)
>  
>  #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
