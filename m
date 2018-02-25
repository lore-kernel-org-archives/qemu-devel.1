Received: from eggs.gnu.org ([2001:4830:134:3::10]:54752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aS-0002Dv-9W
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aO-0002lG-Dp
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:48 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eq0aO-0002i0-3R
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Feb 2018 18:59:27 +0100
Message-Id: <20180225175928.13101-4-laurent@vivier.eu>
In-Reply-To: <20180225175928.13101-1-laurent@vivier.eu>
References: <20180225175928.13101-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/4] linux-user,
 m68k: select CPU according to ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

M680x0 doesn't support the same set of instructions
as ColdFire, so we can't use "any" CPU type to execute
m68020 instructions.
We select CPU type ("m68040" or "any" for ColdFire)
according to the ELF header. If we can't, we
use by default the value used until now: "any".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180220173307.25125-4-laurent@vivier.eu>
---
 include/elf.h                | 28 ++++++++++++++++++++++++++++
 linux-user/m68k/target_elf.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e8a515ce3d..ca9a419043 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -537,6 +537,34 @@ typedef struct {
 #define HWCAP_S390_HIGH_GPRS    512
 #define HWCAP_S390_TE           1024
 
+/* M68K specific definitions. */
+/* We use the top 24 bits to encode information about the
+   architecture variant.  */
+#define EF_M68K_CPU32    0x00810000
+#define EF_M68K_M68000   0x01000000
+#define EF_M68K_CFV4E    0x00008000
+#define EF_M68K_FIDO     0x02000000
+#define EF_M68K_ARCH_MASK                                               \
+  (EF_M68K_M68000 | EF_M68K_CPU32 | EF_M68K_CFV4E | EF_M68K_FIDO)
+
+/* We use the bottom 8 bits to encode information about the
+   coldfire variant.  If we use any of these bits, the top 24 bits are
+   either 0 or EF_M68K_CFV4E.  */
+#define EF_M68K_CF_ISA_MASK     0x0F  /* Which ISA */
+#define EF_M68K_CF_ISA_A_NODIV  0x01  /* ISA A except for div */
+#define EF_M68K_CF_ISA_A        0x02
+#define EF_M68K_CF_ISA_A_PLUS   0x03
+#define EF_M68K_CF_ISA_B_NOUSP  0x04  /* ISA_B except for USP */
+#define EF_M68K_CF_ISA_B        0x05
+#define EF_M68K_CF_ISA_C        0x06
+#define EF_M68K_CF_ISA_C_NODIV  0x07  /* ISA C except for div */
+#define EF_M68K_CF_MAC_MASK     0x30
+#define EF_M68K_CF_MAC          0x10  /* MAC */
+#define EF_M68K_CF_EMAC         0x20  /* EMAC */
+#define EF_M68K_CF_EMAC_B       0x30  /* EMAC_B */
+#define EF_M68K_CF_FLOAT        0x40  /* Has float insns */
+#define EF_M68K_CF_MASK         0xFF
+
 /*
  * 68k ELF relocation types
  */
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index df375ad5d3..998fe0fe2f 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -9,6 +9,12 @@
 #define M68K_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    if (eflags == 0 || (eflags & EF_M68K_M68000)) {
+        /* 680x0 */
+        return "m68040";
+    }
+
+    /* Coldfire */
     return "any";
 }
 #endif
-- 
2.14.3
