Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz01V-00014h-H5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz01R-0007RK-6M
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:40:37 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  2 Oct 2017 14:40:29 +0200
Message-Id: <20171002124029.17407-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] kvmclock: use the updated system_timer_msr
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jim Somerville <Jim.Somerville@windriver.com>, qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

From: Jim Somerville <Jim.Somerville@windriver.com>

Fixes e2b6c17 (kvmclock: update system_time_msr address forcibly)
which makes a call to get the latest value of the address
stored in system_timer_msr, but then uses the old address anyway.

Signed-off-by: Jim Somerville <Jim.Somerville@windriver.com>
Message-Id: <59b67db0bd15a46ab47c3aa657c81a4c11f168ea.1506702472.git.Jim.Somerville@windriver.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 75ad1ba6f0..1707434db3 100644
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
2.13.6
