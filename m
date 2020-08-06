Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54464C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C032173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9RlGvwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lxa-0004fD-7U
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPi-0007pU-IL
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPg-0006h0-Mt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2o3z543BwQNJiqsu8SJSUCnvV9TS/KTwSbMD9xcgwOc=;
 b=V9RlGvwMLB2VnMqTk2qiIpQOA81Cuxs9ONkVx8FpAu9+LFh5E/v5YhMPGwEBNpkhjfeBSh
 B1/awmpZoS5n3jcgYdcn07Th/hTfJSCbtVLz4O7ADZEu3Zqlk5xTC+SALUQmIWKT5nPf3E
 mCagmEtCxYgHrE5QMpeBSo8zTZ3TsSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-0mtMv3YpPLSiLfS2fYhrOA-1; Thu, 06 Aug 2020 15:18:50 -0400
X-MC-Unique: 0mtMv3YpPLSiLfS2fYhrOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B01B280183C
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C12C25F9DC;
 Thu,  6 Aug 2020 19:18:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 086/143] meson: convert hw/mem
Date: Thu,  6 Aug 2020 21:15:22 +0200
Message-Id: <1596741379-12902-87-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 13:48:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/mem/Kconfig       | 1 +
 hw/mem/Makefile.objs | 3 ---
 hw/mem/meson.build   | 6 ++++++
 hw/meson.build       | 1 +
 5 files changed, 8 insertions(+), 4 deletions(-)
 delete mode 100644 hw/mem/Makefile.objs
 create mode 100644 hw/mem/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 73c49dd..df72b25 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -34,7 +34,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index c278449..a0ef2cf 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -9,3 +9,4 @@ config NVDIMM
     bool
     default y
     depends on (PC || PSERIES || ARM_VIRT)
+    select MEM_DEVICE
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
deleted file mode 100644
index 56345be..0000000
--- a/hw/mem/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-common-obj-$(CONFIG_DIMM) += pc-dimm.o
-common-obj-y += memory-device.o
-common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
new file mode 100644
index 0000000..ba42462
--- /dev/null
+++ b/hw/mem/meson.build
@@ -0,0 +1,6 @@
+mem_ss = ss.source_set()
+mem_ss.add(files('memory-device.c'))
+mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/hw/meson.build b/hw/meson.build
index dccc2d1..542d675 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
-- 
1.8.3.1



