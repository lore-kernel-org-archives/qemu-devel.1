Received: from eggs.gnu.org ([209.51.188.92]:49361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzl-00051k-DT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzh-00063o-DL
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:47 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 00:59:38 +0000
Message-ID: <c2daf173b9313126c6cb0babc2728ad82053d668.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 02/11] riscv: pmp: Log pmp access errors as
 guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 15a5366616..b11c4ae22f 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -113,10 +113,11 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_=
t pmp_index, uint8_t val)
             env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
             pmp_update_rule(env, pmp_index);
         } else {
-            PMP_DEBUG("ignoring write - locked");
+            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked=
\n");
         }
     } else {
-        PMP_DEBUG("ignoring write - out of bounds");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ignoring pmpcfg write - out of bounds\n");
     }
 }
=20
@@ -249,7 +250,8 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulon=
g addr,
=20
         /* partially inside */
         if ((s + e) =3D=3D 1) {
-            PMP_DEBUG("pmp violation - access is partially inside");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - access is partially inside\n");
             ret =3D 0;
             break;
         }
@@ -306,7 +308,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_=
index,
         env->mhartid, reg_index, val);
=20
     if ((reg_index & 1) && (sizeof(target_ulong) =3D=3D 8)) {
-        PMP_DEBUG("ignoring write - incorrect address");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ignoring pmpcfg write - incorrect address\n");
         return;
     }
=20
@@ -353,10 +356,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
             env->pmp_state.pmp[addr_index].addr_reg =3D val;
             pmp_update_rule(env, addr_index);
         } else {
-            PMP_DEBUG("ignoring write - locked");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpaddr write - locked\n");
         }
     } else {
-        PMP_DEBUG("ignoring write - out of bounds");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ignoring pmpaddr write - out of bounds\n");
     }
 }
=20
@@ -372,7 +377,8 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint3=
2_t addr_index)
     if (addr_index < MAX_RISCV_PMPS) {
         return env->pmp_state.pmp[addr_index].addr_reg;
     } else {
-        PMP_DEBUG("ignoring read - out of bounds");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ignoring pmpaddr read - out of bounds\n");
         return 0;
     }
 }
--=20
2.20.1
