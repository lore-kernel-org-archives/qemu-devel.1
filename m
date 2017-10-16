Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e45b6-0001cA-Nf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e45b5-0007lf-G3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:38:24 -0400
Date: Mon, 16 Oct 2017 14:38:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171016133812.GB11975@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
	<20171013094400.GD20515@redhat.com>
	<20171016132246.GC5145@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171016132246.GC5145@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On Mon, Oct 16, 2017 at 03:22:46PM +0200, Kevin Wolf wrote:
> Am 13.10.2017 um 11:44 hat Daniel P. Berrange geschrieben:
> > On Fri, Oct 13, 2017 at 11:37:08AM +0200, Cornelia Huck wrote:
> > > - Lack of support for encryption/signing of network-based images wa=
s
> > >   criticized. They ended up using Ceph and GlusterFS, which they we=
re
> > >   reasonably happy with.
> >=20
> > Hopefully the 'luks' driver (which can be layered over any block back=
end
> > including network ones), and the TLS support for NBD would be conside=
red
> > to address this last point to some degree. At least from the encrypti=
on
> > side.
>=20
> They refer to a blog post of yours about the weakness of the AES
> encryption in qcow2, but it seems they didn't see that luks exists as a
> replacement. While the qcow2 integration of luks is new in 2.10, we've
> had the separate 'luks' driver for a while. Do we need to inform our
> users better about it?

There is definitely room to improve our docs and general presentation
of QEMU security features.

> The option of using LUKS on the host is mentioned, but also that libvir=
t
> doesn't support this, so it comes with manual work.

Yep

> They saw the TLS support in NBD, but had the impression it's not mature=
:
>=20
>     nbd sieht zwar einen Schutz durch TLS vor, dieser wird jedoch als
>     experimentell bezeichnet und nicht f=C3=BCr den produktiven Betrieb
>     empfohlen.
>=20
> ("nbd provides protection by TLS; however, this is described as
> experimental and not recommended for production")

They probably read the old version of the NBD protocol specification
from early 2016 where TLS was still listed as "Experimental", due to
not having any implementation of the TLS spec. This "Experimental"
tag was removed after we released TLS in QEMU


> > Signing of disk images is impractical as it would imply having to dow=
nload
> > the entire image contents to validate signature, rather defeating the=
 point
> > of having a network based image. But perhaps this is lost in translat=
ion
> > and they mean something else by "signing of images" ?
>=20
> I suppose they mean something on a per-block basis, like a checksum or
> hash that is included in the encryption and can be used to verify that
> nobody changed the encrypted data from outside.
>=20
>     Dar=C3=BCber hinaus besitzt qcow2 keinerlei Integrit=C3=A4tsschutz.=
 Selbst wenn
>     die Verschl=C3=BCsselung als ausreichend sicher angesehen werden w=C3=
=BCrde, so
>     ist es dem Angreifer prinzipiell weiterhin m=C3=B6glich, den Inhalt=
 des
>     Blockger=C3=A4ts zu modifizieren
>=20
> ("In addition, qcow2 has no integrity protection. Even if the
> encryption were considered sufficiently secure, in priciple the attacke=
r
> could still modify the content of the block device.")
>=20
> They mention dm-integrity as an option to implement this on the host
> kernel level.

Ah ok. I would think the user could  still run dm-integrity inside their
guest if they wanted to detect tampering explicitly instead of getting
back garbage decrypted data.

> Another thing that made me a bit sad is that they mention qed as a
> better performing alternative for qcow2. Even in 2017, people keep
> spreading this nonsense. :-(

Probably because when you google for QED you inevitably hit this article
near the top:

  https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DOTY0MQ

And there's little clear information on QEMU website to show that QED
is essentially an obsolete experiment.

Perhaps some clear update to this page would help, and also in the
qemu docs

  https://wiki.qemu.org/Features/QED


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
