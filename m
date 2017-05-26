Received: from eggs.gnu.org ([2001:4830:134:3::10]:56442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1dEEJA-0005aj-NA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1dEEJ6-0006UW-O3
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:25:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:44475 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1dEEJ6-0006U8-Ck
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:25:28 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 26 May 2017 15:25:22 +0300
Message-Id: <1495801522-27628-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] kvmclock: update system_time_msr address
 forcibly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com

Do an update of system_time_msr address every time before reading
the value of tsc_timestamp from guest's kvmclock page.

There is no other code paths which ensure that qemu has an up-to-date
value of system_time_msr. So, force this update on guest's tsc_timestamp
reading.

This bug causes effect on those nested setups which turn off TPR access
interception for L2 guests and that access being intercepted by L0 doesn't
show up in L1.
Linux bootstrap initiate kvmclock before APIC initializing causing TPR access.
That's why on L1 guests, having TPR interception turned on for L2, the effect
of the bug is not revealed.

This patch fixes this problem by making sure it knows the correct
system_time_msr address every time it is needed.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/i386/kvm/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 0f75dd3..875d85f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -61,6 +61,8 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     uint64_t nsec_hi;
     uint64_t nsec;
 
+    cpu_synchronize_state(cpu);
+
     if (!(env->system_time_msr & 1ULL)) {
         /* KVM clock not active */
         return 0;
-- 
2.7.4
