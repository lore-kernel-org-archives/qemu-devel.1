Received: from eggs.gnu.org ([2001:4830:134:3::10]:41793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb8UU-0008OK-GB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb8UR-0003gj-RQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:24:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb8UR-0003gF-Je
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:24:07 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FHO3Ac001823
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 12:24:06 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fh0ccrypu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 12:24:04 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 10:23:58 -0700
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
	<34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 12:23:53 -0500
MIME-Version: 1.0
In-Reply-To: <34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/8] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 01/15/2018 12:05 PM, Eric Blake wrote:
> On 01/15/2018 10:44 AM, Collin L. Walling wrote:
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
>> +++ b/pc-bios/s390-ccw/libc.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + * libc-style definitions and functions
>> + *
>> + * This code is free software; you can redistribute it and/or modify =
it
>> + * under the terms of the GNU General Public License as published by =
the
>> + * Free Software Foundation; either version 2 of the License, or (at =
your
>> + * option) any later version.
> I'm not a lawyer, but generically, the GPL and its variants depend on a
> copyright owner to actually work.  You may want to add a copyright line.


I'll have to check on that.=C2=A0 I was not the original author of the li=
bc.h=20
file.


>
>> + */
>> +
>> +#include "libc.h"
>> +#include "s390-ccw.h"
>> +
>> +/**
>> + * atoi:
>> + * @str: the string to be converted.
>> + *
>> + * Given a string @str, convert it to an integer. Any non-numerical v=
alue
>> + * will terminate the conversion.
>> + *
>> + * Returns: an integer converted from the string @str.
>> + */
>> +int atoi(const char *str)
>> +{
>> +    int i;
>> +    int val =3D 0;
>> +
>> +    for (i =3D 0; str[i]; i++) {
>> +        char c =3D str[i];
>> +        if (!isdigit(c)) {
>> +            break;
>> +        }
>> +        val *=3D 10;
>> +        val +=3D c - '0';
> Silently gives garbage on integer overflow, but matches the fact that
> POSIX atoi() can't flag errors.  However, it does not handle leading
> whitespace nor '-', which means it is NOT doing a POSIX-compatible
> atoi() implementation; naming it atoi() is perhaps thus a disservice to
> end users.


Fair enough. Perhaps the "strtoi" convention suits this better.


>
>> +    }
>> +
>> +    return val;
>> +}
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
>> +static char *_itostr(int num, char *str, size_t len)
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
>> +    if (len <=3D num_len) {
>> +        return 0;
>> +    }
>> +
>> +    /* Convert int to string */
>> +    for (i =3D num_len - 1; i >=3D 0; i--) {
>> +        str[i] =3D num % 10 + '0';
>> +        num /=3D 10;
>> +    }
> No handling of negative integers?


It's not necessary for the purpose it serves.=C2=A0 The functions that
call itostr do some preprocessing to reject the negative sign and
the string.=C2=A0 We only care about positive numbers in the use cases.


>
>> +
>> +    str[num_len] =3D '\0';
>> +
>> +    return str;
>> +}
>> +
>> +char *itostr(int num, char *str, size_t len)
>> +{
>> +    char *tmp =3D _itostr(num, str, len);
>> +    IPL_assert(tmp !=3D 0, "array too small for itostr conversion");
>> +    return tmp;
>> +}
>> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
>> index 0142ea8..00268e3 100644
>> --- a/pc-bios/s390-ccw/libc.h
>> +++ b/pc-bios/s390-ccw/libc.h
>> @@ -42,4 +42,35 @@ static inline void *memcpy(void *s1, const void *s2=
, size_t n)
>>       return s1;
>>   }
>>  =20
>> +static inline int memcmp(const void *s1, const void *s2, size_t n)
>> +{
>> +    int i;
>> +    const uint8_t *p1 =3D s1, *p2 =3D s2;
>> +
>> +    for (i =3D 0; i < n; i++) {
> Are you safe comparing int to size_t, or would it be safer to use size_=
t
> for your iterator?  I guess this shim is unlikely to be abused by
> someone trying to compare 2G of memory at once.


It probably makes more sense to declare i as size_t, at least for the sak=
e
of consistency.=C2=A0 I'll do some clean up.


>
>> +        if (p1[i] !=3D p2[i]) {
>> +            return p1[i] > p2[i] ? 1 : -1;
>> +        }
>> +    }
> Not the fastest of implementations, but that probably doesn't matter
> (the complexity of writing a vectored implementation that works on a
> long or larger per loop iteration is important in a generic libc, but
> less so in a compatibility shim).
>
>> +
>> +    return 0;
>> +}
>> +
>> +static inline size_t strlen(const char *str)
>> +{
>> +    size_t i;
>> +    for (i =3D 0; *str; i++) {
>> +        str++;
>> +    }
>> +    return i;
> Again, not the fastest implementation, but that shouldn't matter.
>
>> +}
>> +
>> +static inline int isdigit(int c)
>> +{
>> +    return (c >=3D '0') && (c <=3D '9');
>> +}
>> +
>> +int atoi(const char *str);
>> +char *itostr(int num, char *str, size_t len);
>> +
>>   #endif


--=20
- Collin L Walling
