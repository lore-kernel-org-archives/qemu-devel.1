Received: from eggs.gnu.org ([2001:4830:134:3::10]:37557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewt87-0007Wz-Gb
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewt83-0001Io-HW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:26:59 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewt83-0001IA-Aq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:26:55 -0400
Received: by mail-pg0-x241.google.com with SMTP id m15so4330979pgc.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:26:55 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 10:26:11 -0700
Message-Id: <1521221171-47213-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This version uses a constant size memory buffer sized for
the maximum possible ISA string length. It also uses g_new
instead of g_new0, uses more efficient logic to append
extensions and adds manual zero termination of the string.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4851890..298abbd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -391,16 +391,16 @@ static const TypeInfo riscv_cpu_type_info = {
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
+            *p++ = riscv_exts[i] - 'A' + 'a';
         }
     }
-    return isa_string;
+    *p = '\0';
+    return isa_str;
 }
 
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
-- 
2.7.0
