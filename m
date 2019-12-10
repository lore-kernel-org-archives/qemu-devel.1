Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A5C2D0C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4124320828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxkQe87U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4124320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieZqF-0001I1-Dy
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieZpM-0000bv-JM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieZpL-00017f-IO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:21:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieZpL-000179-Em
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575962457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HX5Fp0GiN9uAVTCDRqlWqM87jP6Yq/arDsv580GNd/Q=;
 b=TxkQe87U5IkzoGfEFoQQ0i6eirQ7G8pWBpz/DRrIkzMYh7VQu97cMl/QHyas5X1PY+mBWJ
 WEv9/EkRQ58QHErty0+Q05nNgmeL07N8ce4OO98hpuk64gh8iRMSjAW2myawT1Pk/DD3lJ
 4CFhlj5DH0EQlfUYi98XnTKwSG/8ZMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-WVlxRklkPB2Uusts_2LPwQ-1; Tue, 10 Dec 2019 02:20:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B57801E66
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 07:20:54 +0000 (UTC)
Received: from thuth.com (ovpn-116-158.ams2.redhat.com [10.36.116.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D793576FE0;
 Tue, 10 Dec 2019 07:20:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/usb: Introduce Kconfig switches for the CCID card devices
Date: Tue, 10 Dec 2019 08:20:48 +0100
Message-Id: <20191210072048.15603-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WVlxRklkPB2Uusts_2LPwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In our downstream distribution of QEMU, we need more fine-grained
control on the set of CCID card devices that we want to include.
So let's introduce some proper Kconfig switches that it is easier
to disable them without modifying the corresponding Makefile.objs.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/Kconfig       | 10 ++++++++++
 hw/usb/Makefile.objs |  7 +++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 555e09377b..1358847eba 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -96,3 +96,13 @@ config USB_STORAGE_MTP
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
index 303ac084a0..ebe103fb3d 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -29,11 +29,14 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    +=3D dev-bluetoot=
h.o
=20
 ifeq ($(CONFIG_USB_SMARTCARD),y)
 common-obj-y                          +=3D dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo
-smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
+ifeq ($(CONFIG_SMARTCARD),y)
+common-obj-$(call lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=
=3D smartcard.mo
+smartcard.mo-objs :=3D $(call lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passth=
ru.o) \
+                     $(call lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated=
.o)
 smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
 smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
 endif
+endif
=20
 ifeq ($(CONFIG_POSIX),y)
 common-obj-$(CONFIG_USB_STORAGE_MTP)  +=3D dev-mtp.o
--=20
2.18.1


