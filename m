Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF74C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6977D206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAuZ0EG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgkq7-0004XJ-Om
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgknA-0001ph-1z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:00:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgkn6-0007dW-7R
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 03:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591257595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3CtbA+4hlMXeh/iv82sEaLpTQP7GlES7G01nS7YMO54=;
 b=fAuZ0EG9DjzvO4uRvbSZJqKOxoF37xZ7nob3dYX4g5lOt+6Sko2bEyKZeRqMwuU607FKzm
 Mwi5mQrbm32gbPyjxuuRv+6VoNVg4yx6hx8aSwlDfM0UjGMXmU/xJrGqVVDYsSErcGWxYP
 6fTiTy2wRhp7CM2Mj/Q21/eP2+c6Aq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-WvkOUdG-OI6vn8A62gTvqQ-1; Thu, 04 Jun 2020 03:59:51 -0400
X-MC-Unique: WvkOUdG-OI6vn8A62gTvqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD9318FE86D
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 07:59:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2A610013C0;
 Thu,  4 Jun 2020 07:59:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6067C17510; Thu,  4 Jun 2020 09:59:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vga: build qxl as module
Date: Thu,  4 Jun 2020 09:59:43 +0200
Message-Id: <20200604075943.7001-3-kraxel@redhat.com>
In-Reply-To: <20200604075943.7001-1-kraxel@redhat.com>
References: <20200604075943.7001-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Open questions:
 * Do we want this be contigurable?  If so, how?  Does our miniconf
   support tristate Kconfig options?
 * The Makefile.target chunk feels quite hackish.  Better ideas anyone?

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile.objs            | 1 +
 Makefile.target          | 7 +++++++
 hw/core/qdev.c           | 2 ++
 hw/Makefile.objs         | 1 +
 hw/display/Makefile.objs | 4 +++-
 5 files changed, 14 insertions(+), 1 deletion(-)

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
 
diff --git a/Makefile.target b/Makefile.target
index 8ed1eba95b9c..c70325df5796 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -179,6 +179,13 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+#
+# common-obj-m has some crap here, probably as side effect from
+# filling obj-y.  Clear it.  Fixes suspious dependency errors when
+# building devices as modules.
+#
+common-obj-m :=
+
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 20e5c4cbafd8..9ab30676fff7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -156,6 +156,8 @@ static struct {
     const char *type;
     const char *mod;
 } const hwmodules[] = {
+    { .type = "qxl-vga",        .mod = "display-qxl"            },
+    { .type = "qxl",            .mod = "display-qxl"            },
 };
 
 static bool qdev_module_loaded_all;
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b437348..fdbc7b017487 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -43,4 +43,5 @@ devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
+common-obj-m += display/
 obj-y += $(devices-dirs-y)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 77a7d622bd2d..e2003d7083c2 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -44,7 +44,9 @@ common-obj-$(CONFIG_ARTIST) += artist.o
 
 obj-$(CONFIG_VGA) += vga.o
 
-common-obj-$(CONFIG_QXL) += qxl.o qxl-logger.o qxl-render.o
+#common-obj-$(CONFIG_QXL) += qxl.mo
+common-obj-m += qxl.mo
+qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
 
 obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
 obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-- 
2.18.4


