Received: from eggs.gnu.org ([209.51.188.92]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gx8wO-0006MP-9e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gx8wC-0006D9-8E
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gx8vd-0005fr-8y
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MBKTJ2094121
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:23:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtg1trbvs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:23:38 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Feb 2019 11:23:35 -0000
References: <20190222081153.14206-1-david@redhat.com>
	<20190222081153.14206-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Feb 2019 12:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190222081153.14206-2-david@redhat.com>
Content-Language: en-US
Message-Id: <bde70e0f-568d-2505-f372-d0d4989c20f8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] s390x: Use cpu_to_be64 in SIGP
 STORE ADDITIONAL STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>



On 22.02.2019 09:11, David Hildenbrand wrote:
> As we will support vector instructions soon, and vector registers are
> stored in 64bit host chunks, let's use cpu_to_be64. Same applies to the
> guarded storage control block.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

looks sane.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/helper.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 3d74836a83..f3fcf96482 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -272,32 +272,43 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>      return 0;
>  }
>  
> -#define ADTL_GS_OFFSET   1024 /* offset of GS data in adtl save area */
> +typedef struct SigpAdtlSaveArea {
> +    uint64_t    vregs[32][2];                     /* 0x0000 */
> +    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
> +    uint64_t    gscb[4];                          /* 0x0400 */
> +    uint8_t     pad_0x0420[0x1000 - 0x0420];      /* 0x0420 */
> +} SigpAdtlSaveArea;
> +QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
> +
>  #define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
>  int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
>  {
> +    SigpAdtlSaveArea *sa;
>      hwaddr save = len;
> -    void *mem;
> +    int i;
>  
> -    mem = cpu_physical_memory_map(addr, &save, 1);
> -    if (!mem) {
> +    sa = cpu_physical_memory_map(addr, &save, 1);
> +    if (!sa) {
>          return -EFAULT;
>      }
>      if (save != len) {
> -        cpu_physical_memory_unmap(mem, len, 1, 0);
> +        cpu_physical_memory_unmap(sa, len, 1, 0);
>          return -EFAULT;
>      }
>  
> -    /* FIXME: as soon as TCG supports these features, convert cpu->be */
>      if (s390_has_feat(S390_FEAT_VECTOR)) {
> -        memcpy(mem, &cpu->env.vregs, 512);
> +        for (i = 0; i < 32; i++) {
> +            sa->vregs[i][0] = cpu_to_be64(cpu->env.vregs[i][0].ll);
> +            sa->vregs[i][1] = cpu_to_be64(cpu->env.vregs[i][1].ll);
> +        }
>      }
>      if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
> -        memcpy(mem + ADTL_GS_OFFSET, &cpu->env.gscb, 32);
> +        for (i = 0; i < 4; i++) {
> +            sa->gscb[i] = cpu_to_be64(cpu->env.gscb[i]);
> +        }
>      }
>  
> -    cpu_physical_memory_unmap(mem, len, 1, len);
> -
> +    cpu_physical_memory_unmap(sa, len, 1, len);
>      return 0;
>  }
>  #endif /* CONFIG_USER_ONLY */
> 
