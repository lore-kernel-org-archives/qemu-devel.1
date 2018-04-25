Received: from eggs.gnu.org ([2001:4830:134:3::10]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJmf-0008Pt-FL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJmb-0005xd-Gc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:44:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fBJmb-0005wV-Ag
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:44:25 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PCf3Nf019388
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:44:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hjrs3u3tf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:44:24 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Apr 2018 13:44:22 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
	<1524647323-6449-3-git-send-email-thuth@redhat.com>
	<60dc9968-58fd-46e3-b471-7a0b7093ba15@de.ibm.com>
	<775de9f5-7da0-45fa-da32-edceac7cf258@redhat.com>
	<24876878-e365-604e-348c-f649568e167f@de.ibm.com>
Date: Wed, 25 Apr 2018 14:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <24876878-e365-604e-348c-f649568e167f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7ed61a09-c00c-acf0-f504-f6feb8d55950@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] pc-bios/s390-ccw/net: Use diag308
 to reset machine before jumping to the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>



On 04/25/2018 02:41 PM, Christian Borntraeger wrote:
> You load from address 0. 
> 
> On 04/25/2018 02:34 PM, Thomas Huth wrote:
>> On 25.04.2018 14:18, Christian Borntraeger wrote:
>>>
>>> On 04/25/2018 11:08 AM, Thomas Huth wrote:
>>>
>>>> --- a/pc-bios/s390-ccw/netmain.c
>>>> +++ b/pc-bios/s390-ccw/netmain.c
>>>> @@ -283,6 +283,15 @@ void panic(const char *string)
>>>>      }
>>>>  }
>>>>  
>>>> +void write_subsystem_identification(void)
>>>> +{
>>>> +    uint32_t *schid = (uint32_t *) 184;
>>>> +    uint32_t *zeroes = (uint32_t *) 188;
>>>> +
>>>> +    *schid = 0;         /* We must not set this for virtio-net */
>>>> +    *zeroes = 0;
>>>> +}
>>>> +
>>>
>>> I think we actually want to have the CCW devno of that network device
>>> stored. It has some value to know which CCW device we bootet from, no?
>>
>> Actually, I tried that first (and it took quite some time to debug it),
>> but the Linux kernel then bails out quite early, without any error
>> message. The trace looks like this:
>>
>> 0x0000000007801802:  diag	%r1,%r1,776
>> 0x0000000007801780:  larl	%r2,0x7831004
>> 0x0000000007801786:  llgf	%r1,8
>> 0x000000000780178c:  mvc	0(12,%r0),0(%r2)
>> 0x0000000007801792:  br	%r1
>> 0x0000000000000418:  bas	%r14,512
>> 0x0000000000000200:  mvi	163,1
>> 0x0000000000000204:  slr	%r0,%r0
>> 0x0000000000000206:  lhi	%r1,2
>> 0x000000000000020a:  sigp	%r1,%r0,18
>> 0x000000000000020e:  bras	%r13,0x252
>> 0x0000000000000252:  lmh	%r0,%r15,0(%r13)
>> 0x0000000000000258:  sam31
>> 0x000000000000025a:  br	%r14
>> 0x000000000000041c:  lh	%r1,184
>> 0x0000000000000420:  bct	%r1,1322
>> 0x0000000000000424:  l	%r1,184
>> 0x0000000000000428:  la	%r2,1840
>> 0x000000000000042c:  bas	%r14,640
>> 0x0000000000000280:  la	%r4,0(%r14)
>> 0x0000000000000284:  la	%r3,792
>> 0x0000000000000288:  la	%r5,804
>> 0x000000000000028c:  la	%r6,888
>> 0x0000000000000290:  la	%r7,20
>> 0x0000000000000294:  st	%r2,4(%r6)
>> 0x0000000000000298:  la	%r2,80(%r2)
>> 0x000000000000029c:  la	%r6,8(%r6)
>> 0x00000000000002a0:  bct	%r7,660
>> 0x00000000000002a4:  lctl	%c6,%c6,868
>> 0x00000000000002a8:  slr	%r2,%r2
>> 0x00000000000002aa:  ssch	0(%r3)
>> 0x00000000000002ae:  bne	786
>> 0x0000000000000312:  lpsw	880
>> Guest crashed on cpu 0: disabled-wait
>> PSW: 0x000a000000000000 0x0000000000000000
>>
>> That's the Lloader function in arch/s390/kernel/head.S which is failing
>> here, so seems like Linux tries to load from a block device in case
>> there is a value in 184. Thus I assume that 184 has to contain 0 in this
>> case.
> 
> Hmm, I think this is because we jump to 418 for your kernel (which is the loader
> that tries to bootstrap the ccw ipl). When you look at ipl.c we override that
> and jump to 0x10000 instead for linux (which is also hackish) for image files.
> So I guess if we would do a psw restart instead (like you do) on a kernel image
> the normal ipl would also fail....
> 

FWIW, zipl also loads linux kernels from 0x10000
$ git grep 0x10000
boot/head.S:.Lstack: .long  0x10000-160
boot/stage2dump.c:      if (prefix < 0x10000) /* if < linux-start addr */
boot/tape0.S:KERNEL_OFF         = 0x10000               # kernel start code offset
boot/tape0.S:KERNEL_ADDR                = 0x10000               # default kernel load addr
include/zipl.h:#define DEFAULT_IMAGE_ADDRESS            0x10000LL
include/zipl.h:#define MINIMUM_ADDRESS          0x10000LL
src/bootmap.c:          size += DIV_ROUND_UP(st.st_size - 0x10000,
src/job.c:                          &ipl->image_addr, 0, 0x10000,
src/job.c:                      &ipl->ramdisk_addr, 0, 0, 0x10000);
src/job.c:                          &dump->image_addr, 0, 0x10000,
src/job.c:                                  0, 0, 0x10000);
src/job.c:                          &ipl_tape->image_addr, 0, 0x10000,
src/job.c:                                  0, 0, 0x10000);
