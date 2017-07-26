Received: from eggs.gnu.org ([2001:4830:134:3::10]:37424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKSh-0006KL-Di
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKSb-0002C1-Bu
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1daKSb-0002Ah-2L
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:26:37 -0400
Date: Wed, 26 Jul 2017 12:26:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726112633.GE18489@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 02:30:06PM +0100, Peter Maydell wrote:
> On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Instead I suggest adding a trace backend generates calls to registered
> > "callback" functions:
> >
> >   $ cat >my-instrumentation.c
> >   #include "trace/control.h"
> >
> >   static void my_cpu_in(unsigned int addr, char size, unsigned int val)
> >   {
> >       printf("my_cpu_in\n");
> >   }
> >
> >   static void my_init(void)
> >   {
> >       trace_register_event_callback("cpu_in", my_cpu_in);
> >       trace_enable_events("cpu_in");
> >   }
> >   trace_init(my_init);
> >
> >   $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
> >
> > This is still a clean interface that allows instrumentation code to be
> > kept separate from the trace event call sites.
> >
> > The instrumentation code gets compiled into QEMU, but that shouldn't be
> > a huge burden since QEMU's Makefiles only recompile changed source
> > files (only the first build is slow).
>=20
> Is your proposal that my-instrumentation.c gets compiled into
> QEMU at this point? That doesn't seem like a great idea to
> me, because it means you can only use this tracing if you
> build QEMU yourself, and distros won't enable it and so
> lots of our users won't have convenient access to it.
> I'd much rather see a cleanly designed plugin interface
> (which we should be able to implement in a manner that doesn't
> let the plugin monkey patch arbitrary parts of QEMU beyond
> what can already be achieved via LD_PRELOAD).

Trace events are not a stable public API.  They change between releases
and need to be interpreted together with the QEMU source code.

It doesn't make sense to be doing instrumentation inside the QEMU
process but not want to compile QEMU.

What is the use case?

Stefan

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeHxpAAoJEJykq7OBq3PIqaMH/35zPaVWfPb7onVe8UJ2EqnO
Y9NIVvs2RkydgeUuDPHAWzWxrAgUfgD9k6qXJnHWF1kb6y2n8Mlpk59+XymkahCA
BZPXP6ZofZIMMxrAqs3JwH+3KBpjFjyoz8FUN+xtZnZZZpuhaWsI4SCNzsLZp97Y
C5Yrk0g/G9ca3BeJBKhGLBVF4N2IDPSerfNV+2k1U0mVkrs36zbTOzjyyn5mEbe1
Tfi7ZeR7q3+n/ce/KvVjz6A7J+zl6eq8BdZQFiMJU557QTvUiwex3OgwKRHNgfng
pr0Fzt2wXMMMz+7WuBrWnzDCvsOksXJ6s88mHFmO9XqR9H9cjoynBXxa0nNwQiM=
=Ay2l
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
