Received: from eggs.gnu.org ([209.51.188.92]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyP-0007WQ-QF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyL-0003II-S3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyF-00037n-Jy
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:01 -0500
Date: Tue, 15 Jan 2019 15:05:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-36-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 35/49] virtio: Make
 disable-legacy/disable-modern compat properties optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The disable-legacy and disable-modern properties apply only to
some virtio-pci devices.  Make those properties optional.

This fixes the crash introduced by commit f6e501a28ef9 ("virtio: Provide
version-specific variants of virtio PCI devices"):

  $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
    -device virtio-net-pci-non-transitional
  Unexpected error in object_property_find() at qom/object.c:1092:
  qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't apply \
  global virtio-pci.disable-modern=on: Property '.disable-modern' not found
  Aborted (core dumped)

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of virtio PCI devices")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 95dc7c3913..f0c0ae6be8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -91,8 +91,9 @@ const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
 GlobalProperty hw_compat_2_6[] = {
     { "virtio-mmio", "format_transport_address", "off" },
-    { "virtio-pci", "disable-modern", "on" },
-    { "virtio-pci", "disable-legacy", "off" },
+    /* Optional because not all virtio-pci devices support legacy mode */
+    { "virtio-pci", "disable-modern", "on",  .optional = true },
+    { "virtio-pci", "disable-legacy", "off", .optional = true },
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
-- 
MST
