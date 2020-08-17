Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0337420888
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAht4bHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0337420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gxi-00015a-4o
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gK2-0002AC-IA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gJz-0006oI-QH
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1/obpthDPiI++kV8GyCWd8c/EELxIwncGfunuXqk48=;
 b=CAht4bHdGRWu3Dzj850ClIGz+SHv8RbXJ3VcbI3Mn2KUbcpzfTfMMuQRxx+wiiUfNGyrws
 Cge012hFaa8WQDaHUzcBfuivhWG6OvQz5MUXNwxLWMXetb7jI93q/Yui1bOmZLvzk4PMhn
 gl8QcCUz2dTgTt2AISmOyJdlk1kWUlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Q8ueVW3qM4WmR4HruLUm_A-1; Mon, 17 Aug 2020 10:41:09 -0400
X-MC-Unique: Q8ueVW3qM4WmR4HruLUm_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 618371008301
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:07 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8896A70C3D;
 Mon, 17 Aug 2020 14:41:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 102/150] meson: convert hw/pci-bridge
Date: Mon, 17 Aug 2020 16:40:05 +0200
Message-Id: <20200817144053.345107-7-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
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
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/pci-bridge/Makefile.objs | 10 ----------
 hw/pci-bridge/meson.build   | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 11 deletions(-)
 delete mode 100644 hw/pci-bridge/Makefile.objs
 create mode 100644 hw/pci-bridge/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 0038cf89d9..3513040d4a 100644
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
index ca36e486e7..a7301f21e8 100644
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
index 47065f87d9..0000000000
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
index 0000000000..daab8acf2a
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
2.26.2



