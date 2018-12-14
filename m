Received: from eggs.gnu.org ([2001:4830:134:3::10]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqmB-0005lT-La
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm5-0002TJ-TT
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:21 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqm5-0001B5-EZ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:17 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:09 +0000
Message-ID: <20181214165657.749-6-rkagan@virtuozzo.com>
References: <20181214165657.749-1-rkagan@virtuozzo.com>
In-Reply-To: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 5/5] virtio: expose negotiated features in
 r/o properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

Make virtio features acknowledged by the guest visible through QOM as
read-only properties.  One potential usecase of this is debugging;
another is when the upper layer needs to do something only when/if the
guest has acknowledged the support for a feature (e.g. hot-plug a VFIO
device once the guest claims VIRTIO_NET_F_STANDBY support).

Since most of the feature bits already have associated properties for
host_features, reuse those definitions by creating a new macro that
combines the original definition for the host_features bit property and
a definition of a read-only guest_features bit property with the same
name prefixed with "negotiated-".  For the features which have no
associated host_features bit property, only the latter is defined.

Note #1: the macro is somewhat fragile as it produces two values
separated by a comma, to be used for initializing consecutive elements
in an array
Note #2: due to note #1, it fails checkpatch.
Note #3: it is also somewhat fragile as it assumes its first argument to
be a string literal
Note #4: for RFC purposes I only converted some virtio devices.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/virtio/virtio-scsi.h |  2 +-
 include/hw/virtio/virtio.h      |  8 +++
 hw/char/virtio-serial-bus.c     |  6 ++-
 hw/net/virtio-net.c             | 88 ++++++++++++++++++---------------
 hw/scsi/virtio-scsi.c           |  4 +-
 hw/virtio/virtio.c              | 20 ++++----
 6 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scs=
i.h
index 4c0bcdb788..9b412bd2c3 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -86,7 +86,7 @@ typedef struct VirtIOSCSI {
     bool dataplane_starting;
     bool dataplane_stopping;
     bool dataplane_fenced;
-    uint32_t host_features;
+    uint64_t host_features;
 } VirtIOSCSI;
