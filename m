Received: from eggs.gnu.org ([2001:4830:134:3::10]:46554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUYXG-0006sc-29
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUYXB-0000GI-Ub
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:52:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48490
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gUYXB-0000Fz-No
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:52:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5EoTFA108655
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 09:52:17 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6fq2uveg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 09:52:16 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 5 Dec 2018 14:52:16 -0000
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<16daec26-f72a-326c-a808-729b9f1af129@linux.ibm.com>
	<20181205120717.1713d8fe.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 5 Dec 2018 09:52:10 -0500
MIME-Version: 1.0
In-Reply-To: <20181205120717.1713d8fe.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <48e3a09c-1f4e-5f93-e77e-89ff16c7908c@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390: guest support for
 diagnose 318 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: cotte@de.ibm.com, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mimu@linux.ibm.com

On 12/5/18 6:07 AM, Cornelia Huck wrote:
> On Tue, 4 Dec 2018 17:26:36 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> I screen-scraped the @ibm address again (Conny was the victim this time)
>>
>> Reply to this thread to avoid any delivery failures.
>>
>> On 12/4/18 5:18 PM, Collin Walling wrote:
>>> Add migration and reset support for diagnose 318. This is a new z14 GA2 
>>> hardware feature, but we can provide guest support starting with the 
>>> zEC12-full CPU model.
>>>
>>> Because new hardware introduces a new facility-availability byte in 
>>> the Read SCP Info block, we lose one byte in the CPU entries list 
>>> and must limit the maximum VCPUs to 247 (down from 248).
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>
>>> Changelog
>>>
>>>     RFC -> v1
>>>         - introduced kvm stubs for set/get cpc
>>>         - s/fac134/byte_134
>>>         - moved diag318 vmstate description to diag.c
>>>         - reduced S390_VCPU_MAX to 247
>>>
>>>  hw/s390x/ipl.c                  |  3 +++
>>>  hw/s390x/s390-virtio-ccw.c      |  3 +++
>>>  hw/s390x/sclp.c                 |  2 ++
>>>  include/hw/s390x/sclp.h         |  2 ++
>>>  linux-headers/asm-s390/kvm.h    |  5 ++++
>>>  target/s390x/cpu.h              |  2 +-
>>>  target/s390x/cpu_features.c     |  3 +++
>>>  target/s390x/cpu_features.h     |  1 +
>>>  target/s390x/cpu_features_def.h |  3 +++
>>>  target/s390x/diag.c             | 53 +++++++++++++++++++++++++++++++++++++++++
>>>  target/s390x/gen-features.c     |  1 +
>>>  target/s390x/internal.h         |  4 +++-
>>>  target/s390x/kvm-stub.c         | 10 ++++++++
>>>  target/s390x/kvm.c              | 23 ++++++++++++++++++
>>>  target/s390x/kvm_s390x.h        |  3 +++
>>>  15 files changed, 116 insertions(+), 2 deletions(-)
> 
>>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>>> index 0265482..8c206d2 100644
>>> --- a/linux-headers/asm-s390/kvm.h
>>> +++ b/linux-headers/asm-s390/kvm.h
> 
> Please split this out into a dummy headers update patch, which will be
> replaced with a real headers update when applied.
> 
> 

Will do.

-- 
Respectfully,
- Collin Walling
