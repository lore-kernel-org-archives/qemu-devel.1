Received: from eggs.gnu.org ([2001:4830:134:3::10]:52430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebX3T-0004tH-KL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebX3P-0003Uc-NW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:37:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53110
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ebX3P-0003U9-JI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:37:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GJaq1H121461
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:37:50 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fhkkruwfw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:37:49 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 12:37:48 -0700
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-5-git-send-email-walling@linux.vnet.ibm.com>
	<6e4c6445-0b78-1709-b724-e35daeefb1c1@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 14:37:44 -0500
MIME-Version: 1.0
In-Reply-To: <6e4c6445-0b78-1709-b724-e35daeefb1c1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e92dd0a3-422a-57a5-f0a4-c9fbb620a1c4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 4/8] s390-ccw: interactive
 boot menu for eckd dasd (menu setup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 01/16/2018 01:23 PM, Thomas Huth wrote:
> On 15.01.2018 17:44, Collin L. Walling wrote:
>> Reads boot menu flag and timeout values from the iplb and
>> sets the respective fields for the menu.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
> [...]
>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>> index fe909d2..da29e6e 100644
>> --- a/pc-bios/s390-ccw/iplb.h
>> +++ b/pc-bios/s390-ccw/iplb.h
>> @@ -81,6 +81,9 @@ extern IplParameterBlock iplb __attribute__((__align=
ed__(PAGE_SIZE)));
>>   #define S390_IPL_TYPE_CCW 0x02
>>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>  =20
>> +#define LOADPARM_PROMPT "PROMPT  "
>> +#define LOADPARM_EMPTY  "........"
> I've got a question: Is there a (public) specification document
> available somewhere for the loadparm field?


Unfortunately there does not seems to be any kind of documentation=20
regarding loadparm for
KVM on IBM z.=C2=A0 Most of the information available on the IBM Knowledg=
e=20
Center focuses on
z/VM, which isn't very helpful in this case :(

Are there any specific questions that I can help with?


>
> [...]
>> diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
>> new file mode 100644
>> index 0000000..04b1db1
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/menu.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * QEMU S390 Interactive Boot Menu
>> + *
>> + * Copyright 2017 IBM Corp.
>> + * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +
>> +#ifndef MENU_H
>> +#define MENU_H
>> +
>> +#include "libc.h"
>> +
>> +#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
>> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
>> +
>> +void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeo=
ut);
>> +bool menu_check_flags(uint8_t check_flags);
>> +
>> +#endif /* MENU_H */
>>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

Thanks for the review.

--=20
- Collin L Walling
