Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3I-0003Eq-R0
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3H-0006S2-IL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:04 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3H-0006Qr-Cy
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:03 -0500
Received: by mail-wm0-x244.google.com with SMTP id r71so10968235wmd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:28 +0000
Message-Id: <20180208173157.24705-4-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/32] target/arm/cpu64: allow fp16 to be
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

While for CONFIG_USER_ONLY it is policy for the "cpu" to be the most
capable is can be this does cause problems. For example legacy RISU
runs would fail as there are a bunch of implemented instructions which
would have caused failures that now trigger actual calculations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 973614dfc6..0dc4debd9c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -275,6 +275,26 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
     }
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool aarch64_cpu_get_fp16(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return arm_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+}
+
+static void aarch64_cpu_set_fp16(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (value == false) {
+        unset_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+    } else {
+        set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+    }
+}
+#endif
+
 static void aarch64_cpu_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
@@ -283,6 +303,13 @@ static void aarch64_cpu_initfn(Object *obj)
                                     "Set on/off to enable/disable aarch64 "
                                     "execution state ",
                                     NULL);
+#ifdef CONFIG_USER_ONLY
+    object_property_add_bool(obj, "fp16", aarch64_cpu_get_fp16,
+                             aarch64_cpu_set_fp16, NULL);
+    object_property_set_description(obj, "fp16",
+                                    "Set on/off to enable/disable FP16 extensions ",
+                                    NULL);
+#endif
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
-- 
2.15.1
