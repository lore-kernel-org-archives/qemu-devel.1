Received: from eggs.gnu.org ([2001:4830:134:3::10]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eoBnM-0006kn-1O
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eoBnJ-0003u4-4H
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:50853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eoBnI-0003tE-RJ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Feb 2018 18:33:07 +0100
Message-Id: <20180220173307.25125-5-laurent@vivier.eu>
In-Reply-To: <20180220173307.25125-1-laurent@vivier.eu>
References: <20180220173307.25125-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 4/4] linux-user: MIPS set cpu to r6 CPU if
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
Cc: Aaron Sierra <asierra@xes-inc.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, YunQiang Su <syq@debian.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>

From: YunQiang Su <syq@debian.org>

So here we need to detect the version of binaries and set
cpu_model for it.

Signed-off-by: YunQiang Su <syq@debian.org>
[lv: original patch modified to move code into cpu_get_model()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v5: Use EF_MIPS_ARCH mask to read MIPS architecture flags
        -> removed Richard's R-b because of this change
    v4: add YunQiang Su's Signed-off-by
    v3: fix code indent problem reported by patchew
        remove useless "!= 0"
    v2: call cpu_get_model() with the result of get_elf_eflags()

 include/elf.h                  | 7 +++++++
 linux-user/mips/target_elf.h   | 3 +++
 linux-user/mips64/target_elf.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index ca9a419043..943ee21171 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -33,6 +33,9 @@ typedef int64_t  Elf64_Sxword;
 
 /* Flags in the e_flags field of the header */
 /* MIPS architecture level. */
+#define EF_MIPS_ARCH            0xf0000000
+
+/* Legal values for MIPS architecture level.  */
 #define EF_MIPS_ARCH_1		0x00000000	/* -mips1 code.  */
 #define EF_MIPS_ARCH_2		0x10000000	/* -mips2 code.  */
 #define EF_MIPS_ARCH_3		0x20000000	/* -mips3 code.  */
@@ -40,6 +43,10 @@ typedef int64_t  Elf64_Sxword;
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
index bed0b43259..fa5d30bf99 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,6 +9,9 @@
 #define MIPS_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
+        return "mips32r6-generic";
+    }
     return "24Kf";
 }
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5b6f4692e0..ec55d8542a 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,6 +9,9 @@
 #define MIPS64_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
+        return "I6400";
+    }
     return "5KEf";
 }
 #endif
-- 
2.14.3
