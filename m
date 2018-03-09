Received: from eggs.gnu.org ([2001:4830:134:3::10]:57171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euP9p-0003sD-Ox
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euP9l-0004dT-9e
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:02:29 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euP9l-0004d2-3E
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:02:25 -0500
Received: by mail-pf0-x241.google.com with SMTP id j20so1774572pfi.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:02:24 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 10:01:12 +1300
Message-Id: <1520629272-98060-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2] RISC-V: Fix riscv_isa_string,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

Logic bug caused the string size calculation for the RISC-V
format ISA string to be small. This fix allows slack for rv128.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4851890..1456535 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info = {
 char *riscv_isa_string(RISCVCPU *cpu)
 {
     int i;
-    size_t maxlen = 5 + ctz32(cpu->env.misa);
+    size_t maxlen = 8 + ctpop64(cpu->env.misa);
     char *isa_string = g_new0(char, maxlen);
     snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
     for (i = 0; i < sizeof(riscv_exts); i++) {
-- 
2.7.0
