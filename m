Received: from eggs.gnu.org ([2001:4830:134:3::10]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUw-00035F-Vo
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUv-00020y-O0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzKUv-00020g-Gq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id m72so15740071wmc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:32:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:39 +0200
Message-Id: <1507026521-19230-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] kvm: check KVM_CAP_SYNC_MMU with
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
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

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
Message-Id: <150600965332.30533.14702405809647835716.stgit@bahia.lan>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 8 +++++---
 accel/stubs/kvm-stub.c | 4 ++--
 include/sysemu/kvm.h   | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4f1997d..f54a337 100644
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
@@ -1664,6 +1665,8 @@ static int kvm_init(MachineState *ms)
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
+    s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
+
     return 0;
 
 err:
@@ -2130,10 +2133,9 @@ int kvm_device_access(int fd, int group, uint64_t attr,
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
index 3965c52..c964af3 100644
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
index 3a458f5..bbf12a1 100644
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
-- 
1.8.3.1
