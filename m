Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1castF-0001F7-Cy
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1castE-0001X2-Oi
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  6 Feb 2017 20:39:31 -0300
Message-Id: <20170206233931.14921-3-f4bug@amsat.org>
In-Reply-To: <20170206233931.14921-1-f4bug@amsat.org>
References: <20170206233931.14921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] register: fix incorrect read mask
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

The register_read() function expects a bitmask argument.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/register.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 12f4c1e62d..482e3f827a 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -213,6 +213,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
     RegisterInfoArray *reg_array = opaque;
     RegisterInfo *reg = NULL;
     uint64_t read_val;
+    uint64_t re;
     int i;
 
     for (i = 0; i < reg_array->num_elements; i++) {
@@ -228,7 +229,10 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
         return 0;
     }
 
-    read_val = register_read(reg, size * 8, reg_array->prefix,
+    /* Generate appropriate read enable mask */
+    re = register_enabled_mask(reg->data_size, size);
+
+    read_val = register_read(reg, re, reg_array->prefix,
                              reg_array->debug);
 
     return extract64(read_val, 0, size * 8);
-- 
2.11.0
