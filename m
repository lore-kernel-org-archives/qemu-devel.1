Received: from eggs.gnu.org ([209.51.188.92]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hAyyk-0006xC-QE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hAyyj-0000Ae-It
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:36:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41814
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hAyyj-0000AJ-BR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:36:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31FVMbR143854
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 11:36:04 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkmmy37bu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 11:36:04 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 1 Apr 2019 16:36:03 +0100
Reply-To: jjherne@linux.ibm.com
References: <1552494682-16788-1-git-send-email-jjherne@linux.ibm.com>
	<1552494682-16788-16-git-send-email-jjherne@linux.ibm.com>
	<fd2f7e0d-cfab-245e-8c06-9b9ed424b7e4@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 1 Apr 2019 11:35:56 -0400
MIME-Version: 1.0
In-Reply-To: <fd2f7e0d-cfab-245e-8c06-9b9ed424b7e4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2b819e81-b308-6989-1724-4d7fca7296e1@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 15/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/29/19 4:33 AM, Thomas Huth wrote:
> On 13/03/2019 17.31, Jason J. Herne wrote:
> 
> s/tansfers/transfers/
> 

Will fix this, and the other typos you've pointed out.

...
>> +static char prefix_page[PAGE_SIZE * 2]
>> +            __attribute__((__aligned__(PAGE_SIZE * 2)));
>> +
>> +static void enable_prefixing(void)
>> +{
>> +    memcpy(&prefix_page, (void *)0, 4096);
> 
> You could use the "lowcore" variable from s390-arch.h here instead of
> "(void *)0", I guess.
>

Agreed.

>> +    set_prefix(ptr2u32(&prefix_page));
>> +}
>> +
>> +static void disable_prefixing(void)
>> +{
>> +    set_prefix(0);
>> +    /* Copy io interrupt info back to low core */
>> +    memcpy((void *)0xB8, prefix_page + 0xB8, 12);
> 
> Maybe use &lowcore->subchannel_id instead of 0xB8 ? ... not sure whether
> that's nicer here, though...
> 

I think it is nicer using the named field. I Will make that change.

Note: We need to keep the (void*) cast to prevent a compiler warning about discarding 
const qualifier.

>> +static void ipl1_fixup(void)
>> +{
>> +    Ccw0 *ccwSeek = (Ccw0 *) 0x08;
>> +    Ccw0 *ccwSearchID = (Ccw0 *) 0x10;
>> +    Ccw0 *ccwSearchTic = (Ccw0 *) 0x18;
>> +    Ccw0 *ccwRead = (Ccw0 *) 0x20;
>> +    CcwSeekData *seekData = (CcwSeekData *) 0x30;
>> +    CcwSearchIdData *searchData = (CcwSearchIdData *) 0x38;
>> +
>> +    /* move IPL1 CCWs to make room for CCWs needed to locate record 2 */
>> +    memcpy(ccwRead, (void *)0x08, 16);
> 
> lowcore->ccw1 ?
> 

All the other CCWs in this section still need to use the numeric memory references. I 
think it makes it slightly more confusing to switch just the one to using the struct. For 
this reason I prefer it the way it is, if you're okay with that.

...
>> +static void lpsw(void *psw_addr)
>> +{
>> +    PSWLegacy *pswl = (PSWLegacy *) psw_addr;
>> +
>> +    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
>> +    pswl->addr |= PSW_MASK_BAMODE;
>> +    asm volatile("  llgtr 0,0\n llgtr 1,1\n"     /* Some OS's expect to be */
>> +                 "  llgtr 2,2\n llgtr 3,3\n"     /* in 32-bit mode. Clear  */
>> +                 "  llgtr 4,4\n llgtr 5,5\n"     /* high part of regs to   */
>> +                 "  llgtr 6,6\n llgtr 7,7\n"     /* avoid messing up       */
>> +                 "  llgtr 8,8\n llgtr 9,9\n"     /* instructions that work */
>> +                 "  llgtr 10,10\n llgtr 11,11\n" /* in both addressing     */
>> +                 "  llgtr 12,12\n llgtr 13,13\n" /* modes, like servc.     */
>> +                 "  llgtr 14,14\n llgtr 15,15\n"
>> +                 "  lpsw %0\n"
>> +                 : : "Q" (*pswl) : "cc");
>> +}
> 
> Have you tried to use jump_to_low_kernel() already? ... it might be
> cleaner to do the diag 0x308 reset here, too, to avoid that some part of
> the machine is in an unexpected state...
> 
>   Thomas

I had not tried jump_to_low_kernel() until just now. It *does* seem to work... and 
eliminates the need for the manual register clearing. I assume the diag 308 reset baked 
into the jump_to_low_kernel() is responsible for that? I guess switching to 
jump_to_low_kernel() would be a good thing ... I'll admit I'm slightly uneasy about it 
since I've been testing my way for so long :) But jump_to_low_kernel() works for all of my 
manual test cases.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
