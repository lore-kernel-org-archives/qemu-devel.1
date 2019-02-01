Received: from eggs.gnu.org ([209.51.188.92]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLJ-0007ZL-Ip
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLI-0003G1-H8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:01 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbLH-0003FY-T7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:00 -0500
Received: by mail-wr1-x430.google.com with SMTP id t6so7607607wrr.12
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:06:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.06.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:06:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:08 +0000
Message-Id: <20190201160653.13829-3-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/47] armv7m: Don't assume the NVIC's CPU is
 CPU 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently the ARMv7M NVIC object's realize method assumes that the
CPU the NVIC is attached to is CPU 0, because it thinks there can
only ever be one CPU in the system. To allow a dual-Cortex-M33
setup we need to remove this assumption; instead the armv7m
wrapper object tells the NVIC its CPU, in the same way that it
already tells the CPU what the NVIC is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-2-peter.maydell@linaro.org
---
 hw/arm/armv7m.c       | 6 ++++--
 hw/intc/armv7m_nvic.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f4446528307..f9aa83d20ef 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -178,10 +178,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    /* Tell the CPU where the NVIC is; it will fail realize if it doesn't
-     * have one.
+    /*
+     * Tell the CPU where the NVIC is; it will fail realize if it doesn't
+     * have one. Similarly, tell the NVIC where its CPU is.
      */
     s->cpu->env.nvic = &s->nvic;
+    s->nvic.cpu = s->cpu;
 
     object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
     if (err != NULL) {
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 0beefb05d44..790a3d95849 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2274,8 +2274,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     int regionlen;
 
-    s->cpu = ARM_CPU(qemu_get_cpu(0));
-
+    /* The armv7m container object will have set our CPU pointer */
     if (!s->cpu || !arm_feature(&s->cpu->env, ARM_FEATURE_M)) {
         error_setg(errp, "The NVIC can only be used with a Cortex-M CPU");
         return;
-- 
2.20.1
