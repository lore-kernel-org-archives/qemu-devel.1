Received: from eggs.gnu.org ([209.51.188.92]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE7x-0004Ia-LH
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE7v-0007fS-IU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:41 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 31 Jan 2019 16:19:11 +0100
Message-Id: <20190131151914.164903-3-sgarzare@redhat.com>
In-Reply-To: <20190131151914.164903-1-sgarzare@redhat.com>
References: <20190131151914.164903-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/5] virtio-blk: add "discard-wzeroes"
 boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

In order to avoid migration issues, we enable DISCARD and
WRITE ZEROES features only for machine type >=3D 4.0

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c          | 2 ++
 hw/core/machine.c              | 1 +
 include/hw/virtio/virtio-blk.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8a6754d9a2..542ec52536 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1026,6 +1026,8 @@ static Property virtio_blk_properties[] =3D {
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHRE=
AD,
                      IOThread *),
+    DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wzeroes=
, 0,
+                     true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2629515363..ce98857af0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@ GlobalProperty hw_compat_3_1[] =3D {
     { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "t=
rue" },
     { "tpm-crb", "ppi", "false" },
     { "tpm-tis", "ppi", "false" },
+    { "virtio-blk-device", "discard-wzeroes", "false" },
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
index 5117431d96..c336afb4cd 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -40,6 +40,7 @@ struct VirtIOBlkConf
     uint32_t request_merging;
     uint16_t num_queues;
     uint16_t queue_size;
+    uint32_t discard_wzeroes;
 };
=20
 struct VirtIOBlockDataPlane;
--=20
2.20.1
