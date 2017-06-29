Received: from eggs.gnu.org ([2001:4830:134:3::10]:57604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlS-0002C8-Fx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlM-0001Xc-LP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:30 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43371
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQVlM-0001Ws-Fl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:24 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 29 Jun 2017 11:28:53 +0200
Message-Id: <1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 3/3] armv7m_systick: abort instead of
 locking on a bad rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com, alistair@alistair23.me, frederic.konrad@adacore.com

This helps the board developer by asserting that system_clock_rate is not
null. Using systick with a zero rate will lead to a deadlock so better showing
the error.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/timer/armv7m_systick.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index df8d280..745efb7 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -54,6 +54,9 @@ static void systick_reload(SysTickState *s, int reset)
         s->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     }
     s->tick += (s->reload + 1) * systick_scale(s);
+
+    /* system_clock_scale = 0 leads to a nasty deadlock, better aborting */
+    assert(systick_scale(s));
     timer_mod(s->timer, s->tick);
 }
 
-- 
1.8.3.1
