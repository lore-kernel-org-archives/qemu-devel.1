Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3s2-0002Os-3c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3s0-0001An-Fd
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:44:26 -0400
Date: Tue, 8 Aug 2017 13:44:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808124410.GN16801@stefanha-x1.localdomain>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
	<20170726175808.GD3600@stefanha-x1.localdomain>
	<ecbf4c6b-64e0-7878-380a-262753068cb0@redhat.com>
	<20170727134101.GG10129@stefanha-x1.localdomain>
	<87mv7a4h77.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIlomvtVtXAVxSKT"
Content-Disposition: inline
In-Reply-To: <87mv7a4h77.fsf@dusky.pond.sub.org>
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
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>


--oIlomvtVtXAVxSKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 10:06:04AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Wed, Jul 26, 2017 at 02:24:02PM -0400, Cleber Rosa wrote:
> >>=20
> >>=20
> >> On 07/26/2017 01:58 PM, Stefan Hajnoczi wrote:
> >> > On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
> >> >> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
> >> >>> On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
> >> >>>> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> >> >>>>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
> >> >>>>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> >> >>>> Without the static capabilities defined, the dynamic check would =
be
> >> >>>> influenced by the run time environment.  It would really mean "qe=
mu-io
> >> >>>> running on this environment (filesystem?) can do native aio".  Ag=
ain,
> >> >>>> that's not the best type of information to depend on when writing=
 tests.
> >> >>>
> >> >>> Can you explain this more?
> >> >>>
> >> >>> It seems logical to me that if qemu-io in this environment cannot =
do
> >> >>> aio=3Dnative then we must skip those tests.
> >> >>>
> >> >>> Stefan
> >> >>>
> >> >>
> >> >> OK, let's abstract a bit more.  Let's take this part of your statem=
ent:
> >> >>
> >> >>  "if qemu-io in this environment cannot do aio=3Dnative"
> >> >>
> >> >> Let's call that a feature check.  Depending on how the *feature che=
ck*
> >> >> is written, a negative result may hide a test failure, because it w=
ould
> >> >> now be skipped.
> >> >=20
> >> > You are saying a pass->skip transition can hide a failure but ./check
> >> > tracks skipped tests.  See tests/qemu-iotests/check.log for a
> >> > pass/fail/skip history.
> >> >=20
> >>=20
> >> You're not focusing on the problem here.  The problem is that a test
> >> that *was not* supposed to be skipped, would be skipped.
> >
> > As Daniel Berrange mentioned, ./configure has the same problem.  You
> > cannot just run it blindly because it silently disables features.
> >
> > What I'm saying is that in addition to watching ./configure closely, you
> > also need to look at the skipped tests that ./check reports.  If you do
> > that then you can be sure the expected set of tests is passing.
> >
> >> > It is the job of the CI system to flag up pass/fail/skip transitions.
> >> > You're no worse off using feature tests.
> >> >=20
> >> > Stefan
> >> >=20
> >>=20
> >> What I'm trying to help us achieve here is a reliable and predictable
> >> way for the same test job execution to be comparable across
> >> environments.  From the individual developer workstation, CI, QA etc.
> >
> > 1. Use ./configure --enable-foo options for all desired features.
> > 2. Run the ./check command-line and there should be no unexpected skips
> >    like this:
> >
> > 087         [not run] missing aio=3Dnative support
> >
> > To me this seems to address the problem.
> >
> > I have mentioned the issues with the build flags solution: it creates a
> > dependency on the build environment and forces test feature checks to
> > duplicate build dependency logic.  This is why I think feature tests are
> > a cleaner solution.
>=20
> I suspect the actual problem here is that the qemu-iotests harness is
> not integrated in the build process.  For other tests, we specify the
> tests to run in a Makefile, and use the same configuration mechanism as
> for building stuff conditionally.

The ability to run tests against QEMU binaries without a build
environment is useful though.  It would still be possible to symlink to
external binaries but then the build feature information could be
incorrect.

Stefan

--oIlomvtVtXAVxSKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZibIaAAoJEJykq7OBq3PIE8UH/0b33zQWvf2y9VQkXqe0YGeb
1bhEp1KBh0VakhNJBxZ3t85H+StQlZkff95Rz4t0KcJdzo4yM4zSqoNglmH8qz4v
Q1tIctC9p7ufnL18vJ2TLjbn17Y473W3urWbHkEltDqlMlMEYQ67iEppnob8LeaE
iNsr/ckRm7+IgGrtNJsqHgvTjvaWBySQ9XXBcE6UvHI3sIexXxqyM2o+BsJRb+wY
eZtv6efBfwe2IOhCQ5bV15c7IBL0BImLTj9/bAQwaFJAtNjG8qyIaf0C1eRfUrnQ
e3eRpe6jl9zP+6krWOwdUGCJENDUyuQfhpis/INx0OedyAc20udMN8WnPm4SbGY=
=O3W5
-----END PGP SIGNATURE-----

--oIlomvtVtXAVxSKT--
