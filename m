Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f6jHr-0004Yd-Dv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f6jHn-0007Kr-1Y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:57:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f6jHm-00079c-P1
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:57:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3CKuVHb068092
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 16:57:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hact9wef5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 16:57:36 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 12 Apr 2018 14:57:35 -0600
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-3-git-send-email-walling@linux.ibm.com>
	<107962d1-87b5-2574-92a3-a6625757f9e7@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 12 Apr 2018 16:57:29 -0400
MIME-Version: 1.0
In-Reply-To: <107962d1-87b5-2574-92a3-a6625757f9e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <445a3858-d399-ef49-6426-3de9a95509dd@linux.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: frankja@linux.ibm.com, gor@linux.ibm.com

On 04/12/2018 02:57 PM, Thomas Huth wrote:
> On 10.04.2018 17:01, Collin Walling wrote:
>> Rename the loadparm char array in main.c to loadparm_str and
>> increase the size by one byte to account for a null termination
>> when converting the loadparm string to an int via atoui. Also 
>> allow the boot menu to be enabled when loadparm is set to an 
>> empty string or a series of spaces.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>> ---
>>  hw/s390x/ipl.c          |  2 ++
>>  pc-bios/s390-ccw/main.c | 14 +++++++-------
>>  2 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index fdeaec3..23b5b54 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -352,6 +352,8 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
>>              loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
>>          }
>>  
>> +        memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
>> +
>>          g_free(lp);
>>          return 0;
>>      }
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 9d9f8cf..26f9adf 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -15,11 +15,11 @@
>>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>>  static SubChannelId blk_schid = { .one = 1 };
>>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>> -static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>> +static char loadparm_str[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>  QemuIplParameters qipl;
>>  
>>  #define LOADPARM_PROMPT "PROMPT  "
>> -#define LOADPARM_EMPTY  "........"
>> +#define LOADPARM_EMPTY  "        "
> 
> Sorry for my ignorance, but why was the old string containing dots?
> 
>  Thomas
> 

No need for apologies :)

If -machine loadparm is *not* present on the command line, then the loadparm in the sclp 
will be a series of nulls. For whatever reason, that gets translated into a series of dots.

If -machine loadparm="" is present, then loadparm will in the sclp will be a series of
spaces. 

We want to enable the boot menu for both of these cases and, to make things easier, this 
patch replaces any nulls (dots) to spaces when setting loadparm so that we only have to 
handle one case instead of two within the bios.


-- 
Respectfully,
- Collin Walling
