Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7N-0000RY-N1
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7K-0007HH-Lp
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:09 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eaN7K-0007GM-CI
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 13 Jan 2018 15:48:46 +0100
Message-Id: <20180113144847.8403-3-laurent@vivier.eu>
In-Reply-To: <20180113144847.8403-1-laurent@vivier.eu>
References: <20180113144847.8403-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/3] linux-user,
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
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

M680x0 doesn't support the same set of instructions
as ColdFire, so we can't use "any" CPU type to execute
m68020 instructions.
We select CPU type ("m68020" or "any" for ColdFire)
according to the ELF header. If we can't, we
use by default the value used until now: "any".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9ce90ae634..2fc2267fd4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4267,6 +4267,16 @@ static const char *get_cpu_model(int fd)
 #elif defined(TARGET_UNICORE32)
     return "any";
 #elif defined(TARGET_M68K)
+    int ret;
+    uint32_t eflags;
+
+    ret = get_elf_eflags(fd, &eflags);
+    if (ret == 0 && eflags == 0) {
+        /* 680x0 */
+        return "m68020";
+    }
+
+    /* Coldfire */
     return "any";
 #elif defined(TARGET_SPARC)
 #ifdef TARGET_SPARC64
-- 
2.14.3
