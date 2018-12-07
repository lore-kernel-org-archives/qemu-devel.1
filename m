Received: from eggs.gnu.org ([2001:4830:134:3::10]:51485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gVJD2-0004WT-9s
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gVJD1-0001tq-1o
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:42:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gVJD0-0001qV-RL
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:42:34 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 07 Dec 2018 09:42:11 -0700
Message-ID: <154420093096.27028.2850537601140155413.stgit@gimli.home>
In-Reply-To: <154419994154.27028.14774494243513273923.stgit@gimli.home>
References: <154419994154.27028.14774494243513273923.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-4.0 PATCH v4 9/9] pcie: Fast PCIe root ports for
 new machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Auger <eric.auger@redhat.com>

Change the default speed and width for new machine types to the
fastest and widest currently supported.  This should be compatible to
the PCIe 4.0 spec.  Pre-QEMU-4.0 machine types remain at 2.5GT/s, x1
width.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c |    4 ++--
 include/hw/compat.h                |   10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index ca5418a89dd2..9766edb44596 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -125,9 +125,9 @@ static Property gen_rp_props[] = {
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
                      res_reserve.mem_pref_64, -1),
     DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
-                                speed, PCIE_LINK_SPEED_2_5),
+                                speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
-                                width, PCIE_LINK_WIDTH_1),
+                                width, PCIE_LINK_WIDTH_32),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 70958328fe7a..3ca85b037c04 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,15 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_3_1 \
-    /* empty */
+    {\
+        .driver   = "pcie-root-port",\
+        .property = "x-speed",\
+        .value    = "2_5",\
+    },{\
+        .driver   = "pcie-root-port",\
+        .property = "x-width",\
+        .value    = "1",\
+    },
 
 #define HW_COMPAT_3_0 \
     /* empty */
