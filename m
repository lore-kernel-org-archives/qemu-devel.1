Received: from eggs.gnu.org ([2001:4830:134:3::10]:48745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyX-0001Vh-3U
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyU-0000iC-3C
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyT-0000i2-UH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:46 -0400
Date: Wed, 23 May 2018 17:42:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-2-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/28] hw/pci-host/q35: Replace hardcoded value
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zihan Yang <whois.zihan.yang@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Zihan Yang <whois.zihan.yang@gmail.com>

During smram region initialization some addresses are hardcoded,
replace them with macro to be more clear to readers.

Previous patch forgets about one value and exceeds the line
limit of 90 characters. The v2 breaks a few long lines

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
