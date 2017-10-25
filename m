Received: from eggs.gnu.org ([2001:4830:134:3::10]:37065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e7RgU-0000PN-PG
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e7RgP-0001JV-OR
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:49:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51458
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1e7RgP-0001AL-Hu
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 15:49:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PJjMO9094896
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:49:37 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2du0k81cba-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:49:37 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 13:49:36 -0600
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<b04cf5cc-cfb4-1f36-1a8b-99a34933a75c@linux.vnet.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 15:49:31 -0400
MIME-Version: 1.0
In-Reply-To: <b04cf5cc-cfb4-1f36-1a8b-99a34933a75c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bbcf40e2-18a3-bffc-d97c-7dd410e239b7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 10/20/2017 07:37 AM, Halil Pasic wrote:
>
> On 10/20/2017 12:25 PM, Christian Borntraeger wrote:
>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>
>> The sclp console in the s390 bios writes raw data,
>> leading console emulators (such as virsh console) to
>> treat a new line ('\n') as just a new line instead
>> of as a Unix line feed. Because of this, output
>> appears in a "stair case" pattern.
>>
>> Let's print \r\n on every occurrence of a new line
>> in the string passed to write to amend this issue.
>>
>> This is in sync with the guest Linux code in
>> drivers/s390/char/sclp_vt220.c which also does a line feed
>> conversion  in the console part of the driver.
>>
>> This fixes the s390-ccw and s390-netboot output like
>> $ virsh start test --console
>> Domain test started
>> Connected to domain test
>> Escape character is ^]
>> Network boot starting...
>>                            Using MAC address: 02:01:02:03:04:05
>>                                                                  Reque=
sting information via DHCP:  010
>>
> The check for buffer overflow was not there previously, or?
>
> Maybe integrate that in the commit message too.


Good point.


>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   pc-bios/s390-ccw/s390-ccw.h |  3 +++
>>   pc-bios/s390-ccw/sclp.c     | 17 ++++++++++++++---
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 25d4d21..a8bd204 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -33,6 +33,9 @@ typedef unsigned long long __u64;
>>   #ifndef EBUSY
>>   #define EBUSY   2
>>   #endif
>> +#ifndef EFBIG
>> +#define EFBIG   3
>> +#endif
>>   #ifndef NULL
>>   #define NULL    0
>>   #endif
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index b1fc8ff..4795259 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -76,17 +76,28 @@ static int _strlen(const char *str)
>>   long write(int fd, const void *str, size_t len)
>>   {
>>       WriteEventData *sccb =3D (void *)_sccb;
>> +    const char *p;
>> +    size_t data_len =3D 0;
>>
>>       if (fd !=3D 1 && fd !=3D 2) {
>>           return -EIO;
>>       }
>>
>> -    sccb->h.length =3D sizeof(WriteEventData) + len;
>> +    for (p =3D str; *p; ++p) {
>> +        if (data_len > SCCB_DATA_LEN - 1) {
>> +            return -EFBIG;
>> +        }
> We could also do a partial write or do more that one
> sclp_service_call calls.
>
> I don't think EFBIG is entirely correct here. From the man page:
> """
>         EFBIG  An attempt was made to write a file that exceeds the imp=
lementa-
>                tion-defined maximum file size or the process=E2=80=99s =
file size limit,
>                or to write at a position past the maximum allowed offse=
t.
> """
>
> That's not what we have here IMHO.


 From my perspective, the error code was a tie between EFBIG (consider
max sccb size as the maximum allowed offset) and ENOSPC:


"""
ENOSPC The device containing the file referred to by /fd/has no room
for the data.
"""


(consider "the file" as the sccb data buffer)

However, I extremely doubt we'll ever encounter an overflow from
printing during the bios (why would we print something that large?)
... perhaps the check is redundant?


>
>> +        if (*p =3D=3D '\n') {
>> +            sccb->data[data_len++] =3D '\r';
>> +        }
>> +        sccb->data[data_len++] =3D *p;
>> +    }
>> +
>> +    sccb->h.length =3D sizeof(WriteEventData) + data_len;
>>       sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
>> -    sccb->ebh.length =3D sizeof(EventBufferHeader) + len;
>> +    sccb->ebh.length =3D sizeof(EventBufferHeader) + data_len;
>>       sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
>>       sccb->ebh.flags =3D 0;
>> -    memcpy(sccb->data, str, len);
>>
>>       sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>>
> Otherwise LGTM
>
> Halil
>
>

--=20
- Collin L Walling
