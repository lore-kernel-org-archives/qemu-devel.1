Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E20B206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IHa/k63U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVY8b-0006xG-IA
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jVY7j-0006TF-Kt
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:14:55 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:2440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jVY7i-0006yx-BO
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1588587295;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hHXsCBHhwytgii8wsjHMhAMeO4nlwNzTdfKVVjJT9fA=;
 b=IHa/k63UgTtgrqLxVJE3kYWH0RWpztK/L/FTKdHtL8v4gxmC9U5+SVk9
 YUO3JYE0g3sl5xcE6ge8tm9iSIfSxSLBFS2fii6WS9CHw/P5Ni2RpB+m4
 E8ajRykZdz3BMdtoBYQvcdWr8hAdQZBKY72pz50mG5H0olZkomXt1Eg/c c=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: SNtEGKj6AHmTYc1l6JrCrcHWXNdLdYXwAC1CtnPp4dmehEJWK3fBd2Xza3kfcnGTxgV56NFaA1
 Kc8LHSQYGhmdyxy6LD2wFNzeLN36b7J8L3kG/eOIhnarqEJX7u7HVjO5petW2YZQkTLEsbV8kP
 B1vm/YrHLfl603JqJWfP/cU/NXyzqn40Po7JbLg7drX853N3o4zhZCGUZ534GJbZxG+5VN/3YB
 EKFVMWyvShwsmJxBS3dkC4p36OfFsu59+b1lrLmk8dtOtzY7cbeQLXKemE+WTm8yKakgOT88Qd
 clQ=
X-SBRS: 2.7
X-MesageID: 16644716
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,351,1583211600"; d="scan'208";a="16644716"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] xen: fix build without pci passthrough
Date: Mon, 4 May 2020 12:14:43 +0200
Message-ID: <20200504101443.3165-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.155; envelope-from=roger.pau@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:14:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul
 Durrant <paul@xen.org>, Roger Pau Monne <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

has_igd_gfx_passthru is only available when QEMU is built with
CONFIG_XEN_PCI_PASSTHROUGH, and hence shouldn't be used in common
code without checking if it's available.

Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
---
 hw/xen/xen-common.c | 4 ++++
 hw/xen/xen_pt.h     | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index a15070f7f6..c800862419 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -127,6 +127,7 @@ static void xen_change_state_handler(void *opaque, int running,
     }
 }
 
+#ifdef CONFIG_XEN_PCI_PASSTHROUGH
 static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
 {
     return has_igd_gfx_passthru;
@@ -136,6 +137,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
 {
     has_igd_gfx_passthru = value;
 }
+#endif
 
 static void xen_setup_post(MachineState *ms, AccelState *accel)
 {
@@ -197,11 +199,13 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
 
     compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
 
+#ifdef CONFIG_XEN_PCI_PASSTHROUGH
     object_class_property_add_bool(oc, "igd-passthru",
         xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
         &error_abort);
     object_class_property_set_description(oc, "igd-passthru",
         "Set on/off to enable/disable igd passthrou", &error_abort);
+#endif
 }
 
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 179775db7b..660dd8a008 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -1,6 +1,7 @@
 #ifndef XEN_PT_H
 #define XEN_PT_H
 
+#include "qemu/osdep.h"
 #include "hw/xen/xen_common.h"
 #include "hw/pci/pci.h"
 #include "xen-host-pci-device.h"
@@ -322,7 +323,13 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
                                             unsigned int domain,
                                             unsigned int bus, unsigned int slot,
                                             unsigned int function);
+
+#ifdef CONFIG_XEN_PCI_PASSTHROUGH
 extern bool has_igd_gfx_passthru;
+#else
+# define has_igd_gfx_passthru false
+#endif
+
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
     return (has_igd_gfx_passthru
-- 
2.26.2


