Received: from eggs.gnu.org ([2001:4830:134:3::10]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dufYp-000723-5F
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dufYj-0007mr-6U
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dufYi-0007mM-VH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:01 -0400
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
	<4ca77991-ad6a-a138-622b-b42f410fa1eb@redhat.com>
	<a8d8ec43-bc27-b28a-dd7d-163a715acb5e@redhat.com>
	<24ca79b9-9350-4339-960b-0dbdf9cd4c5b@redhat.com>
	<77945ee2-ccfa-becc-eee1-c4b1066303c7@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3920012f-1af2-acc4-4c41-77327482c008@redhat.com>
Date: Wed, 20 Sep 2017 13:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <77945ee2-ccfa-becc-eee1-c4b1066303c7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by
 default for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 09/20/17 13:16, Marcel Apfelbaum wrote:
> On 20/09/2017 14:01, Laszlo Ersek wrote:
>> On 09/20/17 09:42, Marcel Apfelbaum wrote:

>>> The implementation issue might be that Guest Firmware would
>>> take the alignment as default value for an empty root port.
>>> (maybe take it as a bug and "solve" it?)
>>
>> Hm, I don't get this. What do you mean?
>>
>=20
> Empty PCI Express Root Port with io_reserve =3D 0 should end with
> no IO ports range, right?

Yes.

> But there is some code in SeaBIOS that "aligns" the IO range to 4K,
> so we may end up with a 4K range even if io_reserve=3D0.

Ah.

OK, if this makes a difference, please report your findings :)

>>>> (d) pci_bridge_qemu_reserve_cap_init() should be updated accordingly
>>>> (i.e., a conflict exists if both mem_pref_32_reserve and
>>>> mem_pref_64_reserve are *positive*),
>>>>
>>>
>>> I thought we have this check already.
>>
>> We have a check like this, but it doesn't use the exact condition that
>> I'm suggesting above (emphasis on *positive*). We now have
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (mem_pref_32_reserve !=3D (uint32_t)-1 &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_pref_64_reserve !=
=3D (uint64_t)-1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>
>> but after introducing the zero value, this is going to be too strict.
>> Consider all the possible combinations:
>>
>> * (-1; -1): default fw behavior, check is OK
>>
>> * (-1;=C2=A0 0): fw sticks with the default for the first component, p=
icks
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "no reservation" for the second component, check is OK
>>
>> * (-1; >0): fw can treat this identically to ( 0; >0) -- see below. Th=
is
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 is justified because, while the first component says "use
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 the default", the entire situation of having such a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 capability is new, so the firmware can introduce new ways
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 for handling it. The check passes, which is good.
>>
>> * ( 0;=C2=A0 0): check reports error, but the firmware can handle this=
 case
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 fine (no reservation for either component)
>>
>> * ( 0; >0): check reports error, but the fw can handle this (no
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reservation for the first component, specific reservation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 for the second)
>>
>> * (>0; >0): conflict, check is OK
>>
>> (I'm skipping the description of the inverted orderings, such as (0;-1=
),
>> they behave similarly.)
>>
>> So we need to accept 0 as "valid" for either component:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (mem_pref_32_reserve > 0 &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_pref_32_reserve <=
 (uint32_t)-1 &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_pref_64_reserve >=
 0 &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_pref_64_reserve <=
 (uint64_t)-1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>
>=20
> Got it, you are right. How did we end up with something
> complicated again :( ?
> (complicated =3D needs documentation and not straight forward)

Haha, are you serious? :)

*Nothing* is simple in QEMU; nothing at all. :) In general, software is
complex because of feature requests, and QEMU caters to a million
different (and conflicting) use cases, so you get complexity.

(I know this is trivial, but it sure felt good to write down! :) )

>>>> Second, when determining the reservations in OVMF, I would like to l=
ook
>>>> only at the capability fields, and not do a read-write-read-write
>>>> quadruplet to the IO base/limit registers. Do you agree?
>>>>
>>>
>>> Well, as stated before, the semantics for the hint is
>>> max(hint, <sum of all IO/MEM ranges for devices behind the bridge>).
>>> If you can follow it, that would be OK.
>>
>> In OVMF there are two separate questions:
>> - how to report the requested reservations,
>> - how to act upon the reported values.
>>
>> The first question pertains to "platform code", i.e., what I'm going t=
o
>> implement under OvmfPkg. The second question pertains to "universal
>> code" (under "MdeModulePkg/Bus/Pci/PciBusDxe"), which is a lot harder =
to
>> modify, because it is shipped on a wide range of physical platforms to=
o.
>>
>> Again, my understanding is that PciBusDxe implements the "max" semanti=
cs
>> that you describe (pertaining to the 2nd question).
>>
>> My interest is in figuring out the 1st question now, that is, where I
>> should take the information from that goes into the "reservation
>> description" that PciBusDxe understands. My preference would be to loo=
k
>> only at the PCIE port in question (i.e. no other PCI devices at all),
>> and only at said capability in the config space of the PCIE port.
>>
>=20
> Sounds OK.

Thank you! Looks like I can start writing code for OVMF when I find the
time.

Thanks!
Laszlo
