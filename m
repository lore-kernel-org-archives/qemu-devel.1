Received: from eggs.gnu.org ([209.51.188.92]:41440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJH5r-0001ji-Ad
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJGrh-0001dO-EO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:19:06 -0400
Date: Wed, 24 Apr 2019 13:13:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424121339.GG31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<20190424104855.GE31388@redhat.com>
	<d9137693-7727-5f2c-04f3-b1eafd70f056@redhat.com>
	<f8040ada-cb84-d669-3493-0d2da89e6b0b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8040ada-cb84-d669-3493-0d2da89e6b0b@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On Wed, Apr 24, 2019 at 12:02:29PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> 24.04.2019 13:59, Thomas Huth wrote:
> > On 24/04/2019 12.48, Daniel P. Berrang=C3=A9 wrote:
> >> On Wed, Apr 24, 2019 at 12:37:46PM +0200, Thomas Huth wrote:
> >>> People often forget to run the iotests before submitting patches or
> >>> pull requests - this is likely due to the fact that we do not run t=
he
> >>> tests during our mandatory "make check" tests yet. Now that we've g=
ot
> >>> a new "ci" group of iotests that should be fine to run in every env=
iron-
> >>> ment, it should be OK to enable the iotests during "make check" aga=
in.
> >>> Thus we now run the "ci" tests by default from the qemu-iotests-qui=
ck.sh
> >>> script, and only use the former "quick" group (that contains some t=
ests
> >>> that are failing in some environments) when the user decided to run
> >>> "make check SPEED=3Dthorough" or something similar.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>   tests/Makefile.include      |  2 +-
> >>>   tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
> >>>   2 files changed, 17 insertions(+), 2 deletions(-)
> >>
> >>> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick=
.sh
> >>> index 0e554bb972..416b3fc48b 100755
> >>> --- a/tests/qemu-iotests-quick.sh
> >>> +++ b/tests/qemu-iotests-quick.sh
> >>
> >> s/-quick//  perhaps, since it no longer only runs the "quick" tests.
> >>
> >>> @@ -1,8 +1,23 @@
> >>>   #!/bin/sh
> >>>  =20
> >>> +# Honor the SPEED environment variable, just like we do it for the=
 qtests.
> >>> +# The default is to run all tests that still work fine in a CI env=
ironments,
> >>> +# but if the user set SPEED=3Dslow or SPEED=3Dthorough, we also ru=
n all other
> >>> +# tests that are still marked as "quick"
> >>> +if [ "$SPEED" =3D "slow" -o "$SPEED" =3D "thorough" ]; then
> >>> +    group=3Dquick
> >>
> >> When user asks for "slow" tests we run the "quick" tests, which
> >> presumably implies...
> >>
> >>> +else
> >>> +    group=3Dci
> >>
> >> ..."ci" is quicker than the "quick"  tests !
> >>
> >> Confused ? We certainly try to ensure that you will be :-)
> >=20
> > ... and there is also tests/check-block.sh (which is not used by "mak=
e
> > check-block", by the way, but still talks about "make check-block"),
> > which is even slower than the "ci" and "quick" group...
> >=20
> > I guess that could be cleaned up, too (why do we need two scripts?) .=
..
> > just not sure how the final result should look like and if it should =
be
> > part of this patch series or rather something separate. Max, Kevin, w=
hat
> > do you think?
> >=20
> > Maybe we should merge the two scripts, and depending on the SPEED
> > variable, we run:
> >=20
> >   quick =3D> "ci" group
> >   thorough =3D> "quick" group
> >   slow =3D> old behaviour of the check-block.sh script
>=20
> May be, instead of SPEED, introduce GROUP variable? To make it plain

"$SPEED" is something used/defined by the gtester harness, so other bits
run by "make check" already honour that, hence it is desirable fro the
iotests todo the same.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
