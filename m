Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9440C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D93206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi1gPgZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D93206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpmH-0004XM-Oy
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpk2-0007wC-QS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47124
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpk1-00023y-32
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591276624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=7dtnhAMur6O1hPZfDxsUXSZTfj0D83DZ5mYC+o3CW9k=;
 b=Yi1gPgZZEBDzZB/LQgL1XDPjyoJ+IUUmtDTK+eWjgSc0lItM6TQN35JFp6T4RVZ9gC850x
 YkeK8va6jMLY8xW4H5qiRthHgUjlFmU/wJSIWhVuv4s4Qb1/9JI+Igwzq3dH2Ivli7G6XV
 DscRaMScbrYEyhsTx2Vs4i3NjCdDhXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Awld3qPcNDaww1PNyHgxbQ-1; Thu, 04 Jun 2020 09:16:56 -0400
X-MC-Unique: Awld3qPcNDaww1PNyHgxbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE37107B29A
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 13:16:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0445761B7A;
 Thu,  4 Jun 2020 13:16:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 275181753B; Thu,  4 Jun 2020 15:16:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] vga: build virtio-gpu as module
Date: Thu,  4 Jun 2020 15:16:43 +0200
Message-Id: <20200604131643.1776-8-kraxel@redhat.com>
In-Reply-To: <20200604131643.1776-1-kraxel@redhat.com>
References: <20200604131643.1776-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Drops libvirglrenderer.so dependency from core qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/qdev.c           |  6 ++++++
 hw/display/Makefile.objs | 23 +++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 70cf84bb67d0..bc4485e93675 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -161,6 +161,12 @@ static struct {
     { .type = "usb-redir",             .mod = "usb-redirect"          },
     { .type = "qxl-vga",               .mod = "display-qxl"           },
     { .type = "qxl",                   .mod = "display-qxl"           },
+    { .type = "virtio-gpu-device",     .mod = "display-virtio-gpu"    },
+    { .type = "virtio-gpu-pci",        .mod = "display-virtio-gpu"    },
+    { .type = "virtio-vga",            .mod = "display-virtio-gpu"    },
+    { .type = "vhost-user-gpu-device", .mod = "display-virtio-gpu"    },
+    { .type = "vhost-user-gpu-pci",    .mod = "display-virtio-gpu"    },
+    { .type = "vhost-user-vga",        .mod = "display-virtio-gpu"    },
 };
 
 static bool qdev_module_loaded_all;
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index d619594ad4d3..e907f3182b0c 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -49,16 +49,19 @@ common-obj-m += qxl.mo
 qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
 endif
 
-common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
-common-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-common-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
-common-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
-common-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
-common-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
-virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
-virtio-gpu.o-libs += $(VIRGL_LIBS)
-virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
-virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
+ifeq ($(CONFIG_VIRTIO_GPU),y)
+common-obj-m += virtio-gpu.mo
+virtio-gpu-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
+virtio-gpu-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
+virtio-gpu-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
+virtio-gpu-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
+virtio-gpu-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
+virtio-gpu-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
+virtio-gpu.mo-objs := $(virtio-gpu-obj-y)
+virtio-gpu.mo-cflags := $(VIRGL_CFLAGS)
+virtio-gpu.mo-libs := $(VIRGL_LIBS)
+endif
+
 common-obj-$(CONFIG_DPCD) += dpcd.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
 
-- 
2.18.4


