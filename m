Received: from eggs.gnu.org ([2001:4830:134:3::10]:40876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOg3-0004Pw-JM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOg2-0003Xt-U6
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:07 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dkOg2-0003Xf-O8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:06 -0400
Received: by mail-pf0-x244.google.com with SMTP id k3so721465pfc.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 22:58:06 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:13 +0900
Message-Id: <5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 5/5] openrisc: Only kick cpu on timeout,
 not on update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

Previously we were kicking the cpu on every update.  This caused
problems noticeable in SMP configurations where one CPU got pinned
continuously servicing timer exceptions.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/cputimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 4c5415ff75..850f88761c 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -78,7 +78,6 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
     }
     next = now + (uint64_t)wait * TIMER_PERIOD;
     timer_mod(cpu->env.timer, next);
-    qemu_cpu_kick(CPU(cpu));
 }
 
 void cpu_openrisc_count_start(OpenRISCCPU *cpu)
@@ -120,6 +119,7 @@ static void openrisc_timer_cb(void *opaque)
     }
 
     cpu_openrisc_timer_update(cpu);
+    qemu_cpu_kick(CPU(cpu));
 }
 
 static const VMStateDescription vmstate_or1k_timer = {
-- 
2.13.5
