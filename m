Received: from eggs.gnu.org ([2001:4830:134:3::10]:51335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eF51Q-0003II-EI
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eF51N-00017k-O2
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:15:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eF51N-00016I-Fz
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:14:57 -0500
References: <20171114225941.072707456B5@zero.eik.bme.hu>
	<cd544495-16c6-5e75-837b-be1deb4e9768@redhat.com>
	<alpine.BSF.2.21.1711151930030.26122@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9876d19-3ca6-5be0-572c-b664eddee102@redhat.com>
Date: Wed, 15 Nov 2017 22:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1711151930030.26122@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec: Skip mru section if it's a partial
 page and not resolving subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 15/11/2017 20:00, BALATON Zoltan wrote:
> On Wed, 15 Nov 2017, Paolo Bonzini wrote:
>> This is another possibility:
>>
>> diff --git a/exec.c b/exec.c
>> index 97a24a875e..3bb9fcf257 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -410,22 +410,16 @@ static MemoryRegionSection
>> *address_space_lookup_region(AddressSpaceDispatch *d,
>> {
>> =C2=A0=C2=A0=C2=A0 MemoryRegionSection *section =3D atomic_read(&d->mr=
u_section);
>> =C2=A0=C2=A0=C2=A0 subpage_t *subpage;
>> -=C2=A0=C2=A0=C2=A0 bool update;
>>
>> -=C2=A0=C2=A0=C2=A0 if (section && section !=3D
>> &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 section_covers_addr(sectio=
n, addr)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update =3D false;
>> -=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0 if (!section || section =3D=3D
>> &d->map.sections[PHYS_SECTION_UNASSIGNED] ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !section_covers_addr(secti=
on, addr)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 section =3D phys_page_find(=
d, addr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&d->mru_section=
, section);
>> =C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 if (resolve_subpage && section->mr->subpage) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subpage =3D container_of(se=
ction->mr, subpage_t, iomem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 section =3D
>> &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
>> =C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (update) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&d->mru_section=
, section);
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 return section;
>> }
>>
>>
>> It will skip the expensive phys_page_find but not the cheap subpage
>> lookup.
>> Does it work for you?
>=20
> This also works but I can't understand why becuase the problematic call
> to this function which got the wrong result from section_covers_addr wa=
s
> with resolve_subpage=3Dfalse and in that case this looks identical to t=
he
> original which did not work.

The problem was that a resolve_subpage=3Dtrue mru_section was reused for =
a
resolve_subpage=3Dfalse mru_section.  This is fixed by always making the
mru_section the same as if resolve_subpage=3Dfalse (mru_section is set
before looking into the subpage_t).

Thanks,

Paolo

> Unless this function is called multiple
> times and another call with resolve_subpage=3Dtrue now somehow works
> better with this change or replacing the mru_section earlier before
> subpage lookup makes a difference which is not obvious from this functi=
on.
>=20
> Anyway, it fixes the problem I see so you can use this instead of my pa=
tch.
>=20
> Thank you,
> BALATON Zoltan
