Received: from eggs.gnu.org ([209.51.188.92]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJHnF-0002FV-ET
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJHhG-0007aA-2c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:12:23 -0400
Date: Wed, 24 Apr 2019 14:12:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424131210.GK31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
	<20190424112537.GF31388@redhat.com>
	<c2202c0c-e504-7678-d1f3-6afc67bd2164@redhat.com>
	<20190424125046.GJ31388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424125046.GJ31388@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On Wed, Apr 24, 2019 at 01:50:46PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 02:37:02PM +0200, Thomas Huth wrote:
> > On 24/04/2019 13.25, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
> > >> Tests in this group are supposed to run in every possible QEMU con=
figuration.
> > >> That means they should run with every QEMU binary (also non-x86), =
without
> > >> dependencies on an optional features, they must work at least with=
 the qcow2
> > >> image format and be able to run on all kind of host filesystems an=
d users
> > >> (i.e. also as "nobody" or "root").
> > >>
> > >> The initial list has been created as a subset of the "quick" group=
, where
> > >> I've disabled all tests that are failing with qemu-system-aarch64 =
or
> > >> qemu-system-tricore or in one of our CI pipelines.
> > >>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >> ---
> > >>  tests/qemu-iotests/group | 194 ++++++++++++++++++++--------------=
-----
> > >>  1 file changed, 102 insertions(+), 92 deletions(-)
> > >>
> > >> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> > >> index bae7718380..2ed42dcc14 100644
> > >> --- a/tests/qemu-iotests/group
> > >> +++ b/tests/qemu-iotests/group
> > >> @@ -4,63 +4,73 @@
> > >>  # - do not start group names with a digit
> > >>  #
> > >> =20
> > >> +#
> > >> +# Some notes about the groups:
> > >> +# - Tests in the "quick" group should finish within some few seco=
nds
> > >> +# - Tests in the "ci" group are suitable for running in CI system=
s. That
> > >> +#   means they should run with every QEMU binary (also non-x86), =
with
> > >> +#   every QEMU configuration (i.e. no dependency on an optional f=
eature),
> > >> +#   at least with the qcow2 image format and all kind of host fil=
esystems
> > >> +#   and users (i.e. also as "nobody" or "root").
> > >=20
> > > No dependancy on optional features feels a bit restrictive from my =
POV.
> > >=20
> > > We have quite alot of testing coverage of stuff that depends on the
> > > crypto libraries that is important for us to run in "CI". This incl=
udes
> > > LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I ex=
pect
> > > all of those to be tested by CI systems.
> > >=20
> > > IOW for a "CI" group, the bar should be higher than "no optional fe=
atures"
> >=20
> > Ok, I think I just did not write it properly. What I meant was: the t=
est
> > should not *fail* because of a missing feature (what some tests are
> > unfortunately doing). It's fine if the test detects the missing featu=
re
> > and then marks the test as *skip*.
>=20
> Ok, this brings back the topic I don't think we ever resolved around ho=
w
> to best "detect" features in the iotests. eg if we want to know whether
> we can use TLS features, how do we decide this ?
>=20
> One option is to do a dummy launch of QEMU using TLS & check if it fail=
s,
> but that's kind of fragile for CI. A genuine bug in QEMU might cause th=
is
> dummy launch to fail, and thus mistakenly skip all the tests instead of
> failing.
>=20
> We can't look at config-host.{h,mak} either as iotests are supposed to =
be
> runnable outside of a build tree.
>=20
> We could look at whether gnutls is linked to QEMU but again that is goi=
ng
> to be fragile if a bug in configure causes us to mistakenly stop enabli=
ng
> gnutls.
>=20
> For developers, dynamically probing features & skipping is reasonable.
>=20
> For automated CI, I think we should set clear desired featureset upfron=
t
> based on what we know we are supposde to have available and not silentl=
y
> skip tests

I guess I should say "perfect is the enemy of good". What you propose
with "make check" is clearly better than what we have today which is
nothing by default.  So my point about defined featureset for running
under CI shouldn't be a blocker of the "make check" improvement.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
