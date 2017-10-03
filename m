Received: from eggs.gnu.org ([2001:4830:134:3::10]:42691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKV2-0003AW-83
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKV1-00027X-6b
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:28 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:41 +0200
Message-Id: <1507026521-19230-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] kvmclock: use the updated system_timer_msr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jim Somerville <Jim.Somerville@windriver.com>, qemu-stable@nongnu.org

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
index 75ad1ba..1707434 100644
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
1.8.3.1
