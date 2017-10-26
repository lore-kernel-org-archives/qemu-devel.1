Received: from eggs.gnu.org ([2001:4830:134:3::10]:41426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e7oum-0007u2-9s
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e7ouj-0007W5-5v
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:38:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1e7oui-0006wo-TA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:38:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QKb1CR086405
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:37:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dujyvb7em-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:37:12 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 16:37:11 -0400
References: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
	<5edd8fdc-e2b2-2112-afaf-30b63e738e33@suse.de>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 16:37:07 -0400
MIME-Version: 1.0
In-Reply-To: <5edd8fdc-e2b2-2112-afaf-30b63e738e33@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b062faac-e5d8-29f8-a6df-f1559340a76a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, rth@twiddle.net

On 10/26/2017 04:25 PM, Alexander Graf wrote:
>
> On 26.10.17 20:52, Collin L. Walling wrote:
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
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   pc-bios/s390-ccw/sclp.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index 486fce1..f8ad5ae 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -68,17 +68,27 @@ void sclp_setup(void)
>>   long write(int fd, const void *str, size_t len)
>>   {
>>       WriteEventData *sccb =3D (void *)_sccb;
>> +    const char *p =3D str;
>> +    size_t data_len =3D 0;
>> +    size_t i;
>>  =20
>>       if (fd !=3D 1 && fd !=3D 2) {
>>           return -EIO;
>>       }
>>  =20
>> -    sccb->h.length =3D sizeof(WriteEventData) + len;
>> +    for (i =3D len; i > 0; i--) {
> Where did the bounds check go? If you write(max) before, you were
> writing max bytes. If you do it now, you end up writing max + n bytes
> and potentially overflow the array, no?
>
>
> Alex

I wasn't a fan of the code aesthetics and being that the SCCB write buffe=
r
allows about 4k bytes of data to be written to it, I felt it was safe to
remove it.=C2=A0 It's unlikely we'd be writing that much data in the bios=
, plus
that check did not exist prior to this fixup.

Though, reading that out loud, it probably isn't the best idea to sacrifi=
ce
code robustness for code aesthetics.

for (i =3D len; i > 0; i--) {
 =C2=A0=C2=A0=C2=A0 if (data_len > SCCB_DATA_LEN - 1) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -SOME_ERROR
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 if (*p =3D=3D '\n') {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sccb->data[data_len++] =3D '\r';
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 sccb->data[data_len++] =3D *p;
 =C2=A0=C2=A0=C2=A0 p++;
}

What do you think?

- Collin

>
>> +        if (*p =3D=3D '\n') {
>> +            sccb->data[data_len++] =3D '\r';
>> +        }
>> +        sccb->data[data_len++] =3D *p;
>> +        p++;
>> +    }
>> +
>> +    sccb->h.length =3D sizeof(WriteEventData) + data_len;
>>       sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
>> -    sccb->ebh.length =3D sizeof(EventBufferHeader) + len;
>> +    sccb->ebh.length =3D sizeof(EventBufferHeader) + data_len;
>>       sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
>>       sccb->ebh.flags =3D 0;
>> -    memcpy(sccb->data, str, len);
>>  =20
>>       sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>>  =20
>>

--=20
- Collin L Walling
