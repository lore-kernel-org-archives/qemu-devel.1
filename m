Received: from eggs.gnu.org ([2001:4830:134:3::10]:55365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d0pBO-0006B2-RD
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d0pBN-0003Jd-IZ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:58:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1d0pBN-0003JJ-9Q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:58:05 -0400
Date: Wed, 19 Apr 2017 14:58:01 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170419125801.ort44uiuepmklm5j@eukaryote>
References: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
	<20170419104300.gousbztqfl5j4k7q@eukaryote>
	<111400435.11010636.1492604926409.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <111400435.11010636.1492604926409.JavaMail.zimbra@oxygem.tv>
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
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Apr 19, 2017 at 02:28:46PM +0200, Alexandre DERUMIER wrote:
> Thanks I'll try. (I'm on 2.9.0-rc4)
>=20
> can you send your initial qemu command line ?

    $ ~/build/qemu-upstream/x86_64-softmmu/qemu-system-x86_64 \
		-display none -nodefconfig -nodefaults -m 512 \
		-device virtio-scsi-pci,id=3Dscsi -device virtio-serial-pci \
		-blockdev node-name=3Dfoo,driver=3Dqcow2,file.driver=3Dfile,file.filena=
me=3D./base.qcow2 \
		-monitor stdio -qmp unix:./qmp-sock,server,nowait

> also :
>=20
> >>"execute":"blockdev-add",=20
> >>"arguments":{=20
> >>"driver":"qcow2",=20
> >>"node-name":"node1",

Oops, it should be 'node2'.  Copy / paste mistake, sorry.

> ...
>=20
> then=20
>=20
>=20
> >>"execute":"blockdev-mirror",=20
> >>"arguments":{=20
> >>"device":"foo",=20
> >>"job-id":"job-2",=20
> >>"target":"node2",    --> node2 ? =20
> >>"sync":"full"=20

With the above copy / paste error I noted in the `blockdev-add` command,
the commands I noted in my previous email should work as expected.

Regards,
Kashyap

> ----- Mail original -----
> De: "Kashyap Chamarthy" <kchamart@redhat.com>
> =C0: "aderumier" <aderumier@odiso.com>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>
> Envoy=E9: Mercredi 19 Avril 2017 12:43:00
> Objet: Re: [Qemu-devel] blockdev-mirror , how to replace old nodename b=
y new nodename ?
>=20
> On Wed, Apr 19, 2017 at 09:08:20AM +0200, Alexandre DERUMIER wrote:=20
> > Hi,=20
> >=20
> > I'm trying to implement blockdev-mirror, to replace drive-mirror as w=
e=20
> > can pass more options with blockdev-mirror.=20
> >=20
> >=20
> > I would like to mirror an attached blockdev to a new blockdev, then=20
> > switch at the end of block-job-complete, like for drive-mirror.=20
>=20
> [...]=20
>=20
> > blockdev-mirror:=20
> >=20
> > {"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"=
full","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blo=
ckdev-mirror"}=20
> >=20
> > (I have try with or without replaces option)=20
> >=20
> > then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirro=
r=20
> > "node-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name=20
> >=20
> > I expected that both was switched, like for drive-mirror.=20
>=20
> For me, 'blockdev-mirror' does do the switch when I issue=20
> 'block-job-complete' (similar to 'drive-mirror')=20
>=20
> The below is my test from Git:=20
>=20
> I was here (on Git):=20
>=20
> $ git describe=20
> v2.9.0-rc5=20
>=20
> -----------------------------------------------------------------------=
=20
> $ qemu-img create -f qcow2 /export/target2.qcow2 1G=20
> Formatting '/export/target2.qcow2', fmt=3Dqcow2 size=3D1073741824 encry=
ption=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"blockdev-add",=20
> "arguments":{=20
> "driver":"qcow2",=20
> "node-name":"node1",=20
> "file":{=20
> "driver":"file",=20
> "filename":"/export/target2.qcow2"=20
> }=20
> }=20
> }=20
> {"return": {}}=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {"execute":"query-named-block-nodes"}=20
> [...]=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"blockdev-mirror",=20
> "arguments":{=20
> "device":"foo",=20
> "job-id":"job-2",=20
> "target":"node2",=20
> "sync":"full"=20
> }=20
> }=20
> {"return": {}}=20
> {"timestamp": {"seconds": 1492598410, "microseconds": 35946}, "event": =
"BLOCK_JOB_READY", "data": {"device": "job-2", "len": 24182784, "offset":=
 24182784, "speed": 0, "type": "mirror"}}=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"block-job-complete",=20
> "arguments":{=20
> "device":"job-2"=20
> }=20
> }=20
> {"return": {}}=20
> {"timestamp": {"seconds": 1492598419, "microseconds": 115458}, "event":=
 "BLOCK_JOB_COMPLETED", "data": {"device": "job-2", "len": 24182784, "off=
set": 24182784, "speed": 0, "type": "mirror"}}=20
> -----------------------------------------------------------------------=
=20
>=20
>=20
> [...]=20
>=20
>=20
> --=20
> /kashyap=20
>=20
