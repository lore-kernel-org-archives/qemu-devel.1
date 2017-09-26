Received: from eggs.gnu.org ([2001:4830:134:3::10]:53848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dwooL-0001L3-Dx
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dwooG-0004hy-Fu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:18:01 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 26 Sep 2017 14:17:50 +0200
Message-Id: <20170926121750.9015-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: select default vty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

SLOF uses the "/chosen/linux,stdout-path" variable to
choose its console. This variable is provided by QEMU.
QEMU selects the spapr-vty using the "reg" property:
it takes the vty with the lowest reg number.
This patch allows the user to define "linux,stdout-path"
from the command line by adding a keyword 'default' to
the spapr-vty device.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/char/spapr_vty.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 0fa416ca6b..aa56a9a6cb 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -15,6 +15,7 @@ typedef struct VIOsPAPRVTYDevice {
     CharBackend chardev;
     uint32_t in, out;
     uint8_t buf[VTERM_BUFSIZE];
+    bool is_default;
 } VIOsPAPRVTYDevice;
 
 #define TYPE_VIO_SPAPR_VTY_DEVICE "spapr-vty"
@@ -153,6 +154,7 @@ void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev)
 static Property spapr_vty_properties[] = {
     DEFINE_SPAPR_PROPERTIES(VIOsPAPRVTYDevice, sdev),
     DEFINE_PROP_CHR("chardev", VIOsPAPRVTYDevice, chardev),
+    DEFINE_PROP_BOOL("default", VIOsPAPRVTYDevice, is_default, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -194,11 +196,13 @@ static const TypeInfo spapr_vty_info = {
 VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bus)
 {
     VIOsPAPRDevice *sdev, *selected;
+    VIOsPAPRVTYDevice *dev;
     BusChild *kid;
 
     /*
      * To avoid the console bouncing around we want one VTY to be
-     * the "default". We haven't really got anything to go on, so
+     * the "default". If the user doesn't provide the information
+     * we haven't really got anything to go on, so
      * arbitrarily choose the one with the lowest reg value.
      */
 
@@ -213,6 +217,13 @@ VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bus)
 
         sdev = VIO_SPAPR_DEVICE(iter);
 
+        /* The user can provide the default console to use */
+
+        dev = VIO_SPAPR_VTY_DEVICE(sdev);
+        if (dev->is_default) {
+            return sdev;
+        }
+
         /* First VTY we've found, so it is selected for now */
         if (!selected) {
             selected = sdev;
-- 
2.13.5
