Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKVH-0007sA-1Q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKVC-0004Oi-PW
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1daKVC-0004NQ-GS
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:29:18 -0400
Date: Wed, 26 Jul 2017 12:29:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726112915.GF18489@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<87wp6wa80j.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <87wp6wa80j.fsf@frigg.lan>
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
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:47:08PM +0300, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Mon, Jul 24, 2017 at 08:02:24PM +0300, Llu=EDs Vilanova wrote:
> >> This series adds a basic interface to instrument tracing events and co=
ntrol
> >> their tracing state.
> >>=20
> >> The instrumentation code is dynamically loaded into QEMU (either when =
it starts
> >> or later using its remote control interfaces).
> >>=20
> >> All events can be instrumented, but the instrumentable events must be =
explicitly
> >> specified at configure time.
> >>=20
> >> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
>=20
> > Hi Llu=EDs,
> > I'm concerned that the shared library interface will be abused to monkey
> > patch code into QEMU far beyond instrumentation use cases and/or avoid
> > the responsibilities of the GPL license.
>=20
> > Instead I suggest adding a trace backend generates calls to registered
> > "callback" functions:
>=20
> >   $ cat >my-instrumentation.c
> >   #include "trace/control.h"
>=20
> >   static void my_cpu_in(unsigned int addr, char size, unsigned int val)
> >   {
> >       printf("my_cpu_in\n");
> >   }
>=20
> >   static void my_init(void)
> >   {
> >       trace_register_event_callback("cpu_in", my_cpu_in);
> >       trace_enable_events("cpu_in");
> >   }
> >   trace_init(my_init);
>=20
> >   $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
>=20
> > This is still a clean interface that allows instrumentation code to be
> > kept separate from the trace event call sites.
>=20
> > The instrumentation code gets compiled into QEMU, but that shouldn't be
> > a huge burden since QEMU's Makefiles only recompile changed source
> > files (only the first build is slow).
>=20
> > Does this alternative sound reasonable to you?
>=20
> You mean to add a user-provided .c file to QEMU at compile-time? (I'm ass=
uming
> we can keep the "user API" proposed in this series, instead of the one you
> showed).
>=20
> First, a user might want to provide more than just a .c, so we might have=
 to
> accept a directory that produces a library that is included into QEMU at =
link
> time (a bit more complicated to do portably).
>=20
> Second, the user can still do the same actions you want to shield from,
> regardless of whether it's a dynamically loaded library (i.e., access any
> fuction in QEMU).
>=20
> What I propose to do instead is:
>=20
> * For the monkey-patch part, we can limit symbol resolution to the
>   instrumentation API functions when loading the library (e.g., compile Q=
EMU
>   with -fvisibility=3Dhidden).
>=20
> * For the license part, that is a legal issue that can be handled by the =
API
>   header license, right? (the "public" headers I added are GPL, not
>   LGPL). Besides, if only the intended API is available, I'm not sure if =
that
>   matters (e.g., we don't care about the license of a dtrace script, sinc=
e it
>   only has the API provided by QEMU+dtrace).
>=20
> This would be similar to Linux's module support; only selected functions =
are
> available to modules, and we could add a license check (e.g., QI_LICENSE(=
"GPL")
> must be on the instrumentation library or it won't be loaded).

Proprietary Linux kernel modules are controversial and some still
consider them license violations - especially when an "open source" shim
module is used to interface between proprietary code and the kernel.

What is the use case for this instrumentation?

Stefan

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeH0LAAoJEJykq7OBq3PI9RMH/0j5nKGLGgUWvv4zDK/IdDoB
8L6LCsaNvEUe9JQBPdnxArRJd0UCLvFJvGz2sC56uGnuTrc4ToEemNTInPeS5NWF
suvHm+BHRjI/zkNTS4nbr7a/6r9vntmY8ZJIMkCOEHQrhvddJgVekIyRDwhfbw9t
R/dz6nsDe0atUlkMwg9oKN/wA5SB+sad2gSOaALgHtKS7Ckl0ghRO9iFfnvIdmrr
J8brF0Bdk/0VhT+8NC2AMNtfQXP5yS5/v08gmBRO6UtUwiTFKuv5ZK3AJ1k9jcHo
ubcSzWgP2jERVeCfWc3Owig1t/s13vu5KyCbJsSHV9QxEdiHTsPvBQeWNAPF/xE=
=mxc7
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
