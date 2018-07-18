Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTr-00066x-6s
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTq-00053V-2q
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTp-00051b-OP
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14-v6so5135336wro.5
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:35:05 -0700 (PDT)
Date: Wed, 18 Jul 2018 15:29:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718142927.GN21825@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
	<494e6b18-a5e9-0521-4ace-dca2160ea191@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
Content-Disposition: inline
In-Reply-To: <494e6b18-a5e9-0521-4ace-dca2160ea191@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 05:18:03PM +0200, Paolo Bonzini wrote:
> On 11/07/2018 16:49, Stefan Hajnoczi wrote:
> > On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wr=
ote:
> >> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
> >> +static void *qpci_get_driver(void *obj, const char *interface)
> >>  {
> >> -    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
> >> +    QPCIBusPC *qpci =3D obj;
> >> +    if (!g_strcmp0(interface, "pci-bus")) {
> >> +        return &qpci->bus;
> >> +    }
> >> +    printf("%s not present in pci-bus-pc", interface);
> >> +    abort();
> >> +}
> >=20
> > At this point I wonder if it makes sense to use the QEMU Object Model
> > (QOM), which has interfaces and inheritance.  qgraph duplicates part of
> > the object model.
>=20
> Replying for Emanuele on this point since we didn't really go through
> QOM yet; I'll let him answer the comments that are more related to the co=
de.
>=20
> QOM is much heavier weight than qgraph, and adds a lot more boilerplate:
>=20
> - QOM properties interact with QAPI and bring in a lot of baggage;
> qgraph would only use "child" properties to implement containment.
>=20
> - QOM objects are long-lived, qgraph objects only last for the duration
> of a single test.  qgraph doesn't need reference counting or complex
> two-phase initialization like "realize" or "user_complete"
>=20
> - QOM's hierarchy is shallow, but qgraph doesn't really need _any_
> hierarchy.  Because it focuses on interface rather than hierarchy,
> everything can be expressed simply through structs contained into one
> another.
>=20
> Consider that qgraph is 1/4th the size of QOM, and a large part of it is
> the graph data structure that (as you said) would not be provided by QOM.
>=20
> There are two things where using QOM would save a little bit of
> duplicated concepts, namely the get_driver (get interface, what you
> quote above) and get_device (get contained object) callbacks.  However,
> it wouldn't simplify the code at all, because it would require the
> introduction of separate instance and class structs.  We didn't want to
> add all too much boilerplate for people that want to write qtest, as you
> pointed out in the review of patch 4.

Yes, I think these are good points.  QOM does involve a lot of
boilerplate for defining objects.

> >> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *al=
loc)
> >=20
> > It's not clear to me what the purpose of this function is - at least the
> > name is a bit cryptic since it seems more like an initialization
> > function than 'setting pc' on QPCIBusPC.  How about inlining this in
> > qpci_init_pc() instead of keeping a separate function?
>=20
> I agree about the naming.  Perhaps we can rename the existing
> qpci_init_pc to qpci_pc_new, and qpci_set_pc to qpci_pc_init.
>=20
> Would you prefer if the split was done in the patch that introduces the
> user for qpci_set_pc (patch 5)?  We did it here because this patch
> prepares qpci-pc

Either way is fine.  I suggested inlining mainly because it avoids the
need to pick a good name :).

Stefan

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT07HAAoJEJykq7OBq3PIQHgH/3O9jSBbS3kA1alEKoBLc4bd
QoBTlVLKSC+3dSmt5u9lkCbfuArv1Mwp6o2pTBJydCtQlJ+hUj2Z2X9eWhvWHv8e
HpuS4UXirExNtDKUdngCEV186tZ5GJP3YB3npHp+SJyQB6/Y8gnKlsipPiRiVtj8
aJ8OXTHD3PjIv+xMZiPbGTH1LbWR0fMu/ksYM2s1+3ixbP3KRSY1L9IM8DzhnPG2
FdqRuGJSipYeqaWn8ErBPuOFPJEsXwkeW11yDXGxXnYJTm+gRD59U90opc/l9jYc
uvxZWdzV9I4RBdJrH53O7oTcIOtp3jr/tW3zhjfE1/TRjQKIgzXwretAqumd8Hk=
=r4xI
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--
