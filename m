Received: from eggs.gnu.org ([2001:4830:134:3::10]:39779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fL7yw-000833-3E
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fL7ys-0008KT-Qt
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fL7ys-0008IV-Ho
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:09:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4ME5x5f061298
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:09:36 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j4mcc1a3w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:09:36 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 22 May 2018 08:09:35 -0600
References: <20180504072514.8450-1-cohuck@redhat.com>
	<20180504072514.8450-9-cohuck@redhat.com>
	<b1a5eb12-4f1d-2f66-f59f-eb1baa87746d@redhat.com>
	<20180522144426.0e683b60.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 22 May 2018 10:09:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180522144426.0e683b60.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <26c59585-89ca-ecaf-9252-ba23955e42a3@linux.ibm.com>
Subject: Re: [Qemu-devel] [PULL 08/15] pc-bios/s390-ccw: fix loadparm
 initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 05/22/2018 08:44 AM, Cornelia Huck wrote:
> On Tue, 15 May 2018 10:45:02 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> I've come across this patch in downstream review (although I really have
>> zero background in s390x), and Cornelia suggested I might want to repeat
>> my comments on the upstream list too:
>>
>> On 05/04/18 09:25, Cornelia Huck wrote:
>>> From: Collin Walling <walling@linux.ibm.com>
>>>
>>> Rename the loadparm char array in main.c to loadparm_str and
>>> increased the size by one byte to account for a null termination
>>> when converting the loadparm string to an int  via atoui. We
>>> also allow the boot menu to be enabled when loadparm is set to
>>> an empty string or a series of spaces.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/s390x/ipl.c          |  4 ++++
>>>  pc-bios/s390-ccw/main.c | 14 +++++++-------
>>>  2 files changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index fb554ab156..150f6c0582 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -373,6 +373,10 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
>>>              loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
>>>          }
>>>  
>>> +        if (i < 8) {
>>> +            memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
>>> +        }
>>> +
>>>          g_free(lp);
>>>          return 0;
>>>      }
>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>> index 9d9f8cf4d3..26f9adf84a 100644
>>> --- a/pc-bios/s390-ccw/main.c
>>> +++ b/pc-bios/s390-ccw/main.c
>>> @@ -15,11 +15,11 @@
>>>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>>>  static SubChannelId blk_schid = { .one = 1 };
>>>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>>> -static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>>> +static char loadparm_str[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>>  QemuIplParameters qipl;
>>>  
>>>  #define LOADPARM_PROMPT "PROMPT  "
>>> -#define LOADPARM_EMPTY  "........"
>>> +#define LOADPARM_EMPTY  "        "
>>>  #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
>>>  
>>>  /*
>>> @@ -45,7 +45,7 @@ void panic(const char *string)
>>>  
>>>  unsigned int get_loadparm_index(void)
>>>  {
>>> -    return atoui(loadparm);
>>> +    return atoui(loadparm_str);
>>>  }
>>>  
>>>  static bool find_dev(Schib *schib, int dev_no)
>>> @@ -80,13 +80,13 @@ static bool find_dev(Schib *schib, int dev_no)
>>>  
>>>  static void menu_setup(void)
>>>  {
>>> -    if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
>>> +    if (memcmp(loadparm_str, LOADPARM_PROMPT, 8) == 0) {
>>>          menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
>>>          return;
>>>      }
>>>  
>>>      /* If loadparm was set to any other value, then do not enable menu */
>>> -    if (memcmp(loadparm, LOADPARM_EMPTY, 8) != 0) {
>>> +    if (memcmp(loadparm_str, LOADPARM_EMPTY, 8) != 0) {
>>>          return;
>>>      }
>>>  
>>> @@ -116,8 +116,8 @@ static void virtio_setup(void)
>>>       */
>>>      enable_mss_facility();
>>>  
>>> -    sclp_get_loadparm_ascii(loadparm);
>>> -    memcpy(ldp + 10, loadparm, 8);
>>> +    sclp_get_loadparm_ascii(loadparm_str);
>>> +    memcpy(ldp + 10, loadparm_str, 8);
>>>      sclp_print(ldp);
>>>  
>>>      memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
>>>   
>>
>> So here I said, "There are a bunch of naked 8 constants; those should
>> all be (sizeof loadparm_str - 1), I think. Should be a separate patch,
>> of course."
> 
> Alternatively, as loadparm size is architectured IIRC and unlikely to
> change, do
> 

Correct.

> #define LOADPARM_LEN 8
> char loadparm_str[LOADPARM_LEN + 1];
> 
> and compare against LOADPARM_LEN... opinions?
> 

I have another (unrelated) QEMU patch to throw on the list, so I can get to this today.

-- 
Respectfully,
- Collin Walling
