Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRCNB-0003Y2-Ck
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRCN6-0005ys-AX
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:31:33 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-2-git-send-email-walling@linux.vnet.ibm.com>
	<a6920dc1-f2be-cdd9-ba6e-a341a9e93343@redhat.com>
	<231e9fad-a4e0-b957-229e-3f3dcc342e4e@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <31f9a2b4-b8c2-c823-1dfc-b251d00d7fc2@redhat.com>
Date: Tue, 19 Dec 2017 08:31:20 +0100
MIME-Version: 1.0
In-Reply-To: <231e9fad-a4e0-b957-229e-3f3dcc342e4e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 18.12.2017 17:16, Collin L. Walling wrote:
> On 12/18/2017 08:06 AM, Thomas Huth wrote:
>> On 11.12.2017 23:19, Collin L. Walling wrote:
>>> Moved:
>>> =C2=A0=C2=A0 memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>> =C2=A0=C2=A0 strlen from sclp.c to libc.h (renamed from _strlen)
>>>
>>> Added C standard functions:
>>> =C2=A0=C2=A0 isdigit
>>> =C2=A0=C2=A0 atoi
>>>
>>> Added non-C standard function:
>>> =C2=A0=C2=A0 itostr
>>>
>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/Makefile=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 pc-bios/s390-ccw/bootmap.c |=C2=A0 4 +--
>>> =C2=A0 pc-bios/s390-ccw/bootmap.h | 16 +---------
>>> =C2=A0 pc-bios/s390-ccw/libc.c=C2=A0=C2=A0=C2=A0 | 75
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 pc-bios/s390-ccw/libc.h=C2=A0=C2=A0=C2=A0 | 31 +++++++++++++++=
++++
>>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0 | 17 +----------
>>> =C2=A0 pc-bios/s390-ccw/sclp.c=C2=A0=C2=A0=C2=A0 | 10 +------
>>> =C2=A0 7 files changed, 112 insertions(+), 43 deletions(-)
>>> =C2=A0 create mode 100644 pc-bios/s390-ccw/libc.c
>> [...]
>>> +
>>> +/**
>>> + * itostr:
>>> + * @num: the integer to be converted.
>>> + * @str: a pointer to a string to store the conversion.
>>> + * @len: the length of the passed string.
>>> + *
>>> + * Given an integer @num, convert it to a string. The string @str
>>> must be
>>> + * allocated beforehand. The resulting string will be null
>>> terminated and
>>> + * returned.
>>> + *
>>> + * Returns: the string @str of the converted integer @num.
>>> + */
>>> +char *itostr(int num, char *str, size_t len)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 long num_len =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 int tmp =3D num;
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Count length of num */
>>> +=C2=A0=C2=A0=C2=A0 while ((tmp /=3D 10) > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_len++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Check if we have enough space for num and null=
 */
>>> +=C2=A0=C2=A0=C2=A0 if (len < num_len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>> I'm afraid, but I think you've got an off-by-one bug in this code.
>>
>> In patch 5, you're using this function like this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 char tmp[4];
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 sclp_print(itostr(entries, tmp, sizeof(tmp)))=
;
>>
>> That means if entries is >=3D 1000 for example, num_len is 4 ...
>>
>>> +=C2=A0=C2=A0=C2=A0 /* Convert int to string */
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D num_len - 1; i >=3D 0; i--) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[i] =3D num % 10 + '0'=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num /=3D 10;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 str[num_len] =3D '\0';
>> ... and then you run into a buffer overflow here.
>=20
>=20
> Doh, you're correct.=C2=A0 I forgot to put a "<=3D" in the len / num_le=
n check.
> That should fix things up.=C2=A0 Thanks for catching that.
>=20
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 return str;
>>> +}
>> Maybe it would also make more sense to panic() instead of "return 0"
>> since you don't check the return value in patch 5 ?
>=20
>=20
> I'm a bit conflicted about doing something like that.=C2=A0 I'm not sur=
e if
> there's any kind
> of guideline we want to follow for defining functions in libc.
>=20
> I see one of two possibilities:
>=20
> a.=C2=A0 define these functions as "libc-like" as possible, and use the=
m as
> if they were
> =C2=A0=C2=A0=C2=A0=C2=A0 regular standard libc functions
>=20
> =C2=A0=C2=A0=C2=A0 or
>=20
> b.=C2=A0 change up these functions to better fit their use cases in
> pc-bios/s390-ccw
>=20
> Does that make sense?=C2=A0 What do you think?

Keeping them libc-like likely makes sense ... but could we somehow also
make sure that we're not running into unexpected errors when using them?
Something like "IPL_assert(entries < 1000, ...)" before calling the
functions in patch 5?

 Thomas
