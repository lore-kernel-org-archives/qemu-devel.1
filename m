Received: from eggs.gnu.org ([2001:4830:134:3::10]:41053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6mC-000562-RV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6mB-0005OE-Po
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:11:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ej6mB-0005NI-IG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:11:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16HBGEL046656
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 12:11:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyff93fkd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:11:19 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 12:10:58 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
	<0c40e592-32e7-315e-fbad-1969c90b9b01@redhat.com>
	<60be1af6-ab00-5425-1cac-edb722dfcc1a@linux.vnet.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 12:10:55 -0500
MIME-Version: 1.0
In-Reply-To: <60be1af6-ab00-5425-1cac-edb722dfcc1a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <c2c55487-1896-6b16-0fec-ad68600f74d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/06/2018 05:13 AM, Viktor Mihajlovski wrote:
> On 06.02.2018 10:23, Thomas Huth wrote:
>> On 05.02.2018 21:57, Collin L. Walling wrote:
>> [...]
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 0d06fc1..3e3c3b8 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -399,6 +399,20 @@ void s390_reipl_request(void)
>>>       qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>>>   }
>>>   
>>> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>> +{
>>> +    S390IPLState *ipl = get_ipl_device();
>>> +    uint8_t *addr;
>>> +    uint64_t len = 4096;
>>> +
>>> +    addr = cpu_physical_memory_map(cpu->env.psa, &len, 1);
>>> +    if (!addr || len < 204 + sizeof(QemuIplParameters)) {
>>> +        error_report("Cannot set QEMU IPL parameters");
>> I think you should return or exit() here. Otherwise the memcpy below
>> accesses an illegal memory range.Right, I have noticed and fixed that on my private branch, but forgot to
> update the patch. Collin, could you squash in a
>              return;

Can do.

[...]


-- 
- Collin L Walling
