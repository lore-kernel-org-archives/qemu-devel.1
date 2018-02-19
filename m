Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ensEi-0005mS-Q8
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 15:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ensEe-0007Ug-Hx
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 15:40:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50396
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ensEe-0007UV-6c
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 15:40:28 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JKeR3w134617
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 15:40:27 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g85g3gt0d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 15:40:25 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 15:39:28 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
	<4e4f13ad-e1fd-fc61-97c8-4892c200d724@linux.vnet.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 15:39:25 -0500
MIME-Version: 1.0
In-Reply-To: <4e4f13ad-e1fd-fc61-97c8-4892c200d724@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7cc70ad1-d9fd-cd1b-4be5-8689eaf2b98a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 06/12] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 02/19/2018 10:52 AM, Viktor Mihajlovski wrote:
> On 16.02.2018 23:07, Collin L. Walling wrote:
> [...]
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 74469b1..f632c59 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -60,6 +60,9 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>
>>   #define QIPL_ADDRESS  0xcc
>>
>> +#define BOOT_MENU_FLAG_CMD_OPTS  0x80
>> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
>> +
>>   /*
>>    * The QEMU IPL Parameters will be stored 32-bit word aligned.
>>    * Placement of data fields in this area must account for
>> @@ -67,9 +70,11 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>    * The entire structure must not be larger than 28 bytes.
>>    */
>>   struct QemuIplParameters {
>> -    uint8_t  reserved1[4];
>> +    uint8_t  boot_menu_flags;
>> +    uint8_t  reserved1[3];
>> +    uint32_t boot_menu_timeout;
>>       uint64_t netboot_start_addr;
>> -    uint8_t  reserved2[16];
>> +    uint8_t  reserved2[12];
>>   } QEMU_PACKED;Since this has to be touched anyway to re-establish pr=
oper alignment, I
> could also imagine to define the struct as
>    struct QemuIplParameters {
>        struct {
>            uint32_t flags:8;
>            uint32_t timeout:24;
>        } QEMU_PACKED boot_menu;
>        uint64_t netboot_start_addr;
>        uint8_t  reserved2[16];
>    } QEMU_PACKED;
> would allow to keep the boot menu stuff together without creating
> unnecessary holes.
> It would allow for a timeout value of more than 4 hours. The code to se=
t
> the boot menu would have to be adapted though to properly deal with the
> bitfields.

I'm currently trying to wrap my brain aroundendian conversion with bit=20
fields.
I'll investigate the best way to handle this in the mean time, but we=20
could also
consider the following:

If neighboring related fields is important, how about moving the fields=20
below netboot?

struct QemuIplParameters {
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1[4];
 =C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
 =C2=A0=C2=A0=C2=A0 uint32_t boot_menu_timeout;
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[11];
 =C2=A0 } QEMU_PACKED;


If we're concerned about space, we could retreat to timeout as a 16-bit=20
field
(and also bring back the ms -> seconds conversion business)

struct QemuIplParameters {
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved;
 =C2=A0=C2=A0=C2=A0 uint16_t boot_menu_timeout;
 =C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
 =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[16];
 =C2=A0 } QEMU_PACKED;

>>   typedef struct QemuIplParameters QemuIplParameters;
>>
>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>> index a23237e..0e39aa0 100644
>> --- a/pc-bios/s390-ccw/iplb.h
>> +++ b/pc-bios/s390-ccw/iplb.h
>> @@ -81,9 +81,11 @@ extern IplParameterBlock iplb __attribute__((__alig=
ned__(PAGE_SIZE)));
>>    * The entire structure must not be larger than 28 bytes.
>>    */
>>   struct QemuIplParameters {
>> -    uint8_t  reserved1[4];
>> +    uint8_t  boot_menu_flags;
>> +    uint8_t  reserved1[3];
>> +    uint32_t boot_menu_timeout;
>>       uint64_t netboot_start_addr;
>> -    uint8_t  reserved2[16];
>> +    uint8_t  reserved2[12];
>>   } __attribute__ ((packed));
>>   typedef struct QemuIplParameters QemuIplParameters;
>>
> same here.
>


--=20
- Collin L Walling
