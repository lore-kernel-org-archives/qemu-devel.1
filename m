Received: from eggs.gnu.org ([2001:4830:134:3::10]:44386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1egAPi-0006s0-E5
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1egAPd-0005xM-HQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:28:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1egAPd-0005uQ-9r
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:27:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TENnnN060703
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:27:54 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft4ncacec-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:27:53 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 09:27:52 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-9-git-send-email-walling@linux.vnet.ibm.com>
	<cc08c79e-a579-e833-c9a7-7476d7e5b328@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 09:27:48 -0500
MIME-Version: 1.0
In-Reply-To: <cc08c79e-a579-e833-c9a7-7476d7e5b328@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0ccc53ab-64c7-382c-624b-afab8ac1b033@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 08/10] s390-ccw: print zipl
 boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 01/29/2018 05:15 AM, David Hildenbrand wrote:
> On 23.01.2018 19:26, Collin L. Walling wrote:
>> When the boot menu options are present and the guest's
>> disk has been configured by the zipl tool, then the user
>> will be presented with an interactive boot menu with
>> labeled entries. An example of what the menu might look
>> like:
>>
>> zIPL v1.37.1-build-20170714 interactive boot menu.
>>
>>    0. default (linux-4.13.0)
>>
>>    1. linux-4.13.0
>>    2. performance
>>    3. kvm
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/menu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index de12c73..174285e 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -10,13 +10,62 @@
>>    */
>>   
>>   #include "menu.h"
>> +#include "s390-ccw.h"
>>   
>>   static uint8_t flags;
>>   static uint64_t timeout;
>>   
>> +/* Offsets from zipl fields to zipl banner start */
>> +#define ZIPL_TIMEOUT_OFFSET 138
>> +#define ZIPL_FLAG_OFFSET    140
>> +
>> +static int get_boot_index(int entries)
>> +{
>> +    return 0; /* Implemented next patch */
>> +}
>> +
>> +static void zipl_println(const char *data, size_t len)
>> +{
>> +    char buf[len + 2];
>> +
>> +    ebcdic_to_ascii(data, buf, len);
>> +    buf[len] = '\n';
>> +    buf[len + 1] = '\0';
>> +
>> +    sclp_print(buf);
>> +}
>> +
>>   int menu_get_zipl_boot_index(const void *stage2, int offset)
>>   {
>> -    return 0; /* implemented next patch */
>> +    const char *data = stage2 + offset;
>> +    uint16_t flag;
>> +    size_t len;
>> +    int ct;
>> +
>> +    flag = *(uint16_t *)(data - ZIPL_FLAG_OFFSET);
> You could initialize this directly above or after you verified (flags &
> BOOT_MENU_FLAG_ZIPL_OPTS)
>
>> +
>> +    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
>> +        if (flag) {
>> +            timeout = *(uint16_t *)(data - ZIPL_TIMEOUT_OFFSET);
>> +        } else {
> You can drop the else and return directly.


This would read a lot better if s/flag/zipl_flag.

It will read as "if (!zipl_flag) return".


>
>> +            return 0; /* Boot default */
>> +        }
>> +    }
>> +
>> +    /* Print and count all menu items, including the banner */
>> +    for (ct = 0; *data; ct++) {
>> +        len = strlen(data);
>> +        zipl_println(data, len);
>> +        data += len + 1;
>> +
>> +        if (ct < 2) {
>> +            sclp_print("\n");
>> +        }
>> +    }
>> +
>> +    sclp_print("\n");
>> +
>> +    return get_boot_index(ct - 1);
>>   }
>>   
>>   void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
>>
> Looks good to me!
>

Thanks!

-- 
- Collin L Walling
