Received: from eggs.gnu.org ([2001:4830:134:3::10]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dag6G-0002ML-I7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dag6D-00014j-Ab
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dag6D-00014A-24
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:32:57 -0400
Date: Thu, 27 Jul 2017 11:32:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170727103253.GE10129@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
	<20170726112210.GD18489@stefanha-x1.localdomain>
	<871sp34bbc.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <871sp34bbc.fsf@frigg.lan>
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
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 03:44:39PM +0300, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Tue, Jul 25, 2017 at 06:11:43PM +0300, Llu=EDs Vilanova wrote:
> >> Peter Maydell writes:
> >>=20
> >> > On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >> >> Instead I suggest adding a trace backend generates calls to registe=
red
> >> >> "callback" functions:
> >> >>=20
> >> >> $ cat >my-instrumentation.c
> >> >> #include "trace/control.h"
> >> >>=20
> >> >> static void my_cpu_in(unsigned int addr, char size, unsigned int va=
l)
> >> >> {
> >> >> printf("my_cpu_in\n");
> >> >> }
> >> >>=20
> >> >> static void my_init(void)
> >> >> {
> >> >> trace_register_event_callback("cpu_in", my_cpu_in);
> >> >> trace_enable_events("cpu_in");
> >> >> }
> >> >> trace_init(my_init);
> >> >>=20
> >> >> $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
> >> >>=20
> >> >> This is still a clean interface that allows instrumentation code to=
 be
> >> >> kept separate from the trace event call sites.
> >> >>=20
> >> >> The instrumentation code gets compiled into QEMU, but that shouldn'=
t be
> >> >> a huge burden since QEMU's Makefiles only recompile changed source
> >> >> files (only the first build is slow).
> >>=20
> >> > Is your proposal that my-instrumentation.c gets compiled into
> >> > QEMU at this point? That doesn't seem like a great idea to
> >> > me, because it means you can only use this tracing if you
> >> > build QEMU yourself, and distros won't enable it and so
> >> > lots of our users won't have convenient access to it.
> >> > I'd much rather see a cleanly designed plugin interface
> >> > (which we should be able to implement in a manner that doesn't
> >> > let the plugin monkey patch arbitrary parts of QEMU beyond
> >> > what can already be achieved via LD_PRELOAD).
> >>=20
> >> Just to be clear, what do you both mean by monkey-patching?
> >>=20
> >> * Accessing unintended symbols in QEMU from the library (and from there
> >> modifying QEMU's behavior).
> >> * QEMU using symbols on the library instead of its own just because th=
ey have
> >> the same name.
> >>=20
> >> As I said, the former can be accomplished by compiling QEMU with
> >> "-fvisibility=3Dhidden".
> >>=20
> >> The latter is already achieved by using dlopen with RTLD_LOCAL (the de=
fault).
>=20
> > Instrumentation functions are invoked in the same memory space as QEMU,
> > so pointer arguments can be modified.
>=20
> > Think of all the void *s arguments we trace.  Instrumentation code can
> > access those structs, hijack function pointers, etc.  No symbols are
> > required.
>=20
> And why exactly is this a threat? Because it can be used to "extend" QEMU
> without touching its sources? Is this a realistic threat? (it's a rather =
brittle
> way to do it, so I'm not sure it's practical)

Unfortunately it is a problem.  I recently came across a product that
was using LD_PRELOAD=3D to "integrate" with QEMU.  People really abuse
these interfaces instead of integrating their features cleanly into
QEMU.

I see the use cases that Peter has been describing and am sure we can
come up with good solutions.  What I care about is that it doesn't allow
loading a .so that connects to arbitrary trace events.

> If that's the case, forcing instrumentation libraries to be exclusively G=
PL
> seems like a solution to me, just as GPL protects QEMU itself.
>=20
> Do we agree on that? Or did I miss something else?

How the license applies depends on how user instrumentation code
interfaces with QEMU.  We probably need to ask the QEMU project's
lawyers for confirmation.  I don't think it's as simple as saying "the
interface will be protected by GPL".

Let's discuss the use cases and how instrumentation should work in
another subthread first.  Then towards the end we can come back to GPL
again.

> As a side note, I find instrumentation to be most useful for guest code e=
vents,
> which mostly contain non-pointer values (except for the CPUState*).

That's great.  I'll read the entire series to get a feel for what
instrumentation code needs to be able to do.  I'm wondering if a stable
public API is possible that does not leave room for abuse.

Stefan

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZecFVAAoJEJykq7OBq3PImjgIALUQ+3+8OQJI91va5GnisC4u
huwnuFEAS3Uo+xhLZdxSxZJiv8kY4L4cE9fVo001qTQ5kL20s+WqIRRR5dJ/7RO8
O3TLXEVs3etaniLAGH71Wzz3Uh8uGchwKSF/NEwKEFp9lS1BwJ3GOb0qMrJ5O0IH
hUwETDF/Yy8IRb1mUeHg+giStNDZfF7CXDC1VwqYxMUUuD/749O08Wd1/80hekBy
L856CH8Be574GJtnq3ODfMyhanVQKWQaWlDEEL0ulqe6DOE/OOiIYapWxPTmFClO
dWVHPO52bVxZllTJG9LSUb6YVrl83Iifg9DSMejkMo78WBNDb97uchDW6NJX8Is=
=dLRC
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
