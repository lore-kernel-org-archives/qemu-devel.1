Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9B720709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9B720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3I9-0002KX-6S
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb3H3-0001JF-0j
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:31:17 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:7098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb3H1-0006fn-Hg
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:31:16 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: CmRLdw6LI7GbmUBiN8Dk3dr+z8cZBmJRvieC/1Iylk3BPxEU3SgNwAHcpTcJzXLbGOqrbm8TWC
 15mQPDS2nlav+b5ExdiiPjOUHjTYKE6G5niJ6uI4t7/lkFVAkXlT0X8WmqV3r/Rvh5hPxAeNm4
 p2w0rKmhWkL3zVhDxRswNWqGNkFWJEuau6eW2pTMLI5x84vE1Djo/0R+GKhihf5tMptLEzmbht
 MpO5QkZjry+eDaJZY7wOqTTinQkNdM0rozNXzYhreS0zJFOHUBqdP5cARl2l1PO996SOrG8FPj
 Af4=
X-SBRS: 2.7
X-MesageID: 18167038
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,410,1583211600"; d="scan'208";a="18167038"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] xen: fix build without pci passthrough
Date: Tue, 19 May 2020 16:31:01 +0200
Message-ID: <20200519143101.75330-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.142; envelope-from=roger.pau@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 10:31:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Changes since v1:
 - Do not include osdep in header file.
 - Always add the setters/getters of igd-passthru, report an error
   when attempting to set igd-passthru without built in
   pci-passthrough support.
---
 hw/xen/xen-common.c | 4 ++++
 hw/xen/xen_pt.h     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 70564cc952..d758770da0 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -134,7 +134,11 @@ static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
 
 static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
 {
+#ifdef CONFIG_XEN_PCI_PASSTHROUGH
     has_igd_gfx_passthru = value;
+#else
+    error_setg(errp, "Xen PCI passthrough support not built in");
+#endif
 }
 
 static void xen_setup_post(MachineState *ms, AccelState *accel)
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 179775db7b..7430235a27 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -322,7 +322,13 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
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


