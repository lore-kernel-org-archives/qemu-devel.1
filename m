Received: from eggs.gnu.org ([2001:4830:134:3::10]:51668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxr8X-0007Vy-E3
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxr8S-0000UZ-BJ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:59:09 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:54579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxr8S-0000U7-0S
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:59:04 -0400
Received: by mail-wr0-f170.google.com with SMTP id g29so1220123wrg.11
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 01:59:03 -0700 (PDT)
References: <1506085187-24259-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170922130004eucas1p2aadaabbca4a656f43cd30bcfef6f6537@eucas1p2.samsung.com>
	<1506085187-24259-2-git-send-email-a.perevalov@samsung.com>
	<20170927190526.GB2395@work-vm>
	<f1e1f29c-26c0-3c5a-2f79-28ad4a694d45@redhat.com>
	<20170928180257.GG2130@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54108765-45ac-4207-ad37-ff209c88ed35@redhat.com>
Date: Fri, 29 Sep 2017 10:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170928180257.GG2130@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-headers: sync against v4.14-rc1
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 28/09/2017 20:02, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 27/09/2017 21:05, Dr. David Alan Gilbert wrote:
>>> cc'ing in Paolo who I think knows more about checking this sync.
>>
>> It looks good to me.
> 
> Fancy turning that into a Reviewed-by and pulling it?

Sure.

Paolo

> Dave
> 
>> Paolo
>>
>>> Dave
>>>
>>> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>>>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>>>> ---
>>>>  include/standard-headers/asm-x86/hyperv.h    | 19 ++++++++++---
>>>>  include/standard-headers/linux/pci_regs.h    | 42 ++++++++++++++++------------
>>>>  include/standard-headers/linux/virtio_ring.h |  4 +--
>>>>  linux-headers/asm-s390/kvm.h                 |  6 ++++
>>>>  linux-headers/linux/kvm.h                    |  3 +-
>>>>  linux-headers/linux/userfaultfd.h            | 16 ++++++++++-
>>>>  6 files changed, 64 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
>>>> index fac7651..5f95d5e 100644
>>>> --- a/include/standard-headers/asm-x86/hyperv.h
>>>> +++ b/include/standard-headers/asm-x86/hyperv.h
>>>> @@ -149,12 +149,9 @@
>>>>   */
>>>>  #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
>>>>  
>>>> -/*
>>>> - * HV_VP_SET available
>>>> - */
>>>> +/* Recommend using the newer ExProcessorMasks interface */
>>>>  #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
>>>>  
>>>> -
>>>>  /*
>>>>   * Crash notification flag.
>>>>   */
>>>> @@ -242,7 +239,11 @@
>>>>  		(~((1ull << HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT) - 1))
>>>>  
>>>>  /* Declare the various hypercall operations. */
>>>> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
>>>> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>>>>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>>>> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
>>>> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
>>>>  #define HVCALL_POST_MESSAGE			0x005c
>>>>  #define HVCALL_SIGNAL_EVENT			0x005d
>>>>  
>>>> @@ -259,6 +260,16 @@
>>>>  #define HV_PROCESSOR_POWER_STATE_C2		2
>>>>  #define HV_PROCESSOR_POWER_STATE_C3		3
>>>>  
>>>> +#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>>>> +#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>>>> +#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
>>>> +#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
>>>> +
>>>> +enum HV_GENERIC_SET_FORMAT {
>>>> +	HV_GENERIC_SET_SPARCE_4K,
>>>> +	HV_GENERIC_SET_ALL,
>>>> +};
>>>> +
>>>>  /* hypercall status code */
>>>>  #define HV_STATUS_SUCCESS			0
>>>>  #define HV_STATUS_INVALID_HYPERCALL_CODE	2
>>>> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
>>>> index c22d3eb..f8d5804 100644
>>>> --- a/include/standard-headers/linux/pci_regs.h
>>>> +++ b/include/standard-headers/linux/pci_regs.h
>>>> @@ -513,6 +513,7 @@
>>>>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>>>>  #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
>>>>  #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
>>>> +#define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
>>>>  #define PCI_EXP_LNKCAP		12	/* Link Capabilities */
>>>>  #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
>>>>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
>>>> @@ -556,7 +557,7 @@
>>>>  #define  PCI_EXP_LNKSTA_DLLLA	0x2000	/* Data Link Layer Link Active */
>>>>  #define  PCI_EXP_LNKSTA_LBMS	0x4000	/* Link Bandwidth Management Status */
>>>>  #define  PCI_EXP_LNKSTA_LABS	0x8000	/* Link Autonomous Bandwidth Status */
>>>> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V1	20	/* v1 endpoints end here */
>>>> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V1	20	/* v1 endpoints with link end here */
>>>>  #define PCI_EXP_SLTCAP		20	/* Slot Capabilities */
>>>>  #define  PCI_EXP_SLTCAP_ABP	0x00000001 /* Attention Button Present */
>>>>  #define  PCI_EXP_SLTCAP_PCP	0x00000002 /* Power Controller Present */
>>>> @@ -639,7 +640,7 @@
>>>>  #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
>>>>  #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
>>>>  #define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
>>>> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
>>>> +#define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
>>>>  #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
>>>>  #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
>>>>  #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5.0GT/s */
>>>> @@ -647,6 +648,7 @@
>>>>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>>>>  #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
>>>>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>>>> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
>>>>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
>>>>  #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
>>>>  #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
>>>> @@ -733,23 +735,17 @@
>>>>  #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
>>>>  #define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
>>>>  #define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
>>>> -/* Correctable Err Reporting Enable */
>>>> -#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001
>>>> -/* Non-fatal Err Reporting Enable */
>>>> -#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002
>>>> -/* Fatal Err Reporting Enable */
>>>> -#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004
>>>> +#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001 /* Correctable Err Reporting Enable */
>>>> +#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
>>>> +#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
>>>>  #define PCI_ERR_ROOT_STATUS	48
>>>> -#define PCI_ERR_ROOT_COR_RCV		0x00000001	/* ERR_COR Received */
>>>> -/* Multi ERR_COR Received */
>>>> -#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002
>>>> -/* ERR_FATAL/NONFATAL Received */
>>>> -#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004
>>>> -/* Multi ERR_FATAL/NONFATAL Received */
>>>> -#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008
>>>> -#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010	/* First Fatal */
>>>> -#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020	/* Non-Fatal Received */
>>>> -#define PCI_ERR_ROOT_FATAL_RCV		0x00000040	/* Fatal Received */
>>>> +#define PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
>>>> +#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
>>>> +#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
>>>> +#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
>>>> +#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
>>>> +#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
>>>> +#define PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
>>>>  #define PCI_ERR_ROOT_ERR_SRC	52	/* Error Source Identification */
>>>>  
>>>>  /* Virtual Channel */
>>>> @@ -967,6 +963,7 @@
>>>>  #define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
>>>>  #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
>>>>  #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
>>>> +#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0xF00	/* RP PIO log size */
>>>>  #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
>>>>  
>>>>  #define PCI_EXP_DPC_CTL			6	/* DPC control */
>>>> @@ -980,6 +977,15 @@
>>>>  
>>>>  #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
>>>>  
>>>> +#define PCI_EXP_DPC_RP_PIO_STATUS	 0x0C	/* RP PIO Status */
>>>> +#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO MASK */
>>>> +#define PCI_EXP_DPC_RP_PIO_SEVERITY	 0x14	/* RP PIO Severity */
>>>> +#define PCI_EXP_DPC_RP_PIO_SYSERROR	 0x18	/* RP PIO SysError */
>>>> +#define PCI_EXP_DPC_RP_PIO_EXCEPTION	 0x1C	/* RP PIO Exception */
>>>> +#define PCI_EXP_DPC_RP_PIO_HEADER_LOG	 0x20	/* RP PIO Header Log */
>>>> +#define PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG	 0x30	/* RP PIO ImpSpec Log */
>>>> +#define PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG 0x34	/* RP PIO TLP Prefix Log */
>>>> +
>>>>  /* Precision Time Measurement */
>>>>  #define PCI_PTM_CAP			0x04	    /* PTM Capability */
>>>>  #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
>>>> diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
>>>> index 023c6db..f1dc05d 100644
>>>> --- a/include/standard-headers/linux/virtio_ring.h
>>>> +++ b/include/standard-headers/linux/virtio_ring.h
>>>> @@ -1,7 +1,7 @@
>>>>  #ifndef _LINUX_VIRTIO_RING_H
>>>>  #define _LINUX_VIRTIO_RING_H
>>>> -/* An interface for efficient virtio implementation, currently for use by KVM
>>>> - * and lguest, but hopefully others soon.  Do NOT change this since it will
>>>> +/* An interface for efficient virtio implementation, currently for use by KVM,
>>>> + * but hopefully others soon.  Do NOT change this since it will
>>>>   * break existing servers and clients.
>>>>   *
>>>>   * This header is BSD licensed so anyone can use the definitions to implement
>>>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>>>> index 8387d71..7b750ef 100644
>>>> --- a/linux-headers/asm-s390/kvm.h
>>>> +++ b/linux-headers/asm-s390/kvm.h
>>>> @@ -88,6 +88,12 @@ struct kvm_s390_io_adapter_req {
>>>>  /* kvm attributes for KVM_S390_VM_TOD */
>>>>  #define KVM_S390_VM_TOD_LOW		0
>>>>  #define KVM_S390_VM_TOD_HIGH		1
>>>> +#define KVM_S390_VM_TOD_EXT		2
>>>> +
>>>> +struct kvm_s390_vm_tod_clock {
>>>> +	__u8  epoch_idx;
>>>> +	__u64 tod;
>>>> +};
>>>>  
>>>>  /* kvm attributes for KVM_S390_VM_CPU_MODEL */
>>>>  /* processor related attributes are r/w */
>>>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>>>> index 7971a4f..dd8a918 100644
>>>> --- a/linux-headers/linux/kvm.h
>>>> +++ b/linux-headers/linux/kvm.h
>>>> @@ -711,7 +711,8 @@ struct kvm_ppc_one_seg_page_size {
>>>>  struct kvm_ppc_smmu_info {
>>>>  	__u64 flags;
>>>>  	__u32 slb_size;
>>>> -	__u32 pad;
>>>> +	__u16 data_keys;	/* # storage keys supported for data */
>>>> +	__u16 instr_keys;	/* # storage keys supported for instructions */
>>>>  	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
>>>>  };
>>>>  
>>>> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
>>>> index 9701772..b43cf0d 100644
>>>> --- a/linux-headers/linux/userfaultfd.h
>>>> +++ b/linux-headers/linux/userfaultfd.h
>>>> @@ -23,7 +23,9 @@
>>>>  			   UFFD_FEATURE_EVENT_REMOVE |	\
>>>>  			   UFFD_FEATURE_EVENT_UNMAP |		\
>>>>  			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
>>>> -			   UFFD_FEATURE_MISSING_SHMEM)
>>>> +			   UFFD_FEATURE_MISSING_SHMEM |		\
>>>> +			   UFFD_FEATURE_SIGBUS |		\
>>>> +			   UFFD_FEATURE_THREAD_ID)
>>>>  #define UFFD_API_IOCTLS				\
>>>>  	((__u64)1 << _UFFDIO_REGISTER |		\
>>>>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
>>>> @@ -78,6 +80,9 @@ struct uffd_msg {
>>>>  		struct {
>>>>  			__u64	flags;
>>>>  			__u64	address;
>>>> +			union {
>>>> +				__u32 ptid;
>>>> +			} feat;
>>>>  		} pagefault;
>>>>  
>>>>  		struct {
>>>> @@ -153,6 +158,13 @@ struct uffdio_api {
>>>>  	 * UFFD_FEATURE_MISSING_SHMEM works the same as
>>>>  	 * UFFD_FEATURE_MISSING_HUGETLBFS, but it applies to shmem
>>>>  	 * (i.e. tmpfs and other shmem based APIs).
>>>> +	 *
>>>> +	 * UFFD_FEATURE_SIGBUS feature means no page-fault
>>>> +	 * (UFFD_EVENT_PAGEFAULT) event will be delivered, instead
>>>> +	 * a SIGBUS signal will be sent to the faulting process.
>>>> +	 *
>>>> +	 * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
>>>> +	 * be returned, if feature is not requested 0 will be returned.
>>>>  	 */
>>>>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>>>>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
>>>> @@ -161,6 +173,8 @@ struct uffdio_api {
>>>>  #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
>>>>  #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
>>>>  #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
>>>> +#define UFFD_FEATURE_SIGBUS			(1<<7)
>>>> +#define UFFD_FEATURE_THREAD_ID			(1<<8)
>>>>  	__u64 features;
>>>>  
>>>>  	__u64 ioctls;
>>>> -- 
>>>> 1.9.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
