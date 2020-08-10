Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5CA20791
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFncMrDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5CA20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5C8j-0000Hn-2l
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BL7-00027D-CA
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BL4-0003Dw-QS
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMJJsIc+cf5gyLxdIWccdwznh3sTxnUR7ZqHdvZWrNo=;
 b=XFncMrDi/aLW7QhkqdPxFfoaQrnnTMf+TRkdYidbxrBM5CRIBdZz3+1UNff8u/+HpHvHRR
 Xd5gxDq2Y3/3j8aoSGIKFtXpkDyIprHDirhHCyew/OaCIESyB7Pw97dDbLXxIWO2u2XWt2
 eNG7gajyZ9DnaZV5j1sxsDKvPgvfn/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-HS-b2zlVM6ODxDh63OgmQw-1; Mon, 10 Aug 2020 13:11:56 -0400
X-MC-Unique: HS-b2zlVM6ODxDh63OgmQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E538B100CCC0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:54 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F354A5F1E9;
 Mon, 10 Aug 2020 17:11:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 100/147] meson: convert hw/pci-bridge
Date: Mon, 10 Aug 2020 19:08:18 +0200
Message-Id: <1597079345-42801-101-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/pci-bridge/Makefile.objs | 10 ----------
 hw/pci-bridge/meson.build   | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 11 deletions(-)
 delete mode 100644 hw/pci-bridge/Makefile.objs
 create mode 100644 hw/pci-bridge/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 0038cf8..3513040 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -22,7 +22,6 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index ca36e48..a7301f2 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
 subdir('rtc')
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
deleted file mode 100644
index 47065f8..0000000
--- a/hw/pci-bridge/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-y += pci_bridge_dev.o
-common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci_bridge.o
-common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
-common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
-common-obj-$(CONFIG_IOH3420) += ioh3420.o
-common-obj-$(CONFIG_I82801B11) += i82801b11.o
-# NewWorld PowerMac
-common-obj-$(CONFIG_DEC_PCI) += dec.o
-# Sun4u
-common-obj-$(CONFIG_SIMBA) += simba.o
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
new file mode 100644
index 0000000..daab8ac
--- /dev/null
+++ b/hw/pci-bridge/meson.build
@@ -0,0 +1,14 @@
+pci_ss = ss.source_set()
+pci_ss.add(files('pci_bridge_dev.c'))
+pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
+pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
+
+# NewWorld PowerMac
+pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
+# Sun4u
+pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
1.8.3.1



