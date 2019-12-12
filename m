Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCEDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497BD2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXE3Ocox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497BD2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTgd-0007c7-UX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbk-0002JF-HV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbi-0008Ac-DS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbi-00089X-9Z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAtzIk6oItbi2dn92fFgYJYX87+Mph/S7n9mnqYbP4M=;
 b=bXE3OcoxDXPlNNR7O4Jsh7XI1XFtdvgwlYMs3N6zqpeumbzIT/L433A2zQvACa6XM5Wpim
 5dy4mvi0BSv7jZy5i3oPQxvuD2yUB1eysfNBVMB47Z00M5je64ZywqUZX7LdWgVTszVbVc
 kL/7O/cAw2Yd+Ih6pFZ0zQN1ieaV+fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-io3a7cODOMuJHDJizlgTfg-1; Thu, 12 Dec 2019 13:54:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007771854322;
 Thu, 12 Dec 2019 18:54:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6DC219C4F;
 Thu, 12 Dec 2019 18:54:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/10] hw/arm/nseries: Replace the bluetooth chardev with a
 "null" chardev
Date: Thu, 12 Dec 2019 19:54:15 +0100
Message-Id: <20191212185424.4675-2-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: io3a7cODOMuJHDJizlgTfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

We are going to remove the bitrotten bluetooth backend, so we can
not use it in the n800 and n810 machines anymore. Replace the chardev
here with a "null" chardev and stop including the "hw/bt.h" header.

I am not aware of a full working N8x0 environment that can be used to
test these machines, but the Linux kernel from the Meego project that
can be found on http://stskeeps.subnetmask.net/meego-n8x0/ still seems
to boot as far as it did before.

Message-Id: <20191120091014.16883-2-thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.18.1


