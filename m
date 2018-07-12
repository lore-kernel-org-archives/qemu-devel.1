Received: from eggs.gnu.org ([2001:4830:134:3::10]:37374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fdVaw-0006f1-7X
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fdVaq-000410-9y
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:00:54 -0400
Date: Thu, 12 Jul 2018 09:00:32 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180712070032.GW1148@andariel.pipo.sk>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143807.GJ5852@localhost.localdomain>
	<871sc9gdr2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2DJuma0xDHN2clgl"
Content-Disposition: inline
In-Reply-To: <871sc9gdr2.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>


--2DJuma0xDHN2clgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 08:38:25 +0200, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Am 10.07.2018 um 16:22 hat Cornelia Huck geschrieben:
> >> On Tue, 10 Jul 2018 07:59:15 +0200
> >> Markus Armbruster <armbru@redhat.com> wrote:
> >> Would that be workable?
> >
> > I think the function should just take a message:
> >
> >     /* Works like error_report(), except for the WARNING/ERROR prefix
> >      * and exit(1) if -no-deprecated-options is set */
> >     void deprecation_report(const char *fmt, ...);
>=20
> I like it.  The contract could use a bit of polish, but that's detail.
>=20
> > We don't necessarily deprecate only options, but we might also deprecate
> > monitor commands, specific options values (while keeping other values of
> > the same option) etc.
>=20
> Exactly.

For monitor commands we luckily have QMP introspection which can help a
lot in this case. At least for deprecating stuff that is expressable by
the schema.

In libvirt we are actually doing schema validation of the blockdev-add
arguments generators and most commands which are covered by the
qemumonitorjsontest. The schema used is based on our capability
detection so it's gathered from the most-recent version of qemu we have
required for our tests (which is most of the time based on GIT version
of qemu if there are any significant new features).

If the deprecation will be expressable by the schema it should be rather
simple to modify the schema validator to catch the deprecation flags and
report errors in our testsuite.

CI-ifying of the above should be then also very simple. We'd just gather
fresh QMP schema rather than using one from our test case pantry.

Some time ago I also added testing of the commandline generator in
libvirt with the most recent capabilities rather than using the
historically declared capabilities that we've added when the test was
created. This means that we actually test some valid combinations and
also if stuff covered by our capability probing is removed the tests
will catch it.

I was also thinking of adding a tool which would use the above tests to
attempt starting of a qemu process until the monitor shows up. That test
then could also use -no-deprecated-options. I'm hoping waiting for the
monitor is sufficient to excercise most of the code which could contain
deprecation warnings. (Alternatively we can go through the
pre-cpu-startup setup done on the monitor as well). Unfortunately doing
this will not be as simple asi the test cases contain random disk paths
and other resources which may not be available. This means that it will
require some in-place modification and creative temporary resource
usage.

--2DJuma0xDHN2clgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAltG/I0ACgkQHGwCByjY
1GrG8BAAl5DTfKGYWxh3wk90xy5X/hC9JuqclDatEQJVa6SMRzAP8qWRbbMvsaPK
jNPQuK+a4zAz1PybSlqucaUQH0GlNjNxDH0OXiggZCYKZ+dibY+yySa0kzEIkug/
rjRHOGi9Z7Z/YBNZ0lWx+V+rCNT3vmDIr4GYNq0VZf9Kpzqx+t2/pDLv8d2nIrL/
syUadUQwN1HrU5/Zksr9OIRjV/1Pmw9uvn87x0v83XH4Rwaa0mKAESSlfbl00OrH
PUTuVqLvk59oIOMT0neGj+Ht7dnxqI3RpR0FI0nMIRaNXMaS/bEKLJuQUkhreTBu
xjUSinlXRrf4b8GhWCU+YmsXYKLcPc7zF+t4tPq2tJ0XAPaiRTvZ3WFjE25tBQvd
BpVA1TBc4EpdPgMNFiTIXEcrUnX3oJk6nFgXnUDgtopL+T7Qa5ue3xjPJawIONbW
H1D3UQH/mT3/4m8mIyFVptpYI/Veny69ae2uW4VEFpowH2FVBveQN95QEQJrBfjH
c4OiOFXS+MtfviXl4C2QsPLUo69aTBhR64T8iBGfH482iB291TVgrzQZFC0o2Da1
QQ2OWD8L80UdD0Y5vaEx/lF66NJjOojQIHTTXoJy7QFJONh98rDuZxQAOsZTO73c
vzqJPp7u/ZgPVsu89KA+coqYocBEG1S0USSnCnRPSlJqH4XhR6s=
=THpf
-----END PGP SIGNATURE-----

--2DJuma0xDHN2clgl--
