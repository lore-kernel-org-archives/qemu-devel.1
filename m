Received: from eggs.gnu.org ([2001:4830:134:3::10]:56188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim6-0006Yu-Jc
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim5-0000Lp-Eu
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Mar 2018 11:35:20 +1100
Message-Id: <20180319003524.28143-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180319003524.28143-1-david@gibson.dropbear.id.au>
References: <20180319003524.28143-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 4/8] hw/misc/macio: Mark the macio devices with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index af1bd46b4b..454244f59e 100644
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
2.14.3
