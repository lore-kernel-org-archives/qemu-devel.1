Received: from eggs.gnu.org ([2001:4830:134:3::10]:33237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000Pz-RV
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tv-0004wG-Tv
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tv-0004rR-Gv
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:15 -0500
Message-Id: <20181209193749.12277-5-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v2 04/38] translate-all: use
 cpu_in_exclusive_work_context() in tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

tb_flush will be called by the plugin module from a safe
work environment. Prepare for that.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 038d82fdb5..62d5e13185 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1269,8 +1269,13 @@ void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
-        async_safe_run_on_cpu(cpu, do_tb_flush,
-                              RUN_ON_CPU_HOST_INT(tb_flush_count));
+
+        if (cpu_in_exclusive_work_context(cpu)) {
+            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+        } else {
+            async_safe_run_on_cpu(cpu, do_tb_flush,
+                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
+        }
     }
 }
 
-- 
2.17.1
