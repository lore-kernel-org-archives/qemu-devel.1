Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSb-0004np-0Z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSX-00057S-2I
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:49 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSW-000579-QX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:44 -0500
Received: by mail-wm0-x243.google.com with SMTP id 141so27959789wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:44 -0800 (PST)
Received: from 640k.lan ([82.84.122.246]) by smtp.gmail.com with ESMTPSA id
	g8sm20029891wra.18.2018.02.05.11.29.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 05 Feb 2018 11:29:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:47 +0100
Message-Id: <1517858941-5538-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/47] cpus: tcg: unregister thread with RCU,
 fix exiting of loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Keep running until cpu_can_run(cpu) becomes false, for consistency
with other acceslerators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 190ad5a..269d527 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1467,6 +1467,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
         deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
     return NULL;
 }
 
@@ -1603,18 +1604,17 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 /* Ignore everything else? */
                 break;
             }
-        } else if (cpu->unplug) {
-            qemu_tcg_destroy_vcpu(cpu);
-            cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
-            qemu_mutex_unlock_iothread();
-            return NULL;
         }
 
         atomic_mb_set(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
-    }
+    } while (!cpu->unplug || cpu_can_run(cpu));
 
+    qemu_tcg_destroy_vcpu(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
1.8.3.1
