Received: from eggs.gnu.org ([2001:4830:134:3::10]:43059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1es6q1-0000ab-Jj
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1es6px-0004jO-Ig
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:04:33 -0500
From: Nia Alarie <nia.alarie@gmail.com>
Date: Sat,  3 Mar 2018 13:02:26 +0000
Message-Id: <20180303130226.26906-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH] PPC: e500: Add check for NULL return value
 from qemu_find_file.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nia.alarie@gmail.com, qemu-ppc@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

This prints a message and exits if the e500 BIOS firmware can't
be found, to avoid dereferencing a null pointer.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 hw/ppc/e500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index a40d3ec3e3..6ce03d6ff4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1005,6 +1005,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         }
     }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find firmware '%s'", bios_name);
+        exit(1);
+    }
 
     bios_size = load_elf(filename, NULL, NULL, &bios_entry, &loadaddr, NULL,
                          1, PPC_ELF_MACHINE, 0, 0);
-- 
2.16.2
