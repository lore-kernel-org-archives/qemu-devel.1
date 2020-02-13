Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2607B20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkCuQ/Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G46-0001U8-BB
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0004kd-CD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhC-0002I9-UV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhC-0002Gc-O5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so7258313wme.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5os6T9iOh7dBv5fGrw979h37TvZ3kqm7dXAx5e9KJF4=;
 b=bkCuQ/YcOtpLi53t48Ps16ySnvhDQ2b10r53alETUR5CILzHtuSVjyuDYdZQ2UO/+B
 QZ884Qh1negW4LXWG1OGCjf13cXQhigfP0hsR4WJdNXmspKb0VcYMTqQEY87e14nqV6I
 jtRGKrd/abFkKqCvKxSoKuBTrwJuBnc2BYIC8l1cMhCbEr109HtTas/YAFDI5pZy7Xfs
 ymhfUySemIL1aqLn3xqY3IRaFHedPa4zN4o9/lyeOrxT1Il+lhn5mPze/MB20u7/LEL9
 lxjnOQ1EGJG+hEF+DlcRGHnpmMnvysx2eqprKZpEEJR/ej04e987bAb/t/0mEmih+0SE
 hkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5os6T9iOh7dBv5fGrw979h37TvZ3kqm7dXAx5e9KJF4=;
 b=h/urqrC42NCva8mgHSGGfx3n0CjN1KgjqWVilqG/nMD3YQ6buY3W+DQfYfbNdX74VV
 wfx+9B8hDx/DDpRdoO87+ICkkOiHSXLRdL8hSj+M4gELnPUpDWEWl9j8NIXhdzDlHceB
 aOzSNrvdsN4/ZO3Jgw3q4T8rM+96BSb4EY0u0wO9CUpmmhK+7Hv2I05p56Ah0bWzRKtA
 A/8CCjlsmsTtq7MZXQC7WiDTKEzxbmhEphgL8tNZPzLMPhIIT/MmnATB2+PC/e/IaSrT
 wz+udvyND+9wI3okxAHWKeB4URVVyCwsqdJ0rWhkLQcr+N+Gqj5VM3iCGhKn9zuKixRS
 9yYA==
X-Gm-Message-State: APjAAAW5SQvOEMmAL/DoUq/0p7rbFZIBAQnFOC9+WY01Ns2EqievzXGF
 wLxjKhgGnutK2Eg14mvRCdF0WK5/BI4=
X-Google-Smtp-Source: APXvYqzoABP5IiZ1UswY7prYBtEXtFsD08NXC3cv26QJwmqHE3f1531Mk2iH4RaIkcL5+v0pPM526w==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr6008245wme.1.1581604945388;
 Thu, 13 Feb 2020 06:42:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/46] hw/arm/raspi: Use BCM2708 machine type with pre Device
 Tree kernels
Date: Thu, 13 Feb 2020 14:41:32 +0000
Message-Id: <20200213144145.818-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

When booting without device tree, the Linux kernels uses the $R1
register to determine the machine type. The list of values is
registered at [1].

There are two entries for the Raspberry Pi:

- https://www.arm.linux.org.uk/developer/machines/list.php?mid=3138
  name: MACH_TYPE_BCM2708
  value: 0xc42 (3138)
  status: Active, not mainlined
  date: 15 Oct 2010

- https://www.arm.linux.org.uk/developer/machines/list.php?mid=4828
  name: MACH_TYPE_BCM2835
  value: 4828
  status: Active, mainlined
  date: 6 Dec 2013

QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182).

The Raspberry Pi foundation bootloader only sets the BCM2708 machine
type, see [2] or [3]:

 133 9:
 134     mov r0, #0
 135     ldr r1, =3138       @ BCM2708 machine id
 136     ldr r2, atags       @ ATAGS
 137     bx  r4

U-Boot only uses MACH_TYPE_BCM2708 (see [4]):

 25 /*
 26  * 2835 is a SKU in a series for which the 2708 is the first or primary SoC,
 27  * so 2708 has historically been used rather than a dedicated 2835 ID.
 28  *
 29  * We don't define a machine type for bcm2709/bcm2836 since the RPi Foundation
 30  * chose to use someone else's previously registered machine ID (3139, MX51_GGC)
 31  * rather than obtaining a valid ID:-/
 32  *
 33  * For the bcm2837, hopefully a machine type is not needed, since everything
 34  * is DT.
 35  */

While the definition MACH_BCM2709 with value 0xc43 was introduced in
a commit described "Add 2709 platform for Raspberry Pi 2" out of the
mainline Linux kernel, it does not seem used, and the platform is
introduced with Device Tree support anyway (see [5] and [6]).

Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
"raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
"raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.

[1] https://www.arm.linux.org.uk/developer/machines/
[2] https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstub7.S#L135
[3] https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstub7.S#L64
[4] https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rpi-common.h#L18
[5] https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d79570df5b392a49e0e006573R526
[6] http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/001268.html

Cc: Zoltán Baldaszti <bztemail@gmail.com>
Cc: Pekka Enberg <penberg@iki.fi>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Kshitij Soni <kshitij.soni@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200208165645.15657-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3996f6c63a4..f2ccabc6628 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -29,8 +29,8 @@
 #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
-/* Table of Linux board IDs for different Pi versions */
-static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
+/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
+#define MACH_TYPE_BCM2708   3138
 
 typedef struct RasPiState {
     BCM283XState soc;
@@ -116,7 +116,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     static struct arm_boot_info binfo;
     int r;
 
-    binfo.board_id = raspi_boardid[version];
+    binfo.board_id = MACH_TYPE_BCM2708;
     binfo.ram_size = ram_size;
     binfo.nb_cpus = machine->smp.cpus;
 
-- 
2.20.1


