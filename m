Received: from eggs.gnu.org ([2001:4830:134:3::10]:36067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgq-0004k3-M9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgp-0000dO-Jh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgp-0000c8-84
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EF06C0567A3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:07 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe7028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:06 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:46 +0100
Message-Id: <20170227124551.8673-13-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 12/17] kvm: use atomic_read/atomic_set to
 access cpu->exit_request
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
index 5bbdc44..1c6f117 100644
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
@@ -2069,7 +2069,7 @@ int kvm_cpu_exec(CPUState *cpu)
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    cpu->exit_request = 0;
+    atomic_set(&cpu->exit_request, 0);
     return ret;
 }
 
-- 
2.9.3
