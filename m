Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F3E2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F3E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEKD-00044Z-Sr
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jmEJG-0003d0-Tr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:31:46 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:43555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jmEJF-0008BC-77
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:31:46 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: fYsZu61/2ZYIqvY2si0AkUINxkWzpin0GRMWoIaFvWIqTj+jIEhBt+O/jzhO6fCY7ZlKmnFqDJ
 uRS9Qq+n7TV99RcpIur2A50qlKP9ZaAuzNPfFL7D8ln3WHsK/IQMa2RU5ud+OV3lSpCT2QZYz/
 3zYWPRpBprx4QGm7TElREiVJ03itvX2G0RB0euKtADDDubWQLfDDXT8vIWICnuc2yNkRjjUPuY
 p5NvJCg5T4OzApEaCdCYke2l4NauscZN+2YTGvy875mSFT9TTm0dB4JapeinR+FMqWmkzzJfV8
 4Og=
X-SBRS: 2.7
X-MesageID: 20756471
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,255,1589256000"; d="scan'208";a="20756471"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] xen: Actually fix build without passthrough
Date: Fri, 19 Jun 2020 11:31:15 +0100
Message-ID: <20200619103115.254127-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=anthony.perard@citrix.com; helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 06:31:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix typo.

Fixes: acd0c9416d48 ("xen: fix build without pci passthrough")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 3fc715e5954d..502b32d877a0 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -4,4 +4,4 @@ common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-b
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
-obj-$(call $(lnot, $(CONFIG_XEN_PCI_PASSTHROUGH))) += xen_pt_stub.o
+obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o
-- 
Anthony PERARD


