Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CM-0001aU-Gl
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CL-0002py-Gh
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:06 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2CL-0002pJ-B4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:05 -0400
Received: by mail-pf0-x244.google.com with SMTP id u5so7555974pfh.6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:20:05 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:49 -0700
Message-Id: <1521494329-19546-27-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 26/26] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

This version uses a constant size memory buffer sized for
the maximum possible ISA string length. It also uses g_new
instead of g_new0, uses more efficient logic to append
extensions and adds manual zero termination of the string.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/riscv/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1f25968..c82359f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -360,16 +360,16 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 char *riscv_isa_string(RISCVCPU *cpu)
 {
     int i;
-    size_t maxlen = 5 + ctz32(cpu->env.misa);
-    char *isa_string = g_new0(char, maxlen);
-    snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
+    const size_t maxlen = sizeof("rv128") + sizeof(riscv_exts) + 1;
+    char *isa_str = g_new(char, maxlen);
+    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
     for (i = 0; i < sizeof(riscv_exts); i++) {
         if (cpu->env.misa & RV(riscv_exts[i])) {
-            isa_string[strlen(isa_string)] = riscv_exts[i] - 'A' + 'a';
-
+            *p++ = tolower(riscv_exts[i]);
         }
     }
-    return isa_string;
+    *p = '\0';
+    return isa_str;
 }
 
 typedef struct RISCVCPUListState {
-- 
2.7.0
