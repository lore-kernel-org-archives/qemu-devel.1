Received: from eggs.gnu.org ([209.51.188.92]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjXM-0000Yg-PY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjXF-0004ec-Pg
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:04:44 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Feb 2019 15:02:55 +0100
Message-Id: <20190218140301.197408-5-sgarzare@redhat.com>
In-Reply-To: <20190218140301.197408-1-sgarzare@redhat.com>
References: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/10] virtio-net: make VirtIOFeature usable
 for other virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>

In order to use VirtIOFeature also in other virtio devices, we move
its declaration and the endof() macro (renamed in virtio_endof())
in virtio.h.
We add virtio_feature_get_config_size() function to iterate the array
of VirtIOFeature and to return the config size depending on the
features enabled. (as virtio_net_set_config_size() did)

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/net/virtio-net.c        | 31 +++++++------------------------
 hw/virtio/virtio.c         | 15 +++++++++++++++
 include/hw/virtio/virtio.h | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3f319ef723..6e6b146022 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -82,29 +82,17 @@ static inline __virtio16 *virtio_net_rsc_ext_num_dupa=
cks(
=20
 #endif
=20
-/*
- * Calculate the number of bytes up to and including the given 'field' o=
f
- * 'container'.
- */
-#define endof(container, field) \
-    (offsetof(container, field) + sizeof_field(container, field))
-
-typedef struct VirtIOFeature {
-    uint64_t flags;
-    size_t end;
-} VirtIOFeature;
-
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
-     .end =3D endof(struct virtio_net_config, mac)},
+     .end =3D virtio_endof(struct virtio_net_config, mac)},
     {.flags =3D 1ULL << VIRTIO_NET_F_STATUS,
-     .end =3D endof(struct virtio_net_config, status)},
+     .end =3D virtio_endof(struct virtio_net_config, status)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MQ,
-     .end =3D endof(struct virtio_net_config, max_virtqueue_pairs)},
+     .end =3D virtio_endof(struct virtio_net_config, max_virtqueue_pairs=
)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MTU,
-     .end =3D endof(struct virtio_net_config, mtu)},
+     .end =3D virtio_endof(struct virtio_net_config, mtu)},
     {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
-     .end =3D endof(struct virtio_net_config, duplex)},
+     .end =3D virtio_endof(struct virtio_net_config, duplex)},
     {}
 };
=20
@@ -2580,15 +2568,10 @@ static void virtio_net_guest_notifier_mask(VirtIO=
Device *vdev, int idx,
=20
 static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_featu=
res)
 {
-    int i, config_size =3D 0;
     virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
=20
-    for (i =3D 0; feature_sizes[i].flags !=3D 0; i++) {
-        if (host_features & feature_sizes[i].flags) {
-            config_size =3D MAX(feature_sizes[i].end, config_size);
-        }
-    }
-    n->config_size =3D config_size;
+    n->config_size =3D virtio_feature_get_config_size(feature_sizes,
+                                                    host_features);
 }
=20
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a1ff647a66..2626a895cb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2036,6 +2036,21 @@ int virtio_set_features(VirtIODevice *vdev, uint64=
_t val)
     return ret;
 }
=20
+size_t virtio_feature_get_config_size(VirtIOFeature *feature_sizes,
+                                      uint64_t host_features)
+{
+    size_t config_size =3D 0;
+    int i;
+
+    for (i =3D 0; feature_sizes[i].flags !=3D 0; i++) {
+        if (host_features & feature_sizes[i].flags) {
+            config_size =3D MAX(feature_sizes[i].end, config_size);
+        }
+    }
+
+    return config_size;
+}
+
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07d6d..ce9516236a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -37,6 +37,21 @@ static inline hwaddr vring_align(hwaddr addr,
     return QEMU_ALIGN_UP(addr, align);
 }
=20
+/*
+ * Calculate the number of bytes up to and including the given 'field' o=
f
+ * 'container'.
+ */
+#define virtio_endof(container, field) \
+    (offsetof(container, field) + sizeof_field(container, field))
+
+typedef struct VirtIOFeature {
+    uint64_t flags;
+    size_t end;
+} VirtIOFeature;
+
+size_t virtio_feature_get_config_size(VirtIOFeature *features,
+                                      uint64_t host_features);
+
 typedef struct VirtQueue VirtQueue;
=20
 #define VIRTQUEUE_MAX_SIZE 1024
--=20
2.20.1
