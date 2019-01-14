Received: from eggs.gnu.org ([209.51.188.92]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3uR-00009c-Gf
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3uL-0001zc-4g
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:12:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gj3uK-0001zL-VI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:12:09 -0500
Date: Mon, 14 Jan 2019 15:12:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190114151201.GM3686@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <87lg3rui28.fsf@linaro.org>
 <20190114150206.GA11818@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114150206.GA11818@flamenco>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Remaining CI failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Jan 14, 2019 at 10:02:06AM -0500, Emilio G. Cota wrote:
> On Fri, Jan 11, 2019 at 19:10:07 +0000, Alex Benn=C3=A9e wrote:
> > So trying to narrow down the remaining failures in the CI system. The=
re
> > is one with a patch in flight (use g_usleep instead of sleep) but the=
re
> > remains two failure modes, both erratic.
> >=20
> > tests/qht-par:
> >=20
> > I can trigger this on my dev machine with a gprof enabled build:
> >=20
> >   # QEMU configure log Fri Jan 11 14:10:45 GMT 2019
> >   # Configured with: './configure' '--disable-tools' '--disable-docs'=
 '--enable-gprof' '--enable-gcov'
> >=20
> > I only seem to be able to trigger it when running via the wrapper in =
the
> > make system:
> >=20
> >   retry.py -n 30 --invert make check-tests/test-qht-par
> >=20
> > Eventually this crashes with:
> >=20
> >   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D=
 0): (35584 =3D=3D 0)
> >=20
> > Leaving a core dump for the child:
>=20
> I can't replicate this on my machine :-(
>=20
> I suspect this is probably related to the fact that gprof
> is not even meant to support multi-threaded programs (like qht-bench).
>=20
> Given that we've fixed the sleep issue (thanks!) and that there is no u=
se
> in running test-qht-par under gprof, I propose to permanently skip
> it under gprof, e.g.:
>=20
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
>  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
>  check-unit-y +=3D tests/test-qdist$(EXESUF)
>  check-unit-y +=3D tests/test-qht$(EXESUF)
> -# FIXME: {test-qht-par + gprof} often break on Travis CI
> +# test-qht-par invokes qht-bench, which is multi-threaded.
> +# gprof doesn't support multi-threaded programs, so skip this test und=
er gprof.

If gprof doesn't support threads, then we potentially need to skip more
of our tests. eg test-io-channel-socket uses APIs that spawn threads
behind the scenes, not to mention the test-thread-pool test. Some
chardev tests probably hit APIs that spawn background threads too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
