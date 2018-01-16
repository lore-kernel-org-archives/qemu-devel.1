Received: from eggs.gnu.org ([2001:4830:134:3::10]:33331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebXa5-0001x8-8R
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebXa4-0001Sz-8i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:11:37 -0500
Date: Tue, 16 Jan 2018 21:11:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180116201127.GC5719@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
	<9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.01.2018 um 19:59 hat Eric Blake geschrieben:
> On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1749376c61..9341f6708d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3320,6 +3320,37 @@
> >  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> > =20
> >  ##
> > +# @BlockdevQcow2CompatLevel:
> > +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (vers=
ion 2)
> > +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (versi=
on 3)
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'enum': 'BlockdevQcow2CompatLevel',
> > +  'data': [ '0_10', '1_1' ] }
>=20
> Enums are allowed to start with digits while struct members are not; so
> you can get away with this naming.  Do we really want the names 0_10 and
> 1_1, or are there better names we could come up with (it already
> undergoes translation such that qemu-img reports 0.10 rather than 0_10).

Yeah, I don't like 0_10/1_1 much.

Either we allow dots in enum values so that we can keep 0.10/1.1, or
something completely different. I was considering 'version': 'int' with
2 and 3 as possible values, after all QMP is already rather low-level.

The question is just what to do with the command line. Will we deprecate
compat=3D0.10/1.1 there, too, and tell users to switch to whatever new
syntax we invent for QMP? Or are we planning to keep the "translation"
=66rom the old syntax forever?

query-block cheated and just exposed it as a string.

> > +
> > +
> > +##
> > +# @BlockdevCreateOptionsQcow2:
> > +#
> > +# Driver specific image creation options for qcow2.
> > +#
> > +# TODO Describe fields
>=20
> Hence this being RFC :)
>=20
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'struct': 'BlockdevCreateOptionsQcow2',
> > +  'data': { 'size':             'size',
>=20
> Is size mandatory even when we have a backing file specification?  It is
> not mandatory for qemu-img create; but on the other hand, I think I can
> live with requiring the QMP caller to supply a size.

The qemu-img create implementation of this is common code at least, but
we're in driver-specific definitions here, so every driver would have to
call some function to guess the size given a backing file string. With
the straightforward implementation of this series, it is really
mandatory because otherwise you'd get zero-sized images.

Accessing the backing file during image creation is also one of those
things that tend to cause surprises, so if we don't have to, I wouldn't
do that.

> > +            '*compat':          'BlockdevQcow2CompatLevel',
> > +            '*backing-file':    'str',
>=20
> Given Dan's comments, perhaps name this one 'backing-str' to make it
> obvious that it is the string written into the qcow2 header, rather than
> the node we open as backing?

If you guys think that this is clearer, I can change it.

> Or, maybe we support an optional '*backing-node' that can be used for
> allowing a default size and backing string if not explicitly
> overridden?

Hm, it would make the interface a bit more complex. I'd try whether we
can do without it.

Kevin

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaXlxvAAoJEH8JsnLIjy/WBNIP/R6zyNw1h26RMSl4lr9qkLDc
ldSKk7+cJvRvYPJW1B00sPRjZMgSjcHR+cd/mgU24cSAtQgLo0D1R3pJxaQ6CKkU
IZ2/BTNZbNS/AdpiQlDFrXCNZvE/64FgbvIIkLMRJYabyDGm5sMMMztg8apISUNy
KDxTtbwe+cvN57kRNk9jWUHAVjD8OZCHp6FmU3V8pf1mO6tqnNsJDizr2FpOalI4
Q7qvxC8wXPrJdav1pNO7AxFvNhrj0btCBLN5PMCmbhP+w84RFtpZWb70PGF7HGav
in/bIr93XpsLuy2Scpc+z5qeayoNaYUuZ5UPT6PwPEJ1jmbbPbqQZKgXxHZLdA4R
0hQ2G2IFG9ROYzQklVOmZp2lGiFsOB+hoYYUOMN7kLs0+pNNmKKTnB2bxiptxWmR
UPabZIvPvFr4Y0wCNsrXYoH87gyZSmYtTkCu72TwNDcx9vd6B4JbVY6MtuEBQPPE
VtDseI0ZL9kz0tmOPP12IW6e3W5Za8TJ/bzCMzmkei0InxiMQBDrkvKVMWW5JDwU
2pTDrzfwlwJTdU0IAyqrSC+xJW1Em7M5MFJVV3lDx9Qj7FkrFkEFJVfq5sAlyIV+
Ula19wDFicAdDjGFRATWoBMn718o/BtoJl1jJ5rtjWKShDimkp6YGqJBP+YRIFQu
suujqO4FEMJ0DoBkELC+
=rR02
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
