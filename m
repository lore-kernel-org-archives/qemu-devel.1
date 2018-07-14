Received: from eggs.gnu.org ([2001:4830:134:3::10]:37646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1feKzO-0005tt-Gu
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 09:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1feKzL-0007h2-GD
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 09:53:34 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1feKzL-0007gi-9p
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 09:53:31 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so24121698pfm.10
	for <qemu-devel@nongnu.org>; Sat, 14 Jul 2018 06:53:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 14 Jul 2018 06:53:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180714135327.GA16925@roeck-us.net>
References: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
Subject: Re: [Qemu-devel] bcm2835_aux: Swap RX and TX interrupt assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

ping ...

On Mon, Jun 18, 2018 at 02:04:06PM -0700, Guenter Roeck wrote:
> RX and TX interrupt bits were reversed, resulting in an endless sequence
> of serial interupts in the emulated system and the following repeated
> error message when booting Linux.
> 
> serial8250: too much work for irq61
> 
> This results in a boot failure most of the time.
> 
> Qemu command line used to reproduce the problem:
> 
> 	qemu-system-aarch64 -M raspi3 -m 1024 \
> 	-kernel arch/arm64/boot/Image \
> 	--append "rdinit=/sbin/init console=ttyS1,115200"
> 	-initrd rootfs.cpio \
> 	-dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb \
> 	-nographic -monitor null -serial null -serial stdio
> 
> This is with arm64:defconfig. The root file system was generated using
> buildroot.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/char/bcm2835_aux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 370dc7e..0364596 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -39,8 +39,8 @@
>  #define AUX_MU_BAUD_REG 0x68
>  
>  /* bits in IER/IIR registers */
> -#define TX_INT  0x1
> -#define RX_INT  0x2
> +#define RX_INT  0x1
> +#define TX_INT  0x2
>  
>  static void bcm2835_aux_update(BCM2835AuxState *s)
>  {
