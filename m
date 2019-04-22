Received: from eggs.gnu.org ([209.51.188.92]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwF-0007vk-TN
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgs-0005LK-6y
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
Received: from m12-12.163.com ([220.181.12.12]:58458)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgr-0005J2-J8
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
From: Li Qiang <liq3ea@163.com>
Date: Mon, 22 Apr 2019 07:11:55 -0700
Message-Id: <20190422141156.15746-3-liq3ea@163.com>
In-Reply-To: <20190422141156.15746-1-liq3ea@163.com>
References: <20190422141156.15746-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v3 2/3] edu: mmio: allow 64-bit access in read
 dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, philmd@redhat.com, Li Qiang <liq3ea@163.com>

The edu spec says when address >= 0x80, the MMIO area can
be accessed by 64-bit.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v2:
Fix an error per Phillippe's advice

 hw/misc/edu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 65fc32b928..33de05141f 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
     EduState *edu = opaque;
     uint64_t val = ~0ULL;
 
-    if (size != 4) {
+    if (addr < 0x80 && size != 4) {
+        return val;
+    }
+
+    if (addr >= 0x80 && size != 4 && size != 8) {
         return val;
     }
 
-- 
2.17.1
