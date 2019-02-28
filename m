Received: from eggs.gnu.org ([209.51.188.92]:36349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYo-0001Ew-IX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYn-0003dK-8v
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYm-0003K6-VI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id n19so8756713wmi.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:08:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:08:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:22 +0000
Message-Id: <20190228110835.16159-4-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/16] target/arm/cpu: Allow init-svtor property
 to be set after realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the M-profile "init-svtor" property be settable after realize.
This matches the hardware, where this is a config signal which
is sampled on CPU reset and can thus be changed between one
reset and another. To do this we have to change the API we
use to add the property.

(We will need this capability for the SSE-200.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-4-peter.maydell@linaro.org
---
 target/arm/cpu.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8ea6569088d..4d7f6a3bc0c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -22,6 +22,7 @@
 #include "target/arm/idau.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "cpu.h"
 #include "internals.h"
 #include "qemu-common.h"
@@ -771,9 +772,21 @@ static Property arm_cpu_pmsav7_dregion_property =
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
 
-/* M profile: initial value of the Secure VTOR */
-static Property arm_cpu_initsvtor_property =
-            DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
+static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_svtor, errp);
+}
+
+static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_svtor, errp);
+}
 
 void arm_cpu_post_init(Object *obj)
 {
@@ -845,8 +858,14 @@ void arm_cpu_post_init(Object *obj)
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG,
                                  &error_abort);
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_initsvtor_property,
-                                 &error_abort);
+        /*
+         * M profile: initial value of the Secure VTOR. We can't just use
+         * a simple DEFINE_PROP_UINT32 for this because we want to permit
+         * the property to be set after realize.
+         */
+        object_property_add(obj, "init-svtor", "uint32",
+                            arm_get_init_svtor, arm_set_init_svtor,
+                            NULL, NULL, &error_abort);
     }
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-- 
2.20.1
