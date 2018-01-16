Received: from eggs.gnu.org ([2001:4830:134:3::10]:36883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzR-00007q-7d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzO-0001P7-54
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:64350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebUzN-0001Ny-GX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 16 Jan 2018 18:25:09 +0100
Message-Id: <20180116172510.28878-4-laurent@vivier.eu>
In-Reply-To: <20180116172510.28878-1-laurent@vivier.eu>
References: <20180116172510.28878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 3/4] linux-user,
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
Cc: YunQiang Su <syq@debian.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>, Laurent Vivier <laurent@vivier.eu>

M680x0 doesn't support the same set of instructions
as ColdFire, so we can't use "any" CPU type to execute
m68020 instructions.
We select CPU type ("m68020" or "any" for ColdFire)
according to the ELF header. If we can't, we
use by default the value used until now: "any".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: call cpu_get_model() with the result of get_elf_eflags()

 linux-user/m68k/target_elf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index df375ad5d3..946b90f342 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -9,6 +9,12 @@
 #define M68K_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    if (eflags == 0) {
+        /* 680x0 */
+        return "m68020";
+    }
+
+    /* Coldfire */
     return "any";
 }
 #endif
-- 
2.14.3
