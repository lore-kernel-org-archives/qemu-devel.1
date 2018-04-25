Received: from eggs.gnu.org ([2001:4830:134:3::10]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fBGbg-0004UR-3Y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fBGbb-0000HG-P2
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:20:56 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fBGbb-0000GH-KD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:20:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id t27-v6so20242756oij.9
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 02:20:50 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 25 Apr 2018 17:20:37 +0800
Message-Id: <1524648037-5010-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/pci-host/q35: Replace hardcoded value with
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

Currently part of mch_realize uses hardcoded value when initializing
smram regions. Use macro to be more clear to code readers

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci-host/q35.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a36a119..49e4be4 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -535,13 +535,13 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(mch->system_memory, 0xa0000,
+                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE, MCH_HOST_BRIDGE_SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                                         &mch->smram_region, 1);
     memory_region_set_enabled(&mch->smram_region, true);
 
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE, MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
                                         &mch->open_high_smram, 1);
     memory_region_set_enabled(&mch->open_high_smram, false);
@@ -550,11 +550,11 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_init(&mch->smram, OBJECT(mch), "smram", 1ull << 32);
     memory_region_set_enabled(&mch->smram, true);
     memory_region_init_alias(&mch->low_smram, OBJECT(mch), "smram-low",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE, 0x20000);
     memory_region_set_enabled(&mch->low_smram, true);
-    memory_region_add_subregion(&mch->smram, 0xa0000, &mch->low_smram);
+    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMRAM_C_BASE, &mch->low_smram);
     memory_region_init_alias(&mch->high_smram, OBJECT(mch), "smram-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE, MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_set_enabled(&mch->high_smram, true);
     memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
 
-- 
2.7.4
