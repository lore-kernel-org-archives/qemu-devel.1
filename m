Received: from eggs.gnu.org ([2001:4830:134:3::10]:35638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7h-0008DZ-Po
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7e-00014l-HK
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7e-00012v-AG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:14 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so250372563wrc.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:49 +0100
Message-Id: <20170704144859.17644-2-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 01/11] risu: make match status take
 tracing into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 reginfo.c | 14 +++++++++-----
 risu.c    |  4 ++--
 risu.h    |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/reginfo.c b/reginfo.c
index 13879d5..d9d37b3 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -138,7 +138,7 @@ int recv_and_compare_register_info(read_fn read_fn,
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(void)
+int report_match_status(int trace)
 {
     int resp = 0;
     fprintf(stderr, "match status...\n");
@@ -148,7 +148,7 @@ int report_match_status(void)
         /* We don't have valid reginfo from the apprentice side
          * so stop now rather than printing anything about it.
          */
-        fprintf(stderr, "master reginfo:\n");
+        fprintf(stderr, "%s reginfo:\n", trace ? "this":"master");
         reginfo_dump(&master_ri, stderr);
         return 1;
     }
@@ -166,11 +166,15 @@ int report_match_status(void)
         return 0;
     }
 
-    fprintf(stderr, "master reginfo:\n");
+    fprintf(stderr, "%s reginfo:\n", trace ? "this":"master");
     reginfo_dump(&master_ri, stderr);
-    fprintf(stderr, "apprentice reginfo:\n");
+    fprintf(stderr, "%s reginfo:\n", trace ? "trace":"apprentice");
     reginfo_dump(&apprentice_ri, stderr);
 
-    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+    if (trace) {
+        reginfo_dump_mismatch(&apprentice_ri, &master_ri, stderr);
+    } else {
+        reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+    }
     return resp;
 }
diff --git a/risu.c b/risu.c
index 6f213dc..47471c6 100644
--- a/risu.c
+++ b/risu.c
@@ -228,7 +228,7 @@ int master(void)
                     signal_count);
             return 0;
         } else {
-            return report_match_status();
+            return report_match_status(0);
         }
     }
     set_sigill_handler(&master_sigill);
@@ -250,7 +250,7 @@ int apprentice(void)
 #endif
         close(apprentice_fd);
         fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
-        return report_match_status();
+        return report_match_status(1);
     }
     set_sigill_handler(&apprentice_sigill);
     fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
diff --git a/risu.h b/risu.h
index 9f15662..1c8ecee 100644
--- a/risu.h
+++ b/risu.h
@@ -91,7 +91,7 @@ int recv_and_compare_register_info(read_fn read_fn,
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(void);
+int report_match_status(int trace);
 
 /* Interface provided by CPU-specific code: */
 
-- 
2.13.0
