Received: from eggs.gnu.org ([2001:4830:134:3::10]:50046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCm-00013v-EV
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCj-000161-AL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCj-000151-1r
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE35u136850
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:00 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmh3e3s0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:00 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:59 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:15:57 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-5-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 04/55] kvmclock: use the updated
 system_timer_msr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jim Somerville <Jim.Somerville@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Jim Somerville <Jim.Somerville@windriver.com>

Fixes e2b6c17 (kvmclock: update system_time_msr address forcibly)
which makes a call to get the latest value of the address
stored in system_timer_msr, but then uses the old address anyway.

Signed-off-by: Jim Somerville <Jim.Somerville@windriver.com>
Message-Id: <59b67db0bd15a46ab47c3aa657c81a4c11f168ea.1506702472.git.Jim.Somerville@windriver.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 346b1215b1e9f7cc6d8fe9fb6f3c2778b890afb6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/kvm/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 363d1b5743..a31d8ff240 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -62,7 +62,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
 {
     CPUState *cpu = first_cpu;
     CPUX86State *env = cpu->env_ptr;
-    hwaddr kvmclock_struct_pa = env->system_time_msr & ~1ULL;
+    hwaddr kvmclock_struct_pa;
     uint64_t migration_tsc = env->tsc;
     struct pvclock_vcpu_time_info time;
     uint64_t delta;
@@ -77,6 +77,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
         return 0;
     }
 
+    kvmclock_struct_pa = env->system_time_msr & ~1ULL;
     cpu_physical_memory_read(kvmclock_struct_pa, &time, sizeof(time));
 
     assert(time.tsc_timestamp <= migration_tsc);
-- 
2.11.0
