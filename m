Received: from eggs.gnu.org ([2001:4830:134:3::10]:39113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epATT-00081Y-7H
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epATQ-0002GH-3V
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:21:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1epATP-0002EY-PN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:21:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NAJmZK154356
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:21:02 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gadfm8nc7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:21:02 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Feb 2018 10:21:00 -0000
References: <20180223101919.21075-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 11:20:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180223101919.21075-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9886a8b5-fe28-6dab-167d-cd1741a9baec@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: remove
 s390_get_memslot_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On 02/23/2018 11:19 AM, Cornelia Huck wrote:
> Not needed anymore after removal of the memory hotplug code.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  include/hw/s390x/sclp.h  | 1 -
>  target/s390x/cpu.c       | 9 ---------
>  target/s390x/cpu.h       | 4 ----
>  target/s390x/kvm-stub.c  | 5 -----
>  target/s390x/kvm.c       | 5 -----
>  target/s390x/kvm_s390x.h | 1 -
>  6 files changed, 25 deletions(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 476cbf78f2..f9db243484 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -35,7 +35,6 @@
>  #define SCLP_FC_ASSIGN_ATTACH_READ_STOR         0xE00000000000ULL
>  #define SCLP_STARTING_SUBINCREMENT_ID           0x10001
>  #define SCLP_INCREMENT_UNIT                     0x10000
> -#define MAX_AVAIL_SLOTS                         32
>  #define MAX_STORAGE_INCREMENTS                  1020
> 
>  /* CPU hotplug SCLP codes */
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index f02ed19c70..627002b225 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -437,15 +437,6 @@ void s390_cmma_reset(void)
>      }
>  }
> 
> -int s390_get_memslot_count(void)
> -{
> -    if (kvm_enabled()) {
> -        return kvm_s390_get_memslot_count();
> -    } else {
> -        return MAX_AVAIL_SLOTS;
> -    }
> -}
> -
>  int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
>                                  int vq, bool assign)
>  {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5bd6de7e8e..c5ef930876 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -621,9 +621,6 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
>  /* SIGP order code mask corresponding to bit positions 56-63 */
>  #define SIGP_ORDER_MASK 0x000000ff
> 
> -/* from s390-virtio-ccw */
> -#define MAX_AVAIL_SLOTS              32
> -
>  /* machine check interruption code */
> 
>  /* subclasses */
> @@ -695,7 +692,6 @@ int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
>  int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
>  void s390_crypto_reset(void);
>  bool s390_get_squash_mcss(void);
> -int s390_get_memslot_count(void);
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
>  void s390_cmma_reset(void);
>  void s390_enable_css_support(S390CPU *cpu);
> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
> index 8cdcf83845..29b10542cc 100644
> --- a/target/s390x/kvm-stub.c
> +++ b/target/s390x/kvm-stub.c
> @@ -84,11 +84,6 @@ void kvm_s390_cmma_reset(void)
>  {
>  }
> 
> -int kvm_s390_get_memslot_count(void)
> -{
> -  return MAX_AVAIL_SLOTS;
> -}
> -
>  void kvm_s390_reset_vcpu(S390CPU *cpu)
>  {
>  }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8ef509ece4..656aaea2cd 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1854,11 +1854,6 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>      return kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
>  }
> 
> -int kvm_s390_get_memslot_count(void)
> -{
> -    return kvm_check_extension(kvm_state, KVM_CAP_NR_MEMSLOTS);
> -}
> -
>  int kvm_s390_get_ri(void)
>  {
>      return cap_ri;
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 7a3b862eea..c383bf4ee9 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -30,7 +30,6 @@ int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
>  void kvm_s390_enable_css_support(S390CPU *cpu);
>  int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>                                      int vq, bool assign);
> -int kvm_s390_get_memslot_count(void);
>  int kvm_s390_cmma_active(void);
>  void kvm_s390_cmma_reset(void);
>  void kvm_s390_reset_vcpu(S390CPU *cpu);
> 
