Received: from eggs.gnu.org ([2001:4830:134:3::10]:43553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGza-0000Nd-DE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGzW-0001LF-IK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:26 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 22 Jun 2018 09:00:09 +0100
Message-Id: <20180622080009.5707-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
References: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] mac_newworld: always enable
 disable_direct_reg3_writes for ADB machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Commit 84051eb400 "adb: add property to disable direct reg 3 writes" added a
workaround for MacOS 9 incorrectly setting the mouse address during boot of
PMU machines.

Further testing has shown that since fb6649f172 "adb: fix read reg 3 byte
ordering" this can still sometimes happen with the CUDA mac99 machine,
so let's enable this workaround for all New World machines using ADB for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.11.0
