Received: from eggs.gnu.org ([2001:4830:134:3::10]:51234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ec8aX-00050K-8K
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ec8aU-0001Ip-6G
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:42:33 -0500
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8c31b940-cc9e-d410-0e0d-46e6dc4c84f0@redhat.com>
Date: Thu, 18 Jan 2018 12:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180118085628.40798-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 18.01.2018 09:56, Christian Borntraeger wrote:
> replace with proper header sync
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 9 ++++-----
>  linux-headers/linux/kvm.h    | 5 +++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 32d372e..11def14 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -6,10 +6,6 @@
>   *
>   * Copyright IBM Corp. 2008
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   */
> @@ -228,6 +224,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_RICCB  (1UL << 7)
>  #define KVM_SYNC_FPRS   (1UL << 8)
>  #define KVM_SYNC_GSCB   (1UL << 9)
> +#define KVM_SYNC_BPBC   (1UL << 10)
>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> @@ -251,7 +248,9 @@ struct kvm_sync_regs {
>  	};
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
> -	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
> +	__u8 bpbc : 1;		/* bp mode */
> +	__u8 reserved2 : 7;
> +	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>  	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
>  	union {
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index ce6c2f1..b4503d8 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -630,9 +630,9 @@ struct kvm_s390_irq {
>  
>  struct kvm_s390_irq_state {
>  	__u64 buf;
> -	__u32 flags;
> +	__u32 flags;        /* will stay unused for compatibility reasons */
>  	__u32 len;
> -	__u32 reserved[4];
> +	__u32 reserved[4];  /* will stay unused for compatibility reasons */
>  };
>  
>  /* for KVM_SET_GUEST_DEBUG */
> @@ -932,6 +932,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
>  #define KVM_CAP_S390_AIS_MIGRATION 150
> +#define KVM_CAP_S390_BPB 151
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
