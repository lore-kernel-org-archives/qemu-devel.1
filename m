Received: from eggs.gnu.org ([209.51.188.92]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gta1N-0004Ks-8X
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gta16-0006yH-NL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:30:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 12 Feb 2019 16:30:25 +0100
Message-Id: <20190212153025.25425-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/kvm: add tracepoint to ioeventfd
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Trace when assigning/unassigning.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c        | 2 ++
 target/s390x/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15fdc168e1c5..7d61bd109092 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1886,6 +1886,8 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
         .addr = sch,
         .len = 8,
     };
+    trace_kvm_s390_assign_subch_ioeventfd(kick.fd, kick.addr, assign,
+                                          kick.datamatch);
     if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
         return -ENOSYS;
     }
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index a84e316e4937..bdc22f42cdbb 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -14,6 +14,7 @@ ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
+kvm_s390_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, int datamatch) "fd: %d sch: @0x%x assign: %d vq: %d"
 
 # target/s390x/cpu.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
-- 
2.17.2
