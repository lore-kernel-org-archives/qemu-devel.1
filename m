Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK0-0003np-4S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-00087a-9u
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:24 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJu-00084x-2Z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJh-0000XL-8n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:22 +0000
Message-Id: <20180301112403.12487-2-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/42] hw: register: Run post_write hook on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Ensure that the post write hook is called during reset. This allows us
to rely on the post write functions instead of having to call them from
the reset() function.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: d131e24b911653a945e46ca2d8f90f572469e1dd.1517856214.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/register.h | 6 +++---
 hw/core/register.c    | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index de2414e6b4..5796584588 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -34,7 +34,7 @@ typedef struct RegisterInfoArray RegisterInfoArray;
  * immediately before the actual write. The returned value is what is written,
  * giving the handler a chance to modify the written value.
  * @post_write: Post write callback. Passed the written value. Most write side
- * effects should be implemented here.
+ * effects should be implemented here. This is called during device reset.
  *
  * @post_read: Post read callback. Passes the value that is about to be returned
  * for a read. The return value from this function is what is ultimately read,
@@ -135,8 +135,8 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re, const char* prefix,
                        bool debug);
 
 /**
- * reset a register
- * @reg: register to reset
+ * Resets a register. This will also call the post_write hook if it exists.
+ * @reg: The register to reset.
  */
 
 void register_reset(RegisterInfo *reg);
diff --git a/hw/core/register.c b/hw/core/register.c
index 900294b9c4..0741a1af32 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -159,13 +159,21 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re, const char* prefix,
 
 void register_reset(RegisterInfo *reg)
 {
+    const RegisterAccessInfo *ac;
+
     g_assert(reg);
 
     if (!reg->data || !reg->access) {
         return;
     }
 
+    ac = reg->access;
+
     register_write_val(reg, reg->access->reset);
+
+    if (ac->post_write) {
+        ac->post_write(reg, reg->access->reset);
+    }
 }
 
 void register_init(RegisterInfo *reg)
-- 
2.16.2
