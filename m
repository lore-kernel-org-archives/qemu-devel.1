Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP5-0008Fe-Ig
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP3-0007Zg-N4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:31 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP3-0007ZH-HS
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:29 -0400
Received: by mail-wr0-x244.google.com with SMTP id x23so2767861wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:36 +0200
Message-Id: <1497523981-38449-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/41] kvm-all: make async_safe_run_on_cpu safe
 on kvm too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Wrap the bulk of kvm_cpu_exec with cpu_exec_start/end, so that kvm
version can also enjoy performing certain operations while all vCPUs are
quiescent.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20170606181948.16238-15-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kvm-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kvm-all.c b/kvm-all.c
index ab8262f..98ad151 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1977,6 +1977,7 @@ int kvm_cpu_exec(CPUState *cpu)
     }
 
     qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
 
     do {
         MemTxAttrs attrs;
@@ -2106,6 +2107,7 @@ int kvm_cpu_exec(CPUState *cpu)
         }
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
     qemu_mutex_lock_iothread();
 
     if (ret < 0) {
-- 
1.8.3.1
