Received: from eggs.gnu.org ([2001:4830:134:3::10]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYp3-0008Us-VJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYoz-0003vF-3E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:46:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVYoy-0003uh-PV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:46:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D7iw9i078105
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:45:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3qc703-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:45:58 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 03:45:57 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
	<92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
	<83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
	<0445c2d0-c810-8d1e-4075-8251eb79a166@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 09:45:52 +0200
MIME-Version: 1.0
In-Reply-To: <0445c2d0-c810-8d1e-4075-8251eb79a166@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <05677519-ff4e-9dd7-2bcb-d01a5e4782bb@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] s390x/migration: Storage attributes
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 07/13/2017 09:35 AM, Thomas Huth wrote:
> On 13.07.2017 09:11, Christian Borntraeger wrote:
>> Thanks for the review, all valid. Claudio has provided me the following fixup.
>>
>> I plan to fold that in the base patch (retest pending).
>>
>> Christian
>>
>>
>> ---
>>  hw/s390x/s390-stattrib-kvm.c          | 26 +++++++++++++++++++-------
>>  hw/s390x/s390-stattrib.c              | 12 +++---------
>>  include/hw/s390x/storage-attributes.h |  9 +++++++++
>>  3 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
>> index 2e7f144..2ab3060 100644
>> --- a/hw/s390x/s390-stattrib-kvm.c
>> +++ b/hw/s390x/s390-stattrib-kvm.c
>> @@ -11,7 +11,6 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "hw/boards.h"
>> -#include "qmp-commands.h"
>>  #include "migration/qemu-file.h"
>>  #include "hw/s390x/storage-attributes.h"
>>  #include "qemu/error-report.h"
>> @@ -19,6 +18,15 @@
>>  #include "exec/ram_addr.h"
>>  #include "cpu.h"
>>
>> +Object *kvm_s390_stattrib_create(void)
>> +{
>> +    if (kvm_enabled() &&
>> +                kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
>> +        return object_new(TYPE_KVM_S390_STATTRIB);
>> +    }
>> +    return object_new(TYPE_QEMU_S390_STATTRIB);
>> +}
> 
> I think you could also return NULL here instead of
> object_new(TYPE_QEMU_S390_STATTRIB) since ...

Yes, I like return NULL better so that we do not create the QEMU one
in *kvm.c. Will also fixup. thanks
> 
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index b9533b4..bac9aea 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -40,16 +40,10 @@ void s390_stattrib_init(void)
>>  {
>>      Object *obj;
>>
>> -#ifdef CONFIG_KVM
>> -    if (kvm_enabled() &&
>> -            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
>> -        obj = object_new(TYPE_KVM_S390_STATTRIB);
>> -    } else {
>> +    obj = kvm_s390_stattrib_create();
>> +    if (!obj) {
>>          obj = object_new(TYPE_QEMU_S390_STATTRIB);
>>      }
> 
> ... the object will be created here, too.
> 
>  Thomas
> 
