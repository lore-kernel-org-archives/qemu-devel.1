Received: from eggs.gnu.org ([2001:4830:134:3::10]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSb-0004no-0B
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSZ-000586-83
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:49 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSZ-00057w-0U
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:47 -0500
Received: by mail-wr0-x242.google.com with SMTP id i56so30829121wra.7
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:46 -0800 (PST)
Received: from 640k.lan ([82.84.122.246]) by smtp.gmail.com with ESMTPSA id
	g8sm20029891wra.18.2018.02.05.11.29.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 05 Feb 2018 11:29:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:49 +0100
Message-Id: <1517858941-5538-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/47] cpus: join thread when removing a vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If no one joins the thread, its associated memory is leaked.

Reported-by: CheneyLin <linzc@zju.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/cpus.c b/cpus.c
index fe127ac..8d8bb7c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1752,19 +1752,14 @@ void resume_all_vcpus(void)
     }
 }
 
-void cpu_remove(CPUState *cpu)
+void cpu_remove_sync(CPUState *cpu)
 {
     cpu->stop = true;
     cpu->unplug = true;
     qemu_cpu_kick(cpu);
-}
-
-void cpu_remove_sync(CPUState *cpu)
-{
-    cpu_remove(cpu);
-    while (cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
+    qemu_mutex_unlock_iothread();
+    qemu_thread_join(cpu->thread);
+    qemu_mutex_lock_iothread();
 }
 
 /* For temporary buffers for forming a name */
-- 
1.8.3.1
