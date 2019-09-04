Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71903C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D16E21881
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pmeZXDRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16E21881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Y7v-0005gp-5J
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Y3p-0004NB-EC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Y3n-0004jr-PD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:23:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:52468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i5Y3k-0004j0-07; Wed, 04 Sep 2019 12:23:04 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id AE6B096F65;
 Wed,  4 Sep 2019 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1567614182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rcVMLpC6xOMKCz5Bixxm42D7b9+MZ27ZtTCp7nDstqY=;
 b=pmeZXDREXbdjrzGPyxl3mMUQx4iq7DqJ1ipk5RKwU4wymD7J2V9/5gXuvNeC/4pA8d522P
 ymI4zqMMGY9AQh6YQcMqueOOU2OlWzcYen3lD+GdVgGsJH9viFH3+TrnNcKtaQqN6fPi4P
 J7ClqwGFbMmSmdO7fVpk5kzU6gifhd4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 18:22:47 +0200
Message-Id: <20190904162247.24095-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1567614182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rcVMLpC6xOMKCz5Bixxm42D7b9+MZ27ZtTCp7nDstqY=;
 b=QYI+5qgETDB1GPxwXYCRtKbX19Oycdu7ls9Dti64gG3HWsYqoUcMuiOA2NbXE2XmZhIduh
 YOtF6PThxuua3WBkimmenHFdrky7Rn532bxi3ebSOGmt94c77grM2T0oXMt60iKDVklGy3
 DcQawa1mukgy3NhjD2zKr5hnbQM17bk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1567614182; a=rsa-sha256; cv=none;
 b=A+T2eN69i1V1m0qxLTfmqceV+q3rMDsqIIT3+hQM2fO8rl0VT2kNtLtu4oSF8LHVStqlkB
 QPxODdadVLdGWENxekPWpm6WgxTY4CQ96WeX8CYyCgeJxTR5U306TP9uajVzt8bPCW9ZsW
 WLuCyb++nxGxEnhAMU7ZmU72dv5yUww=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH] hw/arm/raspi: avoid reparenting the sd card
 during qbus tree reset
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, philmd@redhat.com, Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the raspi machine, the sd card can be on several sd bus (in reality
there is one bus but several controllers). It is initially created in
the "sd-bus" child in the gpio peripheral. Then is moved (parent bus
changes) during machine reset in the "sdhci-bus". It can be moved again
by software between the "sdhci-bus" and another bus ("bcm2835-sdhost-bus"=
).
Here's the corresponding qbus tree of the raspi machine:
 + sysbus
   * bcm2835_gpio
     + sd-bus
       * sd-card
   * bcm2835-sdhost
     + bcm2835-sdhost-bus
   * generic-sdhci
     + sdhci-bus

During the initial machine reset, the sd card is moved. Since reset is
based on qbus tree, moving the card during the reset seems odd (it change=
s
the qbus tree). In this case, because of the order the qbus tree is
walked, the sd card ends up being reset twice; the effective reset order =
call
follows:
 1 sd-card
 2 sd-bus
 3 bcm2835_gpio        -> move the sd-card to sdhci_bus
 4 bcm2835-sdhost-bus
 5 bcm2835-sdhost
 6 sd-card             (again)
 7 sdhci-bus
 8 generic-sdhci

This patch adds a raspi machine reset method which moves the sd card
to the sdhci-bus before doing the whole reset (which will try to do the
move too). By anticipating the move we avoid changing the qdev tree while
resetting it.

In consequence the step 1 is skipped in the previous list: when reset sta=
rts
the sd-card is already not a child of bcm2835_gpio.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
This is a follow-up of this discussion
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06954.html

I did not have much comments about my last proposal so I thought I'd fina=
lize
a corresponding patch since it is small instead of doing a ping.

Feel free to comment,
Damien
---
 hw/arm/raspi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 74c062d05e..19b032546b 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -21,6 +21,7 @@
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
=20
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAG=
S */
 #define MVBAR_ADDR      0x400 /* secure vectors */
@@ -214,6 +215,32 @@ static void raspi_init(MachineState *machine, int ve=
rsion)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
=20
+static void raspi_reset(MachineState *machine)
+{
+    BCM2835GpioState *gpio;
+
+    gpio =3D BCM2835_GPIO(object_resolve_path("gpio", NULL));
+
+    /*
+     * Put the sd-card on sdhci bus as the bcm2835_gpio's reset
+     * procedure will do during qemu_devices_reset().
+     *
+     * Note: we do this here to avoid doing it during following
+     * qemu_devices_reset() so that we don't modify the qbus tree during=
 the
+     * reset (which is based on it).
+     *
+     * Note: sd-card can be on sdbus, sdbus_sdhci or sdbus_sdhost. So at=
 least
+     * one of the following sdbus_reparent_card is useless. This is not =
a
+     * problem because sdbus_reparent_card is a no-op if the source does=
 not
+     * has a card.
+     */
+    sdbus_reparent_card(&gpio->sdbus, gpio->sdbus_sdhci);
+    sdbus_reparent_card(gpio->sdbus_sdhost, gpio->sdbus_sdhci);
+
+    /* then do the classical reset */
+    qemu_devices_reset();
+}
+
 static void raspi2_init(MachineState *machine)
 {
     raspi_init(machine, 2);
@@ -223,6 +250,7 @@ static void raspi2_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Raspberry Pi 2";
     mc->init =3D raspi2_init;
+    mc->reset =3D raspi_reset;
     mc->block_default_type =3D IF_SD;
     mc->no_parallel =3D 1;
     mc->no_floppy =3D 1;
@@ -245,6 +273,7 @@ static void raspi3_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Raspberry Pi 3";
     mc->init =3D raspi3_init;
+    mc->reset =3D raspi_reset;
     mc->block_default_type =3D IF_SD;
     mc->no_parallel =3D 1;
     mc->no_floppy =3D 1;
--=20
2.22.0


