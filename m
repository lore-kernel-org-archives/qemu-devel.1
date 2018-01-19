Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ecVc5-0008Ow-VY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ecVc1-0007qh-Ts
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:17:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ecVc1-0007qF-LR
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:17:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JCEFvR078824
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 07:17:36 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkf8vudxs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 07:17:35 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 19 Jan 2018 12:17:31 -0000
References: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 19 Jan 2018 13:17:29 +0100
MIME-Version: 1.0
In-Reply-To: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d6a912c2-3d19-8890-3caf-b3d9b4103c3c@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: fix storage attributes
 migration for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 01/18/2018 06:51 PM, Claudio Imbrenda wrote:
> Fix storage attribute migration so that it does not fail for guests
> with more than a few GB of RAM.
> With such guests, the index in the buffer would go out of bounds,
> usually by large amounts, thus receiving -EFAULT from the kernel.
> Migration itself would be successful, but storage attributes would then
> not be migrated completely.
> 
> This patch fixes the out of bounds access, and thus migration of all
> storage attributes when the guest have large amounts of memory.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")

Cc: stable ?

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/s390x/s390-stattrib-kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 41770a7..480551c 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -116,7 +116,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>          for (cx = 0; cx + len <= max; cx += len) {
>              clog.start_gfn = cx;
>              clog.count = len;
> -            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
> +            clog.values = (uint64_t)(sas->incoming_buffer + cx);
>              r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
>              if (r) {
>                  error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
> @@ -126,7 +126,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>          if (cx < max) {
>              clog.start_gfn = cx;
>              clog.count = max - cx;
> -            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
> +            clog.values = (uint64_t)(sas->incoming_buffer + cx);
>              r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
>              if (r) {
>                  error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
> 
