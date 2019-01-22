Received: from eggs.gnu.org ([209.51.188.92]:49732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm17j-0007LV-Si
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm17i-0007OT-9E
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:11 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:13810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm17h-0007Kh-Rd
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:10 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 22 Jan 2019 15:53:46 +0000
Message-ID: <20190122155346.26388-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] xen: fix xen-bus state model to allow
 frontend re-connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

There is a flaw in the xen-bus state model. To allow a frontend to re-
connect the backend state of an online XenDevice is transitioned from
Closed to InitWait, but this is currently done unilaterally which is
incorrect. The backend state should remain Closed until the frontend state
transitions to Initialising.

This patch removes the automatic backend state transition from
xen_device_backend_state_changed() and, instead, adds an extra check in
xen_device_frontend_state_changed() to determine whether a frontend is
trying to re-connect to a previously Closed XenDevice. Only if this is
found to be the case is the backend state transitioned from Closed to
InitWait. Note that this transition will be common amongst all XenDevice
classes and hence xen_device_frontend_state_changed() returns immediately
afterwards without calling into the XenDeviceClass frontend_changed()
method.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v2:
 - Fix xl block-detach
---
 hw/xen/xen-bus.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 3aeccec69c..49a725e8c7 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -547,20 +547,15 @@ static void xen_device_backend_changed(void *opaque)
     }
 
     /*
-     * If a backend is still 'online' then its state should be cycled
-     * back round to InitWait in order for a new frontend instance to
-     * connect. This may happen when, for example, a frontend driver is
-     * re-installed or updated.
-     * If a backend is not 'online' then the device should be destroyed.
+     * If a backend is still 'online' then we should leave it alone but,
+     * if a backend is not 'online', then the device should be destroyed
+     * once the state is Closed.
      */
-    if (xendev->backend_online &&
-        xendev->backend_state == XenbusStateClosed) {
-        xen_device_backend_set_state(xendev, XenbusStateInitWait);
-    } else if (!xendev->backend_online &&
-               (xendev->backend_state == XenbusStateClosed ||
-                xendev->backend_state == XenbusStateInitialising ||
-                xendev->backend_state == XenbusStateInitWait ||
-                xendev->backend_state == XenbusStateUnknown)) {
+    if (!xendev->backend_online &&
+        (xendev->backend_state == XenbusStateClosed ||
+         xendev->backend_state == XenbusStateInitialising ||
+         xendev->backend_state == XenbusStateInitWait ||
+         xendev->backend_state == XenbusStateUnknown)) {
         Error *local_err = NULL;
 
         if (!xen_backend_try_device_destroy(xendev, &local_err)) {
@@ -715,6 +710,17 @@ static void xen_device_frontend_changed(void *opaque)
 
     xen_device_frontend_set_state(xendev, state);
 
+    if (state == XenbusStateInitialising &&
+        xendev->backend_state == XenbusStateClosed &&
+        xendev->backend_online) {
+        /*
+         * The frontend is re-initializing so switch back to
+         * InitWait.
+         */
+        xen_device_backend_set_state(xendev, XenbusStateInitWait);
+        return;
+    }
+
     if (xendev_class->frontend_changed) {
         Error *local_err = NULL;
 
-- 
2.20.1.2.gb21ebb6
