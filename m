Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZV-00030Q-TK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZQ-0006PK-Bd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9ZP-0006PC-Vt
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:28 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:29:20 +0100
Message-Id: <20170221122920.16245-3-pbonzini@redhat.com>
In-Reply-To: <20170221122920.16245-1-pbonzini@redhat.com>
References: <20170221122920.16245-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] update Linux headers to 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, mst@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |   8 +
 include/standard-headers/linux/virtio_ids.h        |   1 +
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm/unistd-common.h              | 357 ++++++++++++++++++
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +--------------------
 linux-headers/asm-arm64/kvm.h                      |  13 +
 linux-headers/asm-powerpc/kvm.h                    |  27 ++
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |  13 +-
 linux-headers/linux/kvm.h                          |  24 +-
 linux-headers/linux/kvm_para.h                     |   2 +
 linux-headers/linux/vfio.h                         |  10 +
 15 files changed, 494 insertions(+), 420 deletions(-)
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h

diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 5c10f7e..c8b3338 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -640,7 +640,7 @@
  * Control a data application associated with the currently viewed channel,
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
-#define KEY_DATA			0x275
+#define KEY_DATA			0x277
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index e5a2e68..174d114 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -23,6 +23,14 @@
 #define LINUX_PCI_REGS_H
 
 /*
+ * Conventional PCI and PCI-X Mode 1 devices have 256 bytes of
+ * configuration space.  PCI-X Mode 2 and PCIe devices have 4096 bytes of
+ * configuration space.
+ */
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
+
+/*
  * Under PCI, each device has 256 bytes of configuration address space,
  * of which the first 64 bytes are standardized as follows:
  */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index fe74e42..6d5c3b2 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,4 +43,5 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 2fb7859..1101d55 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -87,9 +87,11 @@ struct kvm_regs {
 /* Supported VGICv3 address types  */
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
+#define KVM_VGIC_ITS_ADDR_TYPE		4
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
+#define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
@@ -179,10 +181,23 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
 #define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
+#define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
+#define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
+			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
+#define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
 #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 #define KVM_DEV_ARM_VGIC_GRP_CTRL       4
+#define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
+#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
+#define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
+			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
+#define VGIC_LEVEL_INFO_LINE_LEVEL	0
+
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT    0
 
 /* KVM_IRQ_LINE irq field index values */
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
new file mode 100644
index 0000000..13a74af
--- /dev/null
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -0,0 +1,357 @@
+#ifndef _ASM_ARM_UNISTD_COMMON_H
+#define _ASM_ARM_UNISTD_COMMON_H 1
+
+#define __NR_restart_syscall (__NR_SYSCALL_BASE + 0)
+#define __NR_exit (__NR_SYSCALL_BASE + 1)
+#define __NR_fork (__NR_SYSCALL_BASE + 2)
+#define __NR_read (__NR_SYSCALL_BASE + 3)
+#define __NR_write (__NR_SYSCALL_BASE + 4)
+#define __NR_open (__NR_SYSCALL_BASE + 5)
+#define __NR_close (__NR_SYSCALL_BASE + 6)
+#define __NR_creat (__NR_SYSCALL_BASE + 8)
+#define __NR_link (__NR_SYSCALL_BASE + 9)
+#define __NR_unlink (__NR_SYSCALL_BASE + 10)
+#define __NR_execve (__NR_SYSCALL_BASE + 11)
+#define __NR_chdir (__NR_SYSCALL_BASE + 12)
+#define __NR_mknod (__NR_SYSCALL_BASE + 14)
+#define __NR_chmod (__NR_SYSCALL_BASE + 15)
+#define __NR_lchown (__NR_SYSCALL_BASE + 16)
+#define __NR_lseek (__NR_SYSCALL_BASE + 19)
+#define __NR_getpid (__NR_SYSCALL_BASE + 20)
+#define __NR_mount (__NR_SYSCALL_BASE + 21)
+#define __NR_setuid (__NR_SYSCALL_BASE + 23)
+#define __NR_getuid (__NR_SYSCALL_BASE + 24)
+#define __NR_ptrace (__NR_SYSCALL_BASE + 26)
+#define __NR_pause (__NR_SYSCALL_BASE + 29)
+#define __NR_access (__NR_SYSCALL_BASE + 33)
+#define __NR_nice (__NR_SYSCALL_BASE + 34)
+#define __NR_sync (__NR_SYSCALL_BASE + 36)
+#define __NR_kill (__NR_SYSCALL_BASE + 37)
+#define __NR_rename (__NR_SYSCALL_BASE + 38)
+#define __NR_mkdir (__NR_SYSCALL_BASE + 39)
+#define __NR_rmdir (__NR_SYSCALL_BASE + 40)
+#define __NR_dup (__NR_SYSCALL_BASE + 41)
+#define __NR_pipe (__NR_SYSCALL_BASE + 42)
+#define __NR_times (__NR_SYSCALL_BASE + 43)
+#define __NR_brk (__NR_SYSCALL_BASE + 45)
+#define __NR_setgid (__NR_SYSCALL_BASE + 46)
+#define __NR_getgid (__NR_SYSCALL_BASE + 47)
+#define __NR_geteuid (__NR_SYSCALL_BASE + 49)
+#define __NR_getegid (__NR_SYSCALL_BASE + 50)
+#define __NR_acct (__NR_SYSCALL_BASE + 51)
+#define __NR_umount2 (__NR_SYSCALL_BASE + 52)
+#define __NR_ioctl (__NR_SYSCALL_BASE + 54)
+#define __NR_fcntl (__NR_SYSCALL_BASE + 55)
+#define __NR_setpgid (__NR_SYSCALL_BASE + 57)
+#define __NR_umask (__NR_SYSCALL_BASE + 60)
+#define __NR_chroot (__NR_SYSCALL_BASE + 61)
+#define __NR_ustat (__NR_SYSCALL_BASE + 62)
+#define __NR_dup2 (__NR_SYSCALL_BASE + 63)
+#define __NR_getppid (__NR_SYSCALL_BASE + 64)
+#define __NR_getpgrp (__NR_SYSCALL_BASE + 65)
+#define __NR_setsid (__NR_SYSCALL_BASE + 66)
+#define __NR_sigaction (__NR_SYSCALL_BASE + 67)
+#define __NR_setreuid (__NR_SYSCALL_BASE + 70)
+#define __NR_setregid (__NR_SYSCALL_BASE + 71)
+#define __NR_sigsuspend (__NR_SYSCALL_BASE + 72)
+#define __NR_sigpending (__NR_SYSCALL_BASE + 73)
+#define __NR_sethostname (__NR_SYSCALL_BASE + 74)
+#define __NR_setrlimit (__NR_SYSCALL_BASE + 75)
+#define __NR_getrusage (__NR_SYSCALL_BASE + 77)
+#define __NR_gettimeofday (__NR_SYSCALL_BASE + 78)
+#define __NR_settimeofday (__NR_SYSCALL_BASE + 79)
+#define __NR_getgroups (__NR_SYSCALL_BASE + 80)
+#define __NR_setgroups (__NR_SYSCALL_BASE + 81)
+#define __NR_symlink (__NR_SYSCALL_BASE + 83)
+#define __NR_readlink (__NR_SYSCALL_BASE + 85)
+#define __NR_uselib (__NR_SYSCALL_BASE + 86)
+#define __NR_swapon (__NR_SYSCALL_BASE + 87)
+#define __NR_reboot (__NR_SYSCALL_BASE + 88)
+#define __NR_munmap (__NR_SYSCALL_BASE + 91)
+#define __NR_truncate (__NR_SYSCALL_BASE + 92)
+#define __NR_ftruncate (__NR_SYSCALL_BASE + 93)
+#define __NR_fchmod (__NR_SYSCALL_BASE + 94)
+#define __NR_fchown (__NR_SYSCALL_BASE + 95)
+#define __NR_getpriority (__NR_SYSCALL_BASE + 96)
+#define __NR_setpriority (__NR_SYSCALL_BASE + 97)
+#define __NR_statfs (__NR_SYSCALL_BASE + 99)
+#define __NR_fstatfs (__NR_SYSCALL_BASE + 100)
+#define __NR_syslog (__NR_SYSCALL_BASE + 103)
+#define __NR_setitimer (__NR_SYSCALL_BASE + 104)
+#define __NR_getitimer (__NR_SYSCALL_BASE + 105)
+#define __NR_stat (__NR_SYSCALL_BASE + 106)
+#define __NR_lstat (__NR_SYSCALL_BASE + 107)
+#define __NR_fstat (__NR_SYSCALL_BASE + 108)
+#define __NR_vhangup (__NR_SYSCALL_BASE + 111)
+#define __NR_wait4 (__NR_SYSCALL_BASE + 114)
+#define __NR_swapoff (__NR_SYSCALL_BASE + 115)
+#define __NR_sysinfo (__NR_SYSCALL_BASE + 116)
+#define __NR_fsync (__NR_SYSCALL_BASE + 118)
+#define __NR_sigreturn (__NR_SYSCALL_BASE + 119)
+#define __NR_clone (__NR_SYSCALL_BASE + 120)
+#define __NR_setdomainname (__NR_SYSCALL_BASE + 121)
+#define __NR_uname (__NR_SYSCALL_BASE + 122)
+#define __NR_adjtimex (__NR_SYSCALL_BASE + 124)
+#define __NR_mprotect (__NR_SYSCALL_BASE + 125)
+#define __NR_sigprocmask (__NR_SYSCALL_BASE + 126)
+#define __NR_init_module (__NR_SYSCALL_BASE + 128)
+#define __NR_delete_module (__NR_SYSCALL_BASE + 129)
+#define __NR_quotactl (__NR_SYSCALL_BASE + 131)
+#define __NR_getpgid (__NR_SYSCALL_BASE + 132)
+#define __NR_fchdir (__NR_SYSCALL_BASE + 133)
+#define __NR_bdflush (__NR_SYSCALL_BASE + 134)
+#define __NR_sysfs (__NR_SYSCALL_BASE + 135)
+#define __NR_personality (__NR_SYSCALL_BASE + 136)
+#define __NR_setfsuid (__NR_SYSCALL_BASE + 138)
+#define __NR_setfsgid (__NR_SYSCALL_BASE + 139)
+#define __NR__llseek (__NR_SYSCALL_BASE + 140)
+#define __NR_getdents (__NR_SYSCALL_BASE + 141)
+#define __NR__newselect (__NR_SYSCALL_BASE + 142)
+#define __NR_flock (__NR_SYSCALL_BASE + 143)
+#define __NR_msync (__NR_SYSCALL_BASE + 144)
+#define __NR_readv (__NR_SYSCALL_BASE + 145)
+#define __NR_writev (__NR_SYSCALL_BASE + 146)
+#define __NR_getsid (__NR_SYSCALL_BASE + 147)
+#define __NR_fdatasync (__NR_SYSCALL_BASE + 148)
+#define __NR__sysctl (__NR_SYSCALL_BASE + 149)
+#define __NR_mlock (__NR_SYSCALL_BASE + 150)
+#define __NR_munlock (__NR_SYSCALL_BASE + 151)
+#define __NR_mlockall (__NR_SYSCALL_BASE + 152)
+#define __NR_munlockall (__NR_SYSCALL_BASE + 153)
+#define __NR_sched_setparam (__NR_SYSCALL_BASE + 154)
+#define __NR_sched_getparam (__NR_SYSCALL_BASE + 155)
+#define __NR_sched_setscheduler (__NR_SYSCALL_BASE + 156)
+#define __NR_sched_getscheduler (__NR_SYSCALL_BASE + 157)
+#define __NR_sched_yield (__NR_SYSCALL_BASE + 158)
+#define __NR_sched_get_priority_max (__NR_SYSCALL_BASE + 159)
+#define __NR_sched_get_priority_min (__NR_SYSCALL_BASE + 160)
+#define __NR_sched_rr_get_interval (__NR_SYSCALL_BASE + 161)
+#define __NR_nanosleep (__NR_SYSCALL_BASE + 162)
+#define __NR_mremap (__NR_SYSCALL_BASE + 163)
+#define __NR_setresuid (__NR_SYSCALL_BASE + 164)
+#define __NR_getresuid (__NR_SYSCALL_BASE + 165)
+#define __NR_poll (__NR_SYSCALL_BASE + 168)
+#define __NR_nfsservctl (__NR_SYSCALL_BASE + 169)
+#define __NR_setresgid (__NR_SYSCALL_BASE + 170)
+#define __NR_getresgid (__NR_SYSCALL_BASE + 171)
+#define __NR_prctl (__NR_SYSCALL_BASE + 172)
+#define __NR_rt_sigreturn (__NR_SYSCALL_BASE + 173)
+#define __NR_rt_sigaction (__NR_SYSCALL_BASE + 174)
+#define __NR_rt_sigprocmask (__NR_SYSCALL_BASE + 175)
+#define __NR_rt_sigpending (__NR_SYSCALL_BASE + 176)
+#define __NR_rt_sigtimedwait (__NR_SYSCALL_BASE + 177)
+#define __NR_rt_sigqueueinfo (__NR_SYSCALL_BASE + 178)
+#define __NR_rt_sigsuspend (__NR_SYSCALL_BASE + 179)
+#define __NR_pread64 (__NR_SYSCALL_BASE + 180)
+#define __NR_pwrite64 (__NR_SYSCALL_BASE + 181)
+#define __NR_chown (__NR_SYSCALL_BASE + 182)
+#define __NR_getcwd (__NR_SYSCALL_BASE + 183)
+#define __NR_capget (__NR_SYSCALL_BASE + 184)
+#define __NR_capset (__NR_SYSCALL_BASE + 185)
+#define __NR_sigaltstack (__NR_SYSCALL_BASE + 186)
+#define __NR_sendfile (__NR_SYSCALL_BASE + 187)
+#define __NR_vfork (__NR_SYSCALL_BASE + 190)
+#define __NR_ugetrlimit (__NR_SYSCALL_BASE + 191)
+#define __NR_mmap2 (__NR_SYSCALL_BASE + 192)
+#define __NR_truncate64 (__NR_SYSCALL_BASE + 193)
+#define __NR_ftruncate64 (__NR_SYSCALL_BASE + 194)
+#define __NR_stat64 (__NR_SYSCALL_BASE + 195)
+#define __NR_lstat64 (__NR_SYSCALL_BASE + 196)
+#define __NR_fstat64 (__NR_SYSCALL_BASE + 197)
+#define __NR_lchown32 (__NR_SYSCALL_BASE + 198)
+#define __NR_getuid32 (__NR_SYSCALL_BASE + 199)
+#define __NR_getgid32 (__NR_SYSCALL_BASE + 200)
+#define __NR_geteuid32 (__NR_SYSCALL_BASE + 201)
+#define __NR_getegid32 (__NR_SYSCALL_BASE + 202)
+#define __NR_setreuid32 (__NR_SYSCALL_BASE + 203)
+#define __NR_setregid32 (__NR_SYSCALL_BASE + 204)
+#define __NR_getgroups32 (__NR_SYSCALL_BASE + 205)
+#define __NR_setgroups32 (__NR_SYSCALL_BASE + 206)
+#define __NR_fchown32 (__NR_SYSCALL_BASE + 207)
+#define __NR_setresuid32 (__NR_SYSCALL_BASE + 208)
+#define __NR_getresuid32 (__NR_SYSCALL_BASE + 209)
+#define __NR_setresgid32 (__NR_SYSCALL_BASE + 210)
+#define __NR_getresgid32 (__NR_SYSCALL_BASE + 211)
+#define __NR_chown32 (__NR_SYSCALL_BASE + 212)
+#define __NR_setuid32 (__NR_SYSCALL_BASE + 213)
+#define __NR_setgid32 (__NR_SYSCALL_BASE + 214)
+#define __NR_setfsuid32 (__NR_SYSCALL_BASE + 215)
+#define __NR_setfsgid32 (__NR_SYSCALL_BASE + 216)
+#define __NR_getdents64 (__NR_SYSCALL_BASE + 217)
+#define __NR_pivot_root (__NR_SYSCALL_BASE + 218)
+#define __NR_mincore (__NR_SYSCALL_BASE + 219)
+#define __NR_madvise (__NR_SYSCALL_BASE + 220)
+#define __NR_fcntl64 (__NR_SYSCALL_BASE + 221)
+#define __NR_gettid (__NR_SYSCALL_BASE + 224)
+#define __NR_readahead (__NR_SYSCALL_BASE + 225)
+#define __NR_setxattr (__NR_SYSCALL_BASE + 226)
+#define __NR_lsetxattr (__NR_SYSCALL_BASE + 227)
+#define __NR_fsetxattr (__NR_SYSCALL_BASE + 228)
+#define __NR_getxattr (__NR_SYSCALL_BASE + 229)
+#define __NR_lgetxattr (__NR_SYSCALL_BASE + 230)
+#define __NR_fgetxattr (__NR_SYSCALL_BASE + 231)
+#define __NR_listxattr (__NR_SYSCALL_BASE + 232)
+#define __NR_llistxattr (__NR_SYSCALL_BASE + 233)
+#define __NR_flistxattr (__NR_SYSCALL_BASE + 234)
+#define __NR_removexattr (__NR_SYSCALL_BASE + 235)
+#define __NR_lremovexattr (__NR_SYSCALL_BASE + 236)
+#define __NR_fremovexattr (__NR_SYSCALL_BASE + 237)
+#define __NR_tkill (__NR_SYSCALL_BASE + 238)
+#define __NR_sendfile64 (__NR_SYSCALL_BASE + 239)
+#define __NR_futex (__NR_SYSCALL_BASE + 240)
+#define __NR_sched_setaffinity (__NR_SYSCALL_BASE + 241)
+#define __NR_sched_getaffinity (__NR_SYSCALL_BASE + 242)
+#define __NR_io_setup (__NR_SYSCALL_BASE + 243)
+#define __NR_io_destroy (__NR_SYSCALL_BASE + 244)
+#define __NR_io_getevents (__NR_SYSCALL_BASE + 245)
+#define __NR_io_submit (__NR_SYSCALL_BASE + 246)
+#define __NR_io_cancel (__NR_SYSCALL_BASE + 247)
+#define __NR_exit_group (__NR_SYSCALL_BASE + 248)
+#define __NR_lookup_dcookie (__NR_SYSCALL_BASE + 249)
+#define __NR_epoll_create (__NR_SYSCALL_BASE + 250)
+#define __NR_epoll_ctl (__NR_SYSCALL_BASE + 251)
+#define __NR_epoll_wait (__NR_SYSCALL_BASE + 252)
+#define __NR_remap_file_pages (__NR_SYSCALL_BASE + 253)
+#define __NR_set_tid_address (__NR_SYSCALL_BASE + 256)
+#define __NR_timer_create (__NR_SYSCALL_BASE + 257)
+#define __NR_timer_settime (__NR_SYSCALL_BASE + 258)
+#define __NR_timer_gettime (__NR_SYSCALL_BASE + 259)
+#define __NR_timer_getoverrun (__NR_SYSCALL_BASE + 260)
+#define __NR_timer_delete (__NR_SYSCALL_BASE + 261)
+#define __NR_clock_settime (__NR_SYSCALL_BASE + 262)
+#define __NR_clock_gettime (__NR_SYSCALL_BASE + 263)
+#define __NR_clock_getres (__NR_SYSCALL_BASE + 264)
+#define __NR_clock_nanosleep (__NR_SYSCALL_BASE + 265)
+#define __NR_statfs64 (__NR_SYSCALL_BASE + 266)
+#define __NR_fstatfs64 (__NR_SYSCALL_BASE + 267)
+#define __NR_tgkill (__NR_SYSCALL_BASE + 268)
+#define __NR_utimes (__NR_SYSCALL_BASE + 269)
+#define __NR_arm_fadvise64_64 (__NR_SYSCALL_BASE + 270)
+#define __NR_pciconfig_iobase (__NR_SYSCALL_BASE + 271)
+#define __NR_pciconfig_read (__NR_SYSCALL_BASE + 272)
+#define __NR_pciconfig_write (__NR_SYSCALL_BASE + 273)
+#define __NR_mq_open (__NR_SYSCALL_BASE + 274)
+#define __NR_mq_unlink (__NR_SYSCALL_BASE + 275)
+#define __NR_mq_timedsend (__NR_SYSCALL_BASE + 276)
+#define __NR_mq_timedreceive (__NR_SYSCALL_BASE + 277)
+#define __NR_mq_notify (__NR_SYSCALL_BASE + 278)
+#define __NR_mq_getsetattr (__NR_SYSCALL_BASE + 279)
+#define __NR_waitid (__NR_SYSCALL_BASE + 280)
+#define __NR_socket (__NR_SYSCALL_BASE + 281)
+#define __NR_bind (__NR_SYSCALL_BASE + 282)
+#define __NR_connect (__NR_SYSCALL_BASE + 283)
+#define __NR_listen (__NR_SYSCALL_BASE + 284)
+#define __NR_accept (__NR_SYSCALL_BASE + 285)
+#define __NR_getsockname (__NR_SYSCALL_BASE + 286)
+#define __NR_getpeername (__NR_SYSCALL_BASE + 287)
+#define __NR_socketpair (__NR_SYSCALL_BASE + 288)
+#define __NR_send (__NR_SYSCALL_BASE + 289)
+#define __NR_sendto (__NR_SYSCALL_BASE + 290)
+#define __NR_recv (__NR_SYSCALL_BASE + 291)
+#define __NR_recvfrom (__NR_SYSCALL_BASE + 292)
+#define __NR_shutdown (__NR_SYSCALL_BASE + 293)
+#define __NR_setsockopt (__NR_SYSCALL_BASE + 294)
+#define __NR_getsockopt (__NR_SYSCALL_BASE + 295)
+#define __NR_sendmsg (__NR_SYSCALL_BASE + 296)
+#define __NR_recvmsg (__NR_SYSCALL_BASE + 297)
+#define __NR_semop (__NR_SYSCALL_BASE + 298)
+#define __NR_semget (__NR_SYSCALL_BASE + 299)
+#define __NR_semctl (__NR_SYSCALL_BASE + 300)
+#define __NR_msgsnd (__NR_SYSCALL_BASE + 301)
+#define __NR_msgrcv (__NR_SYSCALL_BASE + 302)
+#define __NR_msgget (__NR_SYSCALL_BASE + 303)
+#define __NR_msgctl (__NR_SYSCALL_BASE + 304)
+#define __NR_shmat (__NR_SYSCALL_BASE + 305)
+#define __NR_shmdt (__NR_SYSCALL_BASE + 306)
+#define __NR_shmget (__NR_SYSCALL_BASE + 307)
+#define __NR_shmctl (__NR_SYSCALL_BASE + 308)
+#define __NR_add_key (__NR_SYSCALL_BASE + 309)
+#define __NR_request_key (__NR_SYSCALL_BASE + 310)
+#define __NR_keyctl (__NR_SYSCALL_BASE + 311)
+#define __NR_semtimedop (__NR_SYSCALL_BASE + 312)
+#define __NR_vserver (__NR_SYSCALL_BASE + 313)
+#define __NR_ioprio_set (__NR_SYSCALL_BASE + 314)
+#define __NR_ioprio_get (__NR_SYSCALL_BASE + 315)
+#define __NR_inotify_init (__NR_SYSCALL_BASE + 316)
+#define __NR_inotify_add_watch (__NR_SYSCALL_BASE + 317)
+#define __NR_inotify_rm_watch (__NR_SYSCALL_BASE + 318)
+#define __NR_mbind (__NR_SYSCALL_BASE + 319)
+#define __NR_get_mempolicy (__NR_SYSCALL_BASE + 320)
+#define __NR_set_mempolicy (__NR_SYSCALL_BASE + 321)
+#define __NR_openat (__NR_SYSCALL_BASE + 322)
+#define __NR_mkdirat (__NR_SYSCALL_BASE + 323)
+#define __NR_mknodat (__NR_SYSCALL_BASE + 324)
+#define __NR_fchownat (__NR_SYSCALL_BASE + 325)
+#define __NR_futimesat (__NR_SYSCALL_BASE + 326)
+#define __NR_fstatat64 (__NR_SYSCALL_BASE + 327)
+#define __NR_unlinkat (__NR_SYSCALL_BASE + 328)
+#define __NR_renameat (__NR_SYSCALL_BASE + 329)
+#define __NR_linkat (__NR_SYSCALL_BASE + 330)
+#define __NR_symlinkat (__NR_SYSCALL_BASE + 331)
+#define __NR_readlinkat (__NR_SYSCALL_BASE + 332)
+#define __NR_fchmodat (__NR_SYSCALL_BASE + 333)
+#define __NR_faccessat (__NR_SYSCALL_BASE + 334)
+#define __NR_pselect6 (__NR_SYSCALL_BASE + 335)
+#define __NR_ppoll (__NR_SYSCALL_BASE + 336)
+#define __NR_unshare (__NR_SYSCALL_BASE + 337)
+#define __NR_set_robust_list (__NR_SYSCALL_BASE + 338)
+#define __NR_get_robust_list (__NR_SYSCALL_BASE + 339)
+#define __NR_splice (__NR_SYSCALL_BASE + 340)
+#define __NR_arm_sync_file_range (__NR_SYSCALL_BASE + 341)
+#define __NR_tee (__NR_SYSCALL_BASE + 342)
+#define __NR_vmsplice (__NR_SYSCALL_BASE + 343)
+#define __NR_move_pages (__NR_SYSCALL_BASE + 344)
+#define __NR_getcpu (__NR_SYSCALL_BASE + 345)
+#define __NR_epoll_pwait (__NR_SYSCALL_BASE + 346)
+#define __NR_kexec_load (__NR_SYSCALL_BASE + 347)
+#define __NR_utimensat (__NR_SYSCALL_BASE + 348)
+#define __NR_signalfd (__NR_SYSCALL_BASE + 349)
+#define __NR_timerfd_create (__NR_SYSCALL_BASE + 350)
+#define __NR_eventfd (__NR_SYSCALL_BASE + 351)
+#define __NR_fallocate (__NR_SYSCALL_BASE + 352)
+#define __NR_timerfd_settime (__NR_SYSCALL_BASE + 353)
+#define __NR_timerfd_gettime (__NR_SYSCALL_BASE + 354)
+#define __NR_signalfd4 (__NR_SYSCALL_BASE + 355)
+#define __NR_eventfd2 (__NR_SYSCALL_BASE + 356)
+#define __NR_epoll_create1 (__NR_SYSCALL_BASE + 357)
+#define __NR_dup3 (__NR_SYSCALL_BASE + 358)
+#define __NR_pipe2 (__NR_SYSCALL_BASE + 359)
+#define __NR_inotify_init1 (__NR_SYSCALL_BASE + 360)
+#define __NR_preadv (__NR_SYSCALL_BASE + 361)
+#define __NR_pwritev (__NR_SYSCALL_BASE + 362)
+#define __NR_rt_tgsigqueueinfo (__NR_SYSCALL_BASE + 363)
+#define __NR_perf_event_open (__NR_SYSCALL_BASE + 364)
+#define __NR_recvmmsg (__NR_SYSCALL_BASE + 365)
+#define __NR_accept4 (__NR_SYSCALL_BASE + 366)
+#define __NR_fanotify_init (__NR_SYSCALL_BASE + 367)
+#define __NR_fanotify_mark (__NR_SYSCALL_BASE + 368)
+#define __NR_prlimit64 (__NR_SYSCALL_BASE + 369)
+#define __NR_name_to_handle_at (__NR_SYSCALL_BASE + 370)
+#define __NR_open_by_handle_at (__NR_SYSCALL_BASE + 371)
+#define __NR_clock_adjtime (__NR_SYSCALL_BASE + 372)
+#define __NR_syncfs (__NR_SYSCALL_BASE + 373)
+#define __NR_sendmmsg (__NR_SYSCALL_BASE + 374)
+#define __NR_setns (__NR_SYSCALL_BASE + 375)
+#define __NR_process_vm_readv (__NR_SYSCALL_BASE + 376)
+#define __NR_process_vm_writev (__NR_SYSCALL_BASE + 377)
+#define __NR_kcmp (__NR_SYSCALL_BASE + 378)
+#define __NR_finit_module (__NR_SYSCALL_BASE + 379)
+#define __NR_sched_setattr (__NR_SYSCALL_BASE + 380)
+#define __NR_sched_getattr (__NR_SYSCALL_BASE + 381)
+#define __NR_renameat2 (__NR_SYSCALL_BASE + 382)
+#define __NR_seccomp (__NR_SYSCALL_BASE + 383)
+#define __NR_getrandom (__NR_SYSCALL_BASE + 384)
+#define __NR_memfd_create (__NR_SYSCALL_BASE + 385)
+#define __NR_bpf (__NR_SYSCALL_BASE + 386)
+#define __NR_execveat (__NR_SYSCALL_BASE + 387)
+#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
+#define __NR_membarrier (__NR_SYSCALL_BASE + 389)
+#define __NR_mlock2 (__NR_SYSCALL_BASE + 390)
+#define __NR_copy_file_range (__NR_SYSCALL_BASE + 391)
+#define __NR_preadv2 (__NR_SYSCALL_BASE + 392)
+#define __NR_pwritev2 (__NR_SYSCALL_BASE + 393)
+#define __NR_pkey_mprotect (__NR_SYSCALL_BASE + 394)
+#define __NR_pkey_alloc (__NR_SYSCALL_BASE + 395)
+#define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
+
+#endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm/unistd-eabi.h b/linux-headers/asm-arm/unistd-eabi.h
new file mode 100644
index 0000000..266f1fc
--- /dev/null
+++ b/linux-headers/asm-arm/unistd-eabi.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_ARM_UNISTD_EABI_H
+#define _ASM_ARM_UNISTD_EABI_H 1
+
+
+#endif /* _ASM_ARM_UNISTD_EABI_H */
diff --git a/linux-headers/asm-arm/unistd-oabi.h b/linux-headers/asm-arm/unistd-oabi.h
new file mode 100644
index 0000000..47d9afb
--- /dev/null
+++ b/linux-headers/asm-arm/unistd-oabi.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_ARM_UNISTD_OABI_H
+#define _ASM_ARM_UNISTD_OABI_H 1
+
+#define __NR_time (__NR_SYSCALL_BASE + 13)
+#define __NR_umount (__NR_SYSCALL_BASE + 22)
+#define __NR_stime (__NR_SYSCALL_BASE + 25)
+#define __NR_alarm (__NR_SYSCALL_BASE + 27)
+#define __NR_utime (__NR_SYSCALL_BASE + 30)
+#define __NR_getrlimit (__NR_SYSCALL_BASE + 76)
+#define __NR_select (__NR_SYSCALL_BASE + 82)
+#define __NR_readdir (__NR_SYSCALL_BASE + 89)
+#define __NR_mmap (__NR_SYSCALL_BASE + 90)
+#define __NR_socketcall (__NR_SYSCALL_BASE + 102)
+#define __NR_syscall (__NR_SYSCALL_BASE + 113)
+#define __NR_ipc (__NR_SYSCALL_BASE + 117)
+
+#endif /* _ASM_ARM_UNISTD_OABI_H */
diff --git a/linux-headers/asm-arm/unistd.h b/linux-headers/asm-arm/unistd.h
index ceb5450..155571b 100644
--- a/linux-headers/asm-arm/unistd.h
+++ b/linux-headers/asm-arm/unistd.h
@@ -17,409 +17,14 @@
 
 #if defined(__thumb__) || defined(__ARM_EABI__)
 #define __NR_SYSCALL_BASE	0
+#include <asm/unistd-eabi.h>
 #else
 #define __NR_SYSCALL_BASE	__NR_OABI_SYSCALL_BASE
+#include <asm/unistd-oabi.h>
 #endif
 
-/*
- * This file contains the system call numbers.
- */
-
-#define __NR_restart_syscall		(__NR_SYSCALL_BASE+  0)
-#define __NR_exit			(__NR_SYSCALL_BASE+  1)
-#define __NR_fork			(__NR_SYSCALL_BASE+  2)
-#define __NR_read			(__NR_SYSCALL_BASE+  3)
-#define __NR_write			(__NR_SYSCALL_BASE+  4)
-#define __NR_open			(__NR_SYSCALL_BASE+  5)
-#define __NR_close			(__NR_SYSCALL_BASE+  6)
-					/* 7 was sys_waitpid */
-#define __NR_creat			(__NR_SYSCALL_BASE+  8)
-#define __NR_link			(__NR_SYSCALL_BASE+  9)
-#define __NR_unlink			(__NR_SYSCALL_BASE+ 10)
-#define __NR_execve			(__NR_SYSCALL_BASE+ 11)
-#define __NR_chdir			(__NR_SYSCALL_BASE+ 12)
-#define __NR_time			(__NR_SYSCALL_BASE+ 13)
-#define __NR_mknod			(__NR_SYSCALL_BASE+ 14)
-#define __NR_chmod			(__NR_SYSCALL_BASE+ 15)
-#define __NR_lchown			(__NR_SYSCALL_BASE+ 16)
-					/* 17 was sys_break */
-					/* 18 was sys_stat */
-#define __NR_lseek			(__NR_SYSCALL_BASE+ 19)
-#define __NR_getpid			(__NR_SYSCALL_BASE+ 20)
-#define __NR_mount			(__NR_SYSCALL_BASE+ 21)
-#define __NR_umount			(__NR_SYSCALL_BASE+ 22)
-#define __NR_setuid			(__NR_SYSCALL_BASE+ 23)
-#define __NR_getuid			(__NR_SYSCALL_BASE+ 24)
-#define __NR_stime			(__NR_SYSCALL_BASE+ 25)
-#define __NR_ptrace			(__NR_SYSCALL_BASE+ 26)
-#define __NR_alarm			(__NR_SYSCALL_BASE+ 27)
-					/* 28 was sys_fstat */
-#define __NR_pause			(__NR_SYSCALL_BASE+ 29)
-#define __NR_utime			(__NR_SYSCALL_BASE+ 30)
-					/* 31 was sys_stty */
-					/* 32 was sys_gtty */
-#define __NR_access			(__NR_SYSCALL_BASE+ 33)
-#define __NR_nice			(__NR_SYSCALL_BASE+ 34)
-					/* 35 was sys_ftime */
-#define __NR_sync			(__NR_SYSCALL_BASE+ 36)
-#define __NR_kill			(__NR_SYSCALL_BASE+ 37)
-#define __NR_rename			(__NR_SYSCALL_BASE+ 38)
-#define __NR_mkdir			(__NR_SYSCALL_BASE+ 39)
-#define __NR_rmdir			(__NR_SYSCALL_BASE+ 40)
-#define __NR_dup			(__NR_SYSCALL_BASE+ 41)
-#define __NR_pipe			(__NR_SYSCALL_BASE+ 42)
-#define __NR_times			(__NR_SYSCALL_BASE+ 43)
-					/* 44 was sys_prof */
-#define __NR_brk			(__NR_SYSCALL_BASE+ 45)
-#define __NR_setgid			(__NR_SYSCALL_BASE+ 46)
-#define __NR_getgid			(__NR_SYSCALL_BASE+ 47)
-					/* 48 was sys_signal */
-#define __NR_geteuid			(__NR_SYSCALL_BASE+ 49)
-#define __NR_getegid			(__NR_SYSCALL_BASE+ 50)
-#define __NR_acct			(__NR_SYSCALL_BASE+ 51)
-#define __NR_umount2			(__NR_SYSCALL_BASE+ 52)
-					/* 53 was sys_lock */
-#define __NR_ioctl			(__NR_SYSCALL_BASE+ 54)
-#define __NR_fcntl			(__NR_SYSCALL_BASE+ 55)
-					/* 56 was sys_mpx */
-#define __NR_setpgid			(__NR_SYSCALL_BASE+ 57)
-					/* 58 was sys_ulimit */
-					/* 59 was sys_olduname */
-#define __NR_umask			(__NR_SYSCALL_BASE+ 60)
-#define __NR_chroot			(__NR_SYSCALL_BASE+ 61)
-#define __NR_ustat			(__NR_SYSCALL_BASE+ 62)
-#define __NR_dup2			(__NR_SYSCALL_BASE+ 63)
-#define __NR_getppid			(__NR_SYSCALL_BASE+ 64)
-#define __NR_getpgrp			(__NR_SYSCALL_BASE+ 65)
-#define __NR_setsid			(__NR_SYSCALL_BASE+ 66)
-#define __NR_sigaction			(__NR_SYSCALL_BASE+ 67)
-					/* 68 was sys_sgetmask */
-					/* 69 was sys_ssetmask */
-#define __NR_setreuid			(__NR_SYSCALL_BASE+ 70)
-#define __NR_setregid			(__NR_SYSCALL_BASE+ 71)
-#define __NR_sigsuspend			(__NR_SYSCALL_BASE+ 72)
-#define __NR_sigpending			(__NR_SYSCALL_BASE+ 73)
-#define __NR_sethostname		(__NR_SYSCALL_BASE+ 74)
-#define __NR_setrlimit			(__NR_SYSCALL_BASE+ 75)
-#define __NR_getrlimit			(__NR_SYSCALL_BASE+ 76)	/* Back compat 2GB limited rlimit */
-#define __NR_getrusage			(__NR_SYSCALL_BASE+ 77)
-#define __NR_gettimeofday		(__NR_SYSCALL_BASE+ 78)
-#define __NR_settimeofday		(__NR_SYSCALL_BASE+ 79)
-#define __NR_getgroups			(__NR_SYSCALL_BASE+ 80)
-#define __NR_setgroups			(__NR_SYSCALL_BASE+ 81)
-#define __NR_select			(__NR_SYSCALL_BASE+ 82)
-#define __NR_symlink			(__NR_SYSCALL_BASE+ 83)
-					/* 84 was sys_lstat */
-#define __NR_readlink			(__NR_SYSCALL_BASE+ 85)
-#define __NR_uselib			(__NR_SYSCALL_BASE+ 86)
-#define __NR_swapon			(__NR_SYSCALL_BASE+ 87)
-#define __NR_reboot			(__NR_SYSCALL_BASE+ 88)
-#define __NR_readdir			(__NR_SYSCALL_BASE+ 89)
-#define __NR_mmap			(__NR_SYSCALL_BASE+ 90)
-#define __NR_munmap			(__NR_SYSCALL_BASE+ 91)
-#define __NR_truncate			(__NR_SYSCALL_BASE+ 92)
-#define __NR_ftruncate			(__NR_SYSCALL_BASE+ 93)
-#define __NR_fchmod			(__NR_SYSCALL_BASE+ 94)
-#define __NR_fchown			(__NR_SYSCALL_BASE+ 95)
-#define __NR_getpriority		(__NR_SYSCALL_BASE+ 96)
-#define __NR_setpriority		(__NR_SYSCALL_BASE+ 97)
-					/* 98 was sys_profil */
-#define __NR_statfs			(__NR_SYSCALL_BASE+ 99)
-#define __NR_fstatfs			(__NR_SYSCALL_BASE+100)
-					/* 101 was sys_ioperm */
-#define __NR_socketcall			(__NR_SYSCALL_BASE+102)
-#define __NR_syslog			(__NR_SYSCALL_BASE+103)
-#define __NR_setitimer			(__NR_SYSCALL_BASE+104)
-#define __NR_getitimer			(__NR_SYSCALL_BASE+105)
-#define __NR_stat			(__NR_SYSCALL_BASE+106)
-#define __NR_lstat			(__NR_SYSCALL_BASE+107)
-#define __NR_fstat			(__NR_SYSCALL_BASE+108)
-					/* 109 was sys_uname */
-					/* 110 was sys_iopl */
-#define __NR_vhangup			(__NR_SYSCALL_BASE+111)
-					/* 112 was sys_idle */
-#define __NR_syscall			(__NR_SYSCALL_BASE+113) /* syscall to call a syscall! */
-#define __NR_wait4			(__NR_SYSCALL_BASE+114)
-#define __NR_swapoff			(__NR_SYSCALL_BASE+115)
-#define __NR_sysinfo			(__NR_SYSCALL_BASE+116)
-#define __NR_ipc			(__NR_SYSCALL_BASE+117)
-#define __NR_fsync			(__NR_SYSCALL_BASE+118)
-#define __NR_sigreturn			(__NR_SYSCALL_BASE+119)
-#define __NR_clone			(__NR_SYSCALL_BASE+120)
-#define __NR_setdomainname		(__NR_SYSCALL_BASE+121)
-#define __NR_uname			(__NR_SYSCALL_BASE+122)
-					/* 123 was sys_modify_ldt */
-#define __NR_adjtimex			(__NR_SYSCALL_BASE+124)
-#define __NR_mprotect			(__NR_SYSCALL_BASE+125)
-#define __NR_sigprocmask		(__NR_SYSCALL_BASE+126)
-					/* 127 was sys_create_module */
-#define __NR_init_module		(__NR_SYSCALL_BASE+128)
-#define __NR_delete_module		(__NR_SYSCALL_BASE+129)
-					/* 130 was sys_get_kernel_syms */
-#define __NR_quotactl			(__NR_SYSCALL_BASE+131)
-#define __NR_getpgid			(__NR_SYSCALL_BASE+132)
-#define __NR_fchdir			(__NR_SYSCALL_BASE+133)
-#define __NR_bdflush			(__NR_SYSCALL_BASE+134)
-#define __NR_sysfs			(__NR_SYSCALL_BASE+135)
-#define __NR_personality		(__NR_SYSCALL_BASE+136)
-					/* 137 was sys_afs_syscall */
-#define __NR_setfsuid			(__NR_SYSCALL_BASE+138)
-#define __NR_setfsgid			(__NR_SYSCALL_BASE+139)
-#define __NR__llseek			(__NR_SYSCALL_BASE+140)
-#define __NR_getdents			(__NR_SYSCALL_BASE+141)
-#define __NR__newselect			(__NR_SYSCALL_BASE+142)
-#define __NR_flock			(__NR_SYSCALL_BASE+143)
-#define __NR_msync			(__NR_SYSCALL_BASE+144)
-#define __NR_readv			(__NR_SYSCALL_BASE+145)
-#define __NR_writev			(__NR_SYSCALL_BASE+146)
-#define __NR_getsid			(__NR_SYSCALL_BASE+147)
-#define __NR_fdatasync			(__NR_SYSCALL_BASE+148)
-#define __NR__sysctl			(__NR_SYSCALL_BASE+149)
-#define __NR_mlock			(__NR_SYSCALL_BASE+150)
-#define __NR_munlock			(__NR_SYSCALL_BASE+151)
-#define __NR_mlockall			(__NR_SYSCALL_BASE+152)
-#define __NR_munlockall			(__NR_SYSCALL_BASE+153)
-#define __NR_sched_setparam		(__NR_SYSCALL_BASE+154)
-#define __NR_sched_getparam		(__NR_SYSCALL_BASE+155)
-#define __NR_sched_setscheduler		(__NR_SYSCALL_BASE+156)
-#define __NR_sched_getscheduler		(__NR_SYSCALL_BASE+157)
-#define __NR_sched_yield		(__NR_SYSCALL_BASE+158)
-#define __NR_sched_get_priority_max	(__NR_SYSCALL_BASE+159)
-#define __NR_sched_get_priority_min	(__NR_SYSCALL_BASE+160)
-#define __NR_sched_rr_get_interval	(__NR_SYSCALL_BASE+161)
-#define __NR_nanosleep			(__NR_SYSCALL_BASE+162)
-#define __NR_mremap			(__NR_SYSCALL_BASE+163)
-#define __NR_setresuid			(__NR_SYSCALL_BASE+164)
-#define __NR_getresuid			(__NR_SYSCALL_BASE+165)
-					/* 166 was sys_vm86 */
-					/* 167 was sys_query_module */
-#define __NR_poll			(__NR_SYSCALL_BASE+168)
-#define __NR_nfsservctl			(__NR_SYSCALL_BASE+169)
-#define __NR_setresgid			(__NR_SYSCALL_BASE+170)
-#define __NR_getresgid			(__NR_SYSCALL_BASE+171)
-#define __NR_prctl			(__NR_SYSCALL_BASE+172)
-#define __NR_rt_sigreturn		(__NR_SYSCALL_BASE+173)
-#define __NR_rt_sigaction		(__NR_SYSCALL_BASE+174)
-#define __NR_rt_sigprocmask		(__NR_SYSCALL_BASE+175)
-#define __NR_rt_sigpending		(__NR_SYSCALL_BASE+176)
-#define __NR_rt_sigtimedwait		(__NR_SYSCALL_BASE+177)
-#define __NR_rt_sigqueueinfo		(__NR_SYSCALL_BASE+178)
-#define __NR_rt_sigsuspend		(__NR_SYSCALL_BASE+179)
-#define __NR_pread64			(__NR_SYSCALL_BASE+180)
-#define __NR_pwrite64			(__NR_SYSCALL_BASE+181)
-#define __NR_chown			(__NR_SYSCALL_BASE+182)
-#define __NR_getcwd			(__NR_SYSCALL_BASE+183)
-#define __NR_capget			(__NR_SYSCALL_BASE+184)
-#define __NR_capset			(__NR_SYSCALL_BASE+185)
-#define __NR_sigaltstack		(__NR_SYSCALL_BASE+186)
-#define __NR_sendfile			(__NR_SYSCALL_BASE+187)
-					/* 188 reserved */
-					/* 189 reserved */
-#define __NR_vfork			(__NR_SYSCALL_BASE+190)
-#define __NR_ugetrlimit			(__NR_SYSCALL_BASE+191)	/* SuS compliant getrlimit */
-#define __NR_mmap2			(__NR_SYSCALL_BASE+192)
-#define __NR_truncate64			(__NR_SYSCALL_BASE+193)
-#define __NR_ftruncate64		(__NR_SYSCALL_BASE+194)
-#define __NR_stat64			(__NR_SYSCALL_BASE+195)
-#define __NR_lstat64			(__NR_SYSCALL_BASE+196)
-#define __NR_fstat64			(__NR_SYSCALL_BASE+197)
-#define __NR_lchown32			(__NR_SYSCALL_BASE+198)
-#define __NR_getuid32			(__NR_SYSCALL_BASE+199)
-#define __NR_getgid32			(__NR_SYSCALL_BASE+200)
-#define __NR_geteuid32			(__NR_SYSCALL_BASE+201)
-#define __NR_getegid32			(__NR_SYSCALL_BASE+202)
-#define __NR_setreuid32			(__NR_SYSCALL_BASE+203)
-#define __NR_setregid32			(__NR_SYSCALL_BASE+204)
-#define __NR_getgroups32		(__NR_SYSCALL_BASE+205)
-#define __NR_setgroups32		(__NR_SYSCALL_BASE+206)
-#define __NR_fchown32			(__NR_SYSCALL_BASE+207)
-#define __NR_setresuid32		(__NR_SYSCALL_BASE+208)
-#define __NR_getresuid32		(__NR_SYSCALL_BASE+209)
-#define __NR_setresgid32		(__NR_SYSCALL_BASE+210)
-#define __NR_getresgid32		(__NR_SYSCALL_BASE+211)
-#define __NR_chown32			(__NR_SYSCALL_BASE+212)
-#define __NR_setuid32			(__NR_SYSCALL_BASE+213)
-#define __NR_setgid32			(__NR_SYSCALL_BASE+214)
-#define __NR_setfsuid32			(__NR_SYSCALL_BASE+215)
-#define __NR_setfsgid32			(__NR_SYSCALL_BASE+216)
-#define __NR_getdents64			(__NR_SYSCALL_BASE+217)
-#define __NR_pivot_root			(__NR_SYSCALL_BASE+218)
-#define __NR_mincore			(__NR_SYSCALL_BASE+219)
-#define __NR_madvise			(__NR_SYSCALL_BASE+220)
-#define __NR_fcntl64			(__NR_SYSCALL_BASE+221)
-					/* 222 for tux */
-					/* 223 is unused */
-#define __NR_gettid			(__NR_SYSCALL_BASE+224)
-#define __NR_readahead			(__NR_SYSCALL_BASE+225)
-#define __NR_setxattr			(__NR_SYSCALL_BASE+226)
-#define __NR_lsetxattr			(__NR_SYSCALL_BASE+227)
-#define __NR_fsetxattr			(__NR_SYSCALL_BASE+228)
-#define __NR_getxattr			(__NR_SYSCALL_BASE+229)
-#define __NR_lgetxattr			(__NR_SYSCALL_BASE+230)
-#define __NR_fgetxattr			(__NR_SYSCALL_BASE+231)
-#define __NR_listxattr			(__NR_SYSCALL_BASE+232)
-#define __NR_llistxattr			(__NR_SYSCALL_BASE+233)
-#define __NR_flistxattr			(__NR_SYSCALL_BASE+234)
-#define __NR_removexattr		(__NR_SYSCALL_BASE+235)
-#define __NR_lremovexattr		(__NR_SYSCALL_BASE+236)
-#define __NR_fremovexattr		(__NR_SYSCALL_BASE+237)
-#define __NR_tkill			(__NR_SYSCALL_BASE+238)
-#define __NR_sendfile64			(__NR_SYSCALL_BASE+239)
-#define __NR_futex			(__NR_SYSCALL_BASE+240)
-#define __NR_sched_setaffinity		(__NR_SYSCALL_BASE+241)
-#define __NR_sched_getaffinity		(__NR_SYSCALL_BASE+242)
-#define __NR_io_setup			(__NR_SYSCALL_BASE+243)
-#define __NR_io_destroy			(__NR_SYSCALL_BASE+244)
-#define __NR_io_getevents		(__NR_SYSCALL_BASE+245)
-#define __NR_io_submit			(__NR_SYSCALL_BASE+246)
-#define __NR_io_cancel			(__NR_SYSCALL_BASE+247)
-#define __NR_exit_group			(__NR_SYSCALL_BASE+248)
-#define __NR_lookup_dcookie		(__NR_SYSCALL_BASE+249)
-#define __NR_epoll_create		(__NR_SYSCALL_BASE+250)
-#define __NR_epoll_ctl			(__NR_SYSCALL_BASE+251)
-#define __NR_epoll_wait			(__NR_SYSCALL_BASE+252)
-#define __NR_remap_file_pages		(__NR_SYSCALL_BASE+253)
-					/* 254 for set_thread_area */
-					/* 255 for get_thread_area */
-#define __NR_set_tid_address		(__NR_SYSCALL_BASE+256)
-#define __NR_timer_create		(__NR_SYSCALL_BASE+257)
-#define __NR_timer_settime		(__NR_SYSCALL_BASE+258)
-#define __NR_timer_gettime		(__NR_SYSCALL_BASE+259)
-#define __NR_timer_getoverrun		(__NR_SYSCALL_BASE+260)
-#define __NR_timer_delete		(__NR_SYSCALL_BASE+261)
-#define __NR_clock_settime		(__NR_SYSCALL_BASE+262)
-#define __NR_clock_gettime		(__NR_SYSCALL_BASE+263)
-#define __NR_clock_getres		(__NR_SYSCALL_BASE+264)
-#define __NR_clock_nanosleep		(__NR_SYSCALL_BASE+265)
-#define __NR_statfs64			(__NR_SYSCALL_BASE+266)
-#define __NR_fstatfs64			(__NR_SYSCALL_BASE+267)
-#define __NR_tgkill			(__NR_SYSCALL_BASE+268)
-#define __NR_utimes			(__NR_SYSCALL_BASE+269)
-#define __NR_arm_fadvise64_64		(__NR_SYSCALL_BASE+270)
-#define __NR_pciconfig_iobase		(__NR_SYSCALL_BASE+271)
-#define __NR_pciconfig_read		(__NR_SYSCALL_BASE+272)
-#define __NR_pciconfig_write		(__NR_SYSCALL_BASE+273)
-#define __NR_mq_open			(__NR_SYSCALL_BASE+274)
-#define __NR_mq_unlink			(__NR_SYSCALL_BASE+275)
-#define __NR_mq_timedsend		(__NR_SYSCALL_BASE+276)
-#define __NR_mq_timedreceive		(__NR_SYSCALL_BASE+277)
-#define __NR_mq_notify			(__NR_SYSCALL_BASE+278)
-#define __NR_mq_getsetattr		(__NR_SYSCALL_BASE+279)
-#define __NR_waitid			(__NR_SYSCALL_BASE+280)
-#define __NR_socket			(__NR_SYSCALL_BASE+281)
-#define __NR_bind			(__NR_SYSCALL_BASE+282)
-#define __NR_connect			(__NR_SYSCALL_BASE+283)
-#define __NR_listen			(__NR_SYSCALL_BASE+284)
-#define __NR_accept			(__NR_SYSCALL_BASE+285)
-#define __NR_getsockname		(__NR_SYSCALL_BASE+286)
-#define __NR_getpeername		(__NR_SYSCALL_BASE+287)
-#define __NR_socketpair			(__NR_SYSCALL_BASE+288)
-#define __NR_send			(__NR_SYSCALL_BASE+289)
-#define __NR_sendto			(__NR_SYSCALL_BASE+290)
-#define __NR_recv			(__NR_SYSCALL_BASE+291)
-#define __NR_recvfrom			(__NR_SYSCALL_BASE+292)
-#define __NR_shutdown			(__NR_SYSCALL_BASE+293)
-#define __NR_setsockopt			(__NR_SYSCALL_BASE+294)
-#define __NR_getsockopt			(__NR_SYSCALL_BASE+295)
-#define __NR_sendmsg			(__NR_SYSCALL_BASE+296)
-#define __NR_recvmsg			(__NR_SYSCALL_BASE+297)
-#define __NR_semop			(__NR_SYSCALL_BASE+298)
-#define __NR_semget			(__NR_SYSCALL_BASE+299)
-#define __NR_semctl			(__NR_SYSCALL_BASE+300)
-#define __NR_msgsnd			(__NR_SYSCALL_BASE+301)
-#define __NR_msgrcv			(__NR_SYSCALL_BASE+302)
-#define __NR_msgget			(__NR_SYSCALL_BASE+303)
-#define __NR_msgctl			(__NR_SYSCALL_BASE+304)
-#define __NR_shmat			(__NR_SYSCALL_BASE+305)
-#define __NR_shmdt			(__NR_SYSCALL_BASE+306)
-#define __NR_shmget			(__NR_SYSCALL_BASE+307)
-#define __NR_shmctl			(__NR_SYSCALL_BASE+308)
-#define __NR_add_key			(__NR_SYSCALL_BASE+309)
-#define __NR_request_key		(__NR_SYSCALL_BASE+310)
-#define __NR_keyctl			(__NR_SYSCALL_BASE+311)
-#define __NR_semtimedop			(__NR_SYSCALL_BASE+312)
-#define __NR_vserver			(__NR_SYSCALL_BASE+313)
-#define __NR_ioprio_set			(__NR_SYSCALL_BASE+314)
-#define __NR_ioprio_get			(__NR_SYSCALL_BASE+315)
-#define __NR_inotify_init		(__NR_SYSCALL_BASE+316)
-#define __NR_inotify_add_watch		(__NR_SYSCALL_BASE+317)
-#define __NR_inotify_rm_watch		(__NR_SYSCALL_BASE+318)
-#define __NR_mbind			(__NR_SYSCALL_BASE+319)
-#define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
-#define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
-#define __NR_openat			(__NR_SYSCALL_BASE+322)
-#define __NR_mkdirat			(__NR_SYSCALL_BASE+323)
-#define __NR_mknodat			(__NR_SYSCALL_BASE+324)
-#define __NR_fchownat			(__NR_SYSCALL_BASE+325)
-#define __NR_futimesat			(__NR_SYSCALL_BASE+326)
-#define __NR_fstatat64			(__NR_SYSCALL_BASE+327)
-#define __NR_unlinkat			(__NR_SYSCALL_BASE+328)
-#define __NR_renameat			(__NR_SYSCALL_BASE+329)
-#define __NR_linkat			(__NR_SYSCALL_BASE+330)
-#define __NR_symlinkat			(__NR_SYSCALL_BASE+331)
-#define __NR_readlinkat			(__NR_SYSCALL_BASE+332)
-#define __NR_fchmodat			(__NR_SYSCALL_BASE+333)
-#define __NR_faccessat			(__NR_SYSCALL_BASE+334)
-#define __NR_pselect6			(__NR_SYSCALL_BASE+335)
-#define __NR_ppoll			(__NR_SYSCALL_BASE+336)
-#define __NR_unshare			(__NR_SYSCALL_BASE+337)
-#define __NR_set_robust_list		(__NR_SYSCALL_BASE+338)
-#define __NR_get_robust_list		(__NR_SYSCALL_BASE+339)
-#define __NR_splice			(__NR_SYSCALL_BASE+340)
-#define __NR_arm_sync_file_range	(__NR_SYSCALL_BASE+341)
+#include <asm/unistd-common.h>
 #define __NR_sync_file_range2		__NR_arm_sync_file_range
-#define __NR_tee			(__NR_SYSCALL_BASE+342)
-#define __NR_vmsplice			(__NR_SYSCALL_BASE+343)
-#define __NR_move_pages			(__NR_SYSCALL_BASE+344)
-#define __NR_getcpu			(__NR_SYSCALL_BASE+345)
-#define __NR_epoll_pwait		(__NR_SYSCALL_BASE+346)
-#define __NR_kexec_load			(__NR_SYSCALL_BASE+347)
-#define __NR_utimensat			(__NR_SYSCALL_BASE+348)
-#define __NR_signalfd			(__NR_SYSCALL_BASE+349)
-#define __NR_timerfd_create		(__NR_SYSCALL_BASE+350)
-#define __NR_eventfd			(__NR_SYSCALL_BASE+351)
-#define __NR_fallocate			(__NR_SYSCALL_BASE+352)
-#define __NR_timerfd_settime		(__NR_SYSCALL_BASE+353)
-#define __NR_timerfd_gettime		(__NR_SYSCALL_BASE+354)
-#define __NR_signalfd4			(__NR_SYSCALL_BASE+355)
-#define __NR_eventfd2			(__NR_SYSCALL_BASE+356)
-#define __NR_epoll_create1		(__NR_SYSCALL_BASE+357)
-#define __NR_dup3			(__NR_SYSCALL_BASE+358)
-#define __NR_pipe2			(__NR_SYSCALL_BASE+359)
-#define __NR_inotify_init1		(__NR_SYSCALL_BASE+360)
-#define __NR_preadv			(__NR_SYSCALL_BASE+361)
-#define __NR_pwritev			(__NR_SYSCALL_BASE+362)
-#define __NR_rt_tgsigqueueinfo		(__NR_SYSCALL_BASE+363)
-#define __NR_perf_event_open		(__NR_SYSCALL_BASE+364)
-#define __NR_recvmmsg			(__NR_SYSCALL_BASE+365)
-#define __NR_accept4			(__NR_SYSCALL_BASE+366)
-#define __NR_fanotify_init		(__NR_SYSCALL_BASE+367)
-#define __NR_fanotify_mark		(__NR_SYSCALL_BASE+368)
-#define __NR_prlimit64			(__NR_SYSCALL_BASE+369)
-#define __NR_name_to_handle_at		(__NR_SYSCALL_BASE+370)
-#define __NR_open_by_handle_at		(__NR_SYSCALL_BASE+371)
-#define __NR_clock_adjtime		(__NR_SYSCALL_BASE+372)
-#define __NR_syncfs			(__NR_SYSCALL_BASE+373)
-#define __NR_sendmmsg			(__NR_SYSCALL_BASE+374)
-#define __NR_setns			(__NR_SYSCALL_BASE+375)
-#define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
-#define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
-#define __NR_kcmp			(__NR_SYSCALL_BASE+378)
-#define __NR_finit_module		(__NR_SYSCALL_BASE+379)
-#define __NR_sched_setattr		(__NR_SYSCALL_BASE+380)
-#define __NR_sched_getattr		(__NR_SYSCALL_BASE+381)
-#define __NR_renameat2			(__NR_SYSCALL_BASE+382)
-#define __NR_seccomp			(__NR_SYSCALL_BASE+383)
-#define __NR_getrandom			(__NR_SYSCALL_BASE+384)
-#define __NR_memfd_create		(__NR_SYSCALL_BASE+385)
-#define __NR_bpf			(__NR_SYSCALL_BASE+386)
-#define __NR_execveat			(__NR_SYSCALL_BASE+387)
-#define __NR_userfaultfd		(__NR_SYSCALL_BASE+388)
-#define __NR_membarrier			(__NR_SYSCALL_BASE+389)
-#define __NR_mlock2			(__NR_SYSCALL_BASE+390)
-#define __NR_copy_file_range		(__NR_SYSCALL_BASE+391)
-#define __NR_preadv2			(__NR_SYSCALL_BASE+392)
-#define __NR_pwritev2			(__NR_SYSCALL_BASE+393)
 
 /*
  * The following SWIs are ARM private.
@@ -431,22 +36,4 @@
 #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
 #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
 
-/*
- * The following syscalls are obsolete and no longer available for EABI.
- */
-#if defined(__ARM_EABI__)
-#undef __NR_time
-#undef __NR_umount
-#undef __NR_stime
-#undef __NR_alarm
-#undef __NR_utime
-#undef __NR_getrlimit
-#undef __NR_select
-#undef __NR_readdir
-#undef __NR_mmap
-#undef __NR_socketcall
-#undef __NR_syscall
-#undef __NR_ipc
-#endif
-
 #endif /* __ASM_ARM_UNISTD_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index fd5a276..651ec30 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -201,10 +201,23 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
 #define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
+#define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
+#define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
+			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
+#define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
 #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 #define KVM_DEV_ARM_VGIC_GRP_CTRL	4
+#define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
+#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
+#define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
+			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
+#define VGIC_LEVEL_INFO_LINE_LEVEL	0
+
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT	0
 
 /* Device Control API on vcpu fd */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index c93cf35..4edbe4b 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -413,6 +413,26 @@ struct kvm_get_htab_header {
 	__u16	n_invalid;
 };
 
+/* For KVM_PPC_CONFIGURE_V3_MMU */
+struct kvm_ppc_mmuv3_cfg {
+	__u64	flags;
+	__u64	process_table;	/* second doubleword of partition table entry */
+};
+
+/* Flag values for KVM_PPC_CONFIGURE_V3_MMU */
+#define KVM_PPC_MMUV3_RADIX	1	/* 1 = radix mode, 0 = HPT */
+#define KVM_PPC_MMUV3_GTSE	2	/* global translation shootdown enb. */
+
+/* For KVM_PPC_GET_RMMU_INFO */
+struct kvm_ppc_rmmu_info {
+	struct kvm_ppc_radix_geom {
+		__u8	page_shift;
+		__u8	level_bits[4];
+		__u8	pad[3];
+	}	geometries[8];
+	__u32	ap_encodings[8];
+};
+
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
 
@@ -573,6 +593,10 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_SPRG9	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xba)
 #define KVM_REG_PPC_DBSR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbb)
 
