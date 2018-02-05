Received: from eggs.gnu.org ([2001:4830:134:3::10]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSU-0004gU-Gc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimST-00055t-M9
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:42 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimST-00055f-Fj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:41 -0500
Received: by mail-wm0-x241.google.com with SMTP id x4-v6so14586362wmc.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:41 -0800 (PST)
Received: from 640k.lan ([82.84.122.246]) by smtp.gmail.com with ESMTPSA id
	g8sm20029891wra.18.2018.02.05.11.29.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 05 Feb 2018 11:29:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:44 +0100
Message-Id: <1517858941-5538-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/47] cpus: hax: register/unregister thread
 with RCU, exit loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 2cb0af9..08a8462 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1473,6 +1473,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
     int r;
 
+    rcu_register_thread();
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
 
@@ -1484,7 +1485,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     hax_init_vcpu(cpu);
     qemu_cond_signal(&qemu_cpu_cond);
 
-    while (1) {
+    do {
         if (cpu_can_run(cpu)) {
             r = hax_smp_cpu_exec(cpu);
             if (r == EXCP_DEBUG) {
@@ -1493,7 +1494,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
         }
 
         qemu_wait_io_event(cpu);
-    }
+    } while (!cpu->unplug || cpu_can_run(cpu));
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
1.8.3.1
