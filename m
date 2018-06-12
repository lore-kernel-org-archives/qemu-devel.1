Received: from eggs.gnu.org ([2001:4830:134:3::10]:40495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSdlZ-0007hC-Ox
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSdlU-0000nr-4k
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:30:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSdlT-0000nH-Ql
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:30:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5C7Sw6O031432
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 03:30:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jj8f2ksek-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 03:30:50 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 12 Jun 2018 08:30:48 +0100
References: <20180611135223.81865-1-borntraeger@de.ibm.com>
	<c5ec6c27-42cb-e354-b861-8485e72cf1e3@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 12 Jun 2018 09:30:42 +0200
MIME-Version: 1.0
In-Reply-To: <c5ec6c27-42cb-e354-b861-8485e72cf1e3@redhat.com>
Content-Language: en-US
Message-Id: <fc99f06a-3f54-343c-4362-3fb9df2d4768@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/ipl: Try to detect Linux vs
 non Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 06/11/2018 06:16 PM, Thomas Huth wrote:
> On 11.06.2018 15:52, Christian Borntraeger wrote:
>> Right now the IPL device always starts from address 0x10000 (the usual
>> Linux entry point). To run other guests (e.g. test programs) it is
>> useful to use the IPL PSW from address 0. We can use the Linux magic
>> at 0x10008 to decide.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> v1->v2:
>> 	- use LINUX_MAGIC_ADDR define
>> 	- use assert for valid iplpsw pointer
>> 	- add endianess conversion
>>  hw/s390x/ipl.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 04245b5258..3790153fa9 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -29,6 +29,7 @@
>>  #include "exec/exec-all.h"
>>  
>>  #define KERN_IMAGE_START                0x010000UL
>> +#define LINUX_MAGIC_ADDR                0x010008UL
>>  #define KERN_PARM_AREA                  0x010480UL
>>  #define INITRD_START                    0x800000UL
>>  #define INITRD_PARM_START               0x010408UL
>> @@ -105,7 +106,9 @@ static uint64_t bios_translate_addr(void *opaque, uint64_t srcaddr)
>>  static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>  {
>>      S390IPLState *ipl = S390_IPL(dev);
>> -    uint64_t pentry = KERN_IMAGE_START;
>> +    uint64_t *iplpsw;
>> +    uint64_t pentry;
>> +    char *magic;
>>      int kernel_size;
>>      Error *err = NULL;
>>  
>> @@ -157,6 +160,16 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>                                 NULL, 1, EM_S390, 0, 0);
>>          if (kernel_size < 0) {
>>              kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
>> +            /* if this is Linux use KERN_IMAGE_START */
>> +            magic = rom_ptr(LINUX_MAGIC_ADDR);
>> +            if (magic && !memcmp(magic, "S390EP", 6)) {
>> +                pentry = KERN_IMAGE_START;
>> +            } else {
>> +                /* if not Linux use the IPL PSW */
>> +                iplpsw = rom_ptr(0);
>> +                assert(iplpsw);
> 
> Hmm, wait, what if load_image_targphys() failed and returned a
> kernel_size < 0 ... won't we hit that assert() in that case? I think you
> might want to check for kernel_size > 0 (or even > 8) here first.

I think I can just check for iplpsw being != NULL. That will only be the case
if the load has succeeded. 
