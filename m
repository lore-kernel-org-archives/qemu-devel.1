Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E4AC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EF924689
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDpwy49z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EF924689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iskZI-0003wa-Bd
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 04:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iskYM-0003JG-0X
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iskYJ-0004rJ-2W
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:38:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iskYI-0004qd-Ll
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579340277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWvXN4kWSOrjLhgRD9W8/+NkX8kJRIL4cBmWxunVj40=;
 b=HDpwy49ziMaPFlKOjoQxiLBEbAeC4yKIJbNo9tD9qwINPGxynSinzg1bPzGlOgjWhcKvLD
 j/vXQ0gGXWURhI/37JLMOywa0rSf1NME2aJnmkOJtBoBZK/hs71odIWENvPJK2UmeZDv08
 c9ICJziNXGkmbrhrE/uR52zSmZixsi4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-qhuZ_8xkNYuo-mbTjVHpSA-1; Sat, 18 Jan 2020 04:37:55 -0500
Received: by mail-wm1-f70.google.com with SMTP id q206so2833720wme.9
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 01:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HWvXN4kWSOrjLhgRD9W8/+NkX8kJRIL4cBmWxunVj40=;
 b=ksjgdLQ8DAxzbsUQLLlq8v7Zv+nhUMBvG0TjVNI0+wStg9KHsnlTZ3HXIi6d7RZl5p
 u1oBBFJ6zdxUILpDhk1kJJkll7LjF1vPXnY3OaVGBpVXXkWg9Wx4pBFsIcdR/997g4qv
 GGsSxPxnOsAIjiNkNAvm1xPxE5HC3R/Y97/dmOsed1HuOcO2Bnbnh1VjXxV2Ab1Vg+H8
 KWwJ747SggbLnutAWPiSpREDmhtm4OXMPRJiz24yM6lvX/RiiQUNSy9GsJSCw27U40pm
 nSWMAFtdvWokWrdYc40basG6H2dHaEPJ4ACx3K63ZFdt8B+n3HJtTzFWIqvGXMskxWY+
 EpxA==
X-Gm-Message-State: APjAAAVOpepnLjxYIxVEAAa7gt5AubodgkfvDr+oo9rJvz0CyijPdI9u
 HJQzwgVKrAhCBXgkdJvb3ad1bvciCKDfKWbWERp8CZ11H9sEHIlWfMx9ntfHawDRHbVaYcb06rb
 jT0meyfw63Ur/gig=
X-Received: by 2002:adf:eb51:: with SMTP id u17mr7975359wrn.29.1579340273884; 
 Sat, 18 Jan 2020 01:37:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJqQq7husWewMv6CIgIHHaHDyxKvj0tWHcIKWUtvfv9NUnFDbMle6sB8B7Tyuwu7QibazgTQ==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr7975334wrn.29.1579340273383; 
 Sat, 18 Jan 2020 01:37:53 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d12sm38852120wrp.62.2020.01.18.01.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 01:37:52 -0800 (PST)
Subject: Re: [PATCH v3 17/17] docs: add Orange Pi PC document
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-18-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15d377a2-9d40-6195-5bfb-64e69037cd64@redhat.com>
Date: Sat, 18 Jan 2020 10:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-18-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: qhuZ_8xkNYuo-mbTjVHpSA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> The Xunlong Orange Pi PC machine is a functional ARM machine
> based on the Allwinner H3 System-on-Chip. It supports mainline
> Linux, U-Boot, NetBSD and is covered by acceptance tests.
> 
> This commit adds a documentation text file with a description
> of the machine and instructions for the user.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   docs/orangepi.rst | 200 ++++++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS       |   1 +
>   2 files changed, 201 insertions(+)
>   create mode 100644 docs/orangepi.rst
> 
> diff --git a/docs/orangepi.rst b/docs/orangepi.rst
> new file mode 100644
> index 0000000000..5ac2a7b7cc
> --- /dev/null
> +++ b/docs/orangepi.rst
> @@ -0,0 +1,200 @@
> +=========================
> +Orange Pi PC Machine Type
> +=========================
> +
> +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> +based embedded computer with mainline support in both U-Boot
> +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> +512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> +various other I/O.
> +
> +Supported devices
> +-----------------
> +
> +The Orange Pi PC machine type supports the following devices:

