Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8FD20829
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJhMXgeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8FD20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CCd-0000VM-Ee
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLk-00030L-5w
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLc-0003IZ-De
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/83xfaOygaLxyY//8kwq5BKN5UauDG55mdMBi9Apvj8=;
 b=NJhMXgeYNjSGNXPCNOh8v+Y65ChbizYW34x9xAbwCALuzpBt+30h1WtKDoT94PGkp9I9D9
 D7bbHm1irRIYDUV2IfteGblmNdOg3j3SA9o03QGPxmHIBvkdF+dz1KXS7Z5b+gcSx9ZHhf
 JKwd7n5LP+beOn5WdvMdTyEnSgdQ/kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-G1gY2DhLPrC3TREqLbQYlA-1; Mon, 10 Aug 2020 13:12:27 -0400
X-MC-Unique: G1gY2DhLPrC3TREqLbQYlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E09919067E0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BCC65F1E9;
 Mon, 10 Aug 2020 17:12:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 119/147] meson: convert hw/block
Date: Mon, 10 Aug 2020 19:08:37 +0200
Message-Id: <1597079345-42801-120-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:11:16
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
 hw/Makefile.objs                 |  1 -
 hw/block/Makefile.objs           | 18 ------------------
 hw/block/dataplane/Makefile.objs |  2 --
 hw/block/dataplane/meson.build   |  2 ++
 hw/block/meson.build             | 21 +++++++++++++++++++++
 hw/meson.build                   |  1 +
 6 files changed, 24 insertions(+), 21 deletions(-)
 delete mode 100644 hw/block/Makefile.objs
 delete mode 100644 hw/block/dataplane/Makefile.objs
 create mode 100644 hw/block/dataplane/meson.build
 create mode 100644 hw/block/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 04cfb6c..9068859 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -3,7 +3,6 @@ devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFI
 devices-dirs-y += acpi/
 devices-dirs-y += adc/
 devices-dirs-y += audio/
-devices-dirs-y += block/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
deleted file mode 100644
index 8855c22..0000000
--- a/hw/block/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-common-obj-y += block.o cdrom.o hd-geometry.o
-common-obj-$(CONFIG_FDC) += fdc.o
-common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
-common-obj-$(CONFIG_NAND) += nand.o
-common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
-common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
-common-obj-$(CONFIG_XEN) += xen-block.o
-common-obj-$(CONFIG_ECC) += ecc.o
-common-obj-$(CONFIG_ONENAND) += onenand.o
-common-obj-$(CONFIG_SWIM) += swim.o
-
-common-obj-$(CONFIG_SH4) += tc58128.o
-
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
-common-obj-$(CONFIG_NVME_PCI) += nvme.o
-
-obj-y += dataplane/
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile.objs
deleted file mode 100644
index 0c52702..0000000
--- a/hw/block/dataplane/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_XEN) += xen-block.o
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
new file mode 100644
index 0000000..12c6a26
--- /dev/null
+++ b/hw/block/dataplane/meson.build
@@ -0,0 +1,2 @@
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
new file mode 100644
index 0000000..78cad8f
--- /dev/null
+++ b/hw/block/meson.build
@@ -0,0 +1,21 @@
+softmmu_ss.add(files(
+  'block.c',
+  'cdrom.c',
+  'hd-geometry.c'
+))
+softmmu_ss.add(when: 'CONFIG_ECC', if_true: files('ecc.c'))
+softmmu_ss.add(when: 'CONFIG_FDC', if_true: files('fdc.c'))
+softmmu_ss.add(when: 'CONFIG_NAND', if_true: files('nand.c'))
+softmmu_ss.add(when: 'CONFIG_ONENAND', if_true: files('onenand.c'))
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
+softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
+softmmu_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
+softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c'))
+
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
+
+subdir('dataplane')
diff --git a/hw/meson.build b/hw/meson.build
index dd0c77e..f968aa8 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('block')
 subdir('char')
 subdir('core')
 subdir('cpu')
-- 
1.8.3.1



