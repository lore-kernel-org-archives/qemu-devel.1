Received: from eggs.gnu.org ([2001:4830:134:3::10]:44448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eviO1-00027U-7j
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eviNv-0008TC-Md
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:46:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35260
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eviNv-0008S4-CC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:46:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2DBkF5b078835
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 07:46:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gpcwkk7ty-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 07:46:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 13 Mar 2018 11:45:42 -0000
References: <1520937591-27088-1-git-send-email-pbonzini@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 13 Mar 2018 12:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <1520937591-27088-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2c23a5aa-ea1f-b561-1b63-bdeca3bb0c25@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] update Linux headers to 4.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com



On 03/13/2018 11:39 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/standard-headers/linux/input-event-codes.h |   1 +
>  include/standard-headers/linux/pci_regs.h          |  30 +-
>  include/standard-headers/linux/virtio_gpu.h        |   1 -
>  include/standard-headers/linux/virtio_net.h        |  13 +
>  include/standard-headers/linux/virtio_ring.h       |   2 +-
>  include/standard-headers/rdma/vmw_pvrdma-abi.h     |  13 +-
>  linux-headers/asm-powerpc/kvm.h                    |   2 +
>  linux-headers/asm-powerpc/unistd.h                 |   3 +
>  linux-headers/asm-s390/unistd.h                    | 401 +--------------------
>  linux-headers/asm-s390/unistd_32.h                 | 364 +++++++++++++++++++
>  linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
>  linux-headers/asm-x86/kvm_para.h                   |   5 +
>  linux-headers/linux/kvm.h                          |  92 +++++
>  linux-headers/linux/psci.h                         |   3 +
>  linux-headers/linux/vfio.h                         |  72 ++++
>  scripts/update-linux-headers.sh                    |   2 +
>  16 files changed, 918 insertions(+), 417 deletions(-)
>  create mode 100644 linux-headers/asm-s390/unistd_32.h
>  create mode 100644 linux-headers/asm-s390/unistd_64.h

