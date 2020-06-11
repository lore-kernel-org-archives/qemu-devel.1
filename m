Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45596C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107182072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjDrZmnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107182072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIUV-0006WE-B4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjITa-0004vk-RL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:22:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjITV-0006qr-Nd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591863732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=DeN3q5RGjvT7QnboHK4q5+BTEr1qbI6D85IAOMA0dRo=;
 b=NjDrZmnjvfZ0A+pkE4Sdq7CGnY/JkzzkN+1hbGzXWL9JmZQOX58FwTnG8lf6QO7NXz4sL3
 5VfUWVUiW9qbGXeVNmNwXoj74r1ELMWViq1iIViB/i/L3HovMd31EcDMESbR2nIYrslwFK
 BBz15E+72d8JOTh55IKmaM3flV4USl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-7NuxBY0bPPO_wbfo1euXzg-1; Thu, 11 Jun 2020 04:22:08 -0400
X-MC-Unique: 7NuxBY0bPPO_wbfo1euXzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EEF188360B
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:22:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7CB7C3B7;
 Thu, 11 Jun 2020 08:22:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F61D17511; Thu, 11 Jun 2020 10:22:00 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] ccid: build smartcard as module
Date: Thu, 11 Jun 2020 10:21:55 +0200
Message-Id: <20200611082200.26331-4-kraxel@redhat.com>
In-Reply-To: <20200611082200.26331-1-kraxel@redhat.com>
References: <20200611082200.26331-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drops libcacard.so dependency from core qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile.objs        | 1 +
 hw/core/qdev.c       | 2 ++
 hw/Makefile.objs     | 1 +
 hw/usb/Makefile.objs | 4 +++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 99774cfd2545..28c165c0e623 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -59,6 +59,7 @@ common-obj-y += migration/
 common-obj-y += audio/
 common-obj-m += audio/
 common-obj-y += hw/
+common-obj-m += hw/
 
 common-obj-y += replay/
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 342b5b64871e..0388efe2190b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -156,6 +156,8 @@ static struct {
     const char *type;
     const char *mod;
 } const hwmodules[] = {
+    { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
+    { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },
 };
 
 static bool qdev_module_loaded_all;
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b437348..71843591fe43 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -43,4 +43,5 @@ devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
+common-obj-m += usb/
 obj-y += $(devices-dirs-y)
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index fa5c3fa1b877..3c5b3d4fadd3 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -29,11 +29,13 @@ common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
 
 ifeq ($(CONFIG_USB_SMARTCARD),y)
 common-obj-y                          += dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
+ifeq ($(CONFIG_SMARTCARD),y)
+common-obj-m                          += smartcard.mo
 smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
 smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
 smartcard.mo-libs := $(SMARTCARD_LIBS)
 endif
+endif
 
 ifeq ($(CONFIG_POSIX),y)
 common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
-- 
2.18.4


