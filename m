Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUp-00059R-GQ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUm-00076j-Gn
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fwsUm-00075r-B8
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  3 Sep 2018 13:18:29 -0400
Message-Id: <20180903171831.15446-5-cota@braap.org>
In-Reply-To: <20180903171831.15446-1-cota@braap.org>
References: <20180903171831.15446-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/6] cpus: initialize timers_state.vm_clock_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We forgot to initialize the spinlock introduced in 94377115b2
("cpus: protect TimerState writes with a spinlock", 2018-08-23).
Fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cpus.c b/cpus.c
index 8ee6e5db93..ebc13bac2d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -823,6 +823,7 @@ int cpu_throttle_get_percentage(void)
 void cpu_ticks_init(void)
 {
     seqlock_init(&timers_state.vm_clock_seqlock);
+    qemu_spin_init(&timers_state.vm_clock_lock);
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
     throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
                                            cpu_throttle_timer_tick, NULL);
-- 
2.17.1
