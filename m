Received: from eggs.gnu.org ([2001:4830:134:3::10]:40587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGU-0005Tv-QB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGT-0001fx-HR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:46 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUGGT-0001fW-B1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:45 -0500
Received: by mail-wm0-x234.google.com with SMTP id r126so2706236wmr.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:12:45 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:05:07 +0000
Message-Id: <20170119170507.16185-28-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 27/27] target-ppc: take global mutex for
 set_irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

We have to do this conditionally as the reset paths can trigger IRQ
setting when the machine is first brought up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/ppc/ppc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8945869009..59c3faa6c8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -62,7 +62,16 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    unsigned int old_pending = env->pending_interrupts;
+    unsigned int old_pending;
+    bool locked = false;
+
+    /* We may already have the BQL if coming from the reset path */
+    if (!qemu_mutex_iothread_locked()) {
+        locked = true;
+        qemu_mutex_lock_iothread();
+    }
+
+    old_pending = env->pending_interrupts;
 
     if (level) {
         env->pending_interrupts |= 1 << n_IRQ;
@@ -80,9 +89,14 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 #endif
     }
 
+
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
                 env->pending_interrupts, CPU(cpu)->interrupt_request);
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 /* PowerPC 6xx / 7xx internal IRQ controller */
-- 
2.11.0
