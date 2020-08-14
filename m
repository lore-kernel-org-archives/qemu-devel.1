Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833E22074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVc7fuIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833E22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WhF-000819-OY
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnl-0007y6-6i
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnh-00039m-7t
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeqJ/1Sm+Fvm29kxgyAv/NFi2pw/pN96WZxTtdD3hbU=;
 b=MVc7fuIm/DQussAV9czqOojIgk8VXu+BzKwDSiue/FlqyUKqyI8JqM6wvpeT8/OLLc0+A4
 bFyOan18ev+13c55HMYOyL8hwCEZzwCekgPHKibe7b7aBDWuoP5s6pMGsClPB8pAoUGxpR
 teXUEv0JGgzS4OCgpk4m1YZ0x9Xumvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-6TvxWRryNNaZ21mGrdRFBw-1; Fri, 14 Aug 2020 05:14:57 -0400
X-MC-Unique: 6TvxWRryNNaZ21mGrdRFBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE9041015DBF
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7011B5D9D2;
 Fri, 14 Aug 2020 09:14:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 122/150] meson: convert hw/block
Date: Fri, 14 Aug 2020 05:12:58 -0400
Message-Id: <20200814091326.16173-123-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index 04cfb6ca6d..9068859ef0 100644
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
index 8855c22656..0000000000
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
index 0c5270268e..0000000000
--- a/hw/block/dataplane/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_XEN) += xen-block.o
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
new file mode 100644
index 0000000000..12c6a264f1
--- /dev/null
+++ b/hw/block/dataplane/meson.build
@@ -0,0 +1,2 @@
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
new file mode 100644
index 0000000000..78cad8f7cb
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
index dd0c77ec2b..f968aa8374 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('block')
 subdir('char')
 subdir('core')
 subdir('cpu')
-- 
2.26.2



