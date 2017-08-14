Received: from eggs.gnu.org ([2001:4830:134:3::10]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJA-0007QW-A4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJ7-0007V0-48
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:20 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:44 +0300
Message-Id: <a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 7/7] hw/misc/mmio_interface: Return after
 error_setg() to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

QEMU currently abort()s if the user tries to specify the mmio_interface
device without parameters:

x86_64-softmmu/qemu-system-x86_64 -nographic -device mmio_interface
qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
 Assertion `*errp == ((void *)0)' failed.
Aborted (core dumped)

This happens because the realize function is trying to set the errp
twice in this case. After setting an error, the realize function
should immediately return instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/misc/mmio_interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
index 6f004d2bab..da154e5c95 100644
--- a/hw/misc/mmio_interface.c
+++ b/hw/misc/mmio_interface.c
@@ -63,10 +63,12 @@ static void mmio_interface_realize(DeviceState *dev, Error **errp)
 
     if (!s->host_ptr) {
         error_setg(errp, "host_ptr property must be set");
+        return;
     }
 
     if (!s->subregion) {
         error_setg(errp, "subregion property must be set");
+        return;
     }
 
     memory_region_init_ram_ptr(&s->ram_mem, OBJECT(s), "ram",
-- 
2.11.0
