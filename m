Received: from eggs.gnu.org ([2001:4830:134:3::10]:39433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSi8h-0007Yo-E5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSi8b-0008QH-7B
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:11:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSi8a-0008Px-Vi
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:11:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5CC63g6058519
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:11:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jjcjd4vhh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:10:59 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 12 Jun 2018 13:10:58 +0100
References: <20180612100448.202315-1-borntraeger@de.ibm.com>
	<20180612135545.1b7c2346.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 12 Jun 2018 14:10:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180612135545.1b7c2346.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <4ac300ef-cda8-40bc-60dd-b8f4af94ea6b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/ipl: Try to detect Linux vs
 non Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 06/12/2018 01:55 PM, Cornelia Huck wrote:
> On Tue, 12 Jun 2018 12:04:48 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Right now the IPL device always starts from address 0x10000 (the usual
>> Linux entry point). To run other guests (e.g. test programs) it is
>> useful to use the IPL PSW from address 0. We can use the Linux magic
>> at 0x10008 to decide.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> v2->v3:
>> 	- check for iplpsw to avoid assert on file errors
>> 	- use 4 bytes at 4 instead of 8 bytes at 0
>> v1->v2:
>> 	- use LINUX_MAGIC_ADDR define
>> 	- use assert for valid iplpsw pointer
>> 	- add endianess conversion
>>  hw/s390x/ipl.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 04245b5258..1a42630962 100644
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
>> +    uint32_t *iplpsw;
> 
> In case you respin: Can this be ipl_psw, please?

sure. 
> 
>> +    uint64_t pentry;
>> +    char *magic;
>>      int kernel_size;
>>      Error *err = NULL;
>>  
>> @@ -157,6 +160,20 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>                                 NULL, 1, EM_S390, 0, 0);
>>          if (kernel_size < 0) {
>>              kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
>> +            /* if this is Linux use KERN_IMAGE_START */
>> +            magic = rom_ptr(LINUX_MAGIC_ADDR);
>> +            if (magic && !memcmp(magic, "S390EP", 6)) {
>> +                pentry = KERN_IMAGE_START;
>> +            } else {
>> +                /* if not Linux use the IPL PSW */
> 
> "use the address of the IPL PSW"?

Well we use the IPL PSW (and we need the address to get that) See the * before iplpsw.
> 
>> +                iplpsw = rom_ptr(4);
>> +                if (iplpsw) {
>> +                    pentry = be32_to_cpu(*iplpsw) & 0x7fffffffUL;
>> +                } else {
>> +                    error_setg(&err, "Could not get IPL PSW");
>> +                    goto error;
>> +                }
>> +            }
>>          }
>>          if (kernel_size < 0) {
>>              error_setg(&err, "could not load kernel '%s'", ipl->kernel);
> 
> Is this ever reached now? In any case, it might make sense to move this

Hmm, Right. If kernel_size < 0  then magic and ipl_psw should be NULL and we
error out early


> up, as the "could not load kernel 'plahh'" message seems more useful
> than "Could not get IPL PSW"...
> 
> Also, further below we copy ipl->cmdline if we think we're dealing with
> a Linux image. Would it make sense to explicitly check for the Linux
> magic there as well? (Separate patch, of course.)
> 
> Can/should netboot do a similar check? It uses KERN_IMAGE_START
> unconditionally if it wasn't an ELF file.

I think we already changed that there (I asked for that change). 
