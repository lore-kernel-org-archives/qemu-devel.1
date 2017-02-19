Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cfWjv-0007wa-DP
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 14:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cfWjs-0007sX-AV
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 14:01:43 -0500
References: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
	<CAFEAcA-zURkUb28wVA347AFJX5Wa4GyXbFSVmUDH1BSXRMA+rQ@mail.gmail.com>
	<4d2f2d04-e294-bdad-4f77-9a0171357d05@ispras.ru>
From: Kurban Mallachiev <mallachiev@ispras.ru>
Message-ID: <332706f6-7b54-89db-6b89-5684362fb2e3@ispras.ru>
Date: Sun, 19 Feb 2017 22:00:50 +0300
MIME-Version: 1.0
In-Reply-To: <4d2f2d04-e294-bdad-4f77-9a0171357d05@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] ARM i.MX timers: fix software reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, QEMU Developers <qemu-devel@nongnu.org>

Hello!

Problem: function imx_gpt_reset is used for soft (requested by guest) 
and hard resets. But soft and hard resets should have different 
behaviour (hard reset should clear all registers, while soft reset 
should preserve some bits).

Patch changelog:
v1 -> v2: use different approach, patch completely rewritten
v2 -> v3: in software reset add preserving of CLKSRC bit as manual says

---
Software reset function clears CR bits that should not be cleared and
preserve bits that should be cleared.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
---
  hw/timer/imx_gpt.c | 27 +++++++++++++++++++++------
  1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 010ccbf207..3ea18ff5de 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -296,18 +296,21 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr 
offset, unsigned size)
      return reg_value;
  }

-static void imx_gpt_reset(DeviceState *dev)
+static void imx_gpt_reset_common(IMXGPTState *s, int is_soft_reset)
  {
-    IMXGPTState *s = IMX_GPT(dev);
-
      /* stop timer */
      ptimer_stop(s->timer);

      /*
       * Soft reset doesn't touch some bits; hard reset clears them
       */
-    s->cr &= ~(GPT_CR_EN|GPT_CR_ENMOD|GPT_CR_STOPEN|GPT_CR_DOZEN|
-               GPT_CR_WAITEN|GPT_CR_DBGEN);
+    if (is_soft_reset) {
+        s->cr &= GPT_CR_EN|GPT_CR_ENMOD|GPT_CR_STOPEN|GPT_CR_DOZEN|
+                   GPT_CR_WAITEN|GPT_CR_DBGEN|
+                   GPT_CR_CLKSRC_MASK<<GPT_CR_CLKSRC_SHIFT;
+    } else {
+        s->cr = 0;
+    }
      s->sr = 0;
      s->pr = 0;
      s->ir = 0;
@@ -333,6 +336,18 @@ static void imx_gpt_reset(DeviceState *dev)
      }
  }

+static void imx_gpt_soft_reset(DeviceState *dev)
+{
+    IMXGPTState *s = IMX_GPT(dev);
+    imx_gpt_reset_common(s, 1);
+}
+
+static void imx_gpt_reset(DeviceState *dev)
+{
+    IMXGPTState *s = IMX_GPT(dev);
+    imx_gpt_reset_common(s, 0);
+}
+
  static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
  {
@@ -348,7 +363,7 @@ static void imx_gpt_write(void *opaque, hwaddr 
offset, uint64_t value,
          s->cr = value & ~0x7c14;
          if (s->cr & GPT_CR_SWR) { /* force reset */
              /* handle the reset */
-            imx_gpt_reset(DEVICE(s));
+            imx_gpt_soft_reset(DEVICE(s));
          } else {
              /* set our freq, as the source might have changed */
              imx_gpt_set_freq(s);
-- 
2.11.1
