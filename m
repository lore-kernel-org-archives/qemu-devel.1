Received: from eggs.gnu.org ([2001:4830:134:3::10]:37858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dxTYN-0005id-CJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dxTYK-000128-9A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dxTYJ-00011L-WE
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:48:12 -0400
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
	<4ca77991-ad6a-a138-622b-b42f410fa1eb@redhat.com>
	<a8d8ec43-bc27-b28a-dd7d-163a715acb5e@redhat.com>
	<24ca79b9-9350-4339-960b-0dbdf9cd4c5b@redhat.com>
	<13096938-e70f-7a3a-3cd0-4b9d475c2b18@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6e81f338-1a43-518c-b39e-f09de76c3106@redhat.com>
Date: Thu, 28 Sep 2017 09:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <13096938-e70f-7a3a-3cd0-4b9d475c2b18@redhat.com>
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>

On 09/27/17 12:06, Marcel Apfelbaum wrote:
> Hi Laszlo,
>=20
> On 20/09/2017 14:01, Laszlo Ersek wrote:
>> =C2=A0 We now have
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
> SeaBIOS=C2=A0 will not allow (0,0) values for pref32 and pref64 fields.
> More than that, 0 values are not being taken in consideration.
>=20
> We may say is a bug and fix it. But taking a step back, we need the
> hints to reserve *more* mem range, I am not sure 0 values are
> interesting for mem reservation. Also is also only a hint,
> the firmware should decide.
>=20
> Do we have a concrete scenario where would we want to use (0, non-zero)
> or (non-zero, 0) ? (ask for 32/64 prefetch)
>=20
> Our current semantic is: "we give a hint to the Guest Firmware,
> we don't decide. However, giving hints to both pref32 and pref64
> is wrong".

After having written the OVMF code for this, my understanding is
clearer, and I agree that, for *prefetchable*, distinguishing -1 from 0
is not necessary (-1 means "firmware default (unspecified)", and 0 means
"do not reserve"; and for prefetchable, the two things mean the same in
OVMF). So the current QEMU code should be fine.

> Not related: Using 0 value to disable IO works just fine!
> No need for disable-IO-fwd property :)

Great!

Thanks!
Laszlo