Maybe drop "type"?

> +
> + * SMP (Quad Core Cortex A7)
> + * Generic Interrupt Controller configuration
> + * SRAM mappings
> + * SDRAM controller
> + * Real Time Clock
> + * Timer device (re-used from Allwinner A10)
> + * UART
> + * SD/MMC storage controller
> + * EMAC ethernet connectivity

Drop "connectivity"?

> + * USB 2.0 interfaces
> + * Clock Control Unit
> + * System Control module
> + * Security Identifier device
> +
> +Limitations
> +-----------
> +
> +Currently, Orange Pi PC does *not* support the following features:
> +
> +- Graphical output via HDMI, GPU and/or the Display Engine
> +- Audio output
> +- Hardware Watchdog
> +
> +Also see the 'unimplemented' array in the Allwinner H3 SoC module
> +for a complete list of unimplemented I/O devices:
> +  ./hw/arm/allwinner-h3.c
> +
> +Using the Orange Pi PC machine type
> +-----------------------------------
> +
> +Boot options
> +~~~~~~~~~~~~
> +
> +The Orange Pi PC machine can start using the standard -kernel functionality
> +for loading a Linux kernel or ELF executable. Additionally, the Orange Pi PC
> +machine can also emulate the BootROM which is present on an actual Allwinner H3
> +based SoC, which loads the bootloader from SD card, specified via the -sd argument

"from a SD card"?

> +to qemu-system-arm.
> +
> +Running mainline Linux
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Recently released mainline Linux kernels from 4.19 up to latest master

Drop "Recently released mainline" or only use "Mainline"?

> +are known to work. To build a Linux mainline kernel that can be booted
> +by the Orange Pi PC machine, simply configure the kernel using the
> +sunxi_defconfig configuration:
> +
> +  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
> +  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig
> +
> +To be able to use USB storage, you need to manually enable the corresponding
> +configuration item. Start the kconfig configuration tool:
> +
> +  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make menuconfig
> +
> +Navigate to the following item, enable it and save your configuration:
> +
> +  Device Drivers > USB support > USB Mass Storage support

Isn't it simpler to run 'echo CONFIG_USB_STORAGE=y >> .config && make 
oldconfig'?

> +
> +Build the Linux kernel with:
> +
> +  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j5

I'm not sure about recommending "-j5" in the doc, not all user have >=4 
SMP system. Maybe we don't care.

