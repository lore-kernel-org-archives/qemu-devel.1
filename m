Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29BA23AFE
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWx0T/Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29BA23AFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h4h-0006dp-4x
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKj-0003Db-SJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKi-0006sA-5J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeqJ/1Sm+Fvm29kxgyAv/NFi2pw/pN96WZxTtdD3hbU=;
 b=WWx0T/Z/PYYAnz00/KpiljIcH86OPREwpmVcCPTWo1ffoOawIUWrTRXS/qinZWFQuPnS0x
 vdew/AwzNmZjkdYg21cf1ahcnKErsCIcAyPDylQ+NYWQvAjSTLZn7P+v4Df/s1fCdxyBji
 PPywHZPx4hAjkgO/vO/gc2YOnktiV0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-GRymt9e9NtShPVcTfoVBqA-1; Mon, 17 Aug 2020 10:41:53 -0400
X-MC-Unique: GRymt9e9NtShPVcTfoVBqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED8C51DDE9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:52 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC4670C3D;
 Mon, 17 Aug 2020 14:41:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 121/150] meson: convert hw/block
Date: Mon, 17 Aug 2020 16:40:24 +0200
Message-Id: <20200817144053.345107-26-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



