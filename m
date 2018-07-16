Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3rb-000478-M6
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3ra-0001H9-Rk
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:48:31 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff3ra-0001Gz-Cl
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:48:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so74849652oib.9
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:48:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
References: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:48:09 +0100
Message-ID: <CAFEAcA9fvZbZGjm8Z5nJKi37J7Qma+bSFd0mRQ7tZ1X2NDRqQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] bcm2835_aux: Swap RX and TX interrupt
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 June 2018 at 22:04, Guenter Roeck <linux@roeck-us.net> wrote:
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
>         qemu-system-aarch64 -M raspi3 -m 1024 \
>         -kernel arch/arm64/boot/Image \
>         --append "rdinit=/sbin/init console=ttyS1,115200"
>         -initrd rootfs.cpio \
>         -dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb \
>         -nographic -monitor null -serial null -serial stdio
>
> This is with arm64:defconfig. The root file system was generated using
> buildroot.

Worth mentioning in the commit message that there is an
error in the BCM2835 datasheet for the TX_INT and RX_INT
bits in the AUX_MU_IER_REG description (as per
https://elinux.org/BCM2835_datasheet_errata)

thanks
-- PMM
