Received: from eggs.gnu.org ([2001:4830:134:3::10]:50978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0m6f-00031k-Tf
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0m6b-0003UZ-UQ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:41:01 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:34004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1d0m6b-0003Ts-KN
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:40:57 -0400
Date: Wed, 19 Apr 2017 11:40:18 +0200 (CEST)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1746435304.10992233.1492594818158.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <20170419090236.GA14508@lemon.lan>
References: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
	<20170419090236.GA14508@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] blockdev-mirror ,
 how to replace old nodename by new nodename ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Ok thanks.

I'll retry without replaces, but I'm pretty sure It was not working too.


Also, I notice something strange,

when I define the job-id (which is mandatory), it's replace the device opti=
on.
(If I set a random job-id name, the mirroring is not working because it don=
't find the device).


----- Mail original -----
De: "Fam Zheng" <famz@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 19 Avril 2017 11:02:36
Objet: Re: [Qemu-devel] blockdev-mirror , how to replace old nodename by ne=
w nodename ?

On Wed, 04/19 09:08, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm trying to implement blockdev-mirror, to replace drive-mirror as we ca=
n pass more options with blockdev-mirror.=20
>=20
>=20
> I would like to mirror an attached blockdev to a new blockdev, then switc=
h at the end of block-job-complete, like for drive-mirror.=20
>=20
>=20
> qemu command line (vm-138-disk-1.qcow2 filename on "drive-virtio0" nodena=
me:=20
>=20
> -blockdev {"node-name":"drive-virtio0","cache":{"direct":true},"driver":"=
qcow2","file":{"filename":"/var/lib/vz/images/138/vm-138-disk-1.qcow2","aio=
":"threads","driver":"file"}}=20
> -device virtio-blk-pci,drive=3Ddrive-virtio0,id=3Dvirtio0,bus=3Dpci.0,add=
r=3D0xa,write-cache=3Don=20
>=20
>=20
> add a new blockdev with blockdev-add: (a file vm-138-disk-2.raw has been =
created before, I assign it to a "tempmirror" nodename)=20
>=20
>=20
> {"arguments":{"driver":"raw","cache":{"direct":true},"node-name":"tempmir=
ror","file":{"driver":"file","aio":"threads","filename":"/var/lib/vz/images=
/138/vm-138-disk-2.raw"}},"execute":"blockdev-add"}=20
>=20
>=20
> blockdev-mirror:=20
>=20
> {"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"full=
","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blockdev-=
mirror"}=20
>=20
> (I have try with or without replaces option)=20
>=20
> then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirror "n=
ode-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name=20
>=20
>=20
> I expected that both was switched, like for drive-mirror.=20

The replace/switch happens when you do block-job-complete.=20

And I think in your use case "replaces" is not needed. That one is for repl=
acing=20
a node under quorum=20

Fam=20
