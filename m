Received: from eggs.gnu.org ([2001:4830:134:3::10]:34100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmw6K-00027I-7t
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmw6G-00064F-8Q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:03:44 -0400
References: <20170828155831.4eda8c12@oO_Oo>
	<c0020cdd-f052-6d39-d7a9-4ec36508aa0b@redhat.com>
	<20170829212237.3fbb41ab@oO_Oo>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fee062ce-1c82-5083-8440-ca1636cf0635@redhat.com>
Date: Wed, 30 Aug 2017 08:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170829212237.3fbb41ab@oO_Oo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-discuss] changing from net to netdev with
 vde switches and double nics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo <anotheruser.mailinglist@virgilio.it>
Cc: "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>

On 29.08.2017 21:22, Paolo wrote:
>=20
> ----------------------------------------------------------------------
>> On Tue, 29 Aug 2017 11:48:20 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
> [cut]
>> That's interesting, I think you're the first person I know in months o=
r
>> even years who really seems to be using the vlan=3Dx parameter (with x=
 >=3D
>> 1)...
>=20
> I can't see any other way to realize this topology:
>                       =20
>              Internet---HOST--SambaServer
>                        |    |
>                        |    |
>                   pubNET    prvNET
>                   |         |
>    |--------------          |
>    |                        |
>  NIC0  NIC1-----------------|
>    |    |
>   machine_1                   ....  machine_N       =20
>> You're right, you can not translate your setup 1:1 to -netdev anymore,
>> since there are no 'vlan's (or rather hubs, since 'vlan' is rather a
>> misnomer here) available with the -netdev parameter.
>=20
> This might be a problem for me, as I explain later=20
>> Question is: Why do you need it at all? I see your point that you want
>> to have two network cards, but why does each NIC has to be wired to tw=
o
>> host networks (vde *and* tap)? Isn't it sufficient if you connect each
>> NIC to one VDE network?
>=20
> Easily: by ignorance.

Deja vu ... this is actually one of the reasons why we want to get rid
of this "vlan" stuff in QEMU. Hardly anybody gets it really right, it
mainly causes confusion and mis-configurations.

> Writing that script (about 8 years ago) with almost zero knowledge of n=
etworking and difference between tap, vde (and much more stuff), made me =
rely on a Frankenstein-style patchwork from midnight readings of the vari=
ous howtos on internet. Quite a mess and a long and painful trial-and-err=
or race. Nor that today I might be regarded as an expert in networking, I=
 didn't progress very much (and it' not my job anyway).
>=20
> Back on topic, following your hint, I've tried just know that all I nee=
d is vde, and everything works fine:
>=20
>  NET0=3D"-net vde,vlan=3D0,sock=3D/var/run/vde.ctl00 -net nic,vlan=3D0,=
model=3Drtl8139,macaddr=3D$NIC0MAC"
>  NET1=3D"-net vde,vlan=3D1,sock=3D/var/run/vde.ctl01 -net nic,vlan=3D1,=
model=3Drtl8139,macaddr=3D$NIC1MAC"
>=20
> Now I guess this is impossbile to achieve with netdev?
> How may I tell to qemu that the guest's NIC0 has to be wired to the vde=
 switch vde.ctl00 run on host has, and NIC1 to vde.ctl01?

It should be doable. Could you please try something like this:

 NET0=3D"-netdev vde,id=3Dv0,sock=3D/var/run/vde.ctl00 -device rtl8139,ne=
tdev=3Dv0,mac=3D$NIC0MAC"
 NET1=3D"-netdev vde,id=3Dv1,sock=3D/var/run/vde.ctl01 -device rtl8139,ne=
tdev=3Dv1,mac=3D$NIC1MAC"

I haven't tested it though, so you still might have to tweak it. Run qemu
with "-device rtl8139,?" to see the options of the rtl8139 device.

> Also hubport function is unclear to me. It reproduces the previous vlan=
 concept, but it's left orphan, because no other devices seems to be made=
 aware that hubportN exists, nor they can be wired to it.

You mean "-netdev hubport"? Forget about it, you don't need it. The hubpo=
rt
is only required if you want to connect a device to a legacy "vlan" hub. =
In
your case, you should be fine without these legacy "vlan"s.

 HTH,
  Thomas
