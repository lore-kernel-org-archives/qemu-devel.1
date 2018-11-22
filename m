Received: from eggs.gnu.org ([2001:4830:134:3::10]:45889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiY0-0002xR-8l
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiXy-0001i8-Uc
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:08 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPiXy-0001fh-MO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:06 -0500
Received: by mail-pl1-x641.google.com with SMTP id s5-v6so8764435plq.11
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 22:33:06 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 22:32:51 -0800
Message-Id: <1542868372-2602-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
References: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw: pc: use TYPE_XXX instead of constant
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/i386/pc.c         | 9 +++------
 hw/sparc64/sun4u.c   | 2 +-
 include/hw/i386/pc.h | 7 +++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dba..5d3fd86b83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -502,9 +502,6 @@ void pc_cmos_init(PCMachineState *pcms,
     qemu_register_reset(pc_cmos_init_late, &arg);
 }
 
-#define TYPE_PORT92 "port92"
-#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
-
 /* port 92 stuff: could be split off */
 typedef struct Port92State {
     ISADevice parent_obj;
@@ -1543,10 +1540,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         fdctrl_init_isa(isa_bus, fd);
     }
 
-    i8042 = isa_create_simple(isa_bus, "i8042");
+    i8042 = isa_create_simple(isa_bus, TYPE_I8042);
     if (!no_vmport) {
         vmport_init(isa_bus);
-        vmmouse = isa_try_create(isa_bus, "vmmouse");
+        vmmouse = isa_try_create(isa_bus, TYPE_VMMOUSE);
     } else {
         vmmouse = NULL;
     }
@@ -1555,7 +1552,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e4e9..c49a416b95 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -305,7 +305,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
 
     /* Keyboard */
-    isa_create_simple(s->isa_bus, "i8042");
+    isa_create_simple(s->isa_bus, TYPE_I8042);
 
     /* Floppy */
     for (i = 0; i < MAX_FD; i++) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..29db770d86 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -169,6 +169,13 @@ void gsi_handler(void *opaque, int n, int level);
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
+#define TYPE_PORT92 "port92"
+#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
+
+/* vmmouse.c */
+#define TYPE_VMMOUSE "vmmouse"
+#define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
+
 static inline void vmport_init(ISABus *bus)
 {
     isa_create_simple(bus, TYPE_VMPORT);
-- 
2.11.0
