Received: from eggs.gnu.org ([2001:4830:134:3::10]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cfB9X-0008SD-Ho
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 14:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cfB9W-0005ln-DJ
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 14:58:43 -0500
References: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
	<CAFEAcA-zURkUb28wVA347AFJX5Wa4GyXbFSVmUDH1BSXRMA+rQ@mail.gmail.com>
From: Kurban Mallachiev <mallachiev@ispras.ru>
Message-ID: <4d2f2d04-e294-bdad-4f77-9a0171357d05@ispras.ru>
Date: Sat, 18 Feb 2017 22:57:51 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zURkUb28wVA347AFJX5Wa4GyXbFSVmUDH1BSXRMA+rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ARM i.MX timers: fix software reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>

Ok, thank you for reply.

Here is another patch. I have created different function for software 
reset (imx_gpt_soft_reset), and to prevent duplication extracted common 
code to imx_gpt_reset_common.

Take a look, please.

---
Subject: [PATCH] i.MX timers: fix software reset

Software reset function clears CR bits that should not clear and
preserve bits that should clear.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
---
  hw/timer/imx_gpt.c | 26 ++++++++++++++++++++------
  1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 010ccbf207..f07ae3d9a4 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -296,18 +296,20 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr 
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
+                   GPT_CR_WAITEN|GPT_CR_DBGEN;
+    } else {
+        s->cr = 0;
+    }
      s->sr = 0;
      s->pr = 0;
      s->ir = 0;
@@ -333,6 +335,18 @@ static void imx_gpt_reset(DeviceState *dev)
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
@@ -348,7 +362,7 @@ static void imx_gpt_write(void *opaque, hwaddr 
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

On 18.02.2017 18:46, Peter Maydell wrote:
> On 17 February 2017 at 18:18, Kurban Mallachiev <mallachiev@ispras.ru> wrote:
>> Hello!
>>
>> i.MX6 RM says that setting software reset bit in CR register of GPT (general
>> purpose timers) should resets all of the registers of GPT to their default
>> reset values, except for the CLKSRC, EN, ENMOD, STOPEN, WAITEN, and DBGEN
>> bits in CR. But current implementation does the opposite for CR register (it
>> clears CLKSRC and friends bits and preserves the others).
>>
>> Most importantly this leads to that software reset bit doesn't clears
>> automatically.
>>
>> I have a look at git history and found that software reset bit was being
>> cleared before 462566fc5e3 commit.
>>
>> I have doubts about the correct fixing of this problem. I don't really
>> understand the nature of the "Soft reset doesn't touch some bits; hard reset
>> clears them" comment in imx_gpt_reset function, does it mean that
>> imx_gpt_reset performs a hard reset or soft reset? I see two possible
>> fixings:
>>
>> 1. If imx_gpt_reset purpose is to do a software reset of device, then we
>> should fix this function. My patch at the end of email fixes this function.
>>
>> 2. If imx_gpt_reset purpose is to do a hard reset of device? then there
>> should be another function to software reset of device. If so I can create a
>> new patch.
> As the function registered via the DeviceState's dc->reset
> pointer, imx_gpt_reset() has to behave as a "device was
> powercycled" level reset. It looks like we also call it
> from imx_gpt_write() when the guest does a write to a
> particular register. If that guest-requested reset has
> to have different behaviour from "device was powered off
> and on again" then it needs to use a different function
> and can't just call imx_gpt_reset().
>
> thanks
> -- PMM
