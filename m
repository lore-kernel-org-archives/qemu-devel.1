Received: from eggs.gnu.org ([209.51.188.92]:39253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghei2-0004dc-Rl
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghei2-00016W-0l
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghei1-0000r0-QA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 16:04:58 -0200
Message-Id: <20190110180458.18762-3-ehabkost@redhat.com>
In-Reply-To: <20190110180458.18762-1-ehabkost@redhat.com>
References: <20190110180458.18762-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] virtio: Make
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

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
---
 hw/core/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5530b71981..a19143aa44 100644
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
2.18.0.rc1.1.g3f1ff2140
