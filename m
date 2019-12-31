Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66773206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOAUziJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66773206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMOF-0004ij-3B
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMLb-0001Qo-Rh
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMLa-0004KG-Kz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMLa-0004IE-G5
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSI3N3fJ/6wS+wX4pMnA/gl2W/jxs6r70tpZY/jtCZ0=;
 b=eOAUziJVFfcAttQaim+fMeyVvmY+f47GRUX8N5wi3MjE6iv1nihVHaSpgKQHtYY+Sd3je9
 6sy0H6yXoYgXhTEwxfLos9qIgmszSlVO2YgNJoqKXgt+APxSXjOA8v5ty+Ar1AOdX+4ibV
 tDWLkicIynDykli3tQlh415spAn81eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-93-T6AU7P3qkThI3Um2ihg-1; Tue, 31 Dec 2019 13:34:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C536A18031D3;
 Tue, 31 Dec 2019 18:34:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F7667673;
 Tue, 31 Dec 2019 18:34:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 11/14] hw/ppc/Kconfig: Only select FDT helper for machines
 using it
Date: Tue, 31 Dec 2019 19:32:13 +0100
Message-Id: <20191231183216.6781-12-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 93-T6AU7P3qkThI3Um2ihg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all machines use the ppc_create_page_sizes_prop() helper.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Can Kconfig can restrict to TARGET_PPC64?
---
 hw/ppc/Kconfig       | 10 ++++++++++
 hw/ppc/Makefile.objs |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index e4ca920507..8e62d8f470 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -10,6 +10,7 @@ config PSERIES
     select XICS_SPAPR
     select XIVE_SPAPR
     select MSI_NONBROKEN
+    select FDT_PPC
=20
 config SPAPR_RNG
     bool
@@ -26,6 +27,7 @@ config POWERNV
     select MC146818RTC
     select XICS
     select XIVE
+    select FDT_PPC
=20
 config PPC405
     bool
@@ -42,6 +44,7 @@ config PPC440
     select PCI_EXPRESS
     select PPC4XX
     select SERIAL
+    select FDT_PPC
=20
 config PPC4XX
     bool
@@ -60,6 +63,7 @@ config SAM460EX
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
     select USB_OHCI
+    select FDT_PPC
=20
 config PREP
     bool
@@ -110,6 +114,7 @@ config E500
     select PPCE500_PCI
     select SERIAL
     select MPC_I2C
+    select FDT_PPC
=20
 config VIRTEX
     bool
@@ -118,6 +123,7 @@ config VIRTEX
     select SERIAL
     select XILINX
     select XILINX_ETHLITE
+    select FDT_PPC
=20
 config XIVE
     bool
@@ -134,5 +140,9 @@ config XIVE_KVM
     default y
     depends on XIVE_SPAPR && KVM
=20
+# Only used by 64-bit targets
 config FW_CFG_PPC
     bool
+
+config FDT_PPC
+    bool
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 5c46c68e44..a4bac57be6 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,5 +1,6 @@
 # shared objects
-obj-y +=3D ppc.o ppc_booke.o fdt.o
+obj-y +=3D ppc.o ppc_booke.o
+obj-$(CONFIG_FDT_PPC) +=3D fdt.o
 obj-$(CONFIG_FW_CFG_PPC) +=3D fw_cfg.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events.o
--=20
2.21.0


