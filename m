Received: from eggs.gnu.org ([2001:4830:134:3::10]:54402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRGBY-0002NR-On
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRGBU-0001Jg-Qz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:48 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1eRGBU-0001J9-Kz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:44 -0500
Received: by mail-pg0-x243.google.com with SMTP id j4so10430749pgp.1
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 03:35:44 -0800 (PST)
Sender: YunQiang Su <wzssyqa@gmail.com>
From: YunQiang Su <syq@debian.org>
Date: Tue, 19 Dec 2017 19:35:29 +0800
Message-Id: <20171219113529.6260-1-syq@debian.org>
Subject: [Qemu-devel] [PATCH] linux-user: set P5600 as default for MIPS o32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>

P5600 supports MIPS32r5, and is supported by qemu.
The current 24Kf supports mips32r2 only, to execute r3/r5 binaries
we need P5600.

.CP1_fcr31_rw_bitmask for P5600 is also modified:
 to make FCR31_NAN2008 and FCR31_ABS2008 editable, otherwise
only NAN2008 binaries are supported.

Signed-off-by: YunQiang Su <syq@debian.org>
---
 linux-user/main.c            | 2 +-
 target/mips/translate_init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index f2b02a99a2..7c0bffeff6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4323,7 +4323,7 @@ int main(int argc, char **argv, char **envp)
 #if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
         cpu_model = "5KEf";
 #else
-        cpu_model = "24Kf";
+        cpu_model = "P5600";
 #endif
 #elif defined TARGET_OPENRISC
         cpu_model = "or1200";
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index c7ba6ee5f9..e3020619d2 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -404,7 +404,7 @@ const mips_def_t mips_defs[] =
                     (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
                     (1 << FCR0_D) | (1 << FCR0_S) | (0x03 << FCR0_PRID),
         .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
-        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .CP1_fcr31_rw_bitmask = 0xFF8FFFFF,
         .SEGBITS = 32,
         .PABITS = 40,
         .insn_flags = CPU_MIPS32R5 | ASE_MSA,
-- 
2.15.1
