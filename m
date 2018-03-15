Received: from eggs.gnu.org ([2001:4830:134:3::10]:40671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMJ-00074Q-I2
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMH-00043d-Vo
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:19:03 +1100
Message-Id: <20180315041903.10046-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] target/ppc: fix tlbsync to check privilege
 level depending on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

tlbsync also needs to check the Guest Translation Shootdown Enable
(GTSE) bit in the Logical Partition Control Register (LPCR) to
determine at which privilege level it is running.

See commit c6fd28fd573d ("target/ppc: Update tlbie to check privilege
level based on GTSE")

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0a0c090c99..218665b408 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4526,7 +4526,7 @@ static void gen_tlbie(DisasContext *ctx)
     TCGv_i32 t1;
=20
     if (ctx->gtse) {
-        CHK_SV; /* If gtse is set then tblie is supervisor privileged */
+        CHK_SV; /* If gtse is set then tlbie is supervisor privileged */
     } else {
         CHK_HV; /* Else hypervisor privileged */
     }
@@ -4553,7 +4553,12 @@ static void gen_tlbsync(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    CHK_HV;
+
+    if (ctx->gtse) {
+        CHK_SV; /* If gtse is set then tlbsync is supervisor privileged =
*/
+    } else {
+        CHK_HV; /* Else hypervisor privileged */
+    }
=20
     /* BookS does both ptesync and tlbsync make tlbsync a nop for server=
 */
     if (ctx->insns_flags & PPC_BOOKE) {
--=20
2.14.3