+/* POWER9 registers */
+#define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
+#define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
@@ -596,6 +620,7 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_TM_VSCR	(KVM_REG_PPC_TM | KVM_REG_SIZE_U32 | 0x67)
 #define KVM_REG_PPC_TM_DSCR	(KVM_REG_PPC_TM | KVM_REG_SIZE_U64 | 0x68)
 #define KVM_REG_PPC_TM_TAR	(KVM_REG_PPC_TM | KVM_REG_SIZE_U64 | 0x69)
+#define KVM_REG_PPC_TM_XER	(KVM_REG_PPC_TM | KVM_REG_SIZE_U64 | 0x6a)
 
 /* PPC64 eXternal Interrupt Controller Specification */
 #define KVM_DEV_XICS_GRP_SOURCES	1	/* 64-bit source attributes */
@@ -608,5 +633,7 @@ struct kvm_get_htab_header {
 #define  KVM_XICS_LEVEL_SENSITIVE	(1ULL << 40)
 #define  KVM_XICS_MASKED		(1ULL << 41)
 #define  KVM_XICS_PENDING		(1ULL << 42)
+#define  KVM_XICS_PRESENTED		(1ULL << 43)
+#define  KVM_XICS_QUEUED		(1ULL << 44)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index 1e66eba..598043c 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -392,5 +392,6 @@
 #define __NR_copy_file_range	379
 #define __NR_preadv2		380
 #define __NR_pwritev2		381
+#define __NR_kexec_file_load	382
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
index e41c5c1..3a53979 100644
--- a/linux-headers/asm-x86/kvm_para.h
+++ b/linux-headers/asm-x86/kvm_para.h
@@ -45,7 +45,18 @@ struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u8  preempted;
+	__u8  u8_pad[3];
+	__u32 pad[11];
+};
+
+#define KVM_CLOCK_PAIRING_WALLCLOCK 0
+struct kvm_clock_pairing {
+	__s64 sec;
+	__s64 nsec;
+	__u64 tsc;
+	__u32 flags;
+	__u32 pad[9];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index bb0ed71..4e082a8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -218,7 +218,8 @@ struct kvm_hyperv_exit {
 struct kvm_run {
 	/* in */
 	__u8 request_interrupt_window;
-	__u8 padding1[7];
+	__u8 immediate_exit;
+	__u8 padding1[6];
 
 	/* out */
 	__u32 exit_reason;
@@ -651,6 +652,9 @@ struct kvm_enable_cap {
 };
 
 /* for KVM_PPC_GET_PVINFO */
+
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
 struct kvm_ppc_pvinfo {
 	/* out */
 	__u32 flags;
@@ -682,7 +686,12 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
-#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
 
 #define KVMIO 0xAE
 
@@ -870,6 +879,10 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_SPAPR_RESIZE_HPT 133
+#define KVM_CAP_PPC_MMU_RADIX 134
+#define KVM_CAP_PPC_MMU_HASH_V3 135
+#define KVM_CAP_IMMEDIATE_EXIT 136
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1186,6 +1199,13 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* Available with KVM_CAP_SPAPR_RESIZE_HPT */
+#define KVM_PPC_RESIZE_HPT_PREPARE _IOR(KVMIO, 0xad, struct kvm_ppc_resize_hpt)
+#define KVM_PPC_RESIZE_HPT_COMMIT  _IOR(KVMIO, 0xae, struct kvm_ppc_resize_hpt)
+/* Available with KVM_CAP_PPC_RADIX_MMU or KVM_CAP_PPC_HASH_MMU_V3 */
+#define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
+/* Available with KVM_CAP_PPC_RADIX_MMU */
+#define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/linux-headers/linux/kvm_para.h b/linux-headers/linux/kvm_para.h
index e61661e..15b24ff 100644
--- a/linux-headers/linux/kvm_para.h
+++ b/linux-headers/linux/kvm_para.h
@@ -14,6 +14,7 @@
 #define KVM_EFAULT		EFAULT
 #define KVM_E2BIG		E2BIG
 #define KVM_EPERM		EPERM
+#define KVM_EOPNOTSUPP		95
 
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
@@ -23,6 +24,7 @@
 #define KVM_HC_MIPS_GET_CLOCK_FREQ	6
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
+#define KVM_HC_CLOCK_PAIRING		9
 
 /*
  * hypercalls use architecture specific
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 759b850..531cb2e 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -203,6 +203,16 @@ struct vfio_device_info {
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
+/*
+ * Vendor driver using Mediated device framework should provide device_api
+ * attribute in supported type attribute groups. Device API string should be one
+ * of the following corresponding to device flags in vfio_device_info structure.
+ */
+
+#define VFIO_DEVICE_API_PCI_STRING		"vfio-pci"
+#define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
+#define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
-- 
2.9.3
