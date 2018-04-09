Received: from eggs.gnu.org ([2001:4830:134:3::10]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWI-00061a-W0
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWF-0005NY-Pv
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:26 +0200
Message-Id: <20180409151533.2253-2-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 1/8] s390x/kvm: call
 cpu_synchronize_state() on every kvm_arch_handle_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Manually having to use cpu_synchronize_state() is error prone. And as
Christian Borntraeger discovered, e.g. handle_diag() is currently
missing a cpu_synchronize_state(), as decode_basedisp_s() uses a
general purpose register value internally.

So let's do an overall cpu_synchronize_state(), which fixes at least the
one mentioned BUG. We will clean up the superfluous cpu_synchronize_state()
calls later.

We now also call it (although maybe not neded) for
- KVM_EXIT_S390_RESET -> s390_reipl_request()
- KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
- unmanagable/unimplemented intercepts
- ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
- Scenarios where we inject an operation exception
- handle_stsi()

I don't think any of these are performance critical. Especially as we
have all information directly contained in kvm_run, there are no
additional IOCTLs to issue on modern kernels.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180406093552.13016-1-david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f570896dc1..fb59d92def 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1778,6 +1778,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 
     qemu_mutex_lock_iothread();
 
+    cpu_synchronize_state(cs);
+
     switch (run->exit_reason) {
         case KVM_EXIT_S390_SIEIC:
             ret = handle_intercept(cpu);
-- 
2.14.3
