Received: from eggs.gnu.org ([2001:4830:134:3::10]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e455T-0000Dl-G8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e455P-0004RF-V3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:05:43 -0400
Received: from jessie.kos.to ([212.47.231.226]:52492 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1e455P-0004Pb-OU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:05:39 -0400
Date: Mon, 16 Oct 2017 13:05:36 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171016130536.GE1918@kos.to>
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507822245-15748-2-git-send-email-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, pgndev <pgnet.dev@gmail.com>

On Thu, Oct 12, 2017 at 04:30:44PM +0100, Peter Maydell wrote:
> We were defining TARGET_FS_IOC_GETFLAGS and TARGET_FS_IOC_SETFLAGS
> using the host 'long' type in the size field, which meant that
> they had the wrong values if the host and guest had different
> sized longs. Switch to abi_long instead.
> 
> This fixes a bug where these ioctls don't work on 32-bit guests
> on 64-bit hosts (and makes the LTP test 'setxattr03' pass
> where it did not previously.)

Applied to linux-user, thanks
 
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
> -- 
> 2.7.4
> 
