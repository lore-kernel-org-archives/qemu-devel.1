Received: from eggs.gnu.org ([2001:4830:134:3::10]:58682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlun-0006gS-TI
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluk-00074W-1M
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:41 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:41 +0200
Message-Id: <1533586484-5737-14-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 13/16] qdev: export qbus_find_recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

We intend to create the virtio-iommu from the virt machine
realize() code and not by passing the -device virtio-iommu-device
option. That way the instantiation of the virtio-iommu can
depend on a virt machine option, as it is currently done for
the smmuv3 iommu.

Its parent bus, the virtio-bus will need to be located and
set. We intend to locate it by using qbus_find_recursive().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/qdev-core.h | 3 +++
 qdev-monitor.c         | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8..f359c52 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -377,6 +377,9 @@ void qbus_reset_all_fn(void *opaque);
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
 
+BusState *qbus_find_recursive(BusState *bus, const char *name,
+                              const char *bus_typename);
+
 char *qdev_get_fw_dev_path(DeviceState *dev);
 char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 61e0300..666e439 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -410,8 +410,8 @@ static inline bool qbus_is_full(BusState *bus)
  * If more than one exists, prefer one that can take another device.
  * Return the bus if found, else %NULL.
  */
-static BusState *qbus_find_recursive(BusState *bus, const char *name,
-                                     const char *bus_typename)
+BusState *qbus_find_recursive(BusState *bus, const char *name,
+                              const char *bus_typename)
 {
     BusChild *kid;
     BusState *pick, *child, *ret;
@@ -567,7 +567,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         error_setg(errp, QERR_MISSING_PARAMETER, "driver");
         return NULL;
     }
-
     /* find driver */
     dc = qdev_get_device_class(&driver, errp);
     if (!dc) {
-- 
2.5.5
