Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5668FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2148020863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WLVlSEgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2148020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjN2-00047y-N7
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9R-0006l8-CM
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9P-0004za-N1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:45 -0400
Received: from ozlabs.org ([203.11.71.1]:47237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9P-0004xL-A5; Fri, 27 Sep 2019 01:50:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrD28wRz9sQm; Fri, 27 Sep 2019 15:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563436;
 bh=RIksUxZRIpgNgUb+BOQ1iDqTN/tyvu+NfJ2zQyVrB1Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WLVlSEgi2e/cuUtEcW1MMXppRhegZh4/eNWErW/OINU6nvgdj8QB3WNoDf26WajPa
 aks48Kr8ubCtQ0WtoQB6kyxjI16Lav2wrFm4giuqGJ3azlzY2YpuQohH0bzrLfHliG
 WNUOBF1WXvgSPu51i7amT655yRQuTuzpKTXDwSrA=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 08/33] spapr: Replace spapr_vio_qirq() helper with
 spapr_vio_irq_pulse() helper
Date: Fri, 27 Sep 2019 15:50:03 +1000
Message-Id: <20190927055028.11493-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Every caller of spapr_vio_qirq() immediately calls qemu_irq_pulse() with
the result, so we might as well just fold that into the helper.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/spapr_vty.c        | 3 +--
 hw/net/spapr_llan.c        | 3 +--
 hw/ppc/spapr_vio.c         | 3 +--
 include/hw/ppc/spapr_vio.h | 5 +++--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 087c93e4fa..8f4d9fe472 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -5,7 +5,6 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
-#include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/qdev-properties.h"
@@ -37,7 +36,7 @@ static void vty_receive(void *opaque, const uint8_t *bu=
f, int size)
=20
     if ((dev->in =3D=3D dev->out) && size) {
         /* toggle line to simulate edge interrupt */
-        qemu_irq_pulse(spapr_vio_qirq(&dev->sdev));
+        spapr_vio_irq_pulse(&dev->sdev);
     }
     for (i =3D 0; i < size; i++) {
         if (dev->in - dev->out >=3D VTERM_BUFSIZE) {
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 701e6e1514..3d96884d66 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/net.h"
@@ -267,7 +266,7 @@ static ssize_t spapr_vlan_receive(NetClientState *nc,=
 const uint8_t *buf,
     }
=20
     if (sdev->signal_state & 1) {
-        qemu_irq_pulse(spapr_vio_qirq(sdev));
+        spapr_vio_irq_pulse(sdev);
     }
=20
     return size;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 0803649658..554de9930d 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/irq.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "elf.h"
@@ -294,7 +293,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *=
crq)
     dev->crq.qnext =3D (dev->crq.qnext + 16) % dev->crq.qsize;
=20
     if (dev->signal_state & 1) {
-        qemu_irq_pulse(spapr_vio_qirq(dev));
+        spapr_vio_irq_pulse(dev);
     }
=20
     return 0;
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 875be28cdd..72762ed16b 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -24,6 +24,7 @@
=20
 #include "hw/ppc/spapr.h"
 #include "sysemu/dma.h"
+#include "hw/irq.h"
=20
 #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
 #define VIO_SPAPR_DEVICE(obj) \
@@ -84,11 +85,11 @@ extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprVio=
Bus *bus, uint32_t reg);
 void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
 extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
=20
-static inline qemu_irq spapr_vio_qirq(SpaprVioDevice *dev)
+static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    return spapr_qirq(spapr, dev->irq);
+    qemu_irq_pulse(spapr_qirq(spapr, dev->irq));
 }
=20
 static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t tad=
dr,
--=20
2.21.0


