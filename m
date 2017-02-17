Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cen7m-0001jg-9m
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1cen7j-0003sP-0Z
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:19:18 -0500
From: Kurban Mallachiev <mallachiev@ispras.ru>
Message-ID: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
Date: Fri, 17 Feb 2017 21:18:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ARM i.MX timers: fix software reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Chubb <peter.chubb@nicta.com.au>, qemu-arm@nongnu.org

Hello!

i.MX6 RM says that setting software reset bit in CR register of GPT 
(general purpose timers) should resets all of the registers of GPT to 
their default reset values, except for the CLKSRC, EN, ENMOD, STOPEN, 
WAITEN, and DBGEN bits in CR. But current implementation does the 
opposite for CR register (it clears CLKSRC and friends bits and 
preserves the others).

Most importantly this leads to that software reset bit doesn't clears 
automatically.

I have a look at git history and found that software reset bit was being 
cleared before 462566fc5e3 commit.

I have doubts about the correct fixing of this problem. I don't really 
understand the nature of the "/Soft reset doesn't touch some bits; hard 
reset clears them/" comment in /imx_gpt_reset/ function, does it mean 
that /imx_gpt_reset/ performs a hard reset or soft reset? I see two 
possible fixings:

1. If /imx_gpt_reset/ purpose is to do a software reset of device, then 
we should fix this function. My patch at the end of email fixes this 
function.

2. If /imx_gpt_reset/ purpose is to do a hard reset of device? then 
there should be another function to software reset of device. If so I 
can create a new patch.


---

 From e12f689a2f41d18a29714771d83e343ca5195b61 Mon Sep 17 00:00:00 2001

From: Kurban Mallachiev <mallachiev@ispras.ru>

Date: Fri, 17 Feb 2017 20:30:49 +0300

Subject: [PATCH] i.MX timers: fix software reset

Software reset function clears CR bits that should not clear and

preserves bits that should clear.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>

---

  hw/timer/imx_gpt.c | 4 ++--

  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c

index 010ccbf207..9777160f49 100644

--- a/hw/timer/imx_gpt.c

+++ b/hw/timer/imx_gpt.c

@@ -306,8 +306,8 @@ static void imx_gpt_reset(DeviceState *dev)

      /*

       * Soft reset doesn't touch some bits; hard reset clears them

       */

-    s->cr &= ~(GPT_CR_EN|GPT_CR_ENMOD|GPT_CR_STOPEN|GPT_CR_DOZEN|

-               GPT_CR_WAITEN|GPT_CR_DBGEN);

+    s->cr &= GPT_CR_EN|GPT_CR_ENMOD|GPT_CR_STOPEN|GPT_CR_DOZEN|

+               GPT_CR_WAITEN|GPT_CR_DBGEN;

      s->sr = 0;

      s->pr = 0;

      s->ir = 0;

-- 

2.11.1
