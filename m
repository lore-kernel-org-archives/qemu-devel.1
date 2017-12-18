Received: from eggs.gnu.org ([2001:4830:134:3::10]:51647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvws-0003Js-5J
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvwr-0000fU-1k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:59:18 -0500
Date: Mon, 18 Dec 2017 13:59:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218135904.GF16653@stefanha-x1.localdomain>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<CAMr-obtBNF8eetFgz=s8vJGqnzGa8+9n4VnF40vZYy5yeFZ3wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <CAMr-obtBNF8eetFgz=s8vJGqnzGa8+9n4VnF40vZYy5yeFZ3wQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 03:35:07PM +0000, Nir Soffer wrote:
> On Thu, Dec 14, 2017 at 11:39 AM Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
>=20
> > On Wed, Dec 13, 2017 at 06:35:51PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> > > Hi,
> > >
> > > With this series we can now write tests using Python rather than C.
> > > For complex tests this can reduce the test development time, we can
> > focus on
> > > the test purposes instead of his implementation details.
> > >
> > > - 1,2: we already have Python classes to run Block tests, move all the
> > >   non Block-related methods to qtest.py,
> > > - 3: default TEST_DIR to TMPDIR,
> > > - 4: add a method to restrict tests to a list of supported machines,
> > > - 5: since the Block tests are output sensitive, do not mess with the=
ir
> > >   current tuned iotests::main(unittest), add a more generic one in
> > qtest.py,
> > > - 6: finally modify the tests Makefile to run C/Python tests with the
> > same
> > >   rule.
> >
> > Python tests are great for functional tests of qemu-system-* that
> > interact via the command-line and QMP monitor.  From this perspective I
> > think the series is good.
> >
> > > to have a better idea, here is a snippet from the next series:
> > >
> > >     class TestSdCardSpecV2(qtest.QMPTestCase):
> > >         [...]
> > >         def test_power_on_spec_v2(self):
> > >             self.bus.do_cmd(GO_IDLE_STATE)
> > >             [...]
> > >             # verify Card ID
> > >             data =3D self.bus.do_cmd(ALL_SEND_CID)
> > >             oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
> > >             self.assertEqual(oid, "XY") # QEMU default
> > >             self.assertEqual(pnm, "QEMU!") # QEMU default
> > >             self.assertEqual(psn, 0xdeadbeef) # QEMU default
> >
> > Device qtests are better done in C than Python.  Python is not good at
> > binary I/O
>=20
>=20
> Why do you think that? what is missing in python 2 for binary io?

C code can reuse existing header files for struct definitions instead
of doing oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data).

In general, Python's model for binary data is a marshalling (copy) model
rather than a type casting (in-place access) model.  It's fine for some
things but programs that deal with a lot of raw data may use third-party
unboxed data primitives like numpy's instead.  I definitely wouldn't say
that binary I/O is a strength of Python.

> > and porting this to Python 3 will be extra work later (Python
> > 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
> >
>=20
> You can write today code that work with both python 2 and 3. For binary
> io the key is using io.FileIO and io.BytesIO instead of open() and String=
IO
> and CStringIO.

Yes, it's possible to write the code carefully and test under both
Python 2 & 3.  We have to do that for Python code in QEMU since the
world is currently transitioning and both Python versions are in use.

So in this case, where it's questionable to start a new device-level
testing framework in the first place, the extra trouble of dealing with
Python 2 & 3 makes it even less appealing.

Stefan

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8moAAoJEJykq7OBq3PICoAH/1yZWlmT/5yaj8UymP95XbVB
YKgmWYd+wrt3qc+e0/Dr94/n18B8QefyLOUsKZ74A5Y+t8jdVaczcf5vRuL8/oSL
IceR4UtKMoypmLDfnG3kbSipFT8L7B9PRBnfBqx2frd7cw8FLrgasn2uCHM4+/eM
k7FICpw7fPg1YDDwPaeKAoF4GSoBFIXCHuuyldk2gZZ5God/Vr4hlyMW27dlrH9G
PHE16ra2ZWNmG3NbYW2H2t89MwxoBiPt8Hr5GxA2rSPQN7h0KuVNHMD4F4G0WWD7
nQGtXlczqb8mE7Pflvxkti2ji7Ao+58vnrWrtYi5gTnu9bHhHbY8nQA2L5GssZI=
=Ozo4
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
