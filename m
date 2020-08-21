Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E636C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC46F20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLMbHr6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC46F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94sZ-0003IN-S7
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EC-00036Q-Mw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E7-0001jK-VF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3C/7hgOHspBfIxBONsfiAWNW93qZIpPhApRZy9KVThY=;
 b=cLMbHr6vYIW0yHeljIyWYdok9qfhxO+9Y7f523i4+FkueEVUQQouO/YxaVNik03lGfgVtG
 EL15L0WOC5KCWY6iIyLWgeOX40EIvl0/8UUuoe0FKwSZzD2Wydm3KaZJMiuAN+LEQZYpjc
 P0p5yzzZagXezGb59+f8WxR3SGPvWsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-vV2z6SF5M0aGBpYLkadCEQ-1; Fri, 21 Aug 2020 06:24:49 -0400
X-MC-Unique: vV2z6SF5M0aGBpYLkadCEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D531009442
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3199A795AE;
 Fri, 21 Aug 2020 10:24:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 094/152] meson: convert hw/vfio
Date: Fri, 21 Aug 2020 06:22:31 -0400
Message-Id: <20200821102329.29777-95-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/vfio/Makefile.objs |  8 --------
 hw/vfio/meson.build   | 18 ++++++++++++++++++
 4 files changed, 19 insertions(+), 9 deletions(-)
 delete mode 100644 hw/vfio/Makefile.objs
 create mode 100644 hw/vfio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a1cfb99334..f6e08f6660 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -31,7 +31,6 @@ devices-dirs-y += ssi/
 devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
-devices-dirs-$(CONFIG_VFIO) += vfio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 8338fc4408..4dafc8a08e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
deleted file mode 100644
index 9bb1c09e84..0000000000
--- a/hw/vfio/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y += common.o spapr.o
-obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
-obj-$(CONFIG_VFIO_CCW) += ccw.o
-obj-$(CONFIG_VFIO_PLATFORM) += platform.o
-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
-obj-$(CONFIG_VFIO_AP) += ap.o
-obj-$(CONFIG_VFIO_IGD) += igd.o
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
new file mode 100644
index 0000000000..37efa74018
--- /dev/null
+++ b/hw/vfio/meson.build
@@ -0,0 +1,18 @@
+vfio_ss = ss.source_set()
+vfio_ss.add(files(
+  'common.c',
+  'spapr.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+  'pci-quirks.c',
+  'pci.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
+
+specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
-- 
2.26.2



