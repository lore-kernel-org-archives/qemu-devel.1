Received: from eggs.gnu.org ([2001:4830:134:3::10]:35261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewAHn-0004Im-MQ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewAHk-0004zM-JH
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:33:59 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:40084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ewAHk-0004sE-7n
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:33:56 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.225])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 32FF892701
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 18:33:45 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 14 Mar 2018 18:33:36 +0100
Message-Id: <20180314173336.20055-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc: fix tlbsync to check privilege
 level depending on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

tlbsync also needs to check the Guest Translation Shootdown Enable
(GTSE) bit in the Logical Partition Control Register (LPCR) to
determine at which privilege level it is running.

See commit c6fd28fd573d ("target/ppc: Update tlbie to check privilege
level based on GTSE")

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 This will have its importance when we activate the HV bit on the
 POWER9 CPU for the PowerNV machine.

 target/ppc/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0a0c090c9978..218665b4080b 100644
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
2.13.6
