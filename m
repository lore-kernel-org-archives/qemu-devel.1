Received: from eggs.gnu.org ([2001:4830:134:3::10]:57406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmd8K-0007Uy-PJ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmd8F-0004ZA-QG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:48:32 -0400
References: <20170828155831.4eda8c12@oO_Oo>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c0020cdd-f052-6d39-d7a9-4ec36508aa0b@redhat.com>
Date: Tue, 29 Aug 2017 11:48:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170828155831.4eda8c12@oO_Oo>
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
To: Paolo <anotheruser.mailinglist@virgilio.it>, qemu-discuss@nongnu.org
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>

 Hi,

On 28.08.2017 15:58, Paolo wrote:
> Hello everyone,
>=20
> I'm at loss as to how to translate from net to netdev syntax the follow=
ing lines:
>=20
> NET0=3D"-net vde,vlan=3D0,sock=3D/var/run/vde.ctl00 -net nic,vlan=3D0,m=
odel=3Drtl8139,macaddr=3D$NIC0MAC -net tap,vlan=3D0,ifname=3Dpub2,script=3D=
no,downscript=3Dno"
>=20
> NET1=3D"-net vde,vlan=3D1,sock=3D/var/run/vde.ctl01 -net nic,vlan=3D1,m=
odel=3Drtl8139,macaddr=3D$NIC1MAC -net tap,vlan=3D1,ifname=3Dprv2,script=3D=
no,downscript=3Dno"
>=20
> Usage for lines above is: qemu blah blah blah $NET0 $NET1 blah blah
> (obviously NIC0MAC and NIC1MAC are declared before in the script)
>=20
> these syntax, which has been working flawlessly for ages on my pc, crea=
tes two network cards (pubX, prvX) for each one of my virtual machines. E=
ach of the two network cards is attached to a vde switch, so all of pubX =
cards (X is the machine) are attached to vsw0 (virtaul switch 0) and all =
of prvX cards are attached to vsw1. The rationale behind this is to attac=
h each qemu machine to a private vlan (172.16.y.z) and to a public vlan (=
192.168.w.t) at the same time.
> This way the public lan is used when connected to the internet, the pri=
vate lan works always (i.e. with the router inaccessible) for accessing s=
amba directories on the host (of course, firewalled, ip restricted and so=
 on).
>=20
> Translation from net to netdev is simple for the nic (-device) part and=
 for the tap part alike, but how can I tell qemu that the vdeswitch with =
socket /var/run/vde.ctl00 belongs to the same virtual lan of tap pub2 wit=
h device rtl8139 and mac address NIC0MAC?
>=20
> Translating from net to netdev we lose the vlan=3DX info.

That's interesting, I think you're the first person I know in months or
even years who really seems to be using the vlan=3Dx parameter (with x >=3D
1)...

You're right, you can not translate your setup 1:1 to -netdev anymore,
since there are no 'vlan's (or rather hubs, since 'vlan' is rather a
misnomer here) available with the -netdev parameter.

Question is: Why do you need it at all? I see your point that you want
to have two network cards, but why does each NIC has to be wired to two
host networks (vde *and* tap)? Isn't it sufficient if you connect each
NIC to one VDE network?

 Thomas
