Received: from eggs.gnu.org ([209.51.188.92]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonB2-0004uy-OO
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gonB1-0003IR-Jv
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gonB1-0003IC-Bo
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:33:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FA4581F10
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:33:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 30 Jan 2019 10:32:30 +0000
Message-Id: <20190130103236.18302-4-dgilbert@redhat.com>
In-Reply-To: <20190130103236.18302-1-dgilbert@redhat.com>
References: <20190130103236.18302-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/9] virtio-net: Switch to using announce
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com
Cc: germano@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Switch virtio's self announcement to use the AnnounceTimer.
It keeps it's own AnnounceTimer (per device), and starts running it
using a migration post-load and a virtual clock; that way the
announce happens once the guest is actually running.
The timer uses the migration parameters to set the timing of
the repeats.

Based on earlier patches by myself and
 Vladislav Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/trace-events            |  7 +++++++
 hw/net/virtio-net.c            | 36 ++++++++++++++++++++++------------
 include/hw/virtio/virtio-net.h |  4 ++--
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index 9d49f62fa1..fc800dd606 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -359,3 +359,10 @@ sunhme_rx_filter_reject(void) "rejecting incoming fr=
ame"
 sunhme_rx_filter_accept(void) "accepting incoming frame"
 sunhme_rx_desc(uint32_t addr, int offset, uint32_t status, int len, int =
cr, int nr) "addr 0x%"PRIx32"(+0x%x) status 0x%"PRIx32 " len %d (ring %d/=
%d)"
 sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
+
+# hw/net/virtio-net.c
+virtio_net_announce_timer(int round) "%d"
+virtio_net_handle_announce(int round) "%d"
+virtio_net_post_load_device(void)
+
+
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3f319ef723..b50f86d230 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -21,12 +21,14 @@
 #include "qemu/timer.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
+#include "net/announce.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
+#include "trace.h"
=20
 #define VIRTIO_NET_VM_VERSION    11
=20
@@ -164,8 +166,9 @@ static void virtio_net_announce_timer(void *opaque)
 {
     VirtIONet *n =3D opaque;
     VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
+    trace_virtio_net_announce_timer(n->announce_timer.round);
=20
-    n->announce_counter--;
+    n->announce_timer.round--;
     n->status |=3D VIRTIO_NET_S_ANNOUNCE;
     virtio_notify_config(vdev);
 }
@@ -479,8 +482,8 @@ static void virtio_net_reset(VirtIODevice *vdev)
     n->nobcast =3D 0;
     /* multiqueue is disabled by default */
     n->curr_queues =3D 1;
-    timer_del(n->announce_timer);
-    n->announce_counter =3D 0;
+    timer_del(n->announce_timer.tm);
+    n->announce_timer.round =3D 0;
     n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
=20
     /* Flush any MAC and VLAN filter table state */
@@ -976,13 +979,12 @@ static int virtio_net_handle_vlan_table(VirtIONet *=
n, uint8_t cmd,
 static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
                                       struct iovec *iov, unsigned int io=
v_cnt)
 {
+    trace_virtio_net_handle_announce(n->announce_timer.round);
     if (cmd =3D=3D VIRTIO_NET_CTRL_ANNOUNCE_ACK &&
         n->status & VIRTIO_NET_S_ANNOUNCE) {
         n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
-        if (n->announce_counter) {
-            timer_mod(n->announce_timer,
-                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                      self_announce_delay(n->announce_counter));
+        if (n->announce_timer.round) {
+            qemu_announce_timer_step(&n->announce_timer);
         }
         return VIRTIO_NET_OK;
     } else {
@@ -2298,6 +2300,7 @@ static int virtio_net_post_load_device(void *opaque=
, int version_id)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
     int i, link_down;
=20
+    trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_=
1));
@@ -2334,8 +2337,15 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
=20
     if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
         virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
-        n->announce_counter =3D SELF_ANNOUNCE_ROUNDS;
-        timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUA=
L));
+        qemu_announce_timer_reset(&n->announce_timer, migrate_announce_p=
arams(),
+                                  QEMU_CLOCK_VIRTUAL,
+                                  virtio_net_announce_timer, n);
+        if (n->announce_timer.round) {
+            timer_mod(n->announce_timer.tm,
+                      qemu_clock_get_ms(n->announce_timer.type));
+        } else {
+            qemu_announce_timer_del(&n->announce_timer);
+        }
     }
=20
     return 0;
@@ -2696,8 +2706,9 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status =3D VIRTIO_NET_S_LINK_UP;
-    n->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                     virtio_net_announce_timer, n);
+    qemu_announce_timer_reset(&n->announce_timer, migrate_announce_param=
s(),
+                              QEMU_CLOCK_VIRTUAL,
+                              virtio_net_announce_timer, n);
=20
     if (n->netclient_type) {
         /*
@@ -2760,8 +2771,7 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev, Error **errp)
         virtio_net_del_queue(n, i);
     }
=20
-    timer_del(n->announce_timer);
-    timer_free(n->announce_timer);
+    qemu_announce_timer_del(&n->announce_timer);
     g_free(n->vqs);
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index a1a0be3bea..b96f0c643f 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -17,6 +17,7 @@
 #include "qemu/units.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "hw/virtio/virtio.h"
+#include "net/announce.h"
=20
 #define TYPE_VIRTIO_NET "virtio-net-device"
 #define VIRTIO_NET(obj) \
@@ -181,8 +182,7 @@ struct VirtIONet {
     char *netclient_name;
     char *netclient_type;
     uint64_t curr_guest_offloads;
-    QEMUTimer *announce_timer;
-    int announce_counter;
+    AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
 };
--=20
2.20.1
