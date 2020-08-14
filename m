Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83977206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiO2eH5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83977206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WKV-0002uM-Ng
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnL-0006rW-SZ
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnI-00032M-2E
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqxqYSBV7uEMenTXBSHXyP24ul4XVhFr0o+0x9l/sqA=;
 b=SiO2eH5vzyFpV9WfEjKXFSGb3VA0y1sK9Xz5cqRTITpQe7GLnclrCXtPvIaDv+hB6+qoOq
 AV6XZIb3yYiVjW+UBtPhDJOwdB1kLyiQACOoxYiom6QaimCOGnhd0di1fIFnEarQQqdnZh
 3Kop5bLSfm8JmMFbOloY6Agh6qK9Erw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-GBWGlstVNESTSWq9M5pX7w-1; Fri, 14 Aug 2020 05:14:33 -0400
X-MC-Unique: GBWGlstVNESTSWq9M5pX7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093858015C3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC792600E4;
 Fri, 14 Aug 2020 09:14:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 090/150] meson: convert hw/mem
Date: Fri, 14 Aug 2020 05:12:26 -0400
Message-Id: <20200814091326.16173-91-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 73c49ddd3b..df72b25a64 100644
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
index c27844900d..a0ef2cf648 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -9,3 +9,4 @@ config NVDIMM
     bool
     default y
     depends on (PC || PSERIES || ARM_VIRT)
+    select MEM_DEVICE
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
deleted file mode 100644
index 56345befd0..0000000000
--- a/hw/mem/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-common-obj-$(CONFIG_DIMM) += pc-dimm.o
-common-obj-y += memory-device.o
-common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
new file mode 100644
index 0000000000..ba424622bb
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
index dccc2d19a6..542d675618 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
-- 
2.26.2



