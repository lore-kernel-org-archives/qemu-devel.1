Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1castC-0001CP-Mq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1castB-0001Sj-Sp
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:06 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  6 Feb 2017 20:39:30 -0300
Message-Id: <20170206233931.14921-2-f4bug@amsat.org>
In-Reply-To: <20170206233931.14921-1-f4bug@amsat.org>
References: <20170206233931.14921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] register: inline register_enabled_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This patch prepares for the fix of register_read() incorrect mask.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/register.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 4bfbc508de..12f4c1e62d 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -59,6 +59,15 @@ static inline uint64_t register_read_val(RegisterInfo *reg)
     return 0; /* unreachable */
 }
 
+static inline uint64_t register_enabled_mask(int data_size, unsigned size)
+{
+    if (data_size < size) {
+        size = data_size;
+    }
+
+    return MAKE_64BIT_MASK(0, size * 8);
+}
+
 void register_write(RegisterInfo *reg, uint64_t val, uint64_t we,
                     const char *prefix, bool debug)
 {
@@ -192,11 +201,7 @@ void register_write_memory(void *opaque, hwaddr addr,
     }
 
     /* Generate appropriate write enable mask */
-    if (reg->data_size < size) {
-        we = MAKE_64BIT_MASK(0, reg->data_size * 8);
-    } else {
-        we = MAKE_64BIT_MASK(0, size * 8);
-    }
+    we = register_enabled_mask(reg->data_size, size);
 
     register_write(reg, value, we, reg_array->prefix,
                    reg_array->debug);
-- 
2.11.0
