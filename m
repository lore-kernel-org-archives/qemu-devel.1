Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A14C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C8621850
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xux8kpxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C8621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXM2K-0001x9-1N
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXM0Z-0000Fi-DY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXM0X-0003cp-4a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXM0X-0003cQ-11
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574241040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpB5waLtmZfOQckiI3lFKLd6zv3FZN9ww3HoGYALFjE=;
 b=Xux8kpxbt3A9ilyn8EjUEIYTxY7XwfTDFMUnMKvAHYrJOKDKWI6m8x75YxCcJZcqy547Zx
 EpctLktYm4f8bm5ILBYu13Bj/ZtW+QQuc55YEzfwF4JB/BAOKJd46zOZ/rZc06vY+ft1El
 pmWNcVuFYsK00xgNNZl4sTFvk/LtI+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-TFZQBZjXNbeVMyKfBnfosA-1; Wed, 20 Nov 2019 04:10:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B208100551C;
 Wed, 20 Nov 2019 09:10:36 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8861360BAB;
 Wed, 20 Nov 2019 09:10:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-5.0 1/4] hw/arm/nseries: Replace the bluetooth chardev
 with a "null" chardev
Date: Wed, 20 Nov 2019 10:10:11 +0100
Message-Id: <20191120091014.16883-2-thuth@redhat.com>
In-Reply-To: <20191120091014.16883-1-thuth@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TFZQBZjXNbeVMyKfBnfosA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to remove the bitrotten bluetooth backend, so we can
not use it in the n800 and n810 machines anymore. Replace the chardev
here with a "null" chardev and stop including the "hw/bt.h" header.

I am not aware of a full working N8x0 environment that can be used to
test these machines, but the Linux kernel from the Meego project that
can be found on http://stskeeps.subnetmask.net/meego-n8x0/ still seems
to boot as far as it did before.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/nseries.c | 16 +++++++---------
 qemu-doc.texi    |  2 --
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 7e361936a9..3fd196fb30 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "chardev/char.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "sysemu/reset.h"
@@ -39,7 +40,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
-#include "hw/bt.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
@@ -792,13 +792,11 @@ static void n8x0_cbus_setup(struct n800_s *s)
=20
 static void n8x0_uart_setup(struct n800_s *s)
 {
-    Chardev *radio =3D uart_hci_init();
-
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_RESET_GPIO,
-                    csrhci_pins_get(radio)[csrhci_pin_reset]);
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_WKUP_GPIO,
-                    csrhci_pins_get(radio)[csrhci_pin_wakeup]);
-
+    Chardev *radio =3D qemu_chr_new("bt-dummy-uart", "null", NULL);
+    /*
+     * Note: We used to connect N8X0_BT_RESET_GPIO and N8X0_BT_WKUP_GPIO
+     * here, but this code has been removed with the bluetooth backend.
+     */
     omap_uart_attach(s->mpu->uart[BT_UART], radio);
 }
=20
@@ -1137,7 +1135,7 @@ static struct omap_partition_info_s {
     { 0, 0, 0, NULL }
 };
=20
-static bdaddr_t n8x0_bd_addr =3D {{ N8X0_BD_ADDR }};
+static uint8_t n8x0_bd_addr[6] =3D { N8X0_BD_ADDR };
=20
 static int n8x0_atag_setup(void *p, int model)
 {
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3ddf5c0a68..ed3df01dac 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2308,8 +2308,6 @@ Secure Digital card connected to OMAP MMC/SD host
 @item
 Three OMAP on-chip UARTs and on-chip STI debugging console
 @item
-A Bluetooth(R) transceiver and HCI connected to an UART
-@item
 Mentor Graphics "Inventra" dual-role USB controller embedded in a TI
 TUSB6010 chip - only USB host mode is supported
 @item
--=20
2.23.0


