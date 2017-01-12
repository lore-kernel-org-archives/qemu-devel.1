Received: from eggs.gnu.org ([2001:4830:134:3::10]:35058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRhbR-0005KE-RK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRhbN-00079H-3o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:47:49 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cRhbM-00078m-Ss
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:47:45 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r126so25171278wmr.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:47:44 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Jan 2017 15:47:30 +0000
Message-Id: <20170112154731.1028-3-alex.bennee@linaro.org>
In-Reply-To: <20170112154731.1028-1-alex.bennee@linaro.org>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/3] cpu_common_reset: wrap TCG specific
 code in tcg_enabled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Both the cpu->tb_jmp_cache and SoftMMU TLB structures are only used
when running TCG code so we might as well skip them for anything else.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qom/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index cc51de2a8c..61ee0cb88c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -270,13 +270,15 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
 
-    for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
-        atomic_set(&cpu->tb_jmp_cache[i], NULL);
-    }
+    if (tcg_enabled()) {
+        for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
+            atomic_set(&cpu->tb_jmp_cache[i], NULL);
+        }
 
 #ifdef CONFIG_SOFTMMU
-    tlb_flush(cpu, 0);
+        tlb_flush(cpu, 0);
 #endif
+    }
 }
 
 static bool cpu_common_has_work(CPUState *cs)
-- 
2.11.0
