Received: from eggs.gnu.org ([2001:4830:134:3::10]:60900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOwJB-0004wr-MV
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOwJA-0000QP-ET
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:53:33 -0500
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
From: =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
In-Reply-To: <20170105002007.GA13763@umbus.fritz.box>
Date: Thu, 5 Jan 2017 08:53:07 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <404AAC02-2CF3-4F5D-9A1B-2AEA2ADB462E@163.com>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
	<20170104032811.GY12761@umbus.fritz.box>
	<CAFEAcA91zZTPzXGfRSGSQM9kK5cG4Ci-hm7Q4Jd5odfxT+OHHw@mail.gmail.com>
	<20170105002007.GA13763@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

Ok=A3=A1

Just one more comment=A3=BA
After check the code flow, It's clear that the initialized memory region mus=
t be add to address space by calling memory_region_add_subregion in platform=
 code before it can be accessed.

Best wishes =A3=A1

> =D4=DA 2017=C4=EA1=D4=C25=C8=D5=A3=AC08:20=A3=ACDavid Gibson <david@gibson=
.dropbear.id.au> =D0=B4=B5=C0=A3=BA
>=20
>> On Wed, Jan 04, 2017 at 05:04:02PM +0000, Peter Maydell wrote:
>>> On 4 January 2017 at 03:28, David Gibson <david@gibson.dropbear.id.au> w=
rote:
>>>> On Tue, Jan 03, 2017 at 10:02:21PM +0800, =D5=D4=D0=A1=C7=BF wrote:
>>>> Hi=A3=ACdavid=A3=BA
>>>>=20
>>>>   To my understanding=A3=ACwhat must be put in the realize function  is=

>>>>   code which depends on property values. What's the benefit of
>>>>   moving memory region initialization into realize function?  I can
>>>>   not figure out, can you make some explanations?
>>>=20
>>> If nothing else it's better in realize() for consistency with other
>>> devices.
>>=20
>> I'm not sure we're terribly consistent at all, really. My understanding
>> was about the same as =D5=D4=D0=A1=C7=BF -- put stuff in init unless it h=
as to
>> go in realize because it depends on properties or might fail or
>> has permanent effects on the simulation.
>> Lots of existing devices do memory_region_init* calls in
>> their init functions.
>> We should probably write down our preferences somewhere, perhaps
>> http://wiki.qemu.org/Documentation/QOMConventions
>>=20
>>> I'm not familiar enough with the details to be sure, but I also think
>>> it's not safe in instance_init.  Once memory regions are registered,
>>> the device can potentially interact with other devices in the virtual
>>> machine.  realize() is sequenced to expect that, instance_init is not.
>>=20
>> Hmm, that doesn't sound right to me. The other devices will only
>> interact with the memory regions when the calling code has
>> finished doing the create/realize/map memory regions sequence --
>> an MR on its own doesn't do anything unless somebody maps it into
>> an address space.
>=20
> Huh.  Ok, I guess I was wrong.
>=20
> Alright, =D5=D4=D0=A1=C7=BF, feel free to repost addressing just the other=

> comments and I'll merge.
>=20
> --=20
> David Gibson            | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au    | minimalist, thank you.  NOT _the_ _oth=
er_
>                | _way_ _around_!
> http://www.ozlabs.org/~dgibson
> =A1=BE=C0=B4=D7=D4=CD=F8=D2=D7=D3=CA=CF=E4=B5=C4=B3=AC=B4=F3=B8=BD=BC=FE=A1=
=BF
> =D3=CA=BC=FE=B4=F8=D3=D0=B8=BD=BC=FE=D4=A4=C0=C0=C1=B4=BD=D3=A3=AC=C8=F4=C4=
=FA=D7=AA=B7=A2=BB=F2=BB=D8=B8=B4=B4=CB=D3=CA=BC=FE=CA=B1=B2=BB=CF=A3=CD=FB=B6=
=D4=B7=BD=D4=A4=C0=C0=B8=BD=BC=FE=A3=AC=BD=A8=D2=E9=C4=FA=CA=D6=B6=AF=C9=BE=B3=
=FD=C1=B4=BD=D3=A1=A3
>=20
> signature.asc
> =CF=C2=D4=D8: http://u.163.com/t0/EPKVtbajXUHs
>=20
> =D4=A4=C0=C0: http://u.163.com/t0/VUdsq6tC
>=20
