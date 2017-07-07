Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTQ-0005qF-Ce
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTP-00043L-I9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTP-00040L-Az
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:57 +0100
Message-Id: <1499438577-7674-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/11] docs/devel/memory.txt: Add section about
 RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Add a section to docs/devel/memory.txt about migration of
the backing memory for RAM regions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/memory.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/devel/memory.txt b/docs/devel/memory.txt
index 811b1bd..8ed810f 100644
--- a/docs/devel/memory.txt
+++ b/docs/devel/memory.txt
@@ -91,6 +91,37 @@ one of whose subregions is a low priority "background" region covering
 the whole address range; this is often clearer and is preferred.
 Subregions cannot be added to an alias region.
 
+Migration
+---------
+
+Where the memory region is backed by host memory (RAM, ROM and
+ROM device memory region types), this host memory needs to be
+copied to the destination on migration. These APIs which allocate
+the host memory for you will also register the memory so it is
+migrated:
+ - memory_region_init_ram()
+ - memory_region_init_rom()
+ - memory_region_init_rom_device()
+
+For most devices and boards this is the correct thing. If you
+have a special case where you need to manage the migration of
+the backing memory yourself, you can call the functions:
+ - memory_region_init_ram_nomigrate()
+ - memory_region_init_rom_nomigrate()
+ - memory_region_init_rom_device_nomigrate()
+which only initialize the MemoryRegion and leave handling
+migration to the caller.
+
+The functions:
+ - memory_region_init_resizeable_ram()
+ - memory_region_init_ram_from_file()
+ - memory_region_init_ram_from_fd()
+ - memory_region_init_ram_ptr()
+ - memory_region_init_ram_device_ptr()
+are for special cases only, and so they do not automatically
+register the backing memory for migration; the caller must
+manage migration if necessary.
+
 Region names
 ------------
 
-- 
2.7.4
