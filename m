Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1enng8-0007z0-99
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1enng3-0003Lt-8Z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:48:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1enng2-0003Ky-Vm
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:48:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JFl1wH059519
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 10:48:25 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7ym2x8q9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 10:48:24 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 10:48:23 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-12-git-send-email-walling@linux.vnet.ibm.com>
	<594c42b4-74dd-afa7-04ef-70e49925d0aa@de.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 10:48:21 -0500
MIME-Version: 1.0
In-Reply-To: <594c42b4-74dd-afa7-04ef-70e49925d0aa@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5c6041ec-b387-108b-77bc-527bcd187486@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 11/12] s390-ccw: set cp_receive mask
 only when needed and consume pending service irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com

On 02/19/2018 09:15 AM, Christian Borntraeger wrote:
>
> On 02/16/2018 11:07 PM, Collin L. Walling wrote:
>> It is possible while waiting for multiple types of external
>> interrupts that we might have pending irqs remaining between
>> irq consumption and irq-type disabling. Those interrupts
>> could potentially propagate to the guest after IPL completes
>> and cause unwanted behavior.
>>
>> As it is today, the SCLP will only recognize write events that
>> are enabled by the control program's send and receive masks. To
>> limit the window for, and prevent further irqs from, ASCII
>> console events (specifically keystrokes), we should only enable
>> the control program's receive mask when we need it.
>>
>> As an additional measure, once we've disabled/cleared the control
>> program's receive mask, we will print an empty string in order
>> to consume any pending service interrupt.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> This should work some comments below:
>
>> ---
>>   pc-bios/s390-ccw/menu.c     |  5 +++++
>>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>>   pc-bios/s390-ccw/sclp.c     | 10 ++++------
>>   3 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index 9601043..14410a8 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -11,6 +11,7 @@
>>
>>   #include "menu.h"
>>   #include "s390-ccw.h"
>> +#include "sclp.h"
>>
>>   #define KEYCODE_NO_INP '\0'
>>   #define KEYCODE_ESCAPE '\033'
>> @@ -117,8 +118,12 @@ static int get_index(void)
>>
>>       memset(buf, 0, sizeof(buf));
>>
>> +    sclp_set_write_mask(SCLP_EVENT_MASK_MSG_ASCII, SCLP_EVENT_MASK_MS=
G_ASCII);
>>       len =3D read_prompt(buf, sizeof(buf));
>>
>> +    sclp_set_write_mask(0, SCLP_EVENT_MASK_MSG_ASCII);
>> +    sclp_print(""); /* Clear any pending service int */
>> +
> Why cant you use consume_sclp_int from start.S and not do any printing?
> Shouldnt sclp_set_write_mask always make an interrupt pending?

You're correct.=C2=A0 Setting the mask should solve the issue without
the need for a print.

>
>
>>       /* If no input, boot default */
>>       if (len =3D=3D 0) {
>>           return 0;
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index a7e6253..ebdcf86 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -69,6 +69,7 @@ unsigned int get_loadparm_index(void);
>>
>>   /* sclp.c */
>>   void sclp_print(const char *string);
>> +void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>>   void sclp_setup(void);
>>   void sclp_get_loadparm_ascii(char *loadparm);
>>   int sclp_read(char *str, size_t count);
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index a2f25eb..3836cb4 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -46,23 +46,21 @@ static int sclp_service_call(unsigned int command,=
 void *sccb)
>>           return 0;
>>   }
>>
>> -static void sclp_set_write_mask(void)
>> +void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask)
>>   {
>>       WriteEventMask *sccb =3D (void *)_sccb;
>>
>>       sccb->h.length =3D sizeof(WriteEventMask);
>>       sccb->mask_length =3D sizeof(unsigned int);
>> -    sccb->receive_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -    sccb->cp_receive_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -    sccb->send_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -    sccb->cp_send_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> +    sccb->cp_receive_mask =3D receive_mask;
>> +    sccb->cp_send_mask =3D send_mask;
> Isnt this also fixing another issue. write event mask only takes the
> control program (the guest) values and the sclp mask are being returned.

Correct. I'll briefly describe this change in the commit message as well.

>
>>       sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
>>   }
>>
>>   void sclp_setup(void)
>>   {
>> -    sclp_set_write_mask();
>> +    sclp_set_write_mask(0, SCLP_EVENT_MASK_MSG_ASCII);
>>   }
>>
>>   long write(int fd, const void *str, size_t len)
>>
>


--=20
- Collin L Walling
