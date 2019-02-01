Received: from eggs.gnu.org ([209.51.188.92]:58741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLd-0007m8-LM
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLX-0003L7-2C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbLN-0003Ge-N5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id a16so2066178wrv.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.06.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:10 +0000
Message-Id: <20190201160653.13829-5-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/47] armv7m: Pass through start-powered-off
 CPU property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Expose "start-powered-off" as a property of the ARMv7M container,
which we just pass through to the CPU object in the same way that we
do for "init-svtor" and "idau". (We want this for the SSE-200, which
powers up only the first CPU at reset and leaves the second powered
down.)

As with the other CPU properties here, we can't just use alias
properties, because the CPU QOM object is not created until armv7m
realize time.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-4-peter.maydell@linaro.org
---
 include/hw/arm/armv7m.h |  1 +
 hw/arm/armv7m.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 2ba24953b63..e96a98f8093 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -65,6 +65,7 @@ typedef struct ARMv7MState {
     Object *idau;
     uint32_t init_svtor;
     bool enable_bitband;
+    bool start_powered_off;
 } ARMv7MState;
 
 #endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 0f2c8e066cf..adae11e76ed 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -182,6 +182,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
+        object_property_set_bool(OBJECT(s->cpu), s->start_powered_off,
+                                 "start-powered-off", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
 
     /*
      * Tell the CPU where the NVIC is; it will fail realize if it doesn't
@@ -250,6 +258,8 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Object *),
     DEFINE_PROP_UINT32("init-svtor", ARMv7MState, init_svtor, 0),
     DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, false),
+    DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1
