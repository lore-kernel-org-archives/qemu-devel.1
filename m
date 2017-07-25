Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1da6vi-0006ol-Vt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1da6vg-0005Yo-Ad
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1da6vg-0005YK-0q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:59:44 -0400
Message-ID: <1501016375.26846.21.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Tue, 25 Jul 2017 16:59:35 -0400
In-Reply-To: <CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<1500818683.4073.31.camel@redhat.com>
	<CAPcyv4h5O4D2kp6SJhWiz4V=dOLDa_Q3pk2B=u-x7hKKQqdXsQ@mail.gmail.com>
	<1500833428.4073.36.camel@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0yV1qDWO2FxT0D2yrVqZ"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


--=-0yV1qDWO2FxT0D2yrVqZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-07-25 at 07:46 -0700, Dan Williams wrote:
> On Tue, Jul 25, 2017 at 7:27 AM, Pankaj Gupta <pagupta@redhat.com>
> wrote:
> >=20
> > Looks like only way to send flush(blk dev) from guest to host with
> > nvdimm
> > is using flush hint addresses. Is this the correct interface I am
> > looking?
> >=20
> > blkdev_issue_flush
> > =C2=A0submit_bio_wait
> > =C2=A0 submit_bio
> > =C2=A0=C2=A0=C2=A0=C2=A0generic_make_request
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmem_make_request
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (b=
io->bi_opf & REQ_FLUSH)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nvdimm_flush(nd_region);
>=20
> I would inject a paravirtualized version of pmem_make_request() that
> sends an async flush operation over virtio to the host. Don't try to
> use flush hint addresses for this, they don't have the proper
> semantics. The guest should be allowed to issue the flush and receive
> the completion asynchronously rather than taking a vm exist and
> blocking on that request.

That is my feeling, too. A slower IO device benefits
greatly from an asynchronous flush mechanism.

--=20
All rights reversed
--=-0yV1qDWO2FxT0D2yrVqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZd7E3AAoJEM553pKExN6DyR0H/jCXdUHi8A0l9aysr2waOPQ+
IjABA2T0vyG9QqufzE268g9NO7W9a79k0wcwvtU8S6P/7MUE6DU8ZLDvbQW+M3Td
VxBL9DmthzJFJy8/3EGvTUU+sEB1Qm8EeGu844ME8Ea6/rPHJwjHG/shnmocHeyl
G4Mpvc+zzz2WvZSwpsWtodon7jYfWY7NpPHp/JjwMfIVTErTFpSDZsTKpneFs9aC
s2EwM5WyuLlGt9bEPhQe9eQMiGeHsz5hLnO/9HdUZ8Let61bCGrZ5gn+yg0FHit7
lvQFPh1FxjWdFiRNYcAtFOATHWsNhhMWgRUZ2+GX3JKABDa+/LVaRYqtFDErmz8=
=usoe
-----END PGP SIGNATURE-----

--=-0yV1qDWO2FxT0D2yrVqZ--
