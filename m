Received: from eggs.gnu.org ([2001:4830:134:3::10]:35722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKOO-0004bC-1f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKOL-0000FE-F8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1daKOL-0000Eu-5o
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:22:13 -0400
Date: Wed, 26 Jul 2017 12:22:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726112210.GD18489@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <87o9s88sb4.fsf@frigg.lan>
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


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 06:11:43PM +0300, Llu=EDs Vilanova wrote:
> Peter Maydell writes:
>=20
> > On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >> Instead I suggest adding a trace backend generates calls to registered
> >> "callback" functions:
> >>=20
> >> $ cat >my-instrumentation.c
> >> #include "trace/control.h"
> >>=20
> >> static void my_cpu_in(unsigned int addr, char size, unsigned int val)
> >> {
> >> printf("my_cpu_in\n");
> >> }
> >>=20
> >> static void my_init(void)
> >> {
> >> trace_register_event_callback("cpu_in", my_cpu_in);
> >> trace_enable_events("cpu_in");
> >> }
> >> trace_init(my_init);
> >>=20
> >> $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
> >>=20
> >> This is still a clean interface that allows instrumentation code to be
> >> kept separate from the trace event call sites.
> >>=20
> >> The instrumentation code gets compiled into QEMU, but that shouldn't be
> >> a huge burden since QEMU's Makefiles only recompile changed source
> >> files (only the first build is slow).
>=20
> > Is your proposal that my-instrumentation.c gets compiled into
> > QEMU at this point? That doesn't seem like a great idea to
> > me, because it means you can only use this tracing if you
> > build QEMU yourself, and distros won't enable it and so
> > lots of our users won't have convenient access to it.
> > I'd much rather see a cleanly designed plugin interface
> > (which we should be able to implement in a manner that doesn't
> > let the plugin monkey patch arbitrary parts of QEMU beyond
> > what can already be achieved via LD_PRELOAD).
>=20
> Just to be clear, what do you both mean by monkey-patching?
>=20
> * Accessing unintended symbols in QEMU from the library (and from there
>   modifying QEMU's behavior).
> * QEMU using symbols on the library instead of its own just because they =
have
>   the same name.
>=20
> As I said, the former can be accomplished by compiling QEMU with
> "-fvisibility=3Dhidden".
>=20
> The latter is already achieved by using dlopen with RTLD_LOCAL (the defau=
lt).

Instrumentation functions are invoked in the same memory space as QEMU,
so pointer arguments can be modified.

Think of all the void *s arguments we trace.  Instrumentation code can
access those structs, hijack function pointers, etc.  No symbols are
required.

Stefan

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeHtiAAoJEJykq7OBq3PIxA8H/2HpPfjbMqR0bhg9LpmGSU60
ZWhh91o+wSgZ+JJJLdXYa61Tc9ZeA3NSPsvLCH2G2GOKSrIdSMRD+x9Ga530E8Ms
gSjJwslrjBRiM6JU8HPxIjeW4q3yqy6gantHY0Ts3sVmufy/ZpL/cB/XrX+T7CkE
/Ymr+7cYfTV6t4Y+bcfXRd8MrdhbLgT/OfsuOR46c0BoQfRrhRPoWPpSiy5ekuGX
i+taShEAtDKYSX1pN77mHEs+ZsFs53k4RdAad1dBv2GMR/fbq5rCB12/wPnIbrCV
G2IS7UWGDKuUhWVgVuATBuIqO+NIFWggIoaM72+9sAnRXSXPBiX1sjw2+bSpykQ=
=JscS
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
