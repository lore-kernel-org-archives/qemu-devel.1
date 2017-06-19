Received: from eggs.gnu.org ([2001:4830:134:3::10]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCS-0007L5-3c
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCR-0004sh-0s
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:28 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCQ-0004ru-Qj
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:26 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so14026259wrc.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:48 +0100
Message-Id: <20170619104655.31104-7-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 06/13] risu: a bit more verbosity when
 starting
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

When debugging faults it is useful to know where the generated
instructions are living.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

--
v5
  - dropped all the status update due to signal handler contraints
v3
  - use portable fmt string for image_start_address
  - include arm dumping position
---
 risu.c | 4 ++++
 risu.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/risu.c b/risu.c
index 2cd6d22..a10422a 100644
--- a/risu.c
+++ b/risu.c
@@ -124,6 +124,8 @@ int master(int sock)
     }
     master_socket = sock;
     set_sigill_handler(&master_sigill);
+    fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
+            image_start_address);
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
@@ -134,6 +136,8 @@ int apprentice(int sock)
 {
     apprentice_socket = sock;
     set_sigill_handler(&apprentice_sigill);
+    fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
+            image_start_address);
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
diff --git a/risu.h b/risu.h
index 3fbeda8..78a7313 100644
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
-- 
2.13.0
