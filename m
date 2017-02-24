Received: from eggs.gnu.org ([2001:4830:134:3::10]:35053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmM-0003rr-DG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmL-0004nt-DA
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmL-0004Og-5R
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:37 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:20 +0000
Message-Id: <1487957728-8354-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 1/9] Drop the weird modification of a
 ucontext in the ppc reginfo_is_eq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <pmaydell@chiark.greenend.org.uk>

The PPC reginfo_is_eq() has some weird code which tries to modify
a ucontext_t in the middle of comparing the two registers.
I don't understand this, but this is definitely not the right
place to do anything like this. Drop the weird code.

Signed-off-by: Peter Maydell <pmaydell@chiark.greenend.org.uk>
---
 risu_ppc64le.c         |  4 ++--
 risu_reginfo_ppc64le.c | 10 +---------
 risu_reginfo_ppc64le.h |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 9c1fafd..1c986a9 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -89,7 +89,7 @@ int recv_and_compare_register_info(int sock, void *uc)
         if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
             packet_mismatch = 1;
             resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri, uc)) {
+        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             resp = 2;
         }
         else if (op == OP_TESTEND) {
@@ -134,7 +134,7 @@ int report_match_status(void)
         fprintf(stderr, "master reginfo:\n");
         reginfo_dump(&master_ri, 0);
     }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri, NULL)) {
+    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
         fprintf(stderr, "mismatch on regs!\n");
         resp = 1;
     }
diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index e6bc0e0..585d8b7 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -50,7 +50,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     int i;
     for (i = 0; i < 32; i++) {
@@ -86,14 +86,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
                 m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
                 m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
                 m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-
-            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
-                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
-                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
-                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
-                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
-                return 1;
-            }
             return 0;
         }
     }
diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
index abe6002..49bb1aa 100644
--- a/risu_reginfo_ppc64le.h
+++ b/risu_reginfo_ppc64le.h
@@ -29,7 +29,7 @@ struct reginfo
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
 /* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2, ucontext_t *uc);
+int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
 /* print reginfo state to a stream */
 void reginfo_dump(struct reginfo *ri, int is_master);
-- 
2.7.4
