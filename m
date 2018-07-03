Received: from eggs.gnu.org ([2001:4830:134:3::10]:39585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0002li-VX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKM-0006nn-6V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:31 +1000
Message-Id: <20180703055804.13449-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/35] mac_newworld: always enable
 disable_direct_reg3_writes for ADB machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit 84051eb400 "adb: add property to disable direct reg 3 writes" added a
workaround for MacOS 9 incorrectly setting the mouse address during boot of
PMU machines.

Further testing has shown that since fb6649f172 "adb: fix read reg 3 byte
ordering" this can still sometimes happen with the CUDA mac99 machine,
so let's enable this workaround for all New World machines using ADB for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index ff715ffffd..2b13fcdde5 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -407,11 +407,11 @@ static void ppc_core99_init(MachineState *machine)
 
         adb_bus = qdev_get_child_bus(dev, "adb.0");
         dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
-        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
+        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
         qdev_init_nofail(dev);
 
         dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
-        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
+        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
         qdev_init_nofail(dev);
     }
 
-- 
2.17.1
