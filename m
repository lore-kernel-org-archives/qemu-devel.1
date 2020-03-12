Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ABC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f95598/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRGZ-0001jJ-E0
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxp-0000kN-Sx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxn-0005I8-CC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxn-0005Hf-3V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d5so8028503wrc.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ted6m1WkJFc8UqGJYYtw+Q7z+HdH6t/vQqJNiDoDyls=;
 b=f95598/euXoQLAlYf/HZ0Ck/tK04Wpv1Y+8f2I0lFrmnoZK3dxWZtuLVc50ZMuQd5r
 5JsN2pG3WyjYu4M7BVT9Ozun4NQ0T1mpPc4A3q7iLm/YnFQSDlQW8yts2oohi+Tkl1Zc
 arrrF6v9eFx57TndKdTPYB88TJMb38FwDZV7f/I2fPVWZuSlYSwYYqzOFCK9ym13uLIg
 T2hv79kPCR6z1Xc9SLas21pVncs6FlQ5T4Jhwwkx9FY5L2IQeujJm8VfWyGw5DBiLREr
 939P2rtFM0KPOAxlG/NY671BNpFr7iuhbYIWrkiPOLAK08jtfAa7uXyunPtOVpu/aZ2h
 2ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ted6m1WkJFc8UqGJYYtw+Q7z+HdH6t/vQqJNiDoDyls=;
 b=DD2jAGeRBBMBr/nyc+Q4LfyrFWU4sbc6+jd0lNOl9jPBUBAR/QHemTLUcih1QYZou3
 BvlGv1BOL45kU3hg8lDwYgoajfjwu171DAeRhu5Q4N7CQ9fPegyqeXtryP/XBRqdBi1A
 TnxlX1zI4UZrlHVZK47KT8hFjVoO8K0RyHOeciW1Bt4wjFPXddQXH7z9z/vaK+e64zxc
 sTbi0ypK5X+D5wUuXwzZ10ML5C0auebbfPAn4raxsj5JYqaBp1XdeAMJ3TiuQ5UM2xqE
 CEUrQvTwrtLxEDv7Pu8k5TIB/v3U1BDUgTmKI0oghDn0YKjgMJcAmzOI3UNP3MDsRkte
 2BjA==
X-Gm-Message-State: ANhLgQ1OQyU5nm/Ktp010okVdCm5Y4w0nWmYZQCuUN4nfs7G8L6CgOcu
 ex6kd7bNQ0/7cc99GwkHcbWE7XThbStcBQ==
X-Google-Smtp-Source: ADFU+vt+HlV92qqxeejuzGEvCgS+e90zjFnUZXOM89y7g6Y2lNEswf/xdeMu+vfrylgOD3bnaWyVBw==
X-Received: by 2002:adf:de84:: with SMTP id w4mr12126551wrl.350.1584031537234; 
 Thu, 12 Mar 2020 09:45:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] docs: add Orange Pi PC document
Date: Thu, 12 Mar 2020 16:44:52 +0000
Message-Id: <20200312164459.25924-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Xunlong Orange Pi PC machine is a functional ARM machine
based on the Allwinner H3 System-on-Chip. It supports mainline
Linux, U-Boot, NetBSD and is covered by acceptance tests.

This commit adds a documentation text file with a description
of the machine and instructions for the user.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200311221854.30370-19-nieklinnenbank@gmail.com
[PMM: moved file into docs/system/arm to match the reorg
of the arm target part of the docs; tweaked heading to
match other boards]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                  |   1 +
 docs/system/arm/orangepi.rst | 253 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst   |   2 +
 3 files changed, 256 insertions(+)
 create mode 100644 docs/system/arm/orangepi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index d7a26d7171e..32867bc6367 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -499,6 +499,7 @@ S: Maintained
 F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
 F: hw/arm/orangepi.c
