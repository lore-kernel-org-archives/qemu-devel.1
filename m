Received: from eggs.gnu.org ([2001:4830:134:3::10]:47822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvO9D-0007QP-67
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvO98-0005kp-DI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:37:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dvO98-0005kI-7Y
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:37:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MDZIgt101748
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:37:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4yn38417-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:37:29 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Sep 2017 14:37:27 +0100
References: <20170921213052.1765-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Sep 2017 15:37:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170921213052.1765-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9686f4ef-ba96-c492-3f96-fe9c13394f82@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] s390x/kvm: fix and cleanup storing CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 09/21/2017 11:30 PM, David Hildenbrand wrote:
> env->psa is a 64bit value, while we copy 4 bytes into the save area,
> resulting always in 0 getting stored.
> 
> Let's try to reduce such errors by using a proper structure. While at
> it, use correct cpu->be conversion (and get_psw_mask()), as we will be
> reusing this code for TCG soon.

Interesting, I would have expected it to break kdump, but this did work.
So it probably works differently.

Anyway this looks sane, no obvious bug.


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Found with my fancy SIGP kvm-unit-tests I am currently working on. And
> looks like there is even more ... stay tuned :)
> 
>  target/s390x/kvm.c | 63 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 720cb1d833..21c22f48b9 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1548,22 +1548,38 @@ static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
>      return 0;
>  }
> 
> +struct sigp_save_area {
> +    uint64_t    fprs[16];                       /* 0x0000 */
> +    uint64_t    grs[16];                        /* 0x0080 */
> +    PSW         psw;                            /* 0x0100 */
> +    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
> +    uint32_t    prefix;                         /* 0x0118 */
> +    uint32_t    fpc;                            /* 0x011c */
> +    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */

> +    uint32_t    todpr;                          /* 0x0124 */
> +    uint64_t    cputm;                          /* 0x0128 */
> +    uint64_t    ckc;                            /* 0x0130 */
> +    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
> +    uint32_t    ars[16];                        /* 0x0140 */
> +    uint64_t    crs[16];                        /* 0x0384 */
> +} QEMU_PACKED;
> +
>  #define KVM_S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
> -#define SAVE_AREA_SIZE 512
>  static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>  {
>      static const uint8_t ar_id = 1;
> -    uint64_t ckc = cpu->env.ckc >> 8;
> -    void *mem;
> +    struct sigp_save_area *sa;
> +    hwaddr len = sizeof(*sa);
>      int i;
> -    hwaddr len = SAVE_AREA_SIZE;
> 
> -    mem = cpu_physical_memory_map(addr, &len, 1);
> -    if (!mem) {
> +    QEMU_BUILD_BUG_ON(sizeof(*sa) != 512);
> +
> +    sa = cpu_physical_memory_map(addr, &len, 1);
> +    if (!sa) {
>          return -EFAULT;
>      }
> -    if (len != SAVE_AREA_SIZE) {
> -        cpu_physical_memory_unmap(mem, len, 1, 0);
> +    if (len != sizeof(*sa)) {
> +        cpu_physical_memory_unmap(sa, len, 1, 0);
>          return -EFAULT;
>      }
> 
> @@ -1571,19 +1587,26 @@ static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>          cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
>      }
>      for (i = 0; i < 16; ++i) {
> -        *((uint64_t *)mem + i) = get_freg(&cpu->env, i)->ll;
> -    }
> -    memcpy(mem + 128, &cpu->env.regs, 128);
> -    memcpy(mem + 256, &cpu->env.psw, 16);
> -    memcpy(mem + 280, &cpu->env.psa, 4);
> -    memcpy(mem + 284, &cpu->env.fpc, 4);
> -    memcpy(mem + 292, &cpu->env.todpr, 4);
> -    memcpy(mem + 296, &cpu->env.cputm, 8);
> -    memcpy(mem + 304, &ckc, 8);
> -    memcpy(mem + 320, &cpu->env.aregs, 64);
> -    memcpy(mem + 384, &cpu->env.cregs, 128);
> +        sa->fprs[i] = cpu_to_be64(get_freg(&cpu->env, i)->ll);
> +    }
> +    for (i = 0; i < 16; ++i) {
> +        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
> +    }
> +    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
> +    sa->psw.mask = cpu_to_be64(get_psw_mask(&cpu->env));
> +    sa->prefix = cpu_to_be32(cpu->env.psa);
> +    sa->fpc = cpu_to_be32(cpu->env.fpc);
> +    sa->todpr = cpu_to_be32(cpu->env.todpr);
> +    sa->cputm = cpu_to_be64(cpu->env.cputm);
> +    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
> +    for (i = 0; i < 16; ++i) {
> +        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
> +    }
> +    for (i = 0; i < 16; ++i) {
> +        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
> +    }
> 
> -    cpu_physical_memory_unmap(mem, len, 1, len);
> +    cpu_physical_memory_unmap(sa, len, 1, len);
> 
>      return 0;
>  }
> 
