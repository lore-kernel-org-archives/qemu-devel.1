Received: from eggs.gnu.org ([2001:4830:134:3::10]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfh-0002Oe-UR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPff-0001vB-Hn
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPff-0001qs-A1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfV-0002MF-R2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:40 +0000
Message-Id: <1488218699-31035-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/30] ARM i.MX timers: fix reset handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Kurban Mallachiev <mallachiev@ispras.ru>

The i.MX timer device can be reset by writing to the SWR bit
of the CR register. This has to behave differently from hard
(power-on) reset because it does not reset all of the bits
in the CR register.

We were incorrectly implementing soft reset and hard reset
the same way, and in addition had a logic error which meant
that we were clearing the bits that soft-reset is supposed
to preserve and not touching the bits that soft-reset clears.
This was not correct behaviour for either kind of reset.

Separate out the soft reset and hard reset code paths, and
correct the handling of reset of the CR register so that it
is correct in both cases.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
[PMM: rephrased commit message, spacing on operators;
 use bool rather than int for is_soft_reset]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/imx_gpt.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 010ccbf..4b9b54b 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -296,18 +296,23 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
     return reg_value;
 }
 
-static void imx_gpt_reset(DeviceState *dev)
-{
-    IMXGPTState *s = IMX_GPT(dev);
 
+static void imx_gpt_reset_common(IMXGPTState *s, bool is_soft_reset)
+{
     /* stop timer */
     ptimer_stop(s->timer);
 
-    /*
-     * Soft reset doesn't touch some bits; hard reset clears them
+    /* Soft reset and hard reset differ only in their handling of the CR
+     * register -- soft reset preserves the values of some bits there.
      */
-    s->cr &= ~(GPT_CR_EN|GPT_CR_ENMOD|GPT_CR_STOPEN|GPT_CR_DOZEN|
-               GPT_CR_WAITEN|GPT_CR_DBGEN);
+    if (is_soft_reset) {
+        /* Clear all CR bits except those that are preserved by soft reset. */
+        s->cr &= GPT_CR_EN | GPT_CR_ENMOD | GPT_CR_STOPEN | GPT_CR_DOZEN |
+            GPT_CR_WAITEN | GPT_CR_DBGEN |
+            (GPT_CR_CLKSRC_MASK << GPT_CR_CLKSRC_SHIFT);
+    } else {
+        s->cr = 0;
+    }
     s->sr = 0;
     s->pr = 0;
     s->ir = 0;
@@ -333,6 +338,18 @@ static void imx_gpt_reset(DeviceState *dev)
     }
 }
 
+static void imx_gpt_soft_reset(DeviceState *dev)
+{
+    IMXGPTState *s = IMX_GPT(dev);
+    imx_gpt_reset_common(s, true);
+}
+
+static void imx_gpt_reset(DeviceState *dev)
+{
+    IMXGPTState *s = IMX_GPT(dev);
+    imx_gpt_reset_common(s, false);
+}
+
 static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
                           unsigned size)
 {
@@ -348,7 +365,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->cr = value & ~0x7c14;
         if (s->cr & GPT_CR_SWR) { /* force reset */
             /* handle the reset */
-            imx_gpt_reset(DEVICE(s));
+            imx_gpt_soft_reset(DEVICE(s));
         } else {
             /* set our freq, as the source might have changed */
             imx_gpt_set_freq(s);
-- 
2.7.4