+F: docs/system/orangepi.rst
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
new file mode 100644
index 00000000000..c41adad4883
--- /dev/null
+++ b/docs/system/arm/orangepi.rst
@@ -0,0 +1,253 @@
+Orange Pi PC (``orangepi-pc``)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
+based embedded computer with mainline support in both U-Boot
+and Linux. The board comes with a Quad Core Cortex-A7 @ 1.3GHz,
+1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
+various other I/O.
+
+Supported devices
+"""""""""""""""""
+
+The Orange Pi PC machine supports the following devices:
+
+ * SMP (Quad Core Cortex-A7)
+ * Generic Interrupt Controller configuration
+ * SRAM mappings
+ * SDRAM controller
+ * Real Time Clock
+ * Timer device (re-used from Allwinner A10)
+ * UART
+ * SD/MMC storage controller
+ * EMAC ethernet
+ * USB 2.0 interfaces
+ * Clock Control Unit
+ * System Control module
+ * Security Identifier device
+
+Limitations
+"""""""""""
+
+Currently, Orange Pi PC does *not* support the following features:
+
+- Graphical output via HDMI, GPU and/or the Display Engine
+- Audio output
+- Hardware Watchdog
+
+Also see the 'unimplemented' array in the Allwinner H3 SoC module
+for a complete list of unimplemented I/O devices: ``./hw/arm/allwinner-h3.c``
+
+Boot options
+""""""""""""
+
+The Orange Pi PC machine can start using the standard -kernel functionality
+for loading a Linux kernel or ELF executable. Additionally, the Orange Pi PC
+machine can also emulate the BootROM which is present on an actual Allwinner H3
+based SoC, which loads the bootloader from a SD card, specified via the -sd argument
+to qemu-system-arm.
+
+Machine-specific options
+""""""""""""""""""""""""
+
+The following machine-specific options are supported:
+
+- allwinner-rtc.base-year=YYYY
+
+  The Allwinner RTC device is automatically created by the Orange Pi PC machine
+  and uses a default base year value which can be overridden using the 'base-year' property.
+  The base year is the actual represented year when the RTC year value is zero.
+  This option can be used in case the target operating system driver uses a different
+  base year value. The minimum value for the base year is 1900.
+
+- allwinner-sid.identifier=abcd1122-a000-b000-c000-12345678ffff
+
+  The Security Identifier value can be read by the guest.
+  For example, U-Boot uses it to determine a unique MAC address.
+
+The above machine-specific options can be specified in qemu-system-arm
+via the '-global' argument, for example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -sd mycard.img \
+       -global allwinner-rtc.base-year=2000
+
+Running mainline Linux
+""""""""""""""""""""""
+
+Mainline Linux kernels from 4.19 up to latest master are known to work.
+To build a Linux mainline kernel that can be booted by the Orange Pi PC machine,
+simply configure the kernel using the sunxi_defconfig configuration:
+
+.. code-block:: bash
+
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig
+
+To be able to use USB storage, you need to manually enable the corresponding
+configuration item. Start the kconfig configuration tool:
+
+.. code-block:: bash
+
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make menuconfig
+
+Navigate to the following item, enable it and save your configuration:
+
+  Device Drivers > USB support > USB Mass Storage support
+
+Build the Linux kernel with:
+
+.. code-block:: bash
+
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make
+
+To boot the newly build linux kernel in QEMU with the Orange Pi PC machine, use:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
+      -kernel /path/to/linux/arch/arm/boot/zImage \
+      -append 'console=ttyS0,115200' \
+      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
+
+Orange Pi PC images
+"""""""""""""""""""
+
+Note that the mainline kernel does not have a root filesystem. You may provide it
+with an official Orange Pi PC image from the official website:
+
+  http://www.orangepi.org/downloadresources/
+
+Another possibility is to run an Armbian image for Orange Pi PC which
+can be downloaded from:
+
+   https://www.armbian.com/orange-pi-pc/
+
+Alternatively, you can also choose to build you own image with buildroot
+using the orangepi_pc_defconfig. Also see https://buildroot.org for more information.
+
+You can choose to attach the selected image either as an SD card or as USB mass storage.
+For example, to boot using the Orange Pi PC Debian image on SD card, simply add the -sd
+argument and provide the proper root= kernel parameter:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
+      -kernel /path/to/linux/arch/arm/boot/zImage \
+      -append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
+      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
+      -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
+
+To attach the image as an USB mass storage device to the machine,
+simply append to the command:
+
+.. code-block:: bash
+
+  -drive if=none,id=stick,file=myimage.img \
+  -device usb-storage,bus=usb-bus.0,drive=stick
+
+Instead of providing a custom Linux kernel via the -kernel command you may also
+choose to let the Orange Pi PC machine load the bootloader from SD card, just like
+a real board would do using the BootROM. Simply pass the selected image via the -sd
+argument and remove the -kernel, -append, -dbt and -initrd arguments:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
+       -sd Armbian_19.11.3_Orangepipc_buster_current_5.3.9.img
+
+Note that both the official Orange Pi PC images and Armbian images start
+a lot of userland programs via systemd. Depending on the host hardware and OS,
+they may be slow to emulate, especially due to emulating the 4 cores.
+To help reduce the performance slow down due to emulating the 4 cores, you can
+give the following kernel parameters via U-Boot (or via -append):
+
+.. code-block:: bash
+
+  => setenv extraargs 'systemd.default_timeout_start_sec=9000 loglevel=7 nosmp console=ttyS0,115200'
+
+Running U-Boot
+""""""""""""""
+
+U-Boot mainline can be build and configured using the orangepi_pc_defconfig
+using similar commands as describe above for Linux. Note that it is recommended
+for development/testing to select the following configuration setting in U-Boot:
+
+  Device Tree Control > Provider for DTB for DT Control > Embedded DTB
+
+To start U-Boot using the Orange Pi PC machine, provide the
+u-boot binary to the -kernel argument:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
+      -kernel /path/to/uboot/u-boot -sd disk.img
+
+Use the following U-boot commands to load and boot a Linux kernel from SD card:
+
+.. code-block:: bash
+
+  => setenv bootargs console=ttyS0,115200
+  => ext2load mmc 0 0x42000000 zImage
+  => ext2load mmc 0 0x43000000 sun8i-h3-orangepi-pc.dtb
+  => bootz 0x42000000 - 0x43000000
+
+Running NetBSD
+""""""""""""""
+
+The NetBSD operating system also includes support for Allwinner H3 based boards,
+including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi PC
+board and provides a fully working system with serial console, networking and storage.
+For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
+
+  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
+
+The image requires manually installing U-Boot in the image. Build U-Boot with
+the orangepi_pc_defconfig configuration as described in the previous section.
+Next, unzip the NetBSD image and write the U-Boot binary including SPL using:
+
+.. code-block:: bash
+
+  $ gunzip armv7.img.gz
+  $ dd if=/path/to/u-boot-sunxi-with-spl.bin of=armv7.img bs=1024 seek=8 conv=notrunc
+
+Finally, before starting the machine the SD image must be extended such
+that the NetBSD kernel will not conclude the NetBSD partition is larger than
+the emulated SD card:
+
+.. code-block:: bash
+
+  $ dd if=/dev/zero bs=1M count=64 >> armv7.img
+
+Start the machine using the following command:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M orangepi-pc -nic user -nographic \
+        -sd armv7.img -global allwinner-rtc.base-year=2000
+
+At the U-Boot stage, interrupt the automatic boot process by pressing a key
+and set the following environment variables before booting:
+
+.. code-block:: bash
+
+  => setenv bootargs root=ld0a
+  => setenv kernel netbsd-GENERIC.ub
+  => setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
+  => setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; fdt addr ${fdt_addr_r}; bootm ${kernel_addr_r} - ${fdt_addr_r}'
+
+Optionally you may save the environment variables to SD card with 'saveenv'.
+To continue booting simply give the 'boot' command and NetBSD boots.
+
+Orange Pi PC acceptance tests
+"""""""""""""""""""""""""""""
+
+The Orange Pi PC machine has several acceptance tests included.
+To run the whole set of tests, build QEMU from source and simply
+provide the following command:
+
+.. code-block:: bash
+
+  $ AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run \
+     -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1425bd5303a..324e2af1cbc 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
 ``qemu-system-aarch64 --machine help``.
 
 .. toctree::
+   :maxdepth: 1
 
    arm/integratorcp
    arm/versatile
@@ -78,6 +79,7 @@ undocumented; you can get a complete list by running
    arm/stellaris
    arm/musicpal
    arm/sx1
+   arm/orangepi
 
 Arm CPU features
 ================
-- 
2.20.1


