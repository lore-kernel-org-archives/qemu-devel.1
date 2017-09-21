Received: from eggs.gnu.org ([2001:4830:134:3::10]:48773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dv3uR-0007gl-P6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dv3uN-0005D8-ON
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:01:03 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:47773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dv3uN-0005CS-Iy
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:00:59 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D4DAB73737
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 18:00:57 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 21 Sep 2017 18:00:53 +0200
Message-ID: <150600965332.30533.14702405809647835716.stgit@bahia.lan>
In-Reply-To: <150600964184.30533.472565821627831467.stgit@bahia.lan>
References: <150600964184.30533.472565821627831467.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] kvm: check KVM_CAP_SYNC_MMU with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On a server-class ppc host, this capability depends on the KVM type,
ie, HV or PR. If both KVM are present in the kernel, we will always
get the HV specific value, even if we explicitely requested PR on
the command line.

This can have an impact if we're using hugepages or a balloon device.

Since we've already created the VM at the time any user calls
kvm_has_sync_mmu(), switching to kvm_vm_check_extension() is
enough to fix any potential issue.

It is okay for the other archs that also implement KVM_CAP_SYNC_MMU,
ie, mips, s390, x86 and arm, because they don't depend on the VM being
created or not.

While here, let's cache the state of this extension in a bool variable,
since it has several users in the code, as suggested by Thomas Huth.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 accel/kvm/kvm-all.c    |    8 +++++---
 accel/stubs/kvm-stub.c |    4 ++--
 include/sysemu/kvm.h   |    2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b0181d722083..4d96c1fee9fe 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -87,6 +87,7 @@ struct KVMState
 #endif
     int many_ioeventfds;
     int intx_set_mask;
+    bool sync_mmu;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
      * unsigned, and treating them as signed here can break things */
@@ -1665,6 +1666,8 @@ static int kvm_init(MachineState *ms)
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
+    s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
+
     return 0;
 
 err:
@@ -2131,10 +2134,9 @@ int kvm_device_access(int fd, int group, uint64_t attr,
     return err;
 }
 
-/* Return 1 on success, 0 on failure */
-int kvm_has_sync_mmu(void)
+bool kvm_has_sync_mmu(void)
 {
-    return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
+    return kvm_state->sync_mmu;
 }
 
 int kvm_has_vcpu_events(void)
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 3965c528d348..c964af3e1c97 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -64,9 +64,9 @@ int kvm_cpu_exec(CPUState *cpu)
     abort();
 }
 
-int kvm_has_sync_mmu(void)
+bool kvm_has_sync_mmu(void)
 {
-    return 0;
+    return false;
 }
 
 int kvm_has_many_ioeventfds(void)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3a458f50e9f4..bbf12a172339 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -207,7 +207,7 @@ extern KVMState *kvm_state;
 /* external API */
 
 bool kvm_has_free_slot(MachineState *ms);
-int kvm_has_sync_mmu(void);
+bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
