Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzS-00008E-2d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzO-0001PC-53
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:38 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebUzN-0001Nx-EX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 16 Jan 2018 18:25:10 +0100
Message-Id: <20180116172510.28878-5-laurent@vivier.eu>
In-Reply-To: <20180116172510.28878-1-laurent@vivier.eu>
References: <20180116172510.28878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 4/4] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>, Laurent Vivier <laurent@vivier.eu>

From: YunQiang Su <syq@debian.org>

So here we need to detect the version of binaries and set
cpu_model for it.

[lv: original patch modified to move code into cpu_get_model()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    YunQiang Su, please add your Signed-off-by that was
    missing in your original patch.
    
    v2: call cpu_get_model() with the result of get_elf_eflags()

 include/elf.h                  | 4 ++++
 linux-user/mips/target_elf.h   | 3 +++
 linux-user/mips64/target_elf.h | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e8a515ce3d..f2104809b1 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -40,6 +40,10 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_5		0x40000000	/* -mips5 code.  */
 #define EF_MIPS_ARCH_32		0x50000000	/* MIPS32 code.  */
 #define EF_MIPS_ARCH_64		0x60000000	/* MIPS64 code.  */
+#define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
+#define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
+#define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
+#define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
 
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32		0x00001000	/* O32 ABI.  */
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index bed0b43259..ac14f99ac5 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,6 +9,9 @@
 #define MIPS_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+     if ((eflags & EF_MIPS_ARCH_32R6) != 0) {
+         return "mips32r6-generic";
+     }
     return "24Kf";
 }
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5b6f4692e0..6cda7ae435 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,6 +9,9 @@
 #define MIPS64_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+     if ((eflags & EF_MIPS_ARCH_64R6) != 0) {
+         return "I6400";
+     }
     return "5KEf";
 }
 #endif
-- 
2.14.3
