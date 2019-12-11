Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B39AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CDA2073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaM4C+LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CDA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iez7b-0007ek-3R
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 05:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iez6q-0007FN-S1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iez6p-0005KR-2A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:20:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iez6o-0005Ik-TO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576059641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l25echmQaH8Mm8AlECXNUKEehmyRbvKfZ5enIlrv36U=;
 b=GaM4C+LEHdafOCza+u+yNchaAr6tZBiivUdszhqBMjG9yiDICwIz8pk2WnArWGbbEynvij
 0Bxbtz1JLeTMQ1J0Z4xY/QXbcnvWkknaAairbrhMD5a1HIM29YAl2dwiJT7/2/0F9egZ9/
 cMBceqw5ez0mzV0FMva+93iiJbRdFdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-vczVEnVzPXaM2VjHn3GJXg-1; Wed, 11 Dec 2019 05:20:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 431D8800D4C
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 10:20:39 +0000 (UTC)
Received: from thuth.com (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7962B5DA76;
 Wed, 11 Dec 2019 10:20:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/usb: Introduce Kconfig switches for the CCID card
 devices
Date: Wed, 11 Dec 2019 11:20:29 +0100
Message-Id: <20191211102029.1772-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vczVEnVzPXaM2VjHn3GJXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In our downstream distribution of QEMU, we need more fine-grained
control on the set of CCID card devices that we want to include.
So let's introduce some proper Kconfig switches that it is easier
to disable them without modifying the corresponding Makefile.objs.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use CONFIG_SMARTCARD in Kconfig.host as suggested by Philippe

 Kconfig.host         |  3 +++
 Makefile             |  3 ++-
 hw/usb/Kconfig       | 12 +++++++++++-
 hw/usb/Makefile.objs |  9 ++++-----
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Kconfig.host b/Kconfig.host
index bb6e116e2a..b532358854 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -35,3 +35,6 @@ config VIRTFS
=20
 config PVRDMA
     bool
+
+config SMARTCARD
+    bool
diff --git a/Makefile b/Makefile
index b437a346d7..287cda35cb 100644
--- a/Makefile
+++ b/Makefile
@@ -388,7 +388,8 @@ MINIKCONF_ARGS =3D \
     CONFIG_VHOST_USER=3D$(CONFIG_VHOST_USER) \
     CONFIG_VIRTFS=3D$(CONFIG_VIRTFS) \
     CONFIG_LINUX=3D$(CONFIG_LINUX) \
-    CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
+    CONFIG_PVRDMA=3D$(CONFIG_PVRDMA) \
+    CONFIG_SMARTCARD=3D$(CONFIG_SMARTCARD)
=20
 MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
                    $(wildcard $(SRC_PATH)/hw/*/Kconfig)
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 555e09377b..da3026586f 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -90,9 +90,19 @@ config USB_BLUETOOTH
 config USB_SMARTCARD
     bool
     default y
-    depends on USB
+    depends on USB && SMARTCARD
=20
 config USB_STORAGE_MTP
     bool
     default y
     depends on USB
+
+config CCID_PASSTHRU
+    bool
+    default y
+    depends on USB_SMARTCARD
+
+config CCID_EMULATED
+    bool
+    default y
+    depends on USB_SMARTCARD
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 303ac084a0..478e6d5752 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -27,13 +27,12 @@ common-obj-$(CONFIG_USB_SERIAL)       +=3D dev-serial.o
 common-obj-$(CONFIG_USB_NETWORK)      +=3D dev-network.o
 common-obj-$(CONFIG_USB_BLUETOOTH)    +=3D dev-bluetooth.o
=20
-ifeq ($(CONFIG_USB_SMARTCARD),y)
-common-obj-y                          +=3D dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo
-smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
+common-obj-$(CONFIG_USB_SMARTCARD)    +=3D dev-smartcard-reader.o
+common-obj-$(call lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=
=3D smartcard.mo
+smartcard.mo-objs :=3D $(call lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passth=
ru.o) \
+                     $(call lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated=
.o)
 smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
 smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
-endif
=20
 ifeq ($(CONFIG_POSIX),y)
 common-obj-$(CONFIG_USB_STORAGE_MTP)  +=3D dev-mtp.o
--=20
2.18.1


