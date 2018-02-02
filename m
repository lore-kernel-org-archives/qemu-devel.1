Received: from eggs.gnu.org ([2001:4830:134:3::10]:54062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehhET-00023E-Fd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehhEP-0002wS-CY
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:45 -0500
Received: from mail-by2nam01on0041.outbound.protection.outlook.com
	([104.47.34.41]:61408
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ehhEO-0002ug-W5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:41 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Feb 2018 11:38:01 -0800
Message-ID: <8be93dc009d8473294b1adc26657058b8e56a550.1517600250.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] hw: register: Run post_write hook on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Ensure that the post write hook is called during reset. This allows us
to rely on the post write functions instead of having to call them from
the reset() function.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/core/register.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
2.14.1
