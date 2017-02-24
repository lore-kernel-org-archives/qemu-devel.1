Received: from eggs.gnu.org ([2001:4830:134:3::10]:36395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrO-00081H-KR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrM-0002Ic-46
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:50 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrL-0002IH-Ui
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so4043373wmu.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:47 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	s26sm8814533wra.66.2017.02.24.09.40.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 09:40:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:25 +0100
Message-Id: <1487958030-51417-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] kvm: use atomic_read/atomic_set to access
 cpu->exit_request
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
 kvm-all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index d7d5a71..1a96c27 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1931,7 +1931,7 @@ int kvm_cpu_exec(CPUState *cpu)
     DPRINTF("kvm_cpu_exec()\n");
 
     if (kvm_arch_process_async_events(cpu)) {
-        cpu->exit_request = 0;
+        atomic_set(&cpu->exit_request, 0);
         return EXCP_HLT;
     }
 
@@ -1946,7 +1946,7 @@ int kvm_cpu_exec(CPUState *cpu)
         }
 
         kvm_arch_pre_run(cpu, run);
-        if (cpu->exit_request) {
+        if (atomic_read(&cpu->exit_request)) {
             DPRINTF("interrupt exit requested\n");
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
@@ -2065,7 +2065,7 @@ int kvm_cpu_exec(CPUState *cpu)
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    cpu->exit_request = 0;
+    atomic_set(&cpu->exit_request, 0);
     return ret;
 }
 
-- 
1.8.3.1
