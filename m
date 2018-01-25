Received: from eggs.gnu.org ([2001:4830:134:3::10]:41650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eekOQ-0002Iw-BS
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eekOM-0001e7-D5
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:28:50 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eekOM-0001cu-0t
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:28:46 -0500
References: <mvm7es7sds9.fsf@suse.de> <mvm8tcmqdp3.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f74a6cff-446e-0b98-de1b-7416561c650c@vivier.eu>
Date: Thu, 25 Jan 2018 17:28:39 +0100
MIME-Version: 1.0
In-Reply-To: <mvm8tcmqdp3.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Implement ioctl cmd
 TIOCGPTPEER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org

Le 25/01/2018 à 14:18, Andreas Schwab a écrit :
> With glibc 2.27 the openpty function will prefer the TIOCGPTPEER ioctl.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
> v2: handle host with old kernel headers
> ---
>  linux-user/aarch64/termbits.h    | 2 ++
>  linux-user/alpha/termbits.h      | 1 +
>  linux-user/arm/termbits.h        | 1 +
>  linux-user/cris/termbits.h       | 1 +
>  linux-user/hppa/termbits.h       | 2 ++
>  linux-user/i386/termbits.h       | 1 +
>  linux-user/ioctls.h              | 3 +++
>  linux-user/m68k/termbits.h       | 1 +
>  linux-user/microblaze/termbits.h | 1 +
>  linux-user/mips/termbits.h       | 1 +
>  linux-user/nios2/termbits.h      | 2 ++
>  linux-user/openrisc/termbits.h   | 2 ++
>  linux-user/ppc/termbits.h        | 1 +
>  linux-user/s390x/termbits.h      | 1 +
>  linux-user/sh4/termbits.h        | 1 +
>  linux-user/sparc/termbits.h      | 1 +
>  linux-user/sparc64/termbits.h    | 1 +
>  linux-user/syscall.c             | 9 +++++++++
>  linux-user/tilegx/termbits.h     | 1 +
>  linux-user/x86_64/termbits.h     | 1 +
>  20 files changed, 34 insertions(+)
> 
...
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 35cad6f944..586c794639 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -40,6 +40,9 @@
>       IOCTL(TIOCSETD, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(TIOCGPTN, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(TIOCSPTLCK, IOC_W, MK_PTR(TYPE_INT))
> +#ifdef TIOCGPTPEER
> +     IOCTL_SPECIAL(TIOCGPTPEER, 0, do_ioctl_tiocgptpeer, TYPE_INT)
> +#endif
>       IOCTL(FIOCLEX, 0, TYPE_NULL)
>       IOCTL(FIONCLEX, 0, TYPE_NULL)
>       IOCTL(FIOASYNC, IOC_W, MK_PTR(TYPE_INT))
...
> diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
> index 691600d27a..98268936dc 100644
> --- a/linux-user/sparc/termbits.h
> +++ b/linux-user/sparc/termbits.h
> @@ -245,6 +245,7 @@ struct target_termios {
>  /* Get minor device of a pty master's FD -- Solaris equiv is ISPTM */
>  #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty Number */
>  #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
> +#define TARGET_TIOCGPTPEER      TARGET_IO('T', 137) /* Safely open the slave */

On sparc, it's:

#define TIOCGPTPEER     TARGET_IO('t', 137) /* Safely open the slave */

>  
>  /* Little f */
>  #define TARGET_FIOCLEX		TARGET_IO('f', 1)
> diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
> index 691600d27a..98268936dc 100644
> --- a/linux-user/sparc64/termbits.h
> +++ b/linux-user/sparc64/termbits.h
> @@ -245,6 +245,7 @@ struct target_termios {
>  /* Get minor device of a pty master's FD -- Solaris equiv is ISPTM */
>  #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty Number */
>  #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
> +#define TARGET_TIOCGPTPEER      TARGET_IO('T', 137) /* Safely open the slave */

#define TIOCGPTPEER     TARGET_IO('t', 137) /* Safely open the slave */

If you fix that, you can add:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