s390 part look sane. 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
> diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
> index 79841b5..9e6a8ba 100644
> --- a/include/standard-headers/linux/input-event-codes.h
> +++ b/include/standard-headers/linux/input-event-codes.h
> @@ -594,6 +594,7 @@
>  #define BTN_DPAD_RIGHT		0x223
> 
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
> +#define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
> 
>  #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
>  #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index 70c2b2a..0c79eac 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -622,15 +622,19 @@
>   * safely.
>   */
>  #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
> +#define  PCI_EXP_DEVCAP2_COMP_TMOUT_DIS	0x00000010 /* Completion Timeout Disable supported */
>  #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
> -#define PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* Atomic 64-bit compare */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
> +#define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
>  #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
>  #define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
>  #define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
> @@ -966,26 +970,28 @@
> 
>  /* Downstream Port Containment */
>  #define PCI_EXP_DPC_CAP			4	/* DPC Capability */
> -#define PCI_EXP_DPC_IRQ			0x1f	/* DPC Interrupt Message Number */
> -#define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
> -#define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
> -#define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
> -#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0xF00	/* RP PIO log size */
> +#define PCI_EXP_DPC_IRQ			0x001F	/* Interrupt Message Number */
> +#define  PCI_EXP_DPC_CAP_RP_EXT		0x0020	/* Root Port Extensions */
> +#define  PCI_EXP_DPC_CAP_POISONED_TLP	0x0040	/* Poisoned TLP Egress Blocking Supported */
> +#define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x0080	/* Software Triggering Supported */
> +#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size */
>  #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
> 
>  #define PCI_EXP_DPC_CTL			6	/* DPC control */
> -#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x02	/* Enable trigger on ERR_NONFATAL message */
> -#define  PCI_EXP_DPC_CTL_INT_EN 	0x08	/* DPC Interrupt Enable */
> +#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
> +#define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
> 
>  #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
> -#define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
> -#define  PCI_EXP_DPC_STATUS_INTERRUPT	0x08	/* Interrupt Status */
> -#define  PCI_EXP_DPC_RP_BUSY		0x10	/* Root Port Busy */
> +#define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
> +#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN	    0x0006 /* Trigger Reason */
> +#define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
> +#define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
> +#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
> 
>  #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
> 
>  #define PCI_EXP_DPC_RP_PIO_STATUS	 0x0C	/* RP PIO Status */
> -#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO MASK */
> +#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO Mask */
>  #define PCI_EXP_DPC_RP_PIO_SEVERITY	 0x14	/* RP PIO Severity */
>  #define PCI_EXP_DPC_RP_PIO_SYSERROR	 0x18	/* RP PIO SysError */
>  #define PCI_EXP_DPC_RP_PIO_EXCEPTION	 0x1C	/* RP PIO Exception */
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
> index 52a830d..c1c8f07 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -260,7 +260,6 @@ struct virtio_gpu_cmd_submit {
>  };
> 
>  #define VIRTIO_GPU_CAPSET_VIRGL 1
> -#define VIRTIO_GPU_CAPSET_VIRGL2 2
> 
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index 30ff249..e9f255e 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,8 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> 
> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
>  #endif /* VIRTIO_NET_NO_LEGACY */
> @@ -76,6 +78,17 @@ struct virtio_net_config {
>  	uint16_t max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
>  	uint16_t mtu;
> +	/*
> +	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> +	 * Any other value stands for unknown.
> +	 */
> +	uint32_t speed;
> +	/*
> +	 * 0x00 - half duplex
> +	 * 0x01 - full duplex
> +	 * Any other value stands for unknown.
> +	 */
> +	uint8_t duplex;
>  } QEMU_PACKED;
> 
>  /*
> diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
> index f1dc05d..d26e72b 100644
> --- a/include/standard-headers/linux/virtio_ring.h
> +++ b/include/standard-headers/linux/virtio_ring.h
> @@ -78,7 +78,7 @@ struct vring_avail {
>  	__virtio16 ring[];
>  };
> 
> -/* u32 is used here for ids for padding reasons. */
> +/* uint32_t is used here for ids for padding reasons. */
>  struct vring_used_elem {
>  	/* Index of start of used descriptor chain. */
>  	__virtio32 id;
> diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/standard-headers/rdma/vmw_pvrdma-abi.h
> index 0d0f7a8..07a820d 100644
> --- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
> +++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>  /*
>   * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
>   *
> @@ -51,12 +52,14 @@
>  #define PVRDMA_UVERBS_ABI_VERSION	3		/* ABI Version. */
>  #define PVRDMA_UAR_HANDLE_MASK		0x00FFFFFF	/* Bottom 24 bits. */
>  #define PVRDMA_UAR_QP_OFFSET		0		/* QP doorbell. */
> -#define PVRDMA_UAR_QP_SEND		BIT(30)		/* Send bit. */
> -#define PVRDMA_UAR_QP_RECV		BIT(31)		/* Recv bit. */
> +#define PVRDMA_UAR_QP_SEND		(1 << 30)	/* Send bit. */
> +#define PVRDMA_UAR_QP_RECV		(1 << 31)	/* Recv bit. */
>  #define PVRDMA_UAR_CQ_OFFSET		4		/* CQ doorbell. */
> -#define PVRDMA_UAR_CQ_ARM_SOL		BIT(29)		/* Arm solicited bit. */
> -#define PVRDMA_UAR_CQ_ARM		BIT(30)		/* Arm bit. */
> -#define PVRDMA_UAR_CQ_POLL		BIT(31)		/* Poll bit. */
> +#define PVRDMA_UAR_CQ_ARM_SOL		(1 << 29)	/* Arm solicited bit. */
> +#define PVRDMA_UAR_CQ_ARM		(1 << 30)	/* Arm bit. */
> +#define PVRDMA_UAR_CQ_POLL		(1 << 31)	/* Poll bit. */
> +#define PVRDMA_UAR_SRQ_OFFSET		8		/* SRQ doorbell. */
> +#define PVRDMA_UAR_SRQ_RECV		(1 << 30)	/* Recv bit. */
> 
>  enum pvrdma_wr_opcode {
>  	PVRDMA_WR_RDMA_WRITE,
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index 637b726..833ed9a 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -632,6 +632,8 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
>  #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
> 
> +#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
> +
>  /* Transactional Memory checkpointed state:
>   * This is all GPRs, all VSX regs and a subset of SPRs
>   */
> diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
> index 36abf58..0c08edc 100644
> --- a/linux-headers/asm-powerpc/unistd.h
> +++ b/linux-headers/asm-powerpc/unistd.h
> @@ -395,5 +395,8 @@
>  #define __NR_pwritev2		381
>  #define __NR_kexec_file_load	382
>  #define __NR_statx		383
> +#define __NR_pkey_alloc		384
> +#define __NR_pkey_free		385
> +#define __NR_pkey_mprotect	386
> 
>  #endif /* _ASM_POWERPC_UNISTD_H_ */
> diff --git a/linux-headers/asm-s390/unistd.h b/linux-headers/asm-s390/unistd.h
> index 99223b8..27b8b21 100644
> --- a/linux-headers/asm-s390/unistd.h
> +++ b/linux-headers/asm-s390/unistd.h
> @@ -8,405 +8,10 @@
>  #ifndef _ASM_S390_UNISTD_H_
>  #define _ASM_S390_UNISTD_H_
> 
> -/*
> - * This file contains the system call numbers.
> - */
> -
> -#define __NR_exit                 1
> -#define __NR_fork                 2
> -#define __NR_read                 3
> -#define __NR_write                4
> -#define __NR_open                 5
> -#define __NR_close                6
> -#define __NR_restart_syscall	  7
> -#define __NR_creat                8
> -#define __NR_link                 9
> -#define __NR_unlink              10
> -#define __NR_execve              11
> -#define __NR_chdir               12
> -#define __NR_mknod               14
> -#define __NR_chmod               15
> -#define __NR_lseek               19
> -#define __NR_getpid              20
> -#define __NR_mount               21
> -#define __NR_umount              22
> -#define __NR_ptrace              26
> -#define __NR_alarm               27
> -#define __NR_pause               29
> -#define __NR_utime               30
> -#define __NR_access              33
> -#define __NR_nice                34
> -#define __NR_sync                36
> -#define __NR_kill                37
> -#define __NR_rename              38
> -#define __NR_mkdir               39
> -#define __NR_rmdir               40
> -#define __NR_dup                 41
> -#define __NR_pipe                42
> -#define __NR_times               43
> -#define __NR_brk                 45
> -#define __NR_signal              48
> -#define __NR_acct                51
> -#define __NR_umount2             52
> -#define __NR_ioctl               54
> -#define __NR_fcntl               55
> -#define __NR_setpgid             57
> -#define __NR_umask               60
> -#define __NR_chroot              61
> -#define __NR_ustat               62
> -#define __NR_dup2                63
> -#define __NR_getppid             64
> -#define __NR_getpgrp             65
> -#define __NR_setsid              66
> -#define __NR_sigaction           67
> -#define __NR_sigsuspend          72
> -#define __NR_sigpending          73
> -#define __NR_sethostname         74
> -#define __NR_setrlimit           75
> -#define __NR_getrusage           77
> -#define __NR_gettimeofday        78
> -#define __NR_settimeofday        79
> -#define __NR_symlink             83
> -#define __NR_readlink            85
> -#define __NR_uselib              86
> -#define __NR_swapon              87
> -#define __NR_reboot              88
> -#define __NR_readdir             89
> -#define __NR_mmap                90
> -#define __NR_munmap              91
> -#define __NR_truncate            92
> -#define __NR_ftruncate           93
> -#define __NR_fchmod              94
> -#define __NR_getpriority         96
> -#define __NR_setpriority         97
> -#define __NR_statfs              99
> -#define __NR_fstatfs            100
> -#define __NR_socketcall         102
> -#define __NR_syslog             103
> -#define __NR_setitimer          104
> -#define __NR_getitimer          105
> -#define __NR_stat               106
> -#define __NR_lstat              107
> -#define __NR_fstat              108
> -#define __NR_lookup_dcookie     110
> -#define __NR_vhangup            111
> -#define __NR_idle               112
> -#define __NR_wait4              114
> -#define __NR_swapoff            115
> -#define __NR_sysinfo            116
> -#define __NR_ipc                117
> -#define __NR_fsync              118
> -#define __NR_sigreturn          119
> -#define __NR_clone              120
> -#define __NR_setdomainname      121
> -#define __NR_uname              122
> -#define __NR_adjtimex           124
> -#define __NR_mprotect           125
> -#define __NR_sigprocmask        126
> -#define __NR_create_module      127
> -#define __NR_init_module        128
> -#define __NR_delete_module      129
> -#define __NR_get_kernel_syms    130
> -#define __NR_quotactl           131
> -#define __NR_getpgid            132
> -#define __NR_fchdir             133
> -#define __NR_bdflush            134
> -#define __NR_sysfs              135
> -#define __NR_personality        136
> -#define __NR_afs_syscall        137 /* Syscall for Andrew File System */
> -#define __NR_getdents           141
> -#define __NR_flock              143
> -#define __NR_msync              144
> -#define __NR_readv              145
> -#define __NR_writev             146
> -#define __NR_getsid             147
> -#define __NR_fdatasync          148
> -#define __NR__sysctl            149
> -#define __NR_mlock              150
> -#define __NR_munlock            151
> -#define __NR_mlockall           152
> -#define __NR_munlockall         153
> -#define __NR_sched_setparam             154
> -#define __NR_sched_getparam             155
> -#define __NR_sched_setscheduler         156
> -#define __NR_sched_getscheduler         157
> -#define __NR_sched_yield                158
> -#define __NR_sched_get_priority_max     159
> -#define __NR_sched_get_priority_min     160
> -#define __NR_sched_rr_get_interval      161
> -#define __NR_nanosleep          162
> -#define __NR_mremap             163
> -#define __NR_query_module       167
> -#define __NR_poll               168
> -#define __NR_nfsservctl         169
> -#define __NR_prctl              172
> -#define __NR_rt_sigreturn       173
> -#define __NR_rt_sigaction       174
> -#define __NR_rt_sigprocmask     175
> -#define __NR_rt_sigpending      176
> -#define __NR_rt_sigtimedwait    177
> -#define __NR_rt_sigqueueinfo    178
> -#define __NR_rt_sigsuspend      179
> -#define __NR_pread64            180
> -#define __NR_pwrite64           181
> -#define __NR_getcwd             183
> -#define __NR_capget             184
> -#define __NR_capset             185
> -#define __NR_sigaltstack        186
> -#define __NR_sendfile           187
> -#define __NR_getpmsg		188
> -#define __NR_putpmsg		189
> -#define __NR_vfork		190
> -#define __NR_pivot_root         217
> -#define __NR_mincore            218
> -#define __NR_madvise            219
> -#define __NR_getdents64		220
> -#define __NR_readahead		222
> -#define __NR_setxattr		224
> -#define __NR_lsetxattr		225
> -#define __NR_fsetxattr		226
> -#define __NR_getxattr		227
> -#define __NR_lgetxattr		228
> -#define __NR_fgetxattr		229
> -#define __NR_listxattr		230
> -#define __NR_llistxattr		231
> -#define __NR_flistxattr		232
> -#define __NR_removexattr	233
> -#define __NR_lremovexattr	234
> -#define __NR_fremovexattr	235
> -#define __NR_gettid		236
> -#define __NR_tkill		237
> -#define __NR_futex		238
> -#define __NR_sched_setaffinity	239
> -#define __NR_sched_getaffinity	240
> -#define __NR_tgkill		241
> -/* Number 242 is reserved for tux */
> -#define __NR_io_setup		243
> -#define __NR_io_destroy		244
> -#define __NR_io_getevents	245
> -#define __NR_io_submit		246
> -#define __NR_io_cancel		247
> -#define __NR_exit_group		248
> -#define __NR_epoll_create	249
> -#define __NR_epoll_ctl		250
> -#define __NR_epoll_wait		251
> -#define __NR_set_tid_address	252
> -#define __NR_fadvise64		253
> -#define __NR_timer_create	254
> -#define __NR_timer_settime	255
> -#define __NR_timer_gettime	256
> -#define __NR_timer_getoverrun	257
> -#define __NR_timer_delete	258
> -#define __NR_clock_settime	259
> -#define __NR_clock_gettime	260
> -#define __NR_clock_getres	261
> -#define __NR_clock_nanosleep	262
> -/* Number 263 is reserved for vserver */
> -#define __NR_statfs64		265
> -#define __NR_fstatfs64		266
> -#define __NR_remap_file_pages	267
> -#define __NR_mbind		268
> -#define __NR_get_mempolicy	269
> -#define __NR_set_mempolicy	270
> -#define __NR_mq_open		271
> -#define __NR_mq_unlink		272
> -#define __NR_mq_timedsend	273
> -#define __NR_mq_timedreceive	274
> -#define __NR_mq_notify		275
> -#define __NR_mq_getsetattr	276
> -#define __NR_kexec_load		277
> -#define __NR_add_key		278
> -#define __NR_request_key	279
> -#define __NR_keyctl		280
> -#define __NR_waitid		281
> -#define __NR_ioprio_set		282
> -#define __NR_ioprio_get		283
> -#define __NR_inotify_init	284
> -#define __NR_inotify_add_watch	285
> -#define __NR_inotify_rm_watch	286
> -#define __NR_migrate_pages	287
> -#define __NR_openat		288
> -#define __NR_mkdirat		289
> -#define __NR_mknodat		290
> -#define __NR_fchownat		291
> -#define __NR_futimesat		292
> -#define __NR_unlinkat		294
> -#define __NR_renameat		295
> -#define __NR_linkat		296
> -#define __NR_symlinkat		297
> -#define __NR_readlinkat		298
> -#define __NR_fchmodat		299
> -#define __NR_faccessat		300
> -#define __NR_pselect6		301
> -#define __NR_ppoll		302
> -#define __NR_unshare		303
> -#define __NR_set_robust_list	304
> -#define __NR_get_robust_list	305
> -#define __NR_splice		306
> -#define __NR_sync_file_range	307
> -#define __NR_tee		308
> -#define __NR_vmsplice		309
> -#define __NR_move_pages		310
> -#define __NR_getcpu		311
> -#define __NR_epoll_pwait	312
> -#define __NR_utimes		313
> -#define __NR_fallocate		314
> -#define __NR_utimensat		315
> -#define __NR_signalfd		316
> -#define __NR_timerfd		317
> -#define __NR_eventfd		318
> -#define __NR_timerfd_create	319
> -#define __NR_timerfd_settime	320
> -#define __NR_timerfd_gettime	321
> -#define __NR_signalfd4		322
> -#define __NR_eventfd2		323
> -#define __NR_inotify_init1	324
> -#define __NR_pipe2		325
> -#define __NR_dup3		326
> -#define __NR_epoll_create1	327
> -#define	__NR_preadv		328
> -#define	__NR_pwritev		329
> -#define __NR_rt_tgsigqueueinfo	330
> -#define __NR_perf_event_open	331
> -#define __NR_fanotify_init	332
> -#define __NR_fanotify_mark	333
> -#define __NR_prlimit64		334
> -#define __NR_name_to_handle_at	335
> -#define __NR_open_by_handle_at	336
> -#define __NR_clock_adjtime	337
> -#define __NR_syncfs		338
> -#define __NR_setns		339
> -#define __NR_process_vm_readv	340
> -#define __NR_process_vm_writev	341
> -#define __NR_s390_runtime_instr 342
> -#define __NR_kcmp		343
> -#define __NR_finit_module	344
> -#define __NR_sched_setattr	345
> -#define __NR_sched_getattr	346
> -#define __NR_renameat2		347
> -#define __NR_seccomp		348
> -#define __NR_getrandom		349
> -#define __NR_memfd_create	350
> -#define __NR_bpf		351
> -#define __NR_s390_pci_mmio_write	352
> -#define __NR_s390_pci_mmio_read		353
> -#define __NR_execveat		354
> -#define __NR_userfaultfd	355
> -#define __NR_membarrier		356
> -#define __NR_recvmmsg		357
> -#define __NR_sendmmsg		358
> -#define __NR_socket		359
> -#define __NR_socketpair		360
> -#define __NR_bind		361
> -#define __NR_connect		362
> -#define __NR_listen		363
> -#define __NR_accept4		364
> -#define __NR_getsockopt		365
> -#define __NR_setsockopt		366
> -#define __NR_getsockname	367
> -#define __NR_getpeername	368
> -#define __NR_sendto		369
> -#define __NR_sendmsg		370
> -#define __NR_recvfrom		371
> -#define __NR_recvmsg		372
> -#define __NR_shutdown		373
> -#define __NR_mlock2		374
> -#define __NR_copy_file_range	375
> -#define __NR_preadv2		376
> -#define __NR_pwritev2		377
> -#define __NR_s390_guarded_storage	378
> -#define __NR_statx		379
> -#define __NR_s390_sthyi		380
> -#define NR_syscalls 381
> -
> -/* 
> - * There are some system calls that are not present on 64 bit, some
> - * have a different name although they do the same (e.g. __NR_chown32
> - * is __NR_chown on 64 bit).
> - */
> -#ifndef __s390x__
> -
> -#define __NR_time		 13
> -#define __NR_lchown		 16
> -#define __NR_setuid		 23
> -#define __NR_getuid		 24
> -#define __NR_stime		 25
> -#define __NR_setgid		 46
> -#define __NR_getgid		 47
> -#define __NR_geteuid		 49
> -#define __NR_getegid		 50
> -#define __NR_setreuid		 70
> -#define __NR_setregid		 71
> -#define __NR_getrlimit		 76
> -#define __NR_getgroups		 80
> -#define __NR_setgroups		 81
> -#define __NR_fchown		 95
> -#define __NR_ioperm		101
> -#define __NR_setfsuid		138
> -#define __NR_setfsgid		139
> -#define __NR__llseek		140
> -#define __NR__newselect 	142
> -#define __NR_setresuid		164
> -#define __NR_getresuid		165
> -#define __NR_setresgid		170
> -#define __NR_getresgid		171
> -#define __NR_chown		182
> -#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
> -#define __NR_mmap2		192
> -#define __NR_truncate64		193
> -#define __NR_ftruncate64	194
> -#define __NR_stat64		195
> -#define __NR_lstat64		196
> -#define __NR_fstat64		197
> -#define __NR_lchown32		198
> -#define __NR_getuid32		199
> -#define __NR_getgid32		200
> -#define __NR_geteuid32		201
> -#define __NR_getegid32		202
> -#define __NR_setreuid32		203
> -#define __NR_setregid32		204
> -#define __NR_getgroups32	205
> -#define __NR_setgroups32	206
> -#define __NR_fchown32		207
> -#define __NR_setresuid32	208
> -#define __NR_getresuid32	209
> -#define __NR_setresgid32	210
> -#define __NR_getresgid32	211
> -#define __NR_chown32		212
> -#define __NR_setuid32		213
> -#define __NR_setgid32		214
> -#define __NR_setfsuid32		215
> -#define __NR_setfsgid32		216
> -#define __NR_fcntl64		221
> -#define __NR_sendfile64		223
> -#define __NR_fadvise64_64	264
> -#define __NR_fstatat64		293
> -
> +#ifdef __s390x__
> +#include <asm/unistd_64.h>
>  #else
> -
> -#define __NR_select		142
> -#define __NR_getrlimit		191	/* SuS compliant getrlimit */
> -#define __NR_lchown  		198
> -#define __NR_getuid  		199
> -#define __NR_getgid  		200
> -#define __NR_geteuid  		201
> -#define __NR_getegid  		202
> -#define __NR_setreuid  		203
> -#define __NR_setregid  		204
> -#define __NR_getgroups  	205
> -#define __NR_setgroups  	206
> -#define __NR_fchown  		207
> -#define __NR_setresuid  	208
> -#define __NR_getresuid  	209
> -#define __NR_setresgid  	210
> -#define __NR_getresgid  	211
> -#define __NR_chown  		212
> -#define __NR_setuid  		213
> -#define __NR_setgid  		214
> -#define __NR_setfsuid  		215
> -#define __NR_setfsgid  		216
> -#define __NR_newfstatat		293
> -
> +#include <asm/unistd_32.h>
>  #endif
> 
>  #endif /* _ASM_S390_UNISTD_H_ */
> diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
> new file mode 100644
> index 0000000..1ae66a2
> --- /dev/null
> +++ b/linux-headers/asm-s390/unistd_32.h
> @@ -0,0 +1,364 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_S390_UNISTD_32_H
> +#define _ASM_S390_UNISTD_32_H
> +
> +#define __NR_exit 1
> +#define __NR_fork 2
> +#define __NR_read 3
> +#define __NR_write 4
> +#define __NR_open 5
> +#define __NR_close 6
> +#define __NR_restart_syscall 7
> +#define __NR_creat 8
> +#define __NR_link 9
> +#define __NR_unlink 10
> +#define __NR_execve 11
> +#define __NR_chdir 12
> +#define __NR_time 13
> +#define __NR_mknod 14
> +#define __NR_chmod 15
> +#define __NR_lchown 16
> +#define __NR_lseek 19
> +#define __NR_getpid 20
> +#define __NR_mount 21
> +#define __NR_umount 22
> +#define __NR_setuid 23
> +#define __NR_getuid 24
> +#define __NR_stime 25
> +#define __NR_ptrace 26
> +#define __NR_alarm 27
> +#define __NR_pause 29
> +#define __NR_utime 30
> +#define __NR_access 33
> +#define __NR_nice 34
> +#define __NR_sync 36
> +#define __NR_kill 37
> +#define __NR_rename 38
> +#define __NR_mkdir 39
> +#define __NR_rmdir 40
> +#define __NR_dup 41
> +#define __NR_pipe 42
> +#define __NR_times 43
> +#define __NR_brk 45
> +#define __NR_setgid 46
> +#define __NR_getgid 47
> +#define __NR_signal 48
> +#define __NR_geteuid 49
> +#define __NR_getegid 50
> +#define __NR_acct 51
> +#define __NR_umount2 52
> +#define __NR_ioctl 54
> +#define __NR_fcntl 55
> +#define __NR_setpgid 57
> +#define __NR_umask 60
> +#define __NR_chroot 61
> +#define __NR_ustat 62
> +#define __NR_dup2 63
> +#define __NR_getppid 64
> +#define __NR_getpgrp 65
> +#define __NR_setsid 66
> +#define __NR_sigaction 67
> +#define __NR_setreuid 70
> +#define __NR_setregid 71
> +#define __NR_sigsuspend 72
> +#define __NR_sigpending 73
> +#define __NR_sethostname 74
> +#define __NR_setrlimit 75
> +#define __NR_getrlimit 76
> +#define __NR_getrusage 77
> +#define __NR_gettimeofday 78
> +#define __NR_settimeofday 79
> +#define __NR_getgroups 80
> +#define __NR_setgroups 81
> +#define __NR_symlink 83
> +#define __NR_readlink 85
> +#define __NR_uselib 86
> +#define __NR_swapon 87
> +#define __NR_reboot 88
> +#define __NR_readdir 89
> +#define __NR_mmap 90
> +#define __NR_munmap 91
> +#define __NR_truncate 92
> +#define __NR_ftruncate 93
> +#define __NR_fchmod 94
> +#define __NR_fchown 95
> +#define __NR_getpriority 96
> +#define __NR_setpriority 97
> +#define __NR_statfs 99
> +#define __NR_fstatfs 100
> +#define __NR_ioperm 101
> +#define __NR_socketcall 102
> +#define __NR_syslog 103
> +#define __NR_setitimer 104
> +#define __NR_getitimer 105
> +#define __NR_stat 106
> +#define __NR_lstat 107
> +#define __NR_fstat 108
> +#define __NR_lookup_dcookie 110
> +#define __NR_vhangup 111
> +#define __NR_idle 112
> +#define __NR_wait4 114
> +#define __NR_swapoff 115
> +#define __NR_sysinfo 116
> +#define __NR_ipc 117
> +#define __NR_fsync 118
> +#define __NR_sigreturn 119
> +#define __NR_clone 120
> +#define __NR_setdomainname 121
> +#define __NR_uname 122
> +#define __NR_adjtimex 124
> +#define __NR_mprotect 125
> +#define __NR_sigprocmask 126
> +#define __NR_create_module 127
> +#define __NR_init_module 128
> +#define __NR_delete_module 129
> +#define __NR_get_kernel_syms 130
> +#define __NR_quotactl 131
> +#define __NR_getpgid 132
> +#define __NR_fchdir 133
> +#define __NR_bdflush 134
> +#define __NR_sysfs 135
> +#define __NR_personality 136
> +#define __NR_afs_syscall 137
> +#define __NR_setfsuid 138
> +#define __NR_setfsgid 139
> +#define __NR__llseek 140
> +#define __NR_getdents 141
> +#define __NR__newselect 142
> +#define __NR_flock 143
> +#define __NR_msync 144
> +#define __NR_readv 145
> +#define __NR_writev 146
> +#define __NR_getsid 147
> +#define __NR_fdatasync 148
> +#define __NR__sysctl 149
> +#define __NR_mlock 150
> +#define __NR_munlock 151
> +#define __NR_mlockall 152
> +#define __NR_munlockall 153
> +#define __NR_sched_setparam 154
> +#define __NR_sched_getparam 155
> +#define __NR_sched_setscheduler 156
> +#define __NR_sched_getscheduler 157
> +#define __NR_sched_yield 158
> +#define __NR_sched_get_priority_max 159
> +#define __NR_sched_get_priority_min 160
> +#define __NR_sched_rr_get_interval 161
> +#define __NR_nanosleep 162
> +#define __NR_mremap 163
> +#define __NR_setresuid 164
> +#define __NR_getresuid 165
> +#define __NR_query_module 167
> +#define __NR_poll 168
> +#define __NR_nfsservctl 169
> +#define __NR_setresgid 170
> +#define __NR_getresgid 171
> +#define __NR_prctl 172
> +#define __NR_rt_sigreturn 173
> +#define __NR_rt_sigaction 174
> +#define __NR_rt_sigprocmask 175
> +#define __NR_rt_sigpending 176
> +#define __NR_rt_sigtimedwait 177
> +#define __NR_rt_sigqueueinfo 178
> +#define __NR_rt_sigsuspend 179
> +#define __NR_pread64 180
> +#define __NR_pwrite64 181
> +#define __NR_chown 182
> +#define __NR_getcwd 183
> +#define __NR_capget 184
> +#define __NR_capset 185
> +#define __NR_sigaltstack 186
> +#define __NR_sendfile 187
> +#define __NR_getpmsg 188
> +#define __NR_putpmsg 189
> +#define __NR_vfork 190
> +#define __NR_ugetrlimit 191
> +#define __NR_mmap2 192
> +#define __NR_truncate64 193
> +#define __NR_ftruncate64 194
> +#define __NR_stat64 195
> +#define __NR_lstat64 196
> +#define __NR_fstat64 197
> +#define __NR_lchown32 198
> +#define __NR_getuid32 199
> +#define __NR_getgid32 200
> +#define __NR_geteuid32 201
> +#define __NR_getegid32 202
> +#define __NR_setreuid32 203
> +#define __NR_setregid32 204
> +#define __NR_getgroups32 205
> +#define __NR_setgroups32 206
> +#define __NR_fchown32 207
> +#define __NR_setresuid32 208
> +#define __NR_getresuid32 209
> +#define __NR_setresgid32 210
> +#define __NR_getresgid32 211
> +#define __NR_chown32 212
> +#define __NR_setuid32 213
> +#define __NR_setgid32 214
> +#define __NR_setfsuid32 215
> +#define __NR_setfsgid32 216
> +#define __NR_pivot_root 217
> +#define __NR_mincore 218
> +#define __NR_madvise 219
> +#define __NR_getdents64 220
> +#define __NR_fcntl64 221
> +#define __NR_readahead 222
> +#define __NR_sendfile64 223
> +#define __NR_setxattr 224
> +#define __NR_lsetxattr 225
> +#define __NR_fsetxattr 226
> +#define __NR_getxattr 227
> +#define __NR_lgetxattr 228
> +#define __NR_fgetxattr 229
> +#define __NR_listxattr 230
> +#define __NR_llistxattr 231
> +#define __NR_flistxattr 232
> +#define __NR_removexattr 233
> +#define __NR_lremovexattr 234
> +#define __NR_fremovexattr 235
> +#define __NR_gettid 236
> +#define __NR_tkill 237
> +#define __NR_futex 238
> +#define __NR_sched_setaffinity 239
> +#define __NR_sched_getaffinity 240
> +#define __NR_tgkill 241
> +#define __NR_io_setup 243
> +#define __NR_io_destroy 244
> +#define __NR_io_getevents 245
> +#define __NR_io_submit 246
> +#define __NR_io_cancel 247
> +#define __NR_exit_group 248
> +#define __NR_epoll_create 249
> +#define __NR_epoll_ctl 250
> +#define __NR_epoll_wait 251
> +#define __NR_set_tid_address 252
> +#define __NR_fadvise64 253
> +#define __NR_timer_create 254
> +#define __NR_timer_settime 255
> +#define __NR_timer_gettime 256
> +#define __NR_timer_getoverrun 257
> +#define __NR_timer_delete 258
> +#define __NR_clock_settime 259
> +#define __NR_clock_gettime 260
> +#define __NR_clock_getres 261
> +#define __NR_clock_nanosleep 262
> +#define __NR_fadvise64_64 264
> +#define __NR_statfs64 265
> +#define __NR_fstatfs64 266
> +#define __NR_remap_file_pages 267
> +#define __NR_mbind 268
> +#define __NR_get_mempolicy 269
> +#define __NR_set_mempolicy 270
> +#define __NR_mq_open 271
> +#define __NR_mq_unlink 272
> +#define __NR_mq_timedsend 273
> +#define __NR_mq_timedreceive 274
> +#define __NR_mq_notify 275
> +#define __NR_mq_getsetattr 276
> +#define __NR_kexec_load 277
> +#define __NR_add_key 278
> +#define __NR_request_key 279
> +#define __NR_keyctl 280
> +#define __NR_waitid 281
> +#define __NR_ioprio_set 282
> +#define __NR_ioprio_get 283
> +#define __NR_inotify_init 284
> +#define __NR_inotify_add_watch 285
> +#define __NR_inotify_rm_watch 286
> +#define __NR_migrate_pages 287
> +#define __NR_openat 288
> +#define __NR_mkdirat 289
> +#define __NR_mknodat 290
> +#define __NR_fchownat 291
> +#define __NR_futimesat 292
> +#define __NR_fstatat64 293
> +#define __NR_unlinkat 294
> +#define __NR_renameat 295
> +#define __NR_linkat 296
> +#define __NR_symlinkat 297
> +#define __NR_readlinkat 298
> +#define __NR_fchmodat 299
> +#define __NR_faccessat 300
> +#define __NR_pselect6 301
> +#define __NR_ppoll 302
> +#define __NR_unshare 303
> +#define __NR_set_robust_list 304
> +#define __NR_get_robust_list 305
> +#define __NR_splice 306
> +#define __NR_sync_file_range 307
> +#define __NR_tee 308
> +#define __NR_vmsplice 309
> +#define __NR_move_pages 310
> +#define __NR_getcpu 311
> +#define __NR_epoll_pwait 312
> +#define __NR_utimes 313
> +#define __NR_fallocate 314
> +#define __NR_utimensat 315
> +#define __NR_signalfd 316
> +#define __NR_timerfd 317
> +#define __NR_eventfd 318
> +#define __NR_timerfd_create 319
> +#define __NR_timerfd_settime 320
> +#define __NR_timerfd_gettime 321
> +#define __NR_signalfd4 322
> +#define __NR_eventfd2 323
> +#define __NR_inotify_init1 324
> +#define __NR_pipe2 325
> +#define __NR_dup3 326
> +#define __NR_epoll_create1 327
> +#define __NR_preadv 328
> +#define __NR_pwritev 329
> +#define __NR_rt_tgsigqueueinfo 330
> +#define __NR_perf_event_open 331
> +#define __NR_fanotify_init 332
> +#define __NR_fanotify_mark 333
> +#define __NR_prlimit64 334
> +#define __NR_name_to_handle_at 335
> +#define __NR_open_by_handle_at 336
> +#define __NR_clock_adjtime 337
> +#define __NR_syncfs 338
> +#define __NR_setns 339
> +#define __NR_process_vm_readv 340
> +#define __NR_process_vm_writev 341
> +#define __NR_s390_runtime_instr 342
> +#define __NR_kcmp 343
> +#define __NR_finit_module 344
> +#define __NR_sched_setattr 345
> +#define __NR_sched_getattr 346
> +#define __NR_renameat2 347
> +#define __NR_seccomp 348
> +#define __NR_getrandom 349
> +#define __NR_memfd_create 350
> +#define __NR_bpf 351
> +#define __NR_s390_pci_mmio_write 352
> +#define __NR_s390_pci_mmio_read 353
> +#define __NR_execveat 354
> +#define __NR_userfaultfd 355
> +#define __NR_membarrier 356
> +#define __NR_recvmmsg 357
> +#define __NR_sendmmsg 358
> +#define __NR_socket 359
> +#define __NR_socketpair 360
> +#define __NR_bind 361
> +#define __NR_connect 362
> +#define __NR_listen 363
> +#define __NR_accept4 364
> +#define __NR_getsockopt 365
> +#define __NR_setsockopt 366
> +#define __NR_getsockname 367
> +#define __NR_getpeername 368
> +#define __NR_sendto 369
> +#define __NR_sendmsg 370
> +#define __NR_recvfrom 371
> +#define __NR_recvmsg 372
> +#define __NR_shutdown 373
> +#define __NR_mlock2 374
> +#define __NR_copy_file_range 375
> +#define __NR_preadv2 376
> +#define __NR_pwritev2 377
> +#define __NR_s390_guarded_storage 378
> +#define __NR_statx 379
> +#define __NR_s390_sthyi 380
> +
> +#endif /* _ASM_S390_UNISTD_32_H */
> diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
> new file mode 100644
> index 0000000..8aa9d04
> --- /dev/null
> +++ b/linux-headers/asm-s390/unistd_64.h
> @@ -0,0 +1,331 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_S390_UNISTD_64_H
> +#define _ASM_S390_UNISTD_64_H
> +
> +#define __NR_exit 1
> +#define __NR_fork 2
> +#define __NR_read 3
> +#define __NR_write 4
> +#define __NR_open 5
> +#define __NR_close 6
> +#define __NR_restart_syscall 7
> +#define __NR_creat 8
> +#define __NR_link 9
> +#define __NR_unlink 10
> +#define __NR_execve 11
> +#define __NR_chdir 12
> +#define __NR_mknod 14
> +#define __NR_chmod 15
> +#define __NR_lseek 19
> +#define __NR_getpid 20
> +#define __NR_mount 21
> +#define __NR_umount 22
> +#define __NR_ptrace 26
> +#define __NR_alarm 27
> +#define __NR_pause 29
> +#define __NR_utime 30
> +#define __NR_access 33
> +#define __NR_nice 34
> +#define __NR_sync 36
> +#define __NR_kill 37
> +#define __NR_rename 38
> +#define __NR_mkdir 39
> +#define __NR_rmdir 40
> +#define __NR_dup 41
> +#define __NR_pipe 42
> +#define __NR_times 43
> +#define __NR_brk 45
> +#define __NR_signal 48
> +#define __NR_acct 51
> +#define __NR_umount2 52
> +#define __NR_ioctl 54
> +#define __NR_fcntl 55
> +#define __NR_setpgid 57
> +#define __NR_umask 60
> +#define __NR_chroot 61
> +#define __NR_ustat 62
> +#define __NR_dup2 63
> +#define __NR_getppid 64
> +#define __NR_getpgrp 65
> +#define __NR_setsid 66
> +#define __NR_sigaction 67
> +#define __NR_sigsuspend 72
> +#define __NR_sigpending 73
> +#define __NR_sethostname 74
> +#define __NR_setrlimit 75
> +#define __NR_getrusage 77
> +#define __NR_gettimeofday 78
> +#define __NR_settimeofday 79
> +#define __NR_symlink 83
> +#define __NR_readlink 85
> +#define __NR_uselib 86
> +#define __NR_swapon 87
> +#define __NR_reboot 88
> +#define __NR_readdir 89
> +#define __NR_mmap 90
> +#define __NR_munmap 91
> +#define __NR_truncate 92
> +#define __NR_ftruncate 93
> +#define __NR_fchmod 94
> +#define __NR_getpriority 96
> +#define __NR_setpriority 97
> +#define __NR_statfs 99
> +#define __NR_fstatfs 100
> +#define __NR_socketcall 102
> +#define __NR_syslog 103
> +#define __NR_setitimer 104
> +#define __NR_getitimer 105
> +#define __NR_stat 106
> +#define __NR_lstat 107
> +#define __NR_fstat 108
> +#define __NR_lookup_dcookie 110
> +#define __NR_vhangup 111
> +#define __NR_idle 112
> +#define __NR_wait4 114
> +#define __NR_swapoff 115
> +#define __NR_sysinfo 116
> +#define __NR_ipc 117
> +#define __NR_fsync 118
> +#define __NR_sigreturn 119
> +#define __NR_clone 120
> +#define __NR_setdomainname 121
> +#define __NR_uname 122
> +#define __NR_adjtimex 124
> +#define __NR_mprotect 125
> +#define __NR_sigprocmask 126
> +#define __NR_create_module 127
> +#define __NR_init_module 128
> +#define __NR_delete_module 129
> +#define __NR_get_kernel_syms 130
> +#define __NR_quotactl 131
> +#define __NR_getpgid 132
> +#define __NR_fchdir 133
> +#define __NR_bdflush 134
> +#define __NR_sysfs 135
> +#define __NR_personality 136
> +#define __NR_afs_syscall 137
> +#define __NR_getdents 141
> +#define __NR_select 142
> +#define __NR_flock 143
> +#define __NR_msync 144
> +#define __NR_readv 145
> +#define __NR_writev 146
> +#define __NR_getsid 147
> +#define __NR_fdatasync 148
> +#define __NR__sysctl 149
> +#define __NR_mlock 150
> +#define __NR_munlock 151
> +#define __NR_mlockall 152
> +#define __NR_munlockall 153
> +#define __NR_sched_setparam 154
> +#define __NR_sched_getparam 155
> +#define __NR_sched_setscheduler 156
> +#define __NR_sched_getscheduler 157
> +#define __NR_sched_yield 158
> +#define __NR_sched_get_priority_max 159
> +#define __NR_sched_get_priority_min 160
> +#define __NR_sched_rr_get_interval 161
> +#define __NR_nanosleep 162
> +#define __NR_mremap 163
> +#define __NR_query_module 167
> +#define __NR_poll 168
> +#define __NR_nfsservctl 169
> +#define __NR_prctl 172
> +#define __NR_rt_sigreturn 173
> +#define __NR_rt_sigaction 174
> +#define __NR_rt_sigprocmask 175
> +#define __NR_rt_sigpending 176
> +#define __NR_rt_sigtimedwait 177
> +#define __NR_rt_sigqueueinfo 178
> +#define __NR_rt_sigsuspend 179
> +#define __NR_pread64 180
> +#define __NR_pwrite64 181
> +#define __NR_getcwd 183
> +#define __NR_capget 184
> +#define __NR_capset 185
> +#define __NR_sigaltstack 186
> +#define __NR_sendfile 187
> +#define __NR_getpmsg 188
> +#define __NR_putpmsg 189
> +#define __NR_vfork 190
> +#define __NR_getrlimit 191
> +#define __NR_lchown 198
> +#define __NR_getuid 199
> +#define __NR_getgid 200
> +#define __NR_geteuid 201
> +#define __NR_getegid 202
> +#define __NR_setreuid 203
> +#define __NR_setregid 204
> +#define __NR_getgroups 205
> +#define __NR_setgroups 206
> +#define __NR_fchown 207
> +#define __NR_setresuid 208
> +#define __NR_getresuid 209
> +#define __NR_setresgid 210
> +#define __NR_getresgid 211
> +#define __NR_chown 212
> +#define __NR_setuid 213
> +#define __NR_setgid 214
> +#define __NR_setfsuid 215
> +#define __NR_setfsgid 216
> +#define __NR_pivot_root 217
> +#define __NR_mincore 218
> +#define __NR_madvise 219
> +#define __NR_getdents64 220
> +#define __NR_readahead 222
> +#define __NR_setxattr 224
> +#define __NR_lsetxattr 225
> +#define __NR_fsetxattr 226
> +#define __NR_getxattr 227
> +#define __NR_lgetxattr 228
> +#define __NR_fgetxattr 229
> +#define __NR_listxattr 230
> +#define __NR_llistxattr 231
> +#define __NR_flistxattr 232
> +#define __NR_removexattr 233
> +#define __NR_lremovexattr 234
> +#define __NR_fremovexattr 235
> +#define __NR_gettid 236
> +#define __NR_tkill 237
> +#define __NR_futex 238
> +#define __NR_sched_setaffinity 239
> +#define __NR_sched_getaffinity 240
> +#define __NR_tgkill 241
> +#define __NR_io_setup 243
> +#define __NR_io_destroy 244
> +#define __NR_io_getevents 245
> +#define __NR_io_submit 246
> +#define __NR_io_cancel 247
> +#define __NR_exit_group 248
> +#define __NR_epoll_create 249
> +#define __NR_epoll_ctl 250
> +#define __NR_epoll_wait 251
> +#define __NR_set_tid_address 252
> +#define __NR_fadvise64 253
> +#define __NR_timer_create 254
> +#define __NR_timer_settime 255
> +#define __NR_timer_gettime 256
> +#define __NR_timer_getoverrun 257
> +#define __NR_timer_delete 258
> +#define __NR_clock_settime 259
> +#define __NR_clock_gettime 260
> +#define __NR_clock_getres 261
> +#define __NR_clock_nanosleep 262
> +#define __NR_statfs64 265
> +#define __NR_fstatfs64 266
> +#define __NR_remap_file_pages 267
> +#define __NR_mbind 268
> +#define __NR_get_mempolicy 269
> +#define __NR_set_mempolicy 270
> +#define __NR_mq_open 271
> +#define __NR_mq_unlink 272
> +#define __NR_mq_timedsend 273
> +#define __NR_mq_timedreceive 274
> +#define __NR_mq_notify 275
> +#define __NR_mq_getsetattr 276
> +#define __NR_kexec_load 277
> +#define __NR_add_key 278
> +#define __NR_request_key 279
> +#define __NR_keyctl 280
> +#define __NR_waitid 281
> +#define __NR_ioprio_set 282
> +#define __NR_ioprio_get 283
> +#define __NR_inotify_init 284
> +#define __NR_inotify_add_watch 285
> +#define __NR_inotify_rm_watch 286
> +#define __NR_migrate_pages 287
> +#define __NR_openat 288
> +#define __NR_mkdirat 289
> +#define __NR_mknodat 290
> +#define __NR_fchownat 291
> +#define __NR_futimesat 292
> +#define __NR_newfstatat 293
> +#define __NR_unlinkat 294
> +#define __NR_renameat 295
> +#define __NR_linkat 296
> +#define __NR_symlinkat 297
> +#define __NR_readlinkat 298
> +#define __NR_fchmodat 299
> +#define __NR_faccessat 300
> +#define __NR_pselect6 301
> +#define __NR_ppoll 302
> +#define __NR_unshare 303
> +#define __NR_set_robust_list 304
> +#define __NR_get_robust_list 305
> +#define __NR_splice 306
> +#define __NR_sync_file_range 307
> +#define __NR_tee 308
> +#define __NR_vmsplice 309
> +#define __NR_move_pages 310
> +#define __NR_getcpu 311
> +#define __NR_epoll_pwait 312
> +#define __NR_utimes 313
> +#define __NR_fallocate 314
> +#define __NR_utimensat 315
> +#define __NR_signalfd 316
> +#define __NR_timerfd 317
> +#define __NR_eventfd 318
> +#define __NR_timerfd_create 319
> +#define __NR_timerfd_settime 320
> +#define __NR_timerfd_gettime 321
> +#define __NR_signalfd4 322
> +#define __NR_eventfd2 323
> +#define __NR_inotify_init1 324
> +#define __NR_pipe2 325
> +#define __NR_dup3 326
> +#define __NR_epoll_create1 327
> +#define __NR_preadv 328
> +#define __NR_pwritev 329
> +#define __NR_rt_tgsigqueueinfo 330
> +#define __NR_perf_event_open 331
> +#define __NR_fanotify_init 332
> +#define __NR_fanotify_mark 333
> +#define __NR_prlimit64 334
> +#define __NR_name_to_handle_at 335
> +#define __NR_open_by_handle_at 336
> +#define __NR_clock_adjtime 337
> +#define __NR_syncfs 338
> +#define __NR_setns 339
> +#define __NR_process_vm_readv 340
> +#define __NR_process_vm_writev 341
> +#define __NR_s390_runtime_instr 342
> +#define __NR_kcmp 343
> +#define __NR_finit_module 344
> +#define __NR_sched_setattr 345
> +#define __NR_sched_getattr 346
> +#define __NR_renameat2 347
> +#define __NR_seccomp 348
> +#define __NR_getrandom 349
> +#define __NR_memfd_create 350
> +#define __NR_bpf 351
> +#define __NR_s390_pci_mmio_write 352
> +#define __NR_s390_pci_mmio_read 353
> +#define __NR_execveat 354
> +#define __NR_userfaultfd 355
> +#define __NR_membarrier 356
> +#define __NR_recvmmsg 357
> +#define __NR_sendmmsg 358
> +#define __NR_socket 359
> +#define __NR_socketpair 360
> +#define __NR_bind 361
> +#define __NR_connect 362
> +#define __NR_listen 363
> +#define __NR_accept4 364
> +#define __NR_getsockopt 365
> +#define __NR_setsockopt 366
> +#define __NR_getsockname 367
> +#define __NR_getpeername 368
> +#define __NR_sendto 369
> +#define __NR_sendmsg 370
> +#define __NR_recvfrom 371
> +#define __NR_recvmsg 372
> +#define __NR_shutdown 373
> +#define __NR_mlock2 374
> +#define __NR_copy_file_range 375
> +#define __NR_preadv2 376
> +#define __NR_pwritev2 377
> +#define __NR_s390_guarded_storage 378
> +#define __NR_statx 379
> +#define __NR_s390_sthyi 380
> +
> +#endif /* _ASM_S390_UNISTD_64_H */
> diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
> index 4c300f6..4c58184 100644
> --- a/linux-headers/asm-x86/kvm_para.h
> +++ b/linux-headers/asm-x86/kvm_para.h
> @@ -25,6 +25,8 @@
>  #define KVM_FEATURE_STEAL_TIME		5
>  #define KVM_FEATURE_PV_EOI		6
>  #define KVM_FEATURE_PV_UNHALT		7
> +#define KVM_FEATURE_PV_TLB_FLUSH	9
> +#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
> 
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
> @@ -51,6 +53,9 @@ struct kvm_steal_time {
>  	__u32 pad[11];
>  };
> 
> +#define KVM_VCPU_PREEMPTED          (1 << 0)
> +#define KVM_VCPU_FLUSH_TLB          (1 << 1)
> +
>  #define KVM_CLOCK_PAIRING_WALLCLOCK 0
>  struct kvm_clock_pairing {
>  	__s64 sec;
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index d92c9b2..a167be8 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -761,6 +761,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_TRACE_PAUSE           __KVM_DEPRECATED_MAIN_0x07
>  #define KVM_TRACE_DISABLE         __KVM_DEPRECATED_MAIN_0x08
>  #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
> +#define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
> 
>  /*
>   * Extension capability list.
> @@ -934,6 +935,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_AIS_MIGRATION 150
>  #define KVM_CAP_PPC_GET_CPU_CHAR 151
>  #define KVM_CAP_S390_BPB 152
> +#define KVM_CAP_GET_MSR_FEATURES 153
> 
>  #ifdef KVM_CAP_IRQ_ROUTING
> 
> @@ -1362,6 +1364,96 @@ struct kvm_s390_ucas_mapping {
>  /* Available with KVM_CAP_S390_CMMA_MIGRATION */
>  #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
>  #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
> +/* Memory Encryption Commands */
> +#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
> +
> +struct kvm_enc_region {
> +	__u64 addr;
> +	__u64 size;
> +};
> +
> +#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
> +#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
> +
> +/* Secure Encrypted Virtualization command */
> +enum sev_cmd_id {
> +	/* Guest initialization commands */
> +	KVM_SEV_INIT = 0,
> +	KVM_SEV_ES_INIT,
> +	/* Guest launch commands */
> +	KVM_SEV_LAUNCH_START,
> +	KVM_SEV_LAUNCH_UPDATE_DATA,
> +	KVM_SEV_LAUNCH_UPDATE_VMSA,
> +	KVM_SEV_LAUNCH_SECRET,
> +	KVM_SEV_LAUNCH_MEASURE,
> +	KVM_SEV_LAUNCH_FINISH,
> +	/* Guest migration commands (outgoing) */
> +	KVM_SEV_SEND_START,
> +	KVM_SEV_SEND_UPDATE_DATA,
> +	KVM_SEV_SEND_UPDATE_VMSA,
> +	KVM_SEV_SEND_FINISH,
> +	/* Guest migration commands (incoming) */
> +	KVM_SEV_RECEIVE_START,
> +	KVM_SEV_RECEIVE_UPDATE_DATA,
> +	KVM_SEV_RECEIVE_UPDATE_VMSA,
> +	KVM_SEV_RECEIVE_FINISH,
> +	/* Guest status and debug commands */
> +	KVM_SEV_GUEST_STATUS,
> +	KVM_SEV_DBG_DECRYPT,
> +	KVM_SEV_DBG_ENCRYPT,
> +	/* Guest certificates commands */
> +	KVM_SEV_CERT_EXPORT,
> +
> +	KVM_SEV_NR_MAX,
> +};
> +
> +struct kvm_sev_cmd {
> +	__u32 id;
> +	__u64 data;
> +	__u32 error;
> +	__u32 sev_fd;
> +};
> +
> +struct kvm_sev_launch_start {
> +	__u32 handle;
> +	__u32 policy;
> +	__u64 dh_uaddr;
> +	__u32 dh_len;
> +	__u64 session_uaddr;
> +	__u32 session_len;
> +};
> +
> +struct kvm_sev_launch_update_data {
> +	__u64 uaddr;
> +	__u32 len;
> +};
> +
> +
> +struct kvm_sev_launch_secret {
> +	__u64 hdr_uaddr;
> +	__u32 hdr_len;
> +	__u64 guest_uaddr;
> +	__u32 guest_len;
> +	__u64 trans_uaddr;
> +	__u32 trans_len;
> +};
> +
> +struct kvm_sev_launch_measure {
> +	__u64 uaddr;
> +	__u32 len;
> +};
> +
> +struct kvm_sev_guest_status {
> +	__u32 handle;
> +	__u32 policy;
> +	__u32 state;
> +};
> +
> +struct kvm_sev_dbg {
> +	__u64 src_uaddr;
> +	__u64 dst_uaddr;
> +	__u32 len;
> +};
> 
>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
>  #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
> diff --git a/linux-headers/linux/psci.h b/linux-headers/linux/psci.h
> index ccd1773..3905492 100644
> --- a/linux-headers/linux/psci.h
> +++ b/linux-headers/linux/psci.h
> @@ -88,6 +88,9 @@
>  		(((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
>  #define PSCI_VERSION_MINOR(ver)			\
>  		((ver) & PSCI_VERSION_MINOR_MASK)
> +#define PSCI_VERSION(maj, min)						\
> +	((((maj) << PSCI_VERSION_MAJOR_SHIFT) & PSCI_VERSION_MAJOR_MASK) | \
> +	 ((min) & PSCI_VERSION_MINOR_MASK))
> 
>  /* PSCI features decoding (>=1.0) */
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT	1
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4312e96..3a0a305 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -301,6 +301,16 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> 
> +/*
> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> + * which allows direct access to non-MSIX registers which happened to be within
> + * the same system page.
> + *
> + * Even though the userspace gets direct access to the MSIX data, the existing
> + * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
> + */
> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> @@ -503,6 +513,68 @@ struct vfio_pci_hot_reset {
> 
>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> 
> +/**
> + * VFIO_DEVICE_QUERY_GFX_PLANE - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> + *                                    struct vfio_device_query_gfx_plane)
> + *
> + * Set the drm_plane_type and flags, then retrieve the gfx plane info.
> + *
> + * flags supported:
> + * - VFIO_GFX_PLANE_TYPE_PROBE and VFIO_GFX_PLANE_TYPE_DMABUF are set
> + *   to ask if the mdev supports dma-buf. 0 on support, -EINVAL on no
> + *   support for dma-buf.
> + * - VFIO_GFX_PLANE_TYPE_PROBE and VFIO_GFX_PLANE_TYPE_REGION are set
> + *   to ask if the mdev supports region. 0 on support, -EINVAL on no
> + *   support for region.
> + * - VFIO_GFX_PLANE_TYPE_DMABUF or VFIO_GFX_PLANE_TYPE_REGION is set
> + *   with each call to query the plane info.
> + * - Others are invalid and return -EINVAL.
> + *
> + * Note:
> + * 1. Plane could be disabled by guest. In that case, success will be
> + *    returned with zero-initialized drm_format, size, width and height
> + *    fields.
> + * 2. x_hot/y_hot is set to 0xFFFFFFFF if no hotspot information available
> + *
> + * Return: 0 on success, -errno on other failure.
> + */
> +struct vfio_device_gfx_plane_info {
> +	__u32 argsz;
> +	__u32 flags;
> +#define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
> +#define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
> +#define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
> +	/* in */
> +	__u32 drm_plane_type;	/* type of plane: DRM_PLANE_TYPE_* */
> +	/* out */
> +	__u32 drm_format;	/* drm format of plane */
> +	__u64 drm_format_mod;   /* tiled mode */
> +	__u32 width;	/* width of plane */
> +	__u32 height;	/* height of plane */
> +	__u32 stride;	/* stride of plane */
> +	__u32 size;	/* size of plane in bytes, align on page*/
> +	__u32 x_pos;	/* horizontal position of cursor plane */
> +	__u32 y_pos;	/* vertical position of cursor plane*/
> +	__u32 x_hot;    /* horizontal position of cursor hotspot */
> +	__u32 y_hot;    /* vertical position of cursor hotspot */
> +	union {
> +		__u32 region_index;	/* region index */
> +		__u32 dmabuf_id;	/* dma-buf id */
> +	};
> +};
> +
> +#define VFIO_DEVICE_QUERY_GFX_PLANE _IO(VFIO_TYPE, VFIO_BASE + 14)
> +
> +/**
> + * VFIO_DEVICE_GET_GFX_DMABUF - _IOW(VFIO_TYPE, VFIO_BASE + 15, __u32)
> + *
> + * Return a new dma-buf file descriptor for an exposed guest framebuffer
> + * described by the provided dmabuf_id. The dmabuf_id is returned from VFIO_
> + * DEVICE_QUERY_GFX_PLANE as a token of the exposed guest framebuffer.
> + */
> +
> +#define VFIO_DEVICE_GET_GFX_DMABUF _IO(VFIO_TYPE, VFIO_BASE + 15)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
> 
>  /**
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index be06570..43d6334 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -99,6 +99,8 @@ for arch in $ARCHLIST; do
>      mkdir -p "$output/include/standard-headers/asm-$arch"
>      if [ $arch = s390 ]; then
>          cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
> +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
> +        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>      fi
>      if [ $arch = arm ]; then
>          cp "$tmpdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
> 
