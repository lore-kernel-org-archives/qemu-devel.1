Received: from eggs.gnu.org ([2001:4830:134:3::10]:51728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9M-0003qX-Ag
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9J-0006gE-EA
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:36405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvu9J-0006ft-1p
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:37 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Wed,  5 Apr 2017 16:21:31 -0700
Message-Id: <1491434491-1765-4-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 3/3] move xen-mapcache.c to hw/i386/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, pbonzini@redhat.com, eblake@redhat.com, Anthony Xu <anthony.xu@intel.com>


move xen-mapcache.c to hw/i386/xen/

Signed-off -by: Anthony Xu <anthony.xu@intel.com>



---
 Makefile.target                              | 3 ---
 default-configs/i386-softmmu.mak             | 1 -
 default-configs/x86_64-softmmu.mak           | 1 -
 hw/i386/xen/Makefile.objs                    | 2 +-
 hw/i386/xen/trace-events                     | 6 ++++++
 xen-mapcache.c => hw/i386/xen/xen-mapcache.c | 2 +-
 trace-events                                 | 5 -----
 7 files changed, 8 insertions(+), 12 deletions(-)
 rename xen-mapcache.c => hw/i386/xen/xen-mapcache.c (99%)

diff --git a/Makefile.target b/Makefile.target
index d5ff0c7..a535980 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -149,9 +149,6 @@ obj-y += dump.o
 obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
-# xen support
-obj-$(CONFIG_XEN_I386) += xen-mapcache.o
-
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 029e952..d2ab2f6 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -39,7 +39,6 @@ CONFIG_TPM_TIS=$(CONFIG_TPM)
 CONFIG_MC146818RTC=y
 CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
-CONFIG_XEN_I386=$(CONFIG_XEN)
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_VMPORT=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index d1d7432..9bde2f1 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -39,7 +39,6 @@ CONFIG_TPM_TIS=$(CONFIG_TPM)
 CONFIG_MC146818RTC=y
 CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
-CONFIG_XEN_I386=$(CONFIG_XEN)
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_VMPORT=y
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
index daf4f53..be9d10c 100644
--- a/hw/i386/xen/Makefile.objs
+++ b/hw/i386/xen/Makefile.objs
@@ -1 +1 @@
-obj-y += xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o
+obj-y += xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o xen-mapcache.o
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index f25d622..547438d 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -15,3 +15,9 @@ cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64
 cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
 cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
 cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+
+# xen-mapcache.c
+xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
+xen_remap_bucket(uint64_t index) "index %#"PRIx64
+xen_map_cache_return(void* ptr) "%p"
+
diff --git a/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
similarity index 99%
rename from xen-mapcache.c
rename to hw/i386/xen/xen-mapcache.c
index 1a96d2e..31debdf 100644
--- a/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -19,7 +19,7 @@
 #include <xen/hvm/params.h>
 
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include "trace.h"
 
 
 //#define MAPCACHE_DEBUG
diff --git a/trace-events b/trace-events
index 4e14487..e582d63 100644
--- a/trace-events
+++ b/trace-events
@@ -48,11 +48,6 @@ spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
 spice_vmc_event(int event) "spice vmc event %d"
 
-# xen-mapcache.c
-xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
-xen_remap_bucket(uint64_t index) "index %#"PRIx64
-xen_map_cache_return(void* ptr) "%p"
-
 # monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
-- 
1.8.3.1
