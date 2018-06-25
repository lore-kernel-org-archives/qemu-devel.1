Received: from eggs.gnu.org ([2001:4830:134:3::10]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrn-0002j9-Sj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrj-0008Lv-PJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:33 -0300
Message-Id: <20180625124238.25339-42-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 41/46] hw/ppc: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/sam460ex.c       | 2 +-
 target/ppc/mmu_helper.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index ffe561fbc1..c7c799b843 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -126,7 +126,7 @@ static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
     int i;
 
     /* work in terms of MB */
-    ram_size >>= 20;
+    ram_size /= MiB;
 
     while ((ram_size >= 4) && (nbanks <= 2)) {
         int sz_log2 = MIN(31 - clz32(ram_size), 14);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 98ce17985b..e6739e6c24 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "sysemu/kvm.h"
@@ -1090,11 +1091,10 @@ static void mmubooke_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
         pa = entry->RPN & mask;
         /* Extend the physical address to 36 bits */
         pa |= (hwaddr)(entry->RPN & 0xF) << 32;
-        size /= 1024;
-        if (size >= 1024) {
-            snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "M", size / 1024);
+        if (size >= 1 * MiB) {
+            snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "M", size / MiB);
         } else {
-            snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "k", size);
+            snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "k", size / KiB);
         }
         cpu_fprintf(f, "0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
                     (uint64_t)ea, (uint64_t)pa, size_buf, (uint32_t)entry->PID,
-- 
2.18.0
