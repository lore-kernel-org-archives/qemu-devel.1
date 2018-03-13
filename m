Received: from eggs.gnu.org ([2001:4830:134:3::10]:38345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evmzf-0004w9-LI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evmzb-0006tK-7D
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:41:43 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:39145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evmza-0006t0-RS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:41:39 -0400
Received: by mail-wr0-x229.google.com with SMTP id k3so683842wrg.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:41:38 -0700 (PDT)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219])
	by smtp.gmail.com with ESMTPSA id u22sm743937wrf.86.2018.03.13.09.41.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Mar 2018 09:41:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 17:41:01 +0100
Message-Id: <1520959261-96820-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/22] KVM patches for QEMU 2.12 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fb5fff15881ba7a002924b967eb211c002897983:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180312-pull-request' into staging (2018-03-12 18:35:37 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream-sev

for you to fetch changes up to 9f750794985d7386f088da941c76b73880b2b6c4:

  sev/i386: add sev_get_capabilities() (2018-03-13 12:04:04 +0100)

----------------------------------------------------------------
* Migrate MSR_SMI_COUNT (Liran)
* Update kernel headers (Gerd, myself)
* SEV support (Brijesh)

I have not tested non-x86 compilation, but I reordered the SEV patches
so that all non-x86-specific changes go first to catch any possible
issues (which weren't there anyway :)).

----------------------------------------------------------------

v1->v2: squash fixes from Alex

Brijesh Singh (20):
      machine: add memory-encryption option
      docs: add AMD Secure Encrypted Virtualization (SEV)
      kvm: add memory encryption context
      kvm: introduce memory encryption APIs
      target/i386: add Secure Encrypted Virtualization (SEV) object
      sev/i386: qmp: add query-sev command
      include: add psp-sev.h header file
      sev/i386: add command to initialize the memory encryption context
      sev/i386: register the guest memory range which may contain encrypted data
      sev/i386: add command to create launch memory encryption context
      sev/i386: add command to encrypt guest memory region
      target/i386: encrypt bios rom
      sev/i386: add support to LAUNCH_MEASURE command
      sev/i386: finalize the SEV guest launch flow
      sev/i386: add migration blocker
      cpu/i386: populate CPUID 0x8000_001F when SEV is active
      sev/i386: hmp: add 'info sev' command
      sev/i386: qmp: add query-sev-launch-measure command
      sev/i386: qmp: add query-sev-capabilities command
      sev/i386: add sev_get_capabilities()

Liran Alon (1):
      KVM: x86: Add support for save/load MSR_SMI_COUNT

Paolo Bonzini (1):
      update Linux headers to 4.16-rc5

 accel/Makefile.objs                                |   2 +-
 accel/kvm/Makefile.objs                            |   3 +-
 accel/kvm/kvm-all.c                                |  39 +
 accel/kvm/sev-stub.c                               |  26 +
 accel/stubs/kvm-stub.c                             |  10 +
 default-configs/i386-softmmu.mak                   |   1 +
 default-configs/x86_64-softmmu.mak                 |   1 +
 docs/amd-memory-encryption.txt                     | 109 +++
 hmp-commands-info.hx                               |  16 +
 hmp.h                                              |   1 +
 hw/core/machine.c                                  |  22 +
 hw/i386/pc_sysfw.c                                 |  13 +
 include/hw/boards.h                                |   1 +
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/input.h             |  11 +
 include/standard-headers/linux/pci_regs.h          |  30 +-
 include/standard-headers/linux/virtio_net.h        |  13 +
 include/standard-headers/linux/virtio_ring.h       |   2 +-
 include/standard-headers/rdma/vmw_pvrdma-abi.h     |  13 +-
 include/sysemu/kvm.h                               |  17 +
 include/sysemu/sev.h                               |  21 +
 linux-headers/asm-powerpc/kvm.h                    |   2 +
 linux-headers/asm-powerpc/unistd.h                 |   3 +
 linux-headers/asm-s390/unistd.h                    | 401 +---------
 linux-headers/asm-s390/unistd_32.h                 | 364 +++++++++
 linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++
 linux-headers/asm-x86/kvm_para.h                   |   5 +
 linux-headers/linux/kvm.h                          |  92 +++
 linux-headers/linux/psci.h                         |   3 +
 linux-headers/linux/psp-sev.h                      | 142 ++++
 linux-headers/linux/vfio.h                         |  72 ++
 monitor.c                                          |  21 +
 qapi/misc.json                                     | 148 ++++
 qemu-options.hx                                    |  49 +-
 scripts/update-linux-headers.sh                    |   5 +-
 target/i386/Makefile.objs                          |   2 +
 target/i386/cpu.c                                  |  14 +
 target/i386/cpu.h                                  |   3 +
 target/i386/kvm.c                                  |  13 +
 target/i386/machine.c                              |  20 +
 target/i386/monitor.c                              |  66 ++
 target/i386/sev-stub.c                             |  51 ++
 target/i386/sev.c                                  | 811 +++++++++++++++++++++
 target/i386/sev_i386.h                             |  88 +++
 target/i386/trace-events                           |  10 +
 tests/qmp-test.c                                   |   5 +
 46 files changed, 2653 insertions(+), 420 deletions(-)
 create mode 100644 accel/kvm/sev-stub.c
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 include/sysemu/sev.h
 create mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 100644 linux-headers/asm-s390/unistd_64.h
 create mode 100644 linux-headers/linux/psp-sev.h
 create mode 100644 target/i386/sev-stub.c
 create mode 100644 target/i386/sev.c
 create mode 100644 target/i386/sev_i386.h
-- 
1.8.3.1


diff --git a/target/i386/sev.c b/target/i386/sev.c
index 34733f9..019d84c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -70,7 +70,7 @@ sev_ioctl(int fd, int cmd, void *data, int *error)
 
     input.id = cmd;
     input.sev_fd = fd;
-    input.data = (__u64)data;
+    input.data = (__u64)(unsigned long)data;
 
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
 
@@ -131,13 +131,13 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
     int r;
     struct kvm_enc_region range;
 
-    range.addr = (__u64)host;
+    range.addr = (__u64)(unsigned long)host;
     range.size = size;
 
     trace_kvm_memcrypt_register_region(host, size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
     if (r) {
-        error_report("%s: failed to register region (%p+%#lx) error '%s'",
+        error_report("%s: failed to register region (%p+%#zx) error '%s'",
                      __func__, host, size, strerror(errno));
         exit(1);
     }
@@ -149,13 +149,13 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
     int r;
     struct kvm_enc_region range;
 
-    range.addr = (__u64)host;
+    range.addr = (__u64)(unsigned long)host;
     range.size = size;
 
     trace_kvm_memcrypt_unregister_region(host, size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
     if (r) {
-        error_report("%s: failed to unregister region (%p+%#lx)",
+        error_report("%s: failed to unregister region (%p+%#zx)",
                      __func__, host, size);
     }
 }
@@ -588,7 +588,7 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
         return 1;
     }
 
-    update.uaddr = (__u64)addr;
+    update.uaddr = (__u64)(unsigned long)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
     ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
diff --git a/target/i386/trace-events b/target/i386/trace-events
index b1fbde6..6a19a69 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -8,8 +8,8 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 
 # target/i386/sev.c
 kvm_sev_init(void) ""
-kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
-kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%zu"
+kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%zu"
 kvm_sev_change_state(const char *old, const char *new) "%s -> %s"
 kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
