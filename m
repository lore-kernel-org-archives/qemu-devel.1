Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX91n-0000Og-Lx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX91m-0005Pb-VB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:37:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX91m-0005Om-Nr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:37:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:37:42 +0100
Message-Id: <1500309462-12792-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10] hw/display/sm501: Don't use
 vmstate_register_ram_global()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-trivial@nongnu.org

The sm501 device uses vmstate_register_ram_global() to register its
memory region for migration.  This means it gets a name that is
assumed to be global to the whole system, which in turn means that if
you create two of the device we assert because of the duplication:

qemu-system-ppc -device sm501 -device sm501
RAMBlock "sm501.local" already registered, abort!
Aborted (core dumped)

Changing this to just use memory_region_init_ram()'s automatic
registration of the memory region with a device-local name fixes
this.  The downside is that it breaks migration compatibility, but
luckily we only added migration support to this device in the 2.10
release cycle so we haven't released a QEMU version with the broken
implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Recent refactoring that renamed the old "memory_region_init_ram"
to memory_region_init_ram_nomigrate" made this bug a bit easier
to find via grep...

 hw/display/sm501.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index af792c5..9aa515b 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1578,9 +1578,8 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                   s->local_mem_size_index);
 
     /* local memory */
-    memory_region_init_ram_nomigrate(&s->local_mem_region, OBJECT(dev), "sm501.local",
+    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
                            get_local_mem_size(s), &error_fatal);
-    vmstate_register_ram_global(&s->local_mem_region);
     memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
     s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
 
-- 
2.7.4
