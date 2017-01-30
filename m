Received: from eggs.gnu.org ([2001:4830:134:3::10]:37691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20d-0005DZ-Vb
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20a-0003no-LU
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:48:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cY20a-0003mN-CB
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:47:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0U2jttO083002
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:54 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289gyy9p9h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:54 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 30 Jan 2017 00:47:51 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 4D5C31DC0054
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:50 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0U2lnu833358036
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:49 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0U2lnNb001263
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:49 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 00:47:36 -0200
In-Reply-To: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 1/2] risu_ppc64: Fix Risu to run under
 qemu linux user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Qemu linux-user doesn't fill uc_mcontext completely like full emul. does.
For instance, uc->uc_mcontext.regs->nip is an invalid so this
commit replaces it by uc->uc_mcontext.gp_regs[PT_NIP]

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risu_ppc64le.c         |  2 +-
 risu_reginfo_ppc64le.c | 11 ++++++-----
 test_ppc64le.s         | 20 +++++++++-----------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 9c1fafd..773d14c 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -27,7 +27,7 @@ uint8_t apprentice_memblock[MEMBLOCKLEN];
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = (ucontext_t*)vuc;
-    uc->uc_mcontext.regs->nip += 4;
+    uc->uc_mcontext.gp_regs[PT_NIP] += 4;
 }
 
 void set_x0(void *vuc, uint64_t x0)
diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index 7a54eab..4dc509c 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -28,8 +28,9 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     int i;
     memset(ri, 0, sizeof(*ri));
 
-    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.regs->nip);
-    ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
+    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.gp_regs[PT_NIP]);
+    ri->prev_insn = *((uint32_t *)(uc->uc_mcontext.gp_regs[PT_NIP] - 4));
+    ri->nip = uc->uc_mcontext.gp_regs[PT_NIP] - image_start_address;
 
     for (i = 0; i < NGREG; i++) {
         ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
@@ -105,9 +106,9 @@ void reginfo_dump(struct reginfo *ri, int is_master)
 {
     int i;
     if (is_master) {
-        fprintf(stderr, "  faulting insn \e[1;101;37m0x%x\e[0m\n", ri->faulting_insn);
-        fprintf(stderr, "  prev insn     \e[1;101;37m0x%x\e[0m\n", ri->prev_insn);
-        fprintf(stderr, "  prev addr     \e[1;101;37m0x%" PRIx64 "\e[0m\n\n", ri->prev_addr);
+        fprintf(stderr, "  faulting insn 0x%x\n", ri->faulting_insn);
+        fprintf(stderr, "  prev insn     0x%x\n", ri->prev_insn);
+        fprintf(stderr, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
     }
 
     for (i = 0; i < 16; i++) {
diff --git a/test_ppc64le.s b/test_ppc64le.s
index 4321751..4af770c 100644
--- a/test_ppc64le.s
+++ b/test_ppc64le.s
@@ -12,20 +12,18 @@
  *****************************************************************************/
 
 /* Initialise the gp regs */
-li 0,0
-li 1,1
-li 2,2
-li 3,3
-li 4,4
-li 5,5
-li 6,6
-li 7,7
-li 8,8
-li 9,9
+li 0, 0
+li 2, 2
+li 3, 3
+li 4, 4
+li 5, 5
+li 6, 6
+li 7, 7
+li 8, 8
+li 9, 9
 li 10, 10
 li 11, 11
 li 12, 12
-li 13, 13
 li 14, 14
 li 15, 15
 li 16, 16
-- 
2.7.4
