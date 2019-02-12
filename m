Received: from eggs.gnu.org ([209.51.188.92]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtScP-0002Xl-1V
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtScN-0002Sk-Vl
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:36:36 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtScM-0002O1-TI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:36:35 -0500
Received: by mail-pl1-x641.google.com with SMTP id p8so903211plo.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 23:36:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 23:36:28 -0800
Message-Id: <20190212073628.9665-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Add AT_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-arm@nongnu.org, 1813034@bugs.launchpad.net

Fixes: https://bugs.launchpad.net/bugs/1813034
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 775a36ccdd..dde640a2ea 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -500,6 +500,35 @@ static uint32_t get_elf_hwcap2(void)
 #undef GET_FEATURE
 #undef GET_FEATURE_ID
 
+#define ELF_PLATFORM get_elf_platform()
+
+static const char *get_elf_platform(void)
+{
+    CPUARMState *env = thread_cpu->env_ptr;
+
+#ifdef TARGET_WORDS_BIGENDIAN
+# define END  "b"
+#else
+# define END  "l"
+#endif
+
+    if (arm_feature(env, ARM_FEATURE_V7)) {
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return "v7m" END;
+        } else {
+            return "v7" END;
+        }
+    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+        return "v6" END;
+    } else if (arm_feature(env, ARM_FEATURE_V5)) {
+        return "v5" END;
+    } else {
+        return "v4" END;
+    }
+
+#undef END
+}
+
 #else
 /* 64 bit ARM definitions */
 #define ELF_START_MMAP 0x80000000
-- 
2.17.2
