Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5T-0005wn-Vd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5P-0007ND-Ka
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:15 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com
	([40.107.3.107]:56200
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5P-0007MD-86
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:11 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:39 +0300
Message-Id: <20170606181948.16238-15-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/23] kvm-all: make async_safe_run_on_cpu safe
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Wrap the bulk of kvm_cpu_exec with cpu_exec_start/end, so that kvm
version can also enjoy performing certain operations while all vCPUs are
quiescent.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 kvm-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kvm-all.c b/kvm-all.c
index 494b925..85668fb 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1974,6 +1974,7 @@ int kvm_cpu_exec(CPUState *cpu)
     }
 
     qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
 
     do {
         MemTxAttrs attrs;
@@ -2103,6 +2104,7 @@ int kvm_cpu_exec(CPUState *cpu)
         }
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
     qemu_mutex_lock_iothread();
 
     if (ret < 0) {
-- 
2.9.4
