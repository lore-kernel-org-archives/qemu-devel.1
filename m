Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7x-0005xx-Cn
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7w-0004zp-Ah
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:41 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGp7w-0004zA-4V
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:40 -0400
Received: by mail-wm0-x22e.google.com with SMTP id d127so30557701wmf.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:08:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 17:08:42 +0100
Message-Id: <20170602160848.4913-5-alex.bennee@linaro.org>
In-Reply-To: <20170602160848.4913-1-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 04/10] risu: a bit more verbosity when
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Before this is could seem a little quite when running as you had no
indication stuff was happening (or how fast). I only dump on the master
side as I want to minimise the amount of qemu logs to sift through.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

--
v3
  - use portable fmt string for image_start_address
  - include arm dumping position
---
 risu.c         | 15 +++++++++++++--
 risu.h         |  3 +++
 risu_aarch64.c |  3 +++
 risu_arm.c     |  3 +++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/risu.c b/risu.c
index 7e42160..bcdc219 100644
--- a/risu.c
+++ b/risu.c
@@ -37,6 +37,16 @@ sigjmp_buf jmpbuf;
 /* Should we test for FP exception status bits? */
 int test_fp_exc = 0;
 
+long executed_tests = 0;
+void report_test_status(void *pc)
+{
+   executed_tests += 1;
+   if (executed_tests % 100 == 0) {
+      fprintf(stderr,"Executed %ld test instructions (pc=%p)\r",
+              executed_tests, pc);
+   }
+}
+
 void master_sigill(int sig, siginfo_t *si, void *uc)
 {
    switch (recv_and_compare_register_info(master_socket, uc))
@@ -61,6 +71,7 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc)
          return;
       case 1:
          /* end of test */
+         fprintf(stderr, "\nend of test\n");
          exit(0);
       default:
          /* mismatch */
@@ -129,7 +140,7 @@ int master(int sock)
    }
    master_socket = sock;
    set_sigill_handler(&master_sigill);
-   fprintf(stderr, "starting image\n");
+   fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n", image_start_address);
    image_start();
    fprintf(stderr, "image returned unexpectedly\n");
    exit(1);
@@ -139,7 +150,7 @@ int apprentice(int sock)
 {
    apprentice_socket = sock;
    set_sigill_handler(&apprentice_sigill);
-   fprintf(stderr, "starting image\n");
+   fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n", image_start_address);
    image_start();
    fprintf(stderr, "image returned unexpectedly\n");
    exit(1);
diff --git a/risu.h b/risu.h
index 883bcf7..1eeb885 100644
--- a/risu.h
+++ b/risu.h
@@ -37,6 +37,7 @@ extern uintptr_t image_start_address;
 extern void *memblock;
 
 extern int test_fp_exc;
+extern int ismaster;
 
 /* Ops code under test can request from risu: */
 #define OP_COMPARE 0
@@ -72,6 +73,8 @@ int recv_and_compare_register_info(int sock, void *uc);
  */
 int report_match_status(void);
 
+void report_test_status(void *pc);
+
 /* Interface provided by CPU-specific code: */
 
 /* Move the PC past this faulting insn by adjusting ucontext
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 9c6809d..5625979 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -16,6 +16,9 @@ void advance_pc(void *vuc)
 {
     ucontext_t *uc = vuc;
     uc->uc_mcontext.pc += 4;
+    if (ismaster) {
+      report_test_status((void *) uc->uc_mcontext.pc);
+    }
 }
 
 void set_ucontext_paramreg(void *vuc, uint64_t value)
diff --git a/risu_arm.c b/risu_arm.c
index f570828..eaf4f6c 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -44,6 +44,9 @@ void advance_pc(void *vuc)
 {
    ucontext_t *uc = vuc;
    uc->uc_mcontext.arm_pc += insnsize(uc);
+   if (ismaster) {
+      report_test_status((void *) uc->uc_mcontext.arm_pc);
+   }
 }
 
 
-- 
2.13.0
