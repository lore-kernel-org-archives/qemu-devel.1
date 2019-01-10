Received: from eggs.gnu.org ([209.51.188.92]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghgFJ-0001L4-4z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghgFH-0004HV-0b
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:44:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghgFE-0004FL-UF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:44:01 -0500
Date: Thu, 10 Jan 2019 17:43:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190110194354.GK4500@habkost.net>
References: <20190103150951.17592-1-philmd@redhat.com>
	<20190103150951.17592-3-philmd@redhat.com>
	<87woncv5si.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87woncv5si.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: Disable qht-bench parallel
 test when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On Thu, Jan 10, 2019 at 04:25:17PM +0000, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > This test is failing on the Travis CI [*] since some time now,
> > disable it until it get fixed.
> >
> > [*] https://travis-ci.org/qemu/qemu/builds/474821674
> >
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > v2: Use CONFIG_GPROF via config_host_mak (check-unit isn't target)
> > ---
> >  configure              | 1 +
> >  tests/Makefile.include | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index fa5c079f98..69a125814d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7470,6 +7470,7 @@ alpha)
> >  esac
> >
> >  if test "$gprof" =3D "yes" ; then
> > +  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
> >    echo "TARGET_GPROF=3Dy" >> $config_target_mak
> >    if test "$target_linux_user" =3D "yes" ; then
> >      cflags=3D"-p $cflags"
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 3f5a1d0c30..b8f91fdd97 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
> >  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
> >  check-unit-y +=3D tests/test-qdist$(EXESUF)
> >  check-unit-y +=3D tests/test-qht$(EXESUF)
> > -check-unit-y +=3D tests/test-qht-par$(EXESUF)
> > +# FIXME: {test-qht-par + gprof} often break on Travis CI
> > +check-unit-$(call lnot,$(CONFIG_GPROF)) +=3D
> >  tests/test-qht-par$(EXESUF)
>=20
> I got confused between test-qht-par and qht-bench. However we already
> have this in the test case:
>=20
>     if (g_test_quick()) {
>         g_test_add_func("/qht/parallel/2threads-0%updates-1s", test_2th=
0u1s);
>         g_test_add_func("/qht/parallel/2threads-20%updates-1s", test_2t=
h20u1s);
>     } else {
>         g_test_add_func("/qht/parallel/2threads-0%updates-5s", test_2th=
0u5s);
>         g_test_add_func("/qht/parallel/2threads-20%updates-5s", test_2t=
h20u5s);
>     }
>=20
> So maybe we should be asking why it isn't limiting itself to 1s?

We are, but we have no idea why it's happening.  This patch is a
workaround until we find the root cause of the problem.

If nobody objects, I will merge it through my tree.

--=20
Eduardo
