Received: from eggs.gnu.org ([2001:4830:134:3::10]:35127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmQ-0003u5-Gj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmP-00055K-Iw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmP-0004Og-CH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:41 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:24 +0000
Message-Id: <1487957728-8354-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 5/9] m68k: Drop unused ucontext_t*
 argument to reginfo_is_eq()
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

Drop the ucontext*t argument to reginfo_is_eq(); we don't
use it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu_m68k.c         | 4 ++--
 risu_reginfo_m68k.c | 2 +-
 risu_reginfo_m68k.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/risu_m68k.c b/risu_m68k.c
index 87776ab..e345b25 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -91,7 +91,7 @@ int recv_and_compare_register_info(int sock, void *uc)
         if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
             packet_mismatch = 1;
             resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri, uc)) {
+        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             resp = 2;
         }
         else if (op == OP_TESTEND) {
@@ -137,7 +137,7 @@ int report_match_status(void)
         fprintf(stderr, "master reginfo:\n");
         reginfo_dump(&master_ri, stderr);
     }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri, NULL)) {
+    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
         fprintf(stderr, "mismatch on regs!\n");
         resp = 1;
     }
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 3988d71..45950b1 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -38,7 +38,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     int i;
 
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
index 3922bf6..021939d 100644
--- a/risu_reginfo_m68k.h
+++ b/risu_reginfo_m68k.h
@@ -21,7 +21,7 @@ struct reginfo
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
 /* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2, ucontext_t *uc);
+int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
 /* print reginfo state to a stream, returns 1 on success, 0 on failure */
 int reginfo_dump(struct reginfo *ri, FILE *f);
-- 
2.7.4
