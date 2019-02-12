Received: from eggs.gnu.org ([209.51.188.92]:46627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoH-0004DP-1X
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoF-0005xA-6C
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:52 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtSoE-0005pL-Pr
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:51 -0500
Received: by mail-pg1-x544.google.com with SMTP id y1so860801pgk.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 23:48:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 23:48:39 -0800
Message-Id: <20190212074840.13542-2-richard.henderson@linaro.org>
In-Reply-To: <20190212074840.13542-1-richard.henderson@linaro.org>
References: <20190212074840.13542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/2] linux-user: Add ELF_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-arm@nongnu.org

The 32-bit kernel has strings for v4, v5, v6, v7, v7m.
The 64-bit kernel, in compat mode, has strings for v8.

Fixes: https://bugs.launchpad.net/bugs/1813034
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Include v8.
---
 linux-user/elfload.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 775a36ccdd..d796d51ec6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -500,6 +500,37 @@ static uint32_t get_elf_hwcap2(void)
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
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return "v8" END;
+    } else if (arm_feature(env, ARM_FEATURE_V7)) {
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
