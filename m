Received: from eggs.gnu.org ([2001:4830:134:3::10]:47899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOc8-0008UH-7H
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOc7-0001Kg-0N
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:44:44 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 11 Feb 2017 00:43:32 -0300
Message-Id: <20170211034332.12498-1-f4bug@amsat.org>
In-Reply-To: <CAKmqyKMYmNeOOogS4+yv14M2CWTbBNtBP0jnO0DQEuScSp8eYw@mail.gmail.com>
References: <CAKmqyKMYmNeOOogS4+yv14M2CWTbBNtBP0jnO0DQEuScSp8eYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

The register_read() function expects a bitmask argument. To avoid duplicated
code, a new inlined function register_enabled_mask() is introduced.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 v2: squashed together both previous commits as suggested by Francis Alistair.

 hw/core/register.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 4bfbc508de..482e3f827a 100644
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
@@ -208,6 +213,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
     RegisterInfoArray *reg_array = opaque;
     RegisterInfo *reg = NULL;
     uint64_t read_val;
+    uint64_t re;
     int i;
 
     for (i = 0; i < reg_array->num_elements; i++) {
@@ -223,7 +229,10 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
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
