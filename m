Received: from eggs.gnu.org ([2001:4830:134:3::10]:49432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJinX-0006BR-Ab
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJinR-00019E-Ho
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:31:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43556
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJinR-00018v-DA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:31:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASGT8UX061596
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:31:42 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ehadb3f56-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:31:31 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 11:31:25 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-5-git-send-email-walling@linux.vnet.ibm.com>
	<d007f7af-f15e-105c-7859-13b7141cf260@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 11:31:23 -0500
MIME-Version: 1.0
In-Reply-To: <d007f7af-f15e-105c-7859-13b7141cf260@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ff314c86-be4e-db08-aae8-40ef3e3e68d3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 4/5] s390-ccw: interactive
 boot menu for eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 11/28/2017 07:36 AM, Thomas Huth wrote:
> On 27.11.2017 21:55, Collin L. Walling wrote:
> [...] 
>> +static void read_stage2(block_number_t s1b_block_nr, void **stage2_data)
>> +{
>> +    block_number_t s2_block_nr;
>> +    BootEckdStage1b *s1b = (void *)sec;
>> +    int i;
>> +
>> +    /* Get Stage1b data */
>> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>> +    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader.");
>> +
>> +    /* Get Stage2 data */
>> +    *stage2_data = (void *)s2_area;
> I think you could also simply "return s2_area" at the end of the
> function instead of using a pointer-to-a-pointer as parameter of the
> function.

Ideally I'd like to figure out some way to get rid of the s2_area and
just read stage2 block-by-block (that way we're only using sec).

I'll play around with things here after I've taken care of the other
suggestions.

[...]

>
>> +#define KEYCODE_BACKSP '\177'
>> +#define KEYCODE_ENTER  '\r'
>> +
>>   long write(int fd, const void *str, size_t len);
>>   
>>   static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>> @@ -101,3 +106,130 @@ void sclp_get_loadparm_ascii(char *loadparm)
>>           ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
>>       }
>>   }
>> +
>> +static void read(char **str)
> Please avoid using names from the standard C-library, unless the
> function is supposed to do the same (as the write() function here).

Thinking about it, I'm not sure if it would make sense for us to have a
C-like read() function... perhaps it'd be best to rename it for now.

[...]
>> +    );
>> +}
>> +
>> +static inline bool check_clock_int(void)
>> +{
>> +    uint16_t code;
>> +
>> +    consume_sclp_int();
>> +
>> +    asm volatile(
>> +        "lh         1, 0x86(0,0)\n"
>> +        "sth        1, %0"
>> +        : "=r" (code)
>> +    );
> That way, you need r1 in the clobber list. But why don't you simply use
> only "lh %0,0x86(0,0)\n" instead? Or simply do it without assembly:
>
>   code = *(volatile uint16_t *)0x86;

This is new to me... thanks for showing me this :)

>
> ?
[...]
>   Thomas
>
Thanks for the review, Thomas.I've noted all other suggestions.

-- 
- Collin L Walling
