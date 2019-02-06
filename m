Received: from eggs.gnu.org ([209.51.188.92]:48908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1grKxA-0007xA-Ij
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1grKx2-0003hj-It
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:01:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1grKx0-0003gd-Ri
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:01:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA077E6A88
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 11:01:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Feb 2019 11:00:41 +0000
Message-Id: <20190206110044.21662-7-dgilbert@redhat.com>
In-Reply-To: <20190206110044.21662-1-dgilbert@redhat.com>
References: <20190206110044.21662-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/9] virtio-net: Allow qemu_announce_self to
 trigger virtio announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com, eblake@redhat.com, mst@redhat.com
Cc: germano@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Expose the virtio-net self announcement capability and allow
qemu_announce_self() to call it.

These announces are caused by something external (i.e. the
announce-self command); they won't trigger if the migration
counter is triggering announces at the same time.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/trace-events |  1 +
 hw/net/virtio-net.c | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index b237d9024c..3a86004154 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -361,6 +361,7 @@ sunhme_rx_desc(uint32_t addr, int offset, uint32_t st=
atus, int len, int cr, int
 sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
=20
 # hw/net/virtio-net.c
+virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b50f86d230..ed0fa97b88 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -162,15 +162,42 @@ static bool virtio_net_started(VirtIONet *n, uint8_=
t status)
         (n->status & VIRTIO_NET_S_LINK_UP) && vdev->vm_running;
 }
=20
+static void virtio_net_announce_notify(VirtIONet *net)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(net);
+    trace_virtio_net_announce_notify();
+
+    net->status |=3D VIRTIO_NET_S_ANNOUNCE;
+    virtio_notify_config(vdev);
+}
+
 static void virtio_net_announce_timer(void *opaque)
 {
     VirtIONet *n =3D opaque;
-    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
     trace_virtio_net_announce_timer(n->announce_timer.round);
=20
     n->announce_timer.round--;
-    n->status |=3D VIRTIO_NET_S_ANNOUNCE;
-    virtio_notify_config(vdev);
+    virtio_net_announce_notify(n);
+}
+
+static void virtio_net_announce(NetClientState *nc)
+{
+    VirtIONet *n =3D qemu_get_nic_opaque(nc);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
+
+    /*
+     * Make sure the virtio migration announcement timer isn't running
+     * If it is, let it trigger announcement so that we do not cause
+     * confusion.
+     */
+    if (n->announce_timer.round) {
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
+        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
+            virtio_net_announce_notify(n);
+    }
 }
=20
 static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
@@ -2568,6 +2595,7 @@ static NetClientInfo net_virtio_info =3D {
     .receive =3D virtio_net_receive,
     .link_status_changed =3D virtio_net_set_link_status,
     .query_rx_filter =3D virtio_net_query_rxfilter,
+    .announce =3D virtio_net_announce,
 };
=20
 static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int id=
x)
@@ -2709,6 +2737,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
     qemu_announce_timer_reset(&n->announce_timer, migrate_announce_param=
s(),
                               QEMU_CLOCK_VIRTUAL,
                               virtio_net_announce_timer, n);
+    n->announce_timer.round =3D 0;
=20
     if (n->netclient_type) {
         /*
--=20
2.20.1
