Received: from eggs.gnu.org ([2001:4830:134:3::10]:47002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f4Oq0-0002vl-5x
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f4Opx-0007vM-0u
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:43:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f4Opw-0007vB-Q0
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:43:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36AZJFM087390
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 06:43:15 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h64ts6rgt-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:43:15 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 6 Apr 2018 11:43:13 +0100
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<8080442a-bd0b-6231-630c-39b48f910c7a@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 12:43:08 +0200
MIME-Version: 1.0
In-Reply-To: <8080442a-bd0b-6231-630c-39b48f910c7a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <e690471b-c2f5-a19f-c6bf-df54fcb54385@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390: Do not pass inofficial IPL type
 to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 06.04.2018 11:28, Thomas Huth wrote:
> On 05.04.2018 17:07, Viktor Mihajlovski wrote:
>> IPL over a virtio-scsi device requires special handling not
>> available in the real architecture. For this purpose the IPL
>> type 0xFF has been chosen as means of communication between
>> QEMU and the pc-bios. However, a guest OS could be confused
>> by seeing an unknown IPL type.
>>
>> This change sets the IPL parameter type to 0x02 (CCW) to prevent
>> this. Pre-existing Linux has looked up the IPL parameters only in
>> the case of FCP IPL. This means that the behavior should stay
>> the same even if Linux checks for the IPL type unconditionally.
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c |  7 +++++++
>>  pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index fc2a9fe..9287b7a 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -70,6 +70,13 @@ static void jump_to_IPL_code(uint64_t address)
>>  {
>>      /* store the subsystem information _after_ the bootmap was loaded */
>>      write_subsystem_identification();
>> +
>> +    /* prevent unknown IPL types in the guest */
>> +    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
>> +        iplb.pbt = S390_IPL_TYPE_CCW;
>> +        set_iplb(&iplb);
>> +    }
>> +
>>      /*
>>       * The IPL PSW is at address 0. We also must not overwrite the
>>       * content of non-BIOS memory after we loaded the guest, so we
>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>> index 7dfce4f..5357a36 100644
>> --- a/pc-bios/s390-ccw/iplb.h
>> +++ b/pc-bios/s390-ccw/iplb.h
>> @@ -97,16 +97,27 @@ extern QemuIplParameters qipl;
>>  #define S390_IPL_TYPE_CCW 0x02
>>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>  
>> -static inline bool store_iplb(IplParameterBlock *iplb)
>> +static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
>>  {
>>      register unsigned long addr asm("0") = (unsigned long) iplb;
>>      register unsigned long rc asm("1") = 0;
>>  
>>      asm volatile ("diag %0,%2,0x308\n"
>>                    : "+d" (addr), "+d" (rc)
>> -                  : "d" (6)
>> +                  : "d" (store ? 6 : 5)
>>                    : "memory", "cc");
> 
> I can't find a proper public specification for diag 308, so no clue how
> to review this properly. Christian, could you please have a look?
> 
>  Thomas
> 

If it helps, here's the respective Linux implementation:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/ipl.c#n182


-- 
Regards,
  Viktor Mihajlovski
