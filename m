Received: from eggs.gnu.org ([2001:4830:134:3::10]:34782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebO3O-0000dK-RS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebO3L-0002PJ-RM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:01:14 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
	<34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
	<e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <272fa2f6-8a75-3c05-e373-d7d1b65a7e23@redhat.com>
Date: Tue, 16 Jan 2018 11:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 15.01.2018 18:23, Collin L. Walling wrote:
> On 01/15/2018 12:05 PM, Eric Blake wrote:
>> On 01/15/2018 10:44 AM, Collin L. Walling wrote:
[...]
>>> +/**
>>> + * atoi:
>>> + * @str: the string to be converted.
>>> + *
>>> + * Given a string @str, convert it to an integer. Any non-numerical
>>> value
>>> + * will terminate the conversion.
>>> + *
>>> + * Returns: an integer converted from the string @str.
>>> + */
>>> +int atoi(const char *str)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +=C2=A0=C2=A0=C2=A0 int val =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; str[i]; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char c =3D str[i];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!isdigit(c)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val *=3D 10;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val +=3D c - '0';
>> Silently gives garbage on integer overflow, but matches the fact that
>> POSIX atoi() can't flag errors.=C2=A0 However, it does not handle lead=
ing
>> whitespace nor '-', which means it is NOT doing a POSIX-compatible
>> atoi() implementation; naming it atoi() is perhaps thus a disservice t=
o
>> end users.
>=20
> Fair enough. Perhaps the "strtoi" convention suits this better.

Or maybe simply add an assert(str[0] !=3D '-') for now. If we ever hit th=
e
assert, we can still add the support for negative numbers if necessary.

>>> +static inline size_t strlen(const char *str)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 size_t i;
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; *str; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return i;
>> Again, not the fastest implementation, but that shouldn't matter.

Yes, indeed, speed does not really matter here for the some few bytes
that are handled during the life-time of the s390-ccw bios.

>>> +}
>>> +
>>> +static inline int isdigit(int c)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return (c >=3D '0') && (c <=3D '9');
>>> +}
>>> +
>>> +int atoi(const char *str);
>>> +char *itostr(int num, char *str, size_t len);
>>> +
>>> =C2=A0 #endif
>=20
>=20

 Thomas
