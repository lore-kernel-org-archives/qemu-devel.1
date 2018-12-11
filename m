Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gWlCP-00068O-N9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gWlCL-0000Fh-RF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:47:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gWlCK-00009w-Tr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:47:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBBGcbjj106606
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:47:50 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pafv8m1xx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:47:48 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 11 Dec 2018 16:47:46 -0000
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
	<1544135058-21380-3-git-send-email-walling@linux.ibm.com>
	<20181207130853.20506345.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 11 Dec 2018 11:47:41 -0500
MIME-Version: 1.0
In-Reply-To: <20181207130853.20506345.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dbabb43d-01e7-d221-a761-ad5a53fd8f94@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/3] s390: cpu feature for
 diagnose 318 andlimit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

On 12/7/18 7:08 AM, Cornelia Huck wrote:
> On Thu,  6 Dec 2018 17:24:17 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Diagnose 318 is a new z14.2 CPU feature. Since we are able to emulate
>> it entirely via KVM, we can add guest support for earlier models. A
>> new CPU feature for diagnose 318 (shortened to diag318) will be made
>> available to guests starting with the zEC12-full CPU model.
>>
>> The z14.2 adds a new read SCP info byte (let's call it byte 134) to
>> detect the availability of diag318. Because of this, we have room for
>> one less VCPU and thus limit the max VPUs supported in a configuration
>> to 247 (down from 248).
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>.
>> ---
>>  hw/s390x/sclp.c                 | 2 ++
>>  include/hw/s390x/sclp.h         | 2 ++
>>  target/s390x/cpu.h              | 2 +-
>>  target/s390x/cpu_features.c     | 3 +++
>>  target/s390x/cpu_features.h     | 1 +
>>  target/s390x/cpu_features_def.h | 3 +++
>>  target/s390x/gen-features.c     | 1 +
>>  target/s390x/kvm.c              | 1 +
>>  8 files changed, 14 insertions(+), 1 deletion(-)
>>
> 
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 8c2320e..594b4a4 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -52,7 +52,7 @@
>>  
>>  #define MMU_USER_IDX 0
>>  
>> -#define S390_MAX_CPUS 248
>> +#define S390_MAX_CPUS 247
> 
> Isn't that already problematic if you try to migrate from an older QEMU
> with all possible vcpus defined? IOW, don't you really need a way that
> older machines can still run with one more vcpu?
> 

Good call. I'll run some tests on this and see what happens. I'll report
here on those results.

>>  
>>  typedef struct PSW {
>>      uint64_t mask;
> 


-- 
Respectfully,
- Collin Walling
