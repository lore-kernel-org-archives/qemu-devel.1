Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F5C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 03:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111CE21852
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 03:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111CE21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjErk-0006Op-QY
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 23:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hjEqx-0005nu-Ug
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 23:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hjEqw-0004aC-8y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 23:25:39 -0400
Received: from ozlabs.ru ([107.173.13.209]:54631)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hjEqw-0004Z7-3t; Thu, 04 Jul 2019 23:25:38 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id CED23AE80004;
 Thu,  4 Jul 2019 23:25:03 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 13:25:01 +1000
Message-Id: <20190705032501.106966-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [RFC PATCH qemu] vfio-quirks: Pass the actual parent
 when deleting a memory region
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The usual way of using a quirk's MR is to add it as a subregion of a BAR
as this is what quirks are for. However there is less than standard user
of this - NVLink2-enabled NVIDIA GPU which exposes a GPU RAM and a ATSD
64K region outside of PCI MMIO window so these MRs get the system address
space root as a parent. So when the user unplugs such device, assert
occurs:

qemu-system-ppc64: /home/aik/p/qemu/memory.c:2391: memory_region_del_subregion: Assertion `subregion->container == mr' failed.

This passes the actual parent MR to memory_region_del_subregion() in
vfio_bar_quirk_exit.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This removes an extra sanity check that a quirk has a correct parent;
I am not sure if it is very useful.
I could use the "system" MR if quirk->mem[i].container==get_system_memory()
and quirk->mem[i].container otherwise to keep that assert working.

Also this does not help with the actual device removal much because of
the closed source driver nature - the associated service
(nvidia-persistenced, responsible for onlining GPU memory) crashes
the guest system but at least the user can reboot the guest after
the crash which is not as bad as assert.

---
 hw/vfio/pci-quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 27dddbc8fa3e..ef2e182c1d36 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1896,7 +1896,8 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
         }
 
         for (i = 0; i < quirk->nr_mem; i++) {
-            memory_region_del_subregion(bar->region.mem, &quirk->mem[i]);
+            memory_region_del_subregion(quirk->mem[i].container,
+                                        &quirk->mem[i]);
         }
     }
 }
-- 
2.17.1


