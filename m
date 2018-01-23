Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee78i-0005pG-3C
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee78d-0005kf-4J
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:34:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee78c-0005jK-SA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:33:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NMWtrs051968
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 17:33:53 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fpbkw54ab-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 17:33:52 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 15:33:52 -0700
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
	<2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 17:33:46 -0500
MIME-Version: 1.0
In-Reply-To: <2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 04/10] s390-ccw: update libc
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

On 01/23/2018 02:23 PM, Eric Blake wrote:
> On 01/23/2018 12:26 PM, Collin L. Walling wrote:
>> [...]
>> +/**
>> + * atoi:
>> + * @str: the string to be converted.
>> + *
>> + * Given a string @str, convert it to an integer. Leading whitespace =
is
>> + * ignored. The first character (after any whitespace) is checked for=
 the
>> + * negative sign. Any other non-numerical value will terminate the
>> + * conversion.
>> + *
>> + * Returns: an integer converted from the string @str.
>> + */
>> +int atoi(const char *str)
>> +{
>> +    int val =3D 0;
>> +    int sign =3D 1;
>> +
>> +    if (!str || !str[0]) {
>> +        return 0;
>> +    }
>> +
>> +    while (*str =3D=3D ' ') {
>> +        str++;
>> +    }
> That's not "any whitespace", but only spaces.  A fully compliant
> implementation would be checking isspace(), but I don't expect you to
> implement that; at a minimum, also checking '\t' would get you closer
> (but not all the way to) compliance.


I'll fix the comment to be more clear.

I think it's okay to just have the menu code treat any other kind
of whitespace as an error (it will check before calling atoi). I
added support for negatives in bothfunctions because it was easy
enough to do so and for the sakeof completeness.

However, I worry trying to be 100% compliant will just bloat the
code when we only need it for very specific use cases.

Would you say what we have (along with the fix to itostr below) is
sufficient enough?


>
>
>> +static char *_itostr(int num, char *str, size_t len)
>> +{
>> +    int num_idx =3D 0;
>> +    int tmp =3D num;
>> +    char sign =3D 0;
>> +
>> +    if (!str) {
>> +        return NULL;
>> +    }
>> +
>> +    /* Get index to ones place */
>> +    while ((tmp /=3D 10) !=3D 0) {
>> +        num_idx++;
>> +    }
>> +
>> +    if (num < 0) {
>> +        num *=3D -1;
>> +        sign =3D 1;
>> +    }
> If num =3D=3D INT_MIN, then num is still negative at this point...
>
>> +
>> +    /* Check if we have enough space for num, sign, and null */
>> +    if (len <=3D num_idx + sign + 1) {
>> +        return NULL;
>> +    }
>> +
>> +    str[num_idx + sign + 1] =3D '\0';
>> +
>> +    /* Convert int to string */
>> +    while (num_idx >=3D 0) {
>> +        str[num_idx + sign] =3D num % 10 + '0';
> ...which breaks this.
>
> Either make it work, or document the corner case as unsupported.
>

Might as well just make it work at this point:

#define INT32_MIN 0x80000000

static char *itostr(int num, char *str, size_t len)
{
 =C2=A0=C2=A0=C2=A0 int num_idx =3D 0;
 =C2=A0=C2=A0=C2=A0 int tmp =3D num;
 =C2=A0=C2=A0=C2=A0 char sign =3D !!(num & INT32_MIN);

 =C2=A0=C2=A0=C2=A0 if (!str) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 /* Get index to ones place */
 =C2=A0=C2=A0=C2=A0 while ((tmp /=3D 10) !=3D 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_idx++;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 /* Check if we have enough space for num, sign, and n=
ull */
 =C2=A0=C2=A0=C2=A0 if (len <=3D num_idx + sign + 1) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 str[num_idx + sign + 1] =3D '\0';

 =C2=A0=C2=A0=C2=A0 if (sign) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[0] =3D '-';
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num =3D=3D INT32_MIN) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[n=
um_idx + sign] =3D '8';
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num /=
=3D 10;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_i=
dx--;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num *=3D -1;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 /* Convert int to string */
 =C2=A0=C2=A0=C2=A0 while (num_idx >=3D 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[num_idx + sign] =3D num %=
 10 + '0';
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num /=3D 10;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_idx--;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 return str;
}

Thoughts?

--=20
- Collin L Walling
