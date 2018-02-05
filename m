Received: from eggs.gnu.org ([2001:4830:134:3::10]:33155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eilpb-0006EY-S3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eilpW-0003vg-T3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:49:31 -0500
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com
	([104.47.36.63]:12990
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eilpW-0003t8-Jh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:49:26 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 5 Feb 2018 10:44:47 -0800
Message-ID: <d131e24b911653a945e46ca2d8f90f572469e1dd.1517856214.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/1] hw: register: Run post_write hook on
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, f4bug@amsat.org

Ensure that the post write hook is called during reset. This allows us
to rely on the post write functions instead of having to call them from
the reset() function.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

V2:
 - Update the header documentation

 include/hw/register.h | 6 +++---
 hw/core/register.c    | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index de2414e6b4..5796584588 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -34,7 +34,7 @@ typedef struct RegisterInfoArray RegisterInfoArray;
  * immediately before the actual write. The returned value is what is writ=
ten,
  * giving the handler a chance to modify the written value.
  * @post_write: Post write callback. Passed the written value. Most write =
side
- * effects should be implemented here.
+ * effects should be implemented here. This is called during device reset.
  *
  * @post_read: Post read callback. Passes the value that is about to be re=
turned
  * for a read. The return value from this function is what is ultimately r=
ead,
@@ -135,8 +135,8 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re, =
const char* prefix,
                        bool debug);
=20
 /**
- * reset a register
- * @reg: register to reset
+ * Resets a register. This will also call the post_write hook if it exists=
.
+ * @reg: The register to reset.
  */
=20
 void register_reset(RegisterInfo *reg);
diff --git a/hw/core/register.c b/hw/core/register.c
index 900294b9c4..0741a1af32 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -159,13 +159,21 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re=
, const char* prefix,
=20
 void register_reset(RegisterInfo *reg)
 {
+    const RegisterAccessInfo *ac;
+
     g_assert(reg);
=20
     if (!reg->data || !reg->access) {
         return;
     }
=20
+    ac =3D reg->access;
+
     register_write_val(reg, reg->access->reset);
+
+    if (ac->post_write) {
+        ac->post_write(reg, reg->access->reset);
+    }
 }
=20
 void register_init(RegisterInfo *reg)
--=20
2.14.1
