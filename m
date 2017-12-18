Received: from eggs.gnu.org ([2001:4830:134:3::10]:38370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eQy5d-0007VL-RL
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eQy5Z-0005aj-Be
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:16:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36494
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eQy5Z-0005aN-6b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:16:25 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIGEM1K087488
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:16:21 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exekc7hhd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:16:20 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 11:16:20 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-2-git-send-email-walling@linux.vnet.ibm.com>
	<a6920dc1-f2be-cdd9-ba6e-a341a9e93343@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 11:16:16 -0500
MIME-Version: 1.0
In-Reply-To: <a6920dc1-f2be-cdd9-ba6e-a341a9e93343@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <231e9fad-a4e0-b957-229e-3f3dcc342e4e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/5] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 12/18/2017 08:06 AM, Thomas Huth wrote:
> On 11.12.2017 23:19, Collin L. Walling wrote:
>> Moved:
>>    memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>    strlen from sclp.c to libc.h (renamed from _strlen)
>>
>> Added C standard functions:
>>    isdigit
>>    atoi
>>
>> Added non-C standard function:
>>    itostr
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/Makefile  |  2 +-
>>   pc-bios/s390-ccw/bootmap.c |  4 +--
>>   pc-bios/s390-ccw/bootmap.h | 16 +---------
>>   pc-bios/s390-ccw/libc.c    | 75 ++++++++++++++++++++++++++++++++++++=
++++++++++
>>   pc-bios/s390-ccw/libc.h    | 31 +++++++++++++++++++
>>   pc-bios/s390-ccw/main.c    | 17 +----------
>>   pc-bios/s390-ccw/sclp.c    | 10 +------
>>   7 files changed, 112 insertions(+), 43 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/libc.c
> [...]
>> +
>> +/**
>> + * itostr:
>> + * @num: the integer to be converted.
>> + * @str: a pointer to a string to store the conversion.
>> + * @len: the length of the passed string.
>> + *
>> + * Given an integer @num, convert it to a string. The string @str mus=
t be
>> + * allocated beforehand. The resulting string will be null terminated=
 and
>> + * returned.
>> + *
>> + * Returns: the string @str of the converted integer @num.
>> + */
>> +char *itostr(int num, char *str, size_t len)
>> +{
>> +    long num_len =3D 1;
>> +    int tmp =3D num;
>> +    int i;
>> +
>> +    /* Count length of num */
>> +    while ((tmp /=3D 10) > 0) {
>> +        num_len++;
>> +    }
>> +
>> +    /* Check if we have enough space for num and null */
>> +    if (len < num_len) {
>> +        return 0;
>> +    }
> I'm afraid, but I think you've got an off-by-one bug in this code.
>
> In patch 5, you're using this function like this:
>
>      char tmp[4];
>
>      sclp_print(itostr(entries, tmp, sizeof(tmp)));
>
> That means if entries is >=3D 1000 for example, num_len is 4 ...
>
>> +    /* Convert int to string */
>> +    for (i =3D num_len - 1; i >=3D 0; i--) {
>> +        str[i] =3D num % 10 + '0';
>> +        num /=3D 10;
>> +    }
>> +
>> +    str[num_len] =3D '\0';
> ... and then you run into a buffer overflow here.


Doh, you're correct.=C2=A0 I forgot to put a "<=3D" in the len / num_len =
check.
That should fix things up.=C2=A0 Thanks for catching that.


>
>> +    return str;
>> +}
> Maybe it would also make more sense to panic() instead of "return 0"
> since you don't check the return value in patch 5 ?


I'm a bit conflicted about doing something like that.=C2=A0 I'm not sure =
if=20
there's any kind
of guideline we want to follow for defining functions in libc.

I see one of two possibilities:

a.=C2=A0 define these functions as "libc-like" as possible, and use them =
as=20
if they were
 =C2=A0=C2=A0=C2=A0=C2=A0 regular standard libc functions

 =C2=A0=C2=A0=C2=A0 or

b.=C2=A0 change up these functions to better fit their use cases in=20
pc-bios/s390-ccw

Does that make sense?=C2=A0 What do you think?


>
>   Thomas
>
--=20
- Collin L Walling
