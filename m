Received: from eggs.gnu.org ([2001:4830:134:3::10]:39899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6ip-0001jL-QJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6im-0002fY-Vi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:07:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44146
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ej6im-0002fF-R6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:07:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16H3q5i062172
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 12:07:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fydk617hj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:07:51 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 12:07:50 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-5-git-send-email-walling@linux.vnet.ibm.com>
	<35fce730-9133-fe19-2c54-3b9f8a09ed26@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 12:07:46 -0500
MIME-Version: 1.0
In-Reply-To: <35fce730-9133-fe19-2c54-3b9f8a09ed26@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <32981cc9-d660-6079-7948-fafacf731c40@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 04/12] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 02/06/2018 01:14 AM, Thomas Huth wrote:
> On 05.02.2018 21:57, Collin L. Walling wrote:
>> Moved:
>>    memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>    strlen from sclp.c to libc.h (renamed from _strlen)
>>
>> Added C standard functions:
>>    isdigit
>>
>> Added non C-standard function:
>>    itostr
>>    atoui
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
> [...]
>> +/**
>> + * itostr:
>> + * @num: an integer (base 10) to be converted.
>> + * @str: a pointer to a string to store the conversion.
>> + * @len: the length of the passed string.
>> + *
>> + * Given an integer @num, convert it to a string. The string @str mus=
t be
>> + * allocated beforehand. The resulting string will be null terminated=
 and
>> + * returned. This function only handles numbers between 0 and UINT64_=
MAX
>> + * inclusive.
>> + *
>> + * Returns: the string @str of the converted integer @num; NULL if @s=
tr
>> + * is NULL or if there is not enough space allocated.
>> + */
>> +char *itostr(uint64_t num, char *str, size_t len)
> Nitpicking: You renamed atoi to atoui, so maybe this should now rather
> be uitostr or uitoa now?

Was thinking the same right after I hit submit.


>
>> +{
>> +    size_t num_idx =3D 0;
>> +    uint64_t tmp =3D num;
>> +
>> +    IPL_assert(num >=3D 0, "itostr: cannot convert negative values");
> (already mentioned by patchew)
>
>> +    IPL_assert(str !=3D NULL, "itostr: no space allocated to store st=
ring");
>> +
>> +    /* Get index to ones place */
>> +    while ((tmp /=3D 10) !=3D 0) {
>> +        num_idx++;
>> +    }
>> +
>> +    /* Check if we have enough space for num and null */
>> +    IPL_assert(len >=3D num_idx + 1, "itostr: array too small for con=
version");
> Should that rather be "len > num_idx + 1" instead?

Yes -- thank you.=C2=A0 That's what I get for trying to copy-paste old=20
conditionals
into an assert.


>
>> +    str[num_idx + 1] =3D '\0';
>> +
>> +    /* Convert int to string */
>> +    while (num_idx >=3D 0) {
>> +        str[num_idx] =3D num % 10 + '0';
>> +        num /=3D 10;
>> +        num_idx--;
>> +    }
>> +
>> +    return str;
>> +}
>   Thomas
>


--=20
- Collin L Walling
