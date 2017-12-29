Received: from eggs.gnu.org ([2001:4830:134:3::10]:33233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCY-0003ou-2p
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCX-0000aB-9U
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1eUrCX-0000Z1-34
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:41 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 29 Dec 2017 10:42:06 +0100
Message-Id: <20171229094206.14512-3-slp@redhat.com>
In-Reply-To: <20171229094206.14512-1-slp@redhat.com>
References: <20171229094206.14512-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] pvpanic: add PVPANIC_ABORT_PROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>

PVPANIC_ABORT_PROP is a boolean to instruct pvpanic to request an
abort() of the process when the Guest signals a panic.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/misc/pvpanic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 4fb074df06..c901458297 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -28,7 +28,7 @@
 #define ISA_PVPANIC_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
 
-static void handle_event(int event)
+static void handle_event(int event, bool abort_on_panic)
 {
     static bool logged;
 
@@ -38,7 +38,7 @@ static void handle_event(int event)
     }
 
     if (event & PVPANIC_PANICKED) {
-        qemu_system_guest_panicked(NULL, false);
+        qemu_system_guest_panicked(NULL, abort_on_panic);
         return;
     }
 }
@@ -50,6 +50,7 @@ typedef struct PVPanicState {
 
     MemoryRegion io;
     uint16_t ioport;
+    bool abort_on_panic;
 } PVPanicState;
 
 /* return supported events on read */
@@ -61,7 +62,8 @@ static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, unsigned size)
 static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned size)
 {
-    handle_event(val);
+    PVPanicState *s = opaque;
+    handle_event(val, s->abort_on_panic);
 }
 
 static const MemoryRegionOps pvpanic_ops = {
@@ -100,6 +102,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
 }
 
 #define PVPANIC_IOPORT_PROP "ioport"
+#define PVPANIC_ABORT_PROP "abort"
 
 uint16_t pvpanic_port(void)
 {
@@ -112,6 +115,7 @@ uint16_t pvpanic_port(void)
 
 static Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicState, ioport, 0x505),
+    DEFINE_PROP_BOOL(PVPANIC_ABORT_PROP, PVPanicState, abort_on_panic, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.3
