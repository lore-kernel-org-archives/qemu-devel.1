Received: from eggs.gnu.org ([2001:4830:134:3::10]:43180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fYWGE-0007hs-9m
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fYWG9-0003re-2H
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42182
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fYWG8-0003qV-T4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5SCdEWC088854
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:42:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jvwqt6d08-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:42:47 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 28 Jun 2018 13:42:45 +0100
References: <20180628113817.30814-1-david@redhat.com>
	<20180628113817.30814-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 28 Jun 2018 14:42:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180628113817.30814-2-david@redhat.com>
Content-Language: en-US
Message-Id: <f55a705b-994d-4cfd-7b74-03fd83800124@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/2] s390x/kvm:
 legacy_s390_alloc() only supports one allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 06/28/2018 01:38 PM, David Hildenbrand wrote:
> We always allocate at a fixed address, a second allocation can therefore
> of course never work. We would simply overwrite mappings.
> 
> This can e.g. happen in s390_memory_init(), if trying to allocate more
> than > 8TB. Let's just bail out, as there is no need for supporting it
> (legacy handling for z/VM).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/kvm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ac370da281..bbac3454e3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -752,12 +752,20 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>   */
>  static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared)
>  {
> -    void *mem;
> +    static void *mem;
> +
> +    if (mem) {
> +        /* we only support one allocation, which is enough for initial ram */
> +        return NULL;
> +    }
>  
>      mem = mmap((void *) 0x800000000ULL, size,
>                 PROT_EXEC|PROT_READ|PROT_WRITE,
>                 MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> -    return mem == MAP_FAILED ? NULL : mem;
> +    if (mem == MAP_FAILED) {
> +        mem = NULL;
> +    }
> +    return mem;
>  }
>  
>  static uint8_t const *sw_bp_inst;
> 
