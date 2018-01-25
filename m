Received: from eggs.gnu.org ([2001:4830:134:3::10]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eeiw6-0004cZ-MC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eeiw2-0001kF-LI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:55:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39880
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eeiw2-0001jo-5y
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:55:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PEsaMn106182
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:55:25 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fqevjfh7b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:55:25 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 09:55:24 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-3-git-send-email-walling@linux.vnet.ibm.com>
	<ce230364-5139-e49c-0cb9-95fe36296c75@redhat.com>
	<20180125121748.1e476515.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 09:55:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180125121748.1e476515.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <731e0f1b-fc6e-c523-3358-0dc28561d58e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 02/10] s390-ccw: refactor
 eckd_block_num to use CHS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: frankja@linux.vnet.ibm.com, david@redhat.com, alifm@linux.vnet.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On 01/25/2018 06:17 AM, Cornelia Huck wrote:
> On Thu, 25 Jan 2018 12:06:50 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 23.01.2018 19:26, Collin L. Walling wrote:
>>> Add new cylinder/head/sector struct. Use it to calculate
>>> eckd block numbers instead of a BootMapPointer (which used
>>> eckd chs anyway).
>>>
>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> ---
>>>   pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
>>>   pc-bios/s390-ccw/bootmap.h |  8 ++++++--
>>>   2 files changed, 20 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>>> index 6b6c915..621adbe 100644
>>> --- a/pc-bios/s390-ccw/bootmap.c
>>> +++ b/pc-bios/s390-ccw/bootmap.c
>>> @@ -95,32 +95,32 @@ static inline void verify_boot_info(BootInfo *bip)
>>>                  "Bad block size in zIPL section of the 1st record.");
>>>   }
>>>   
>>> -static block_number_t eckd_block_num(BootMapPointer *p)
>>> +static block_number_t eckd_block_num(EckdCHS chs)
>> Should this maybe rather be call-by-pointer instead? I'm not a fan of
>> passing structs by value, though it might be OK in this case since it's
>> a small struct only...
>>
>> What do others think?
> I think passing a struct by value is fine for things like a schid
> (which is basically just the structured version of an integer). In this
> case, I think passing a pointer would look nicer.
>
Easy enough :)

-- 
- Collin L Walling
