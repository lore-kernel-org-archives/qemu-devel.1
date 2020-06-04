Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9218206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNCmnPFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9218206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgplA-0001rV-TI
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpkJ-00007P-L1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpkI-00026U-JO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591276641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=CtccG+l+buVKw/BiwQr17ak+aMxrB65+TBtXNmztbGw=;
 b=FNCmnPFmNITn32PMaO3WnrG4qL4bY4m9Zf+4Y6ZXyx6zz711w9Bd89igUEoq8BtlVvtsP8
 YFQ+slZT4XOcY3IOEmCUr8NzsAtQ8CBtj2F8ru1RTa3+jP4GI/luGNP8HNcR5WFF7ue9GW
 K3nclEW+CzgNAoOB/fTYoJwJ+dTDTgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-bpObeYQZN-6tIeOBZhw5bA-1; Thu, 04 Jun 2020 09:17:14 -0400
X-MC-Unique: bpObeYQZN-6tIeOBZhw5bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7868107AFDB
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 13:17:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE61A1002391;
 Thu,  4 Jun 2020 13:16:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EA81E17511; Thu,  4 Jun 2020 15:16:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] ccid: build smartcard as module
Date: Thu,  4 Jun 2020 15:16:39 +0200
Message-Id: <20200604131643.1776-4-kraxel@redhat.com>
In-Reply-To: <20200604131643.1776-1-kraxel@redhat.com>
References: <20200604131643.1776-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
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
index 7177798840d4..36c301750c31 100644
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
index 66835e5bf732..d8e340cd0748 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -28,11 +28,13 @@ common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
 
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


