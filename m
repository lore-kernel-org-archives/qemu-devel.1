Received: from eggs.gnu.org ([2001:4830:134:3::10]:56943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ennYF-0003xm-Dv
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ennYA-0005hd-UF
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:40:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ennYA-0005h7-Jy
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:40:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JFdg1O002910
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 10:40:16 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g7yqcwjst-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 10:40:16 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 10:40:16 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-5-git-send-email-walling@linux.vnet.ibm.com>
	<3528cfd5-c1e4-1252-5ea4-ed9b255afd91@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 10:40:11 -0500
MIME-Version: 1.0
In-Reply-To: <3528cfd5-c1e4-1252-5ea4-ed9b255afd91@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <564c2c0c-7264-bdf9-b034-e87622137914@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 04/12] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/17/2018 02:48 AM, Thomas Huth wrote:
> On 16.02.2018 23:07, Collin L. Walling wrote:
> [...]
>> +/**
>> + * uitoa:
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
>> + * Returns: the string @str of the converted integer @num
>> + */
>> +char *uitoa(uint64_t num, char *str, size_t len)
>> +{
>> +    size_t num_idx =3D 0;
>> +    uint64_t tmp =3D num;
>> +
>> +    IPL_assert(str !=3D NULL, "uitoa: no space allocated to store str=
ing");
>> +
>> +    /* Get index to ones place */
>> +    while ((tmp /=3D 10) !=3D 0) {
>> +        num_idx++;
>> +    }
>> +
>> +    /* Check if we have enough space for num and null */
>> +    IPL_assert(len > num_idx, "uitoa: array too small for conversion"=
);
> Well, in v5 of this patch you've had "len >=3D num_idx + 1" where we
> agreed that it was wrong. Now you have "len > num_idx" which is pretty
> much the same. WTF?
> I still think you need "len > num_idx + 1" here to properly take the
> trailing NUL-byte into account properly. Please fix it!
>
>   Thomas
>
You're correct, and my apologies for not correcting the true problem here=
:
I messed up the value of num_idx.=C2=A0 It is off by one, but initializin=
g the
value to 1 instead of 0 should fix this. I must've accounted for this in
my test file but forgot to update it in the actual source code.

I think the assertion make more sense as len > num_idx, if num_idx were
actually correct. Sorry for this mess...



--=20
- Collin L Walling
