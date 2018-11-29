Received: from eggs.gnu.org ([2001:4830:134:3::10]:48110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEK9-0005HI-PJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEK8-0007Pq-R6
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:13 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gSEK8-0007OQ-IC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:12 -0500
Received: by mail-pg1-x542.google.com with SMTP id v28so347774pgk.10
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:53:12 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 28 Nov 2018 20:52:11 -0800
Message-Id: <1543467132-2873-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/2] hw: pc: use TYPE_XXX instead of
 constant strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: darren.kenny@oracle.com, armbru@redhat.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

TYPE_VMMOUSE is defined in vmmouse.c currently, move it
to pc.h in order to use it in pc.c.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/i386/pc.c         | 6 +++---
 hw/i386/vmmouse.c    | 1 -
 include/hw/i386/pc.h | 3 +++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dba..73c7b777a0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1543,10 +1543,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
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
@@ -1555,7 +1555,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 5d2d278be4..4412eaf604 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -52,7 +52,6 @@
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
 
-#define TYPE_VMMOUSE "vmmouse"
 #define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
 
 typedef struct VMMouseState
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..c708ac9265 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -169,6 +169,9 @@ void gsi_handler(void *opaque, int n, int level);
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
+/* vmmouse.c */
+#define TYPE_VMMOUSE "vmmouse"
+
 static inline void vmport_init(ISABus *bus)
 {
     isa_create_simple(bus, TYPE_VMPORT);
-- 
2.11.0
