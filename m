Received: from eggs.gnu.org ([2001:4830:134:3::10]:48045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f6jOH-0007xL-TK
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 17:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f6jOD-0003T7-UO
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 17:04:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1f6jOD-0003Sp-OR
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 17:04:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3CKxj2N117512
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 17:04:16 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hae3tads4-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 17:04:16 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 12 Apr 2018 15:04:15 -0600
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-3-git-send-email-walling@linux.ibm.com>
	<107962d1-87b5-2574-92a3-a6625757f9e7@redhat.com>
	<445a3858-d399-ef49-6426-3de9a95509dd@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 12 Apr 2018 17:04:10 -0400
MIME-Version: 1.0
In-Reply-To: <445a3858-d399-ef49-6426-3de9a95509dd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <125df9c3-b133-6882-7d92-1ffc9e4c040f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] pc-bios/s390-ccw: fix loadparm
 initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: frankja@linux.ibm.com, gor@linux.ibm.com



On 04/12/2018 04:57 PM, Collin Walling wrote:
> On 04/12/2018 02:57 PM, Thomas Huth wrote:
>> On 10.04.2018 17:01, Collin Walling wrote:
>>> Rename the loadparm char array in main.c to loadparm_str and
>>> increase the size by one byte to account for a null termination
>>> when converting the loadparm string to an int via atoui. Also
>>> allow the boot menu to be enabled when loadparm is set to an
>>> empty string or a series of spaces.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>>> ---
>>>   hw/s390x/ipl.c          |  2 ++
>>>   pc-bios/s390-ccw/main.c | 14 +++++++-------
>>>   2 files changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index fdeaec3..23b5b54 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -352,6 +352,8 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
>>>               loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
>>>           }
>>>   
>>> +        memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
>>> +
>>>           g_free(lp);
>>>           return 0;
>>>       }
>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>> index 9d9f8cf..26f9adf 100644
>>> --- a/pc-bios/s390-ccw/main.c
>>> +++ b/pc-bios/s390-ccw/main.c
>>> @@ -15,11 +15,11 @@
>>>   char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>>>   static SubChannelId blk_schid = { .one = 1 };
>>>   IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>>> -static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>>> +static char loadparm_str[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>>   QemuIplParameters qipl;
>>>   
>>>   #define LOADPARM_PROMPT "PROMPT  "
>>> -#define LOADPARM_EMPTY  "........"
>>> +#define LOADPARM_EMPTY  "        "
>>
>> Sorry for my ignorance, but why was the old string containing dots?
>>
>>   Thomas
>>
> 
> No need for apologies :)
> 
> If -machine loadparm is *not* present on the command line, then the loadparm in the sclp
> will be a series of nulls. For whatever reason, that gets translated into a series of dots.
> 

It's because of the ebc2asc table we use for conversion, which results 
in the dots when converting from ebcdic_to_ascii.

> If -machine loadparm="" is present, then loadparm will in the sclp will be a series of
> spaces. >
> We want to enable the boot menu for both of these cases and, to make things easier, this
> patch replaces any nulls (dots) to spaces when setting loadparm so that we only have to
> handle one case instead of two within the bios.
> 
> 
