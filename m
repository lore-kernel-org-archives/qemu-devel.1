Received: from eggs.gnu.org ([209.51.188.92]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grLN5-0002q1-Pv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grLN4-0005lJ-Qc
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:28:03 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed,  6 Feb 2019 12:27:26 +0100
Message-Id: <20190206112729.37761-4-sgarzare@redhat.com>
In-Reply-To: <20190206112729.37761-1-sgarzare@redhat.com>
References: <20190206112729.37761-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/6] virtio-blk: add "discard" and
 "write-zeroes" properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

In order to avoid migration issues, we enable DISCARD and
WRITE_ZEROES features only for machine type >=3D 4.0

As discussed with Michael S. Tsirkin and Stefan Hajnoczi on the
list [1], DISCARD operation should not have security implications
(eg. page cache attacks), so we can enable it by default.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00504.html

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c | 4 ++++
 hw/core/machine.c     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 938273c63c..6f2e86264d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1026,6 +1026,10 @@ static Property virtio_blk_properties[] =3D {
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHRE=
AD,
                      IOThread *),
+    DEFINE_PROP_BIT64("discard", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_DISCARD, true),
+    DEFINE_PROP_BIT64("write-zeroes", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 077fbd182a..766ca5899d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,6 +33,8 @@ GlobalProperty hw_compat_3_1[] =3D {
     { "usb-kbd", "serial", "42" },
     { "usb-mouse", "serial", "42" },
     { "usb-kbd", "serial", "42" },
+    { "virtio-blk-device", "discard", "false" },
+    { "virtio-blk-device", "write-zeroes", "false" },
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
--=20
2.20.1
