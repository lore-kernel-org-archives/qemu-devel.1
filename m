Received: from eggs.gnu.org ([2001:4830:134:3::10]:52776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfOGc-00060z-2h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfOGa-0002Dv-FX
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:31:10 -0400
Date: Wed, 9 Aug 2017 11:30:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809103058.GI18003@stefanha-x1.localdomain>
References: <20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
	<20170726175808.GD3600@stefanha-x1.localdomain>
	<ecbf4c6b-64e0-7878-380a-262753068cb0@redhat.com>
	<20170727134101.GG10129@stefanha-x1.localdomain>
	<87mv7a4h77.fsf@dusky.pond.sub.org>
	<20170808124410.GN16801@stefanha-x1.localdomain>
	<877eye9knq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <877eye9knq.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 04:52:25PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Tue, Aug 08, 2017 at 10:06:04AM +0200, Markus Armbruster wrote:
> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> >>=20
> >> > On Wed, Jul 26, 2017 at 02:24:02PM -0400, Cleber Rosa wrote:
> >> >>=20
> >> >>=20
> >> >> On 07/26/2017 01:58 PM, Stefan Hajnoczi wrote:
> >> >> > On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
> >> >> >> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
> >> >> >>> On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
> >> >> >>>> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> >> >> >>>>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wro=
te:
> >> >> >>>>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> >> >> >>>> Without the static capabilities defined, the dynamic check wou=
ld be
> >> >> >>>> influenced by the run time environment.  It would really mean =
"qemu-io
> >> >> >>>> running on this environment (filesystem?) can do native aio". =
 Again,
> >> >> >>>> that's not the best type of information to depend on when writ=
ing tests.
> >> >> >>>
> >> >> >>> Can you explain this more?
> >> >> >>>
> >> >> >>> It seems logical to me that if qemu-io in this environment cann=
ot do
> >> >> >>> aio=3Dnative then we must skip those tests.
> >> >> >>>
> >> >> >>> Stefan
> >> >> >>>
> >> >> >>
> >> >> >> OK, let's abstract a bit more.  Let's take this part of your sta=
tement:
> >> >> >>
> >> >> >>  "if qemu-io in this environment cannot do aio=3Dnative"
> >> >> >>
> >> >> >> Let's call that a feature check.  Depending on how the *feature =
check*
> >> >> >> is written, a negative result may hide a test failure, because i=
t would
> >> >> >> now be skipped.
> >> >> >=20
> >> >> > You are saying a pass->skip transition can hide a failure but ./c=
heck
> >> >> > tracks skipped tests.  See tests/qemu-iotests/check.log for a
> >> >> > pass/fail/skip history.
> >> >> >=20
> >> >>=20
> >> >> You're not focusing on the problem here.  The problem is that a test
> >> >> that *was not* supposed to be skipped, would be skipped.
> >> >
> >> > As Daniel Berrange mentioned, ./configure has the same problem.  You
> >> > cannot just run it blindly because it silently disables features.
> >> >
> >> > What I'm saying is that in addition to watching ./configure closely,=
 you
> >> > also need to look at the skipped tests that ./check reports.  If you=
 do
> >> > that then you can be sure the expected set of tests is passing.
> >> >
> >> >> > It is the job of the CI system to flag up pass/fail/skip transiti=
ons.
> >> >> > You're no worse off using feature tests.
> >> >> >=20
> >> >> > Stefan
> >> >> >=20
> >> >>=20
> >> >> What I'm trying to help us achieve here is a reliable and predictab=
le
> >> >> way for the same test job execution to be comparable across
> >> >> environments.  From the individual developer workstation, CI, QA et=
c.
> >> >
> >> > 1. Use ./configure --enable-foo options for all desired features.
> >> > 2. Run the ./check command-line and there should be no unexpected sk=
ips
> >> >    like this:
> >> >
> >> > 087         [not run] missing aio=3Dnative support
> >> >
> >> > To me this seems to address the problem.
> >> >
> >> > I have mentioned the issues with the build flags solution: it create=
s a
> >> > dependency on the build environment and forces test feature checks to
> >> > duplicate build dependency logic.  This is why I think feature tests=
 are
> >> > a cleaner solution.
> >>=20
> >> I suspect the actual problem here is that the qemu-iotests harness is
> >> not integrated in the build process.  For other tests, we specify the
> >> tests to run in a Makefile, and use the same configuration mechanism as
> >> for building stuff conditionally.
> >
> > The ability to run tests against QEMU binaries without a build
> > environment is useful though.  It would still be possible to symlink to
> > external binaries but then the build feature information could be
> > incorrect.
>=20
> I don't dispute it's useful.  "make check" doesn't do it, though.
>=20
> I think we can either have a standalone test suite (introspects the
> binaries under test to figure out what to test), or an integrated test
> suite (tests exactly what is configured).  "make check" is the latter.
> qemu-iotests is kind-of-sort-of the former.

Yes, originally qemu-iotests was a separate repo.  It was moved into
qemu.git so that it's easier to include tests in a patch series.  But as
a result of this history it has the ability to run against any QEMU.

Actually I'm not sure how important that ability is anymore.  Some
testing teams use qemu-iotests against QEMU binaries from elsewhere, so
we'd inconvenience them by tying it to a build.  But they could update
their process to get the QEMU tree that matches their binaries, if
necessary.

Stefan

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiuRiAAoJEJykq7OBq3PIY1gH/0GMKAilBpe4BAtbzfmUviGt
m+Bd2lEjnX2IBzlBZPh4SrTBVM7S03y6aN5TZqLIBv9JkVBNIqlcpdepGP2RrbTR
fr0H5d7bdZvN1T2EItBguxozYLAexvPLXXV6X5oyQTw+URnJ0UdIJR/OS6JnCIWq
KzXuPlFX281Vo6B0IfHZxopn74BrMTuyMDkk7V1v0ja7h2FfN5XvxM5Jol81ZeFI
o+XTrGbArH2+x425S5YTnEMQ3zOKwVGP9UJKALwq/EcnbugxzXnaVtKghwCqipeR
E6UlnMcTqX47xVGCBXpdxTu03m/dg1gSLJoDufvu8GRam5EXFzg4T5xioIUkQO0=
=YtL6
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
