Received: from eggs.gnu.org ([2001:4830:134:3::10]:40603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlrX-0007yX-WA
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlrU-0000ZW-8M
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:11:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGlrT-0000Z7-Vu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:11:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKDBS0x069241
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 08:11:39 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebx32e3pg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 08:11:30 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 13:11:06 -0000
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-3-borntraeger@de.ibm.com>
	<20171120140052.48c7f646.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 14:11:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171120140052.48c7f646.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <84eddd46-e843-8d4a-5905-1e6956187f4e@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: use valgrind annotations
 for kvm device attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>



On 11/20/2017 02:00 PM, Cornelia Huck wrote:
> On Mon, 20 Nov 2017 13:35:25 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> the KVM_GET/SET_DEVICE_ATTR calls have non-self-describing
>> side effects. Use valgrind annotations to properly mark
>> all storage changes instead of using memset or designated
>> initializers.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-skeys-kvm.c    | 12 ++++++++++-
>>  hw/s390x/s390-stattrib-kvm.c |  7 ++++++
>>  target/s390x/kvm.c           | 51 ++++++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 65 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
>> index dc54ed8..0986795 100644
>> --- a/hw/s390x/s390-skeys-kvm.c
>> +++ b/hw/s390x/s390-skeys-kvm.c
>> @@ -13,6 +13,9 @@
>>  #include "hw/s390x/storage-keys.h"
>>  #include "sysemu/kvm.h"
>>  #include "qemu/error-report.h"
>> +#ifdef CONFIG_VALGRIND_H
>> +#include <valgrind/memcheck.h>
>> +#endif
>>  
>>  static int kvm_s390_skeys_enabled(S390SKeysState *ss)
>>  {
>> @@ -35,8 +38,15 @@ static int kvm_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
>>          .count = count,
>>          .skeydata_addr = (__u64)keys
>>      };
>> +    int ret;
>>  
>> -    return kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
>> +    ret = kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
>> +    if (!ret) {
>> +#ifdef CONFIG_VALGRIND_H
>> +        VALGRIND_MAKE_MEM_DEFINED(keys, count);
>> +#endif
> 
> This looks ugly :(
> 
> Is s390x the only one hitting those side effects?

Almost nobody else uses the device attributes. And when they use it they
have the same problem
We papered over some bugs by zero-initializing structs but I think marking
only the really changed memory will help to detect real bugs (e.g. if code
reads ioctl data but the ioctl fails we will not detect this when pre-zeroing.


 If we need to
> sprinkle those all over the source code, it improves valgrind results
> but makes the code harder to read...
> 
> (And no, I don't have a better idea.)
> 
>> +    }
>> +    return ret;
>>  }
> 
