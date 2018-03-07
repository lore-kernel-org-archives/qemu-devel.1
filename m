Received: from eggs.gnu.org ([2001:4830:134:3::10]:48145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etZyN-0002dU-6G
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etZyK-00040L-1F
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:23:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Mar 2018 15:22:54 +0100
Message-Id: <1520432574-20615-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/misc/macio: Mark the macio devices with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The macio devices currently cause a crash when the user tries to
instantiate them on a different machine:

$ ppc64-softmmu/qemu-system-ppc64 -device macio-newworld
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
qemu-system-ppc64: -device macio-newworld: Device 'serial0' is in use
Aborted (core dumped)

These devices are clearly not intended to be creatable by the user
since they are using serial_hds[] directly in their instance_init
function. So let's mark them with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/macio/macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index af1bd46..454244f 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -406,6 +406,8 @@ static void macio_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_OTHERS << 8;
     dc->props = macio_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    /* Reason: Uses serial_hds in macio_instance_init */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo macio_oldworld_type_info = {
-- 
1.8.3.1
