Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8Te2-0001Ye-2q
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8Tdz-0004nv-Fk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:35:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d8Tdz-0004nd-AV
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:35:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 10 May 2017 17:34:53 +0200
Message-Id: <1494430493-23119-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/i386: Deprecate the machines pc-0.10 to
 pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com, berrange@redhat.com, dgilbert@redhat.com

We don't want to carry along old machine types forever. If we are able to
remove the pc machines up to 0.13 one day for example, this would allow
us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
BARs directly to low memory). Everything up to pc-1.2 is also known to
have issues with migration.  So let's start with a deprecation message
for the old machine types so that the (hopefully) few users of these old
systems start switching over to newer machine types instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Even if we mark all these old machines as deprecated, this ofcourse
 doesn't mean that we also have to remove them all at once later when we
 decide to finally really remove some. We could then also start by removing
 0.10 and 0.11 only, for example (since there should really be no users left
 for these), or only up to 0.13 (to be able to kill rombar=0).

 v2:
 - Deprecate machines up to pc-1.2

 hw/i386/pc_piix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..aace378 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -38,6 +38,7 @@
 #include "sysemu/kvm.h"
 #include "hw/kvm/clock.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "hw/sysbus.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/block-backend.h"
@@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *pci_memory;
     MemoryRegion *rom_memory;
     ram_addr_t lowmem;
+    char *mc_name = MACHINE_CLASS(pcmc)->name;
+
+    /* Machines pc-0.10 up to pc-1.2 are considered as deprecated */
+    if (!qtest_enabled() && (!strncmp(mc_name, "pc-0.", 5)
+        || (!strncmp(mc_name, "pc-1.", 5) && mc_name[5] < '3'))) {
+        error_report("Machine type '%s' is deprecated, "
+                     "please use a newer type instead", mc_name);
+    }
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
-- 
1.8.3.1