> +
> +To boot the newly build linux kernel in QEMU with the Orange Pi PC machine, use:
> +
> +  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
> +      -kernel /path/to/linux/arch/arm/boot/zImage \
> +      -append 'console=ttyS0,115200' \
> +      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
> +
> +Orange Pi PC images
> +~~~~~~~~~~~~~~~~~~~
> +
> +Note that the mainline kernel does not have a root filesystem. You may provide it
> +with an official Orange Pi PC image from the official website:
> +
> +  http://www.orangepi.org/downloadresources/
> +
> +Another possibility is to run an Armbian image for Orange Pi PC which
> +can be downloaded from:
> +
> +   https://www.armbian.com/orange-pi-pc/
> +
> +Alternatively, you can also choose to build you own image with buildroot
> +using the orangepi_pc_defconfig. Also see https://buildroot.org for more information.
> +
> +You can choose to attach the selected image either as an SD card or as USB mass storage.
> +For example, to boot using the Orange Pi PC Debian image on SD card, simply add the -sd
> +argument and provide the proper root= kernel parameter:
> +
> +  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
> +      -kernel /path/to/linux/arch/arm/boot/zImage \
> +      -append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
> +      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
> +      -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
> +
> +To attach the image as an USB mass storage device to the machine,
> +simply append to the command:
> +
> +  -drive if=none,id=stick,file=myimage.img \
> +  -device usb-storage,bus=usb-bus.0,drive=stick
> +
> +Instead of providing a custom Linux kernel via the -kernel command you may also
> +choose to let the Orange Pi PC machine load the bootloader from SD card, just like
> +a real board would do using the BootROM. Simply pass the selected image via the -sd
> +argument and remove the -kernel, -append, -dbt and -initrd arguments:
> +
> +  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
> +       -sd Armbian_19.11.3_Orangepipc_buster_current_5.3.9.img
> +
> +Note that both the official Orange Pi PC images and Armbian images start
> +a lot of userland programs via systemd. Depending on the host hardware and OS,
> +they may be slow to emulate, especially due to emulating the 4 cores.
> +To help reduce the performance slow down due to emulating the 4 cores, you can
> +give the following kernel parameters (or via -append):
> +
> +  => setenv extraargs 'systemd.default_timeout_start_sec=9000 loglevel=7 nosmp console=ttyS0,115200'
> +
> +Running U-Boot
> +~~~~~~~~~~~~~~
> +
> +U-Boot mainline can be build and configured using the orangepi_pc_defconfig
> +using similar commands as describe above for Linux. Note that it is recommended
> +for development/testing to select the following configuration setting in U-Boot:
> +
> +  Device Tree Control > Provider for DTB for DT Control > Embedded DTB
> +
> +To start U-Boot using the Orange Pi PC machine, provide the
> +u-boot binary to the -kernel argument:
> +
> +  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
> +      -kernel /path/to/uboot/u-boot -sd disk.img
> +
> +Use the following U-boot commands to load and boot a Linux kernel from SD card:
> +
> +  -> setenv bootargs console=ttyS0,115200
> +  -> ext2load mmc 0 0x42000000 zImage
> +  -> ext2load mmc 0 0x43000000 sun8i-h3-orangepi-pc.dtb
> +  -> bootz 0x42000000 - 0x43000000
> +
> +Running NetBSD
> +~~~~~~~~~~~~~~
> +
> +The NetBSD operating system also includes support for Allwinner H3 based boards,
> +including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi PC
> +board and provides a fully working system with serial console, networking and storage.
> +
> +Currently NetBSD 9.0 is in testing, but release candidate 1 can be started
> +successfully on the Orange Pi PC machine. Get the 'evbarm-earmv7hf' based image from:
> +
> +  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0_RC1/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
> +
> +The image requires manually installing U-Boot in the image. Build U-Boot with
> +the orangepi_pc_defconfig configuration as described in the previous section.
> +Next, unzip the NetBSD image and write the U-Boot binary including SPL using:
> +
> +  $ gunzip armv7.img.gz
> +  $ dd if=/path/to/u-boot-sunxi-with-spl.bin of=armv7.img bs=1024 seek=8 conv=notrunc
> +
> +Start the machine using the following command:
> +
> +  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
> +        -sd armv7.img
> +
> +At the U-Boot stage, interrupt the automatic boot process by pressing a key
> +and set the following environment variables before booting:
> +
> +  => setenv bootargs root=ld0a
> +  => setenv kernel netbsd-GENERIC.ub
> +  => setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
> +  => setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; fdt addr ${fdt_addr_r}; bootm ${kernel_addr_r} - ${fdt_addr_r}'
> +
> +Optionally you may save the environment variables to SD card with 'saveenv'.
> +To continue booting simply give the 'boot' command and NetBSD boots.
> +
> +Orange Pi PC acceptance tests
> +-----------------------------
> +
> +The Orange Pi PC machine has several acceptance tests included.
> +To run the whole set of tests, build QEMU from source and simply
> +provide the following command:
> +
> +  $ AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run \
> +     -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e1b92b5fa..b52ac2fb9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -488,6 +488,7 @@ S: Maintained
>   F: hw/*/allwinner-h3*
>   F: include/hw/*/allwinner-h3*
>   F: hw/arm/orangepi.c
> +F: docs/orangepi.rst
>   
>   ARM PrimeCell and CMSDK devices
>   M: Peter Maydell <peter.maydell@linaro.org>
> 


