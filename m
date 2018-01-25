Received: from eggs.gnu.org ([2001:4830:134:3::10]:32794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eegJ4-00033H-IA
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eegJ1-0001T8-Ss
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:07:02 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
	<2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
	<ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
Date: Thu, 25 Jan 2018 13:06:52 +0100
MIME-Version: 1.0
In-Reply-To: <ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 23.01.2018 23:33, Collin L. Walling wrote:
> On 01/23/2018 02:23 PM, Eric Blake wrote:
>> On 01/23/2018 12:26 PM, Collin L. Walling wrote:
>>> [...]
>>> +/**
>>> + * atoi:
>>> + * @str: the string to be converted.
>>> + *
>>> + * Given a string @str, convert it to an integer. Leading whitespace=
 is
>>> + * ignored. The first character (after any whitespace) is checked
>>> for the
>>> + * negative sign. Any other non-numerical value will terminate the
>>> + * conversion.
>>> + *
>>> + * Returns: an integer converted from the string @str.
>>> + */
>>> +int atoi(const char *str)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int val =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int sign =3D 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!str || !str[0]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while (*str =3D=3D ' ') {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str++;
>>> +=C2=A0=C2=A0=C2=A0 }
>> That's not "any whitespace", but only spaces.=C2=A0 A fully compliant
>> implementation would be checking isspace(), but I don't expect you to
>> implement that; at a minimum, also checking '\t' would get you closer
>> (but not all the way to) compliance.
>=20
>=20
> I'll fix the comment to be more clear.
>=20
> I think it's okay to just have the menu code treat any other kind
> of whitespace as an error (it will check before calling atoi). I
> added support for negatives in bothfunctions because it was easy
> enough to do so and for the sakeof completeness.
>=20
> However, I worry trying to be 100% compliant will just bloat the
> code when we only need it for very specific use cases.
>=20
> Would you say what we have (along with the fix to itostr below) is
> sufficient enough?

IMHO the current way is good enough for a BIOS implementation. We're not
doing a full replacement of glibc here ;-)

>=20
>>
>>
>>> +static char *_itostr(int num, char *str, size_t len)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int num_idx =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int tmp =3D num;
>>> +=C2=A0=C2=A0=C2=A0 char sign =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!str) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Get index to ones place */
>>> +=C2=A0=C2=A0=C2=A0 while ((tmp /=3D 10) !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_idx++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (num < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num *=3D -1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>> If num =3D=3D INT_MIN, then num is still negative at this point...
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Check if we have enough space for num, sign, a=
nd null */
>>> +=C2=A0=C2=A0=C2=A0 if (len <=3D num_idx + sign + 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 str[num_idx + sign + 1] =3D '\0';
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Convert int to string */
>>> +=C2=A0=C2=A0=C2=A0 while (num_idx >=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[num_idx + sign] =3D n=
um % 10 + '0';
>> ...which breaks this.
>>
>> Either make it work, or document the corner case as unsupported.
>>
>=20
> Might as well just make it work at this point:
>=20
> #define INT32_MIN 0x80000000
>=20
> static char *itostr(int num, char *str, size_t len)
> {
> =C2=A0=C2=A0=C2=A0 int num_idx =3D 0;
> =C2=A0=C2=A0=C2=A0 int tmp =3D num;
> =C2=A0=C2=A0=C2=A0 char sign =3D !!(num & INT32_MIN);
>=20
> =C2=A0=C2=A0=C2=A0 if (!str) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 /* Get index to ones place */
> =C2=A0=C2=A0=C2=A0 while ((tmp /=3D 10) !=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_idx++;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 /* Check if we have enough space for num, sign, and =
null */
> =C2=A0=C2=A0=C2=A0 if (len <=3D num_idx + sign + 1) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 str[num_idx + sign + 1] =3D '\0';
>=20
> =C2=A0=C2=A0=C2=A0 if (sign) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[0] =3D '-';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num =3D=3D INT32_MIN) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[=
num_idx + sign] =3D '8';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num =
/=3D 10;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_=
idx--;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num *=3D -1;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 /* Convert int to string */
> =C2=A0=C2=A0=C2=A0 while (num_idx >=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[num_idx + sign] =3D num =
% 10 + '0';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num /=3D 10;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_idx--;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 return str;
> }
>=20
> Thoughts?

Looks fine to me. With that modification:

Reviewed-by: Thomas Huth <thuth@redhat.com>
