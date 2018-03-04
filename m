Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1esTyK-0004oj-UW
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 08:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1esTyH-0006VG-Sv
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 08:46:41 -0500
From: Nia Alarie <nia.alarie@gmail.com>
Date: Sun,  4 Mar 2018 13:45:48 +0000
Message-Id: <20180304134548.19498-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH] s390x/sclpconsole: Remove dead code - make
 _error functions void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, Nia Alarie <nia.alarie@gmail.com>

These functions always return 0. By changing their return type to
void, some dead code can be removed.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 hw/char/sclpconsole-lm.c          | 3 +--
 hw/char/sclpconsole.c             | 3 +--
 hw/s390x/event-facility.c         | 6 +-----
 hw/s390x/virtio-ccw.c             | 6 +++---
 hw/s390x/virtio-ccw.h             | 2 +-
 include/hw/s390x/event-facility.h | 2 +-
 6 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c500bdaf29..7a02db54b8 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -318,9 +318,8 @@ static int console_init(SCLPEvent *event)
     return 0;
 }
 
-static int console_exit(SCLPEvent *event)
+static void console_exit(SCLPEvent *event)
 {
-    return 0;
 }
 
 static void console_reset(DeviceState *dev)
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index d0265dfa7a..e2a80dd2dd 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -246,9 +246,8 @@ static void console_reset(DeviceState *dev)
    scon->notify = false;
 }
 
-static int console_exit(SCLPEvent *event)
+static void console_exit(SCLPEvent *event)
 {
-    return 0;
 }
 
 static Property console_properties[] = {
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 155a69467b..4263d28012 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -436,11 +436,7 @@ static void event_unrealize(DeviceState *qdev, Error **errp)
     SCLPEvent *event = SCLP_EVENT(qdev);
     SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
     if (child->exit) {
-        int rc = child->exit(event);
-        if (rc < 0) {
-            error_setg(errp, "SCLP event exit failed.");
-            return;
-        }
+        child->exit(event);
     }
 }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8f7fbc2ab7..0773818a82 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -752,7 +752,7 @@ out_err:
     g_free(sch);
 }
 
-static int virtio_ccw_exit(VirtioCcwDevice *dev)
+static void virtio_ccw_exit(VirtioCcwDevice *dev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
@@ -765,7 +765,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
         release_indicator(&dev->routes.adapter, dev->indicators);
         dev->indicators = NULL;
     }
-    return 0;
 }
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
@@ -1710,7 +1709,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    return _info->exit(_dev);
+    _info->exit(_dev);
+    return 0;
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3905f3a3d6..8ffe7fe095 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
 typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
-    int (*exit)(VirtioCcwDevice *dev);
+    void (*exit)(VirtioCcwDevice *dev);
 } VirtIOCCWDeviceClass;
 
 /* Performance improves when virtqueue kick processing is decoupled from the
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 5119b9b7f0..833f12a5e7 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -174,7 +174,7 @@ typedef struct SCLPEvent {
 typedef struct SCLPEventClass {
     DeviceClass parent_class;
     int (*init)(SCLPEvent *event);
-    int (*exit)(SCLPEvent *event);
+    void (*exit)(SCLPEvent *event);
 
     /* get SCLP's send mask */
     unsigned int (*get_send_mask)(void);
-- 
2.16.2
