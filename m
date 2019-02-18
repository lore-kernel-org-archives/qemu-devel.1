Received: from eggs.gnu.org ([209.51.188.92]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvm9l-00007i-7r
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvm9j-0005hT-GM
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:52:36 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-9-git-send-email-jjherne@linux.ibm.com>
	<a9633e15-13c7-70a5-17c2-2204dd174335@redhat.com>
	<30de3db1-c1df-1aed-8dac-5d0e446b7ca4@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e467b63-519a-a3a4-de7e-e38d7d89dfa4@redhat.com>
Date: Mon, 18 Feb 2019 17:52:30 +0100
MIME-Version: 1.0
In-Reply-To: <30de3db1-c1df-1aed-8dac-5d0e446b7ca4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 08/15] s390-bios: Map low core
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 18/02/2019 16.40, Jason J. Herne wrote:
> On 2/12/19 7:47 AM, Thomas Huth wrote:
>> On 2019-01-29 14:29, Jason J. Herne wrote:
>>> Create a new header for basic architecture specific definitions and
>>> add a
>>> mapping of low core memory. This mapping will be used by the real
>>> dasd boot
>>> process.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
>>> =C2=A0 pc-bios/s390-ccw/s390-arch.h | 100
>>> +++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 102 insertions(+)
>>> =C2=A0 create mode 100644 pc-bios/s390-ccw/s390-arch.h
>>>
>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>> index 1bc61b5..fa90aa3 100644
>>> --- a/pc-bios/s390-ccw/main.c
>>> +++ b/pc-bios/s390-ccw/main.c
>>> @@ -9,6 +9,7 @@
>>> =C2=A0=C2=A0 */
>>> =C2=A0 =C2=A0 #include "libc.h"
>>> +#include "s390-arch.h"
>>> =C2=A0 #include "s390-ccw.h"
>>> =C2=A0 #include "cio.h"
>>> =C2=A0 #include "virtio.h"
>>> @@ -19,6 +20,7 @@ static char loadparm_str[LOADPARM_LEN + 1] =3D { 0,
>>> 0, 0, 0, 0, 0, 0, 0, 0 };
>>> =C2=A0 QemuIplParameters qipl;
>>> =C2=A0 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)))=
;
>>> =C2=A0 static bool have_iplb;
>>> +const LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>>> =C2=A0 =C2=A0 #define LOADPARM_PROMPT "PROMPT=C2=A0 "
>>> =C2=A0 #define LOADPARM_EMPTY=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "
>>> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arc=
h.h
>>> new file mode 100644
>>> index 0000000..47eaa04
>>> --- /dev/null
>>> +++ b/pc-bios/s390-ccw/s390-arch.h
>>> @@ -0,0 +1,100 @@
>>> +/*
>>> + * S390 Basic Architecture
>>> + *
>>> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
>>
>> 2019 ?
>>
>=20
> Yep, I will update this,
>=20
>>> + * This work is licensed under the terms of the GNU GPL, version 2
>>> or (at
>>> + * your option) any later version. See the COPYING file in the
>>> top-level
>>> + * directory.
>>> + */
>>> +
>>> +#ifndef S390_ARCH_H
>>> +#define S390_ARCH_H
>>> +
>>> +typedef struct PSW {
>>> +=C2=A0=C2=A0=C2=A0 uint64_t mask;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t addr;
>>> +} __attribute__ ((packed, aligned(8))) PSW;
>>
>> We've seen quite some trouble with "packed" in the past... See
>> 3b8afb41bc8e or 55281a2c53b884d0 for example ... This is only the
>> s390-ccw bios code here, so it is likely ok, but still, since this
>> structure is "naturally" packed, I'd rather go without that attribute
>> here (even if it's only to allow the compiler to generate better code =
in
>> some cases). You could still _Static_assert(sizeof(struct PSW) =3D=3D =
16)
>> afterwards, just to be sure.
>=20
> So the problem is that this struct, if baked into another struct, will
> not be aligned properly?

Yeah, stuff like that. Maybe you can get along here because you also
specified aligned(8) ... but from my experience, it's better to avoid
"packed" if possible.

>>> +
>>> +/* Older PSW format used by LPSW instruction */
>>> +typedef struct PSWLegacy {
>>> +=C2=A0=C2=A0=C2=A0 uint32_t mask;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t addr;
>>> +} __attribute__ ((packed, aligned(8))) PSWLegacy;
>>
>> dito, I'd drop the packed attribute here.
>=20
> Are we sure the compiler will never insert space here if we drop packed=
?
> I don't see why it would but I'll admit that I don't fully know all of
> the rules.

That's why I suggested to also use _Static_assert(sizeof(x) =3D=3D y). Th=
at
way you can be sure that the compiler does not add any unwanted padding.

[...]
>>> +} __attribute__((packed, aligned(8192))) LowCore;
>>
>> dito, please avoid packed, use _Static_assert instead.
>=20
> I'm not convinced this is a good thing to do. Lowcore freely mixes
> fields of size 64, 32, and 8 bits. If we drop packed then the compiler
> will perform all sorts of automatic alignment thereby completely messin=
g
> up offsets.

You should be fine if you also use _Static_assert() afterwards here.

... but since this is the s390-ccw bios and we can be sure that we only
compile this code for s390x and with gcc, I'm also fine if you keep the
attribute here. The problems we've seen so far only occurred on
non-s390x systems (Sparc...) or with Clang, so unlike we want to share
this header with the common QEMU code later, it should not really matter.

 Thomas
