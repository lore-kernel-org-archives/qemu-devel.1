Received: from eggs.gnu.org ([209.51.188.92]:55999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1cQf-0003Rs-Ju
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1cQe-0004Rg-If
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:42:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1cQe-0004R6-7K
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:42:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x26Ja45p031560
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 14:42:10 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2j1k0d9p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 14:42:10 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 6 Mar 2019 19:42:09 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-9-git-send-email-jjherne@linux.ibm.com>
	<5d26b514-7d19-9323-c727-696ee5ed4f84@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 6 Mar 2019 14:42:03 -0500
MIME-Version: 1.0
In-Reply-To: <5d26b514-7d19-9323-c727-696ee5ed4f84@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fc91716f-290c-3531-2a08-76424b4e06bb@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 08/16] s390-bios: Map low
 core memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/5/19 1:27 AM, Thomas Huth wrote:
> On 01/03/2019 19.59, Jason J. Herne wrote:
>> Create a new header for basic architecture specific definitions and add a
>> mapping of low core memory. This mapping will be used by the real dasd boot
>> process.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c      |   2 +
>>   pc-bios/s390-ccw/s390-arch.h | 102 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 104 insertions(+)
>>   create mode 100644 pc-bios/s390-ccw/s390-arch.h
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 2d912cb..0670c14 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #include "libc.h"
>> +#include "s390-arch.h"
>>   #include "s390-ccw.h"
>>   #include "cio.h"
>>   #include "virtio.h"
>> @@ -19,6 +20,7 @@ static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>   QemuIplParameters qipl;
>>   IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>>   static bool have_iplb;
>> +const LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> 
> Shouldn't that rather be "LowCore const *lowcore" instead?
> 

Yep, will fix this in both places.

...
>> +/* Low core mapping */
>> +typedef struct LowCore {
>> +    /* prefix area: defined by architecture */
>> +    PSWLegacy       ipl_psw;                  /* 0x000 */
> 
> Maybe remove some white space between the variable type and name
> everywhere in this struct?
> 

I'd argue to leave this as-is for two reasons. 1) This is how it looks in the original 
(target/s390x/internal.h). 2) I prefer the alignment, I think it makes it easier to find 
what you're looking for, given the size of this struct.

>> +    uint32_t        ccw1[2];                  /* 0x008 */
>> +    uint32_t        ccw2[2];                  /* 0x010 */
>> +    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
>> +    uint32_t        ext_params;               /* 0x080 */
>> +    uint16_t        cpu_addr;                 /* 0x084 */
>> +    uint16_t        ext_int_code;             /* 0x086 */
>> +    uint16_t        svc_ilen;                 /* 0x088 */
>> +    uint16_t        svc_code;                 /* 0x08a */
>> +    uint16_t        pgm_ilen;                 /* 0x08c */
>> +    uint16_t        pgm_code;                 /* 0x08e */
>> +    uint32_t        data_exc_code;            /* 0x090 */
>> +    uint16_t        mon_class_num;            /* 0x094 */
>> +    uint16_t        per_perc_atmid;           /* 0x096 */
>> +    uint64_t        per_address;              /* 0x098 */
>> +    uint8_t         exc_access_id;            /* 0x0a0 */
>> +    uint8_t         per_access_id;            /* 0x0a1 */
>> +    uint8_t         op_access_id;             /* 0x0a2 */
>> +    uint8_t         ar_access_id;             /* 0x0a3 */
>> +    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
>> +    uint64_t        trans_exc_code;           /* 0x0a8 */
>> +    uint64_t        monitor_code;             /* 0x0b0 */
>> +    uint16_t        subchannel_id;            /* 0x0b8 */
>> +    uint16_t        subchannel_nr;            /* 0x0ba */
>> +    uint32_t        io_int_parm;              /* 0x0bc */
>> +    uint32_t        io_int_word;              /* 0x0c0 */
>> +    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
>> +    uint32_t        stfl_fac_list;            /* 0x0c8 */
>> +    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
>> +    uint64_t        mcic;                     /* 0x0e8 */
>> +    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
>> +    uint32_t        external_damage_code;     /* 0x0f4 */
>> +    uint64_t        failing_storage_address;  /* 0x0f8 */
>> +    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
>> +    uint64_t        per_breaking_event_addr;  /* 0x110 */
>> +    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
>> +    PSW             restart_old_psw;          /* 0x120 */
>> +    PSW             external_old_psw;         /* 0x130 */
>> +    PSW             svc_old_psw;              /* 0x140 */
>> +    PSW             program_old_psw;          /* 0x150 */
>> +    PSW             mcck_old_psw;             /* 0x160 */
>> +    PSW             io_old_psw;               /* 0x170 */
>> +    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
>> +    PSW             restart_new_psw;          /* 0x1a0 */
>> +    PSW             external_new_psw;         /* 0x1b0 */
>> +    PSW             svc_new_psw;              /* 0x1c0 */
>> +    PSW             program_new_psw;          /* 0x1d0 */
>> +    PSW             mcck_new_psw;             /* 0x1e0 */
>> +    PSW             io_new_psw;               /* 0x1f0 */

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
