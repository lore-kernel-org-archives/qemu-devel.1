Received: from eggs.gnu.org ([2001:4830:134:3::10]:43068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fBH6L-000557-AN
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fBH6I-0002SS-MF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:37 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fBH6I-0002SD-G0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:52:34 -0400
Received: by mail-ot0-x241.google.com with SMTP id w4-v6so24615909ote.12
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 02:52:34 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 25 Apr 2018 17:52:23 +0800
Message-Id: <1524649943-6922-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH v2] hw/pci-host/q35: Replace hardcoded value
 with macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

During smram region initialization some addresses are hardcoded,
replace them with macro to be more clear to readers.

Previous patch forgets about one value and exceeds the line
limit of 90 characters. The v2 breaks a few long lines

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci-host/q35.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a36a119..02f9576 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -535,13 +535,15 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(mch->system_memory, 0xa0000,
+                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                                         &mch->smram_region, 1);
     memory_region_set_enabled(&mch->smram_region, true);
 
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
                                         &mch->open_high_smram, 1);
     memory_region_set_enabled(&mch->open_high_smram, false);
@@ -550,11 +552,14 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_init(&mch->smram, OBJECT(mch), "smram", 1ull << 32);
     memory_region_set_enabled(&mch->smram, true);
     memory_region_init_alias(&mch->low_smram, OBJECT(mch), "smram-low",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_set_enabled(&mch->low_smram, true);
-    memory_region_add_subregion(&mch->smram, 0xa0000, &mch->low_smram);
+    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                                &mch->low_smram);
     memory_region_init_alias(&mch->high_smram, OBJECT(mch), "smram-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
+                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_set_enabled(&mch->high_smram, true);
     memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
 
-- 
2.7.4
