Received: from eggs.gnu.org ([2001:4830:134:3::10]:53386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXXLd-0005J0-9P
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fXXLc-0003Hm-6Z
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:40:25 -0400
Date: Mon, 25 Jun 2018 12:40:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180625194005.GA21023@roeck-us.net>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
	<cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
	<patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
Subject: Re: [Qemu-devel] [PATCH] s390/boot: block uncompressed vmlinux
 booting attempts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Mon, Jun 25, 2018 at 05:09:19PM +0200, Vasily Gorbik wrote:
> Since uncompressed kernel image "vmlinux" elf file is not bootable under
> qemu anymore, add a check which would report that.
> 
> Qemu users are encouraged to use bzImage or
> arch/s390/boot/compressed/vmlinux instead.
> 
> The check relies on s390 linux entry point ABI definition, which is only
> present in bzImage and arch/s390/boot/compressed/vmlinux.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

With qemu:

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/boot/head.S         |  4 ++--
>  arch/s390/include/asm/setup.h |  3 ++-
>  arch/s390/kernel/early.c      | 12 ++++++++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
> index f09e792df495..f721913b73f1 100644
> --- a/arch/s390/boot/head.S
> +++ b/arch/s390/boot/head.S
> @@ -272,14 +272,14 @@ iplstart:
>  	.org	0x10000
>  ENTRY(startup)
>  	j	.Lep_startup_normal
> -	.org	0x10008
> +	.org	EP_OFFSET
>  #
>  # This is a list of s390 kernel entry points. At address 0x1000f the number of
>  # valid entry points is stored.
>  #
>  # IMPORTANT: Do not change this table, it is s390 kernel ABI!
>  #
> -	.ascii	"S390EP"
> +	.ascii	EP_STRING
>  	.byte	0x00,0x01
>  #
>  # kdump startup-code at 0x10010, running in 64 bit absolute addressing mode
> diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
> index be02f0558048..1d66016f4170 100644
> --- a/arch/s390/include/asm/setup.h
> +++ b/arch/s390/include/asm/setup.h
> @@ -9,7 +9,8 @@
>  #include <linux/const.h>
>  #include <uapi/asm/setup.h>
>  
> -
> +#define EP_OFFSET		0x10008
> +#define EP_STRING		"S390EP"
>  #define PARMAREA		0x10400
>  #define PARMAREA_END		0x11000
>  
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 827699eb48fa..45c5be3d8777 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -331,8 +331,20 @@ static void __init setup_boot_command_line(void)
>  	append_to_cmdline(append_ipl_scpdata);
>  }
>  
> +static void __init check_image_bootable(void)
> +{
> +	if (!memcmp(EP_STRING, (void *)EP_OFFSET, strlen(EP_STRING)))
> +		return;
> +
> +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");
> +	disabled_wait(0xbadb007);
> +}
> +
>  void __init startup_init(void)
>  {
> +	check_image_bootable();
>  	time_early_init();
>  	init_kernel_storage_key();
>  	lockdep_off();
> -- 
> ⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
> ⣿⢿⡿⣿ pacman edition
> 
