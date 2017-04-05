Received: from eggs.gnu.org ([2001:4830:134:3::10]:51733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9M-0003qa-BV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9J-0006g7-AW
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:8130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvu9I-0006fS-SZ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:37 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Wed,  5 Apr 2017 16:21:30 -0700
Message-Id: <1491434491-1765-3-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] move xen-hvm.c to hw/i386/xen/
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

move xen-hvm.c to hw/i386/xen/


Signed-off -by: Anthony Xu <anthony.xu@intel.com>



---
 Makefile.target                    |  3 +--
 hw/i386/xen/Makefile.objs          |  2 +-
 hw/i386/xen/trace-events           | 11 +++++++++++
 xen-hvm.c => hw/i386/xen/xen-hvm.c |  2 +-
 stubs/Makefile.objs                |  1 +
 xen-hvm-stub.c => stubs/xen-hvm.c  |  0
 trace-events                       | 11 -----------
 7 files changed, 15 insertions(+), 15 deletions(-)
 rename xen-hvm.c => hw/i386/xen/xen-hvm.c (99%)
 rename xen-hvm-stub.c => stubs/xen-hvm.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 48c027f..d5ff0c7 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,8 +150,7 @@ obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # xen support
-obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
-obj-$(call lnot,$(CONFIG_XEN_I386)) += xen-hvm-stub.o
+obj-$(CONFIG_XEN_I386) += xen-mapcache.o
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
index 801a68d..daf4f53 100644
--- a/hw/i386/xen/Makefile.objs
+++ b/hw/i386/xen/Makefile.objs
@@ -1 +1 @@
-obj-y += xen_platform.o xen_apic.o xen_pvdevice.o
+obj-y += xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 321fe60..f25d622 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -4,3 +4,14 @@ xen_platform_log(char *s) "xen platform: %s"
 # hw/i386/xen/xen_pvdevice.c
 xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %"PRIx64")"
 xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
+
+# xen-hvm.c
+xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx, size %#lx"
+xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "%#"PRIx64" size %#lx, log_dirty %i"
+handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p read type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p write type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p pio dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
+cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
+cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
diff --git a/xen-hvm.c b/hw/i386/xen/xen-hvm.c
similarity index 99%
rename from xen-hvm.c
rename to hw/i386/xen/xen-hvm.c
index 5043beb..0892361 100644
--- a/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "exec/address-spaces.h"
 
 #include <xen/hvm/ioreq.h>
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 6c80613..f5b47bf 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -38,3 +38,4 @@ stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
+stub-obj-y += xen-hvm.o
diff --git a/xen-hvm-stub.c b/stubs/xen-hvm.c
similarity index 100%
rename from xen-hvm-stub.c
rename to stubs/xen-hvm.c
diff --git a/trace-events b/trace-events
index b07a09b..4e14487 100644
--- a/trace-events
+++ b/trace-events
@@ -48,17 +48,6 @@ spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
 spice_vmc_event(int event) "spice vmc event %d"
 
-# xen-hvm.c
-xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx, size %#lx"
-xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "%#"PRIx64" size %#lx, log_dirty %i"
-handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p read type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p write type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p pio dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
-cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
-cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-
 # xen-mapcache.c
 xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
 xen_remap_bucket(uint64_t index) "index %#"PRIx64
-- 
1.8.3.1
