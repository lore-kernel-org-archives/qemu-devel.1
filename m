Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e45MC-0002aL-PI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e45MB-0007aH-Nr
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:23:00 -0400
Date: Mon, 16 Oct 2017 15:22:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171016132246.GC5145@localhost.localdomain>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
	<20171013094400.GD20515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171013094400.GD20515@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>, qemu-block@nongnu.org

Am 13.10.2017 um 11:44 hat Daniel P. Berrange geschrieben:
> On Fri, Oct 13, 2017 at 11:37:08AM +0200, Cornelia Huck wrote:
> > - Lack of support for encryption/signing of network-based images was
> >   criticized. They ended up using Ceph and GlusterFS, which they were
> >   reasonably happy with.
>=20
> Hopefully the 'luks' driver (which can be layered over any block backen=
d
> including network ones), and the TLS support for NBD would be considere=
d
> to address this last point to some degree. At least from the encryption
> side.

They refer to a blog post of yours about the weakness of the AES
encryption in qcow2, but it seems they didn't see that luks exists as a
replacement. While the qcow2 integration of luks is new in 2.10, we've
had the separate 'luks' driver for a while. Do we need to inform our
users better about it?

The option of using LUKS on the host is mentioned, but also that libvirt
doesn't support this, so it comes with manual work.


They saw the TLS support in NBD, but had the impression it's not mature:

    nbd sieht zwar einen Schutz durch TLS vor, dieser wird jedoch als
    experimentell bezeichnet und nicht f=FCr den produktiven Betrieb
    empfohlen.

("nbd provides protection by TLS; however, this is described as
experimental and not recommended for production")

> Signing of disk images is impractical as it would imply having to downl=
oad
> the entire image contents to validate signature, rather defeating the p=
oint
> of having a network based image. But perhaps this is lost in translatio=
n
> and they mean something else by "signing of images" ?

I suppose they mean something on a per-block basis, like a checksum or
hash that is included in the encryption and can be used to verify that
nobody changed the encrypted data from outside.

    Dar=FCber hinaus besitzt qcow2 keinerlei Integrit=E4tsschutz. Selbst =
wenn
    die Verschl=FCsselung als ausreichend sicher angesehen werden w=FCrde=
, so
    ist es dem Angreifer prinzipiell weiterhin m=F6glich, den Inhalt des
    Blockger=E4ts zu modifizieren

("In addition, qcow2 has no integrity protection. Even if the
encryption were considered sufficiently secure, in priciple the attacker
could still modify the content of the block device.")

They mention dm-integrity as an option to implement this on the host
kernel level.


Another thing that made me a bit sad is that they mention qed as a
better performing alternative for qcow2. Even in 2017, people keep
spreading this nonsense. :-(

Kevin
