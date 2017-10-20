Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5Uk5-0002d4-1T
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5Uk1-0000rB-11
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:41:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e5Uk0-0000q3-OM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:41:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KAe41p065685
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 06:41:18 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqdewxq1w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 06:41:18 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Oct 2017 11:41:16 +0100
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<67132f0e-cc4d-312f-140a-1966f0d877c6@suse.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Oct 2017 12:41:13 +0200
MIME-Version: 1.0
In-Reply-To: <67132f0e-cc4d-312f-140a-1966f0d877c6@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7a65ad71-9c6d-ee0a-851c-ab6bd9806180@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>


On 10/20/2017 12:30 PM, Alexander Graf wrote:
> 
> 
> On 20.10.17 12:25, Christian Borntraeger wrote:
>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>
>> The sclp console in the s390 bios writes raw data,
>> leading console emulators (such as virsh console) to
>> treat a new line ('\n') as just a new line instead
>> of as a Unix line feed. Because of this, output
>> appears in a "stair case" pattern.
>>
>> Let's print \r\n on every occurrence of a new line
>> in the string passed to write to amend this issue.
>>
>> This is in sync with the guest Linux code in
>> drivers/s390/char/sclp_vt220.c which also does a line feed
>> conversion  in the console part of the driver. 
>>
>> This fixes the s390-ccw and s390-netboot output like
>> $ virsh start test --console
>> Domain test started
>> Connected to domain test
>> Escape character is ^]
>> Network boot starting...
>>                           Using MAC address: 02:01:02:03:04:05
>>                                                                 Requesting information via DHCP:  010
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  pc-bios/s390-ccw/s390-ccw.h |  3 +++
>>  pc-bios/s390-ccw/sclp.c     | 17 ++++++++++++++---
>>  2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 25d4d21..a8bd204 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -33,6 +33,9 @@ typedef unsigned long long __u64;
>>  #ifndef EBUSY
>>  #define EBUSY   2
>>  #endif
>> +#ifndef EFBIG
>> +#define EFBIG   3
>> +#endif
>>  #ifndef NULL
>>  #define NULL    0
>>  #endif
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index b1fc8ff..4795259 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -76,17 +76,28 @@ static int _strlen(const char *str)
>>  long write(int fd, const void *str, size_t len)
>>  {
>>      WriteEventData *sccb = (void *)_sccb;
>> +    const char *p;
>> +    size_t data_len = 0;
>>  
>>      if (fd != 1 && fd != 2) {
>>          return -EIO;
>>      }
>>  
>> -    sccb->h.length = sizeof(WriteEventData) + len;
>> +    for (p = str; *p; ++p) {
>> +        if (data_len > SCCB_DATA_LEN - 1) {
>> +            return -EFBIG;
>> +        }
>> +        if (*p == '\n') {
>> +            sccb->data[data_len++] = '\r';
>> +        }
>> +        sccb->data[data_len++] = *p;
>> +    }
>> +
>> +    sccb->h.length = sizeof(WriteEventData) + data_len;
> 
> This subtly changes the semantics of the write() function from an
> explicitly passed in "len" argument to NULL termination determined
> sizing, no?
> 
> In that case, wouldn't it make sense to either remove the len argument
> altogether or keep respecting it?

Yes, well spotted.
The write function is used in other code (SLOF related network boot),
so we should change it to respect the length, I think.

> 
> 
> Alex
> 
>>      sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
>> -    sccb->ebh.length = sizeof(EventBufferHeader) + len;
>> +    sccb->ebh.length = sizeof(EventBufferHeader) + data_len;
>>      sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>>      sccb->ebh.flags = 0;
>> -    memcpy(sccb->data, str, len);
>>  
>>      sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>>  
>>
> 