=20
 typedef struct VirtIOSCSIReq {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index cea356efed..a4690e6176 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -254,6 +254,14 @@ typedef struct virtio_input_conf virtio_input_conf;
 typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
=20
+#define DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED(_name, _bit)     \
+    DEFINE_PROP_BIT64_RO("negotiated-" _name, VirtIODevice,   \
+                         guest_features, _bit)
+
+#define DEFINE_VIRTIO_FEATURE_BIT(_name, _state, _field, _bit, _defval) \
+    DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval),            \
+    DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED(_name, _bit)
+
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 04e3ebe352..07bf729891 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1154,8 +1154,10 @@ static const VMStateDescription vmstate_virtio_conso=
le =3D {
 static Property virtio_serial_properties[] =3D {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_po=
rts,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
+    DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED("multiport",
+                                         VIRTIO_CONSOLE_F_MULTIPORT),
+    DEFINE_VIRTIO_FEATURE_BIT("emergency-write", VirtIOSerial, host_featur=
es,
+                              VIRTIO_CONSOLE_F_EMERG_WRITE, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 385b1a03e9..d4df3394ee 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2144,46 +2144,54 @@ static const VMStateDescription vmstate_virtio_net =
=3D {
 };
=20
 static Property virtio_net_properties[] =3D {
-    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
-                    VIRTIO_NET_F_CSUM, true),
-    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_CSUM, true),
-    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, t=
rue),
-    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_TSO4, true),
-    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_TSO6, true),
-    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_ECN, true),
-    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_UFO, true),
-    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_ANNOUNCE, true),
-    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_TSO4, true),
-    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_TSO6, true),
-    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_ECN, true),
-    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_UFO, true),
-    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
-                    VIRTIO_NET_F_MRG_RXBUF, true),
-    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
-                    VIRTIO_NET_F_STATUS, true),
-    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_VQ, true),
-    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_RX, true),
-    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_VLAN, true),
-    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_RX_EXTRA, true),
-    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_MAC_ADDR, true),
-    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
-    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, fal=
se),
+    DEFINE_VIRTIO_FEATURE_BIT("csum", VirtIONet, host_features,
+                              VIRTIO_NET_F_CSUM, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_csum", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_CSUM, true),
+    DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED("mtu",
+                                         VIRTIO_NET_F_MTU),
+    DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED("mac",
+                                         VIRTIO_NET_F_MAC),
+    DEFINE_VIRTIO_FEATURE_BIT("gso", VirtIONet, host_features,
+                              VIRTIO_NET_F_GSO, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_tso4", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_TSO4, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_tso6", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_TSO6, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_ecn", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_ECN, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_ufo", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_UFO, true),
+    DEFINE_VIRTIO_FEATURE_BIT("guest_announce", VirtIONet, host_features,
+                              VIRTIO_NET_F_GUEST_ANNOUNCE, true),
+    DEFINE_VIRTIO_FEATURE_BIT("host_tso4", VirtIONet, host_features,
+                              VIRTIO_NET_F_HOST_TSO4, true),
+    DEFINE_VIRTIO_FEATURE_BIT("host_tso6", VirtIONet, host_features,
+                              VIRTIO_NET_F_HOST_TSO6, true),
+    DEFINE_VIRTIO_FEATURE_BIT("host_ecn", VirtIONet, host_features,
+                              VIRTIO_NET_F_HOST_ECN, true),
+    DEFINE_VIRTIO_FEATURE_BIT("host_ufo", VirtIONet, host_features,
+                              VIRTIO_NET_F_HOST_UFO, true),
+    DEFINE_VIRTIO_FEATURE_BIT("mrg_rxbuf", VirtIONet, host_features,
+                              VIRTIO_NET_F_MRG_RXBUF, true),
+    DEFINE_VIRTIO_FEATURE_BIT("status", VirtIONet, host_features,
+                              VIRTIO_NET_F_STATUS, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_vq", VirtIONet, host_features,
+                              VIRTIO_NET_F_CTRL_VQ, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_rx", VirtIONet, host_features,
+                              VIRTIO_NET_F_CTRL_RX, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_vlan", VirtIONet, host_features,
+                              VIRTIO_NET_F_CTRL_VLAN, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_rx_extra", VirtIONet, host_features,
+                              VIRTIO_NET_F_CTRL_RX_EXTRA, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_mac_addr", VirtIONet, host_features,
+                              VIRTIO_NET_F_CTRL_MAC_ADDR, true),
+    DEFINE_VIRTIO_FEATURE_BIT("ctrl_guest_offloads", VirtIONet, host_featu=
res,
+                              VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
+    DEFINE_VIRTIO_FEATURE_BIT("mq", VirtIONet, host_features,
+                              VIRTIO_NET_F_MQ, false),
+    DEFINE_VIRTIO_FEATURE_BIT_NEGOTIATED("speed_duplex",
+                                         VIRTIO_NET_F_SPEED_DUPLEX),
     DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
     DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
                        TX_TIMER_INTERVAL),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..6272faa180 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -923,9 +923,9 @@ static Property virtio_scsi_properties[] =3D {
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_=
lun,
                                                   128),
-    DEFINE_PROP_BIT("hotplug", VirtIOSCSI, host_features,
+    DEFINE_VIRTIO_FEATURE_BIT("hotplug", VirtIOSCSI, host_features,
                                            VIRTIO_SCSI_F_HOTPLUG, true),
-    DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
+    DEFINE_VIRTIO_FEATURE_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true=
),
     DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
                      TYPE_IOTHREAD, IOThread *),
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 99d396c516..2020327eb8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2601,16 +2601,16 @@ static void virtio_device_instance_finalize(Object =
*obj)
 }
=20
 static Property virtio_properties[] =3D {
-    DEFINE_PROP_BIT64("indirect_desc", VirtIODevice, host_features,
-                      VIRTIO_RING_F_INDIRECT_DESC, true),
-    DEFINE_PROP_BIT64("event_idx", VirtIODevice, host_features,
-                      VIRTIO_RING_F_EVENT_IDX, true),
-    DEFINE_PROP_BIT64("notify_on_empty", VirtIODevice, host_features,
-                      VIRTIO_F_NOTIFY_ON_EMPTY, true),
-    DEFINE_PROP_BIT64("any_layout", VirtIODevice, host_features,
-                      VIRTIO_F_ANY_LAYOUT, true),
-    DEFINE_PROP_BIT64("iommu_platform", VirtIODevice, host_features,
-                      VIRTIO_F_IOMMU_PLATFORM, false),
+    DEFINE_VIRTIO_FEATURE_BIT("indirect_desc", VirtIODevice, host_features=
,
+                              VIRTIO_RING_F_INDIRECT_DESC, true),
+    DEFINE_VIRTIO_FEATURE_BIT("event_idx", VirtIODevice, host_features,
+                              VIRTIO_RING_F_EVENT_IDX, true),
+    DEFINE_VIRTIO_FEATURE_BIT("notify_on_empty", VirtIODevice, host_featur=
es,
+                              VIRTIO_F_NOTIFY_ON_EMPTY, true),
+    DEFINE_VIRTIO_FEATURE_BIT("any_layout", VirtIODevice, host_features,
+                              VIRTIO_F_ANY_LAYOUT, true),
+    DEFINE_VIRTIO_FEATURE_BIT("iommu_platform", VirtIODevice, host_feature=
s,
+                              VIRTIO_F_IOMMU_PLATFORM, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.19.2
