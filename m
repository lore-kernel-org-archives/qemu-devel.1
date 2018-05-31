Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0000tl-2n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0006XV-61
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUt-0006Uu-TM
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUs-0002us-I4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:49 +0100
Message-Id: <20180531142357.904-18-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/25] Make MemoryRegion valid.accepts callback
 take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to the MemoryRegion valid.accepts
callback. We'll need this for subpage_accepts().

We could take the approach we used with the read and write
callbacks and add new a new _with_attrs version, but since there
are so few implementations of the accepts hook we just change
them all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-9-peter.maydell@linaro.org
---
 include/exec/memory.h |  3 ++-
 exec.c                |  9 ++++++---
 hw/hppa/dino.c        |  3 ++-
 hw/nvram/fw_cfg.c     | 12 ++++++++----
 hw/scsi/esp.c         |  3 ++-
 hw/xen/xen_pt_msi.c   |  3 ++-
 memory.c              |  5 +++--
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3f2671f332..76a2dd3878 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -166,7 +166,8 @@ struct MemoryRegionOps {
          * as a machine check exception).
          */
         bool (*accepts)(void *opaque, hwaddr addr,
-                        unsigned size, bool is_write);
+                        unsigned size, bool is_write,
+                        MemTxAttrs attrs);
     } valid;
     /* Internal implementation constraints: */
     struct {
diff --git a/exec.c b/exec.c
index 6cf97b5d28..b58eb0fedd 100644
--- a/exec.c
+++ b/exec.c
@@ -2539,7 +2539,8 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
 }
 
 static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write)
+                                 unsigned size, bool is_write,
+                                 MemTxAttrs attrs)
 {
     return is_write;
 }
@@ -2762,7 +2763,8 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
 }
 
 static bool subpage_accepts(void *opaque, hwaddr addr,
-                            unsigned len, bool is_write)
+                            unsigned len, bool is_write,
+                            MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
 #if defined(DEBUG_SUBPAGE)
@@ -2845,7 +2847,8 @@ static void readonly_mem_write(void *opaque, hwaddr addr,
 }
 
 static bool readonly_mem_accepts(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write)
+                                 unsigned size, bool is_write,
+                                 MemTxAttrs attrs)
 {
     return is_write;
 }
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index c5dcf3104d..26f2704cd5 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -137,7 +137,8 @@ static void gsc_to_pci_forwarding(DinoState *s)
 }
 
 static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
-                                unsigned size, bool is_write)
+                                unsigned size, bool is_write,
+                                MemTxAttrs attrs)
 {
     switch (addr) {
     case DINO_IAR0:
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2a0739d0e9..b23e7f64a8 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -420,14 +420,16 @@ static void fw_cfg_dma_mem_write(void *opaque, hwaddr addr,
 }
 
 static bool fw_cfg_dma_mem_valid(void *opaque, hwaddr addr,
-                                  unsigned size, bool is_write)
+                                 unsigned size, bool is_write,
+                                 MemTxAttrs attrs)
 {
     return !is_write || ((size == 4 && (addr == 0 || addr == 4)) ||
                          (size == 8 && addr == 0));
 }
 
 static bool fw_cfg_data_mem_valid(void *opaque, hwaddr addr,
-                                  unsigned size, bool is_write)
+                                  unsigned size, bool is_write,
+                                  MemTxAttrs attrs)
 {
     return addr == 0;
 }
@@ -439,7 +441,8 @@ static void fw_cfg_ctl_mem_write(void *opaque, hwaddr addr,
 }
 
 static bool fw_cfg_ctl_mem_valid(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write)
+                                 unsigned size, bool is_write,
+                                 MemTxAttrs attrs)
 {
     return is_write && size == 2;
 }
@@ -458,7 +461,8 @@ static void fw_cfg_comb_write(void *opaque, hwaddr addr,
 }
 
 static bool fw_cfg_comb_valid(void *opaque, hwaddr addr,
-                                  unsigned size, bool is_write)
+                              unsigned size, bool is_write,
+                              MemTxAttrs attrs)
 {
     return (size == 1) || (is_write && size == 2);
 }
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 64ec285826..9ed9727744 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -564,7 +564,8 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
 }
 
 static bool esp_mem_accepts(void *opaque, hwaddr addr,
-                            unsigned size, bool is_write)
+                            unsigned size, bool is_write,
+                            MemTxAttrs attrs)
 {
     return (size == 1) || (is_write && size == 4);
 }
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 6d1e3bdeb4..cc514f9157 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -498,7 +498,8 @@ static uint64_t pci_msix_read(void *opaque, hwaddr addr,
 }
 
 static bool pci_msix_accepts(void *opaque, hwaddr addr,
-                             unsigned size, bool is_write)
+                             unsigned size, bool is_write,
+                             MemTxAttrs attrs)
 {
     return !(addr & (size - 1));
 }
diff --git a/memory.c b/memory.c
index 279f7c9b4a..10fa2ddd31 100644
--- a/memory.c
+++ b/memory.c
@@ -1269,7 +1269,8 @@ static void unassigned_mem_write(void *opaque, hwaddr addr,
 }
 
 static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
-                                   unsigned size, bool is_write)
+                                   unsigned size, bool is_write,
+                                   MemTxAttrs attrs)
 {
     return false;
 }
@@ -1374,7 +1375,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     for (i = 0; i < size; i += access_size) {
         if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
-                                    is_write)) {
+                                    is_write, attrs)) {
             return false;
         }
     }
-- 
2.17.1
