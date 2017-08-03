Received: from eggs.gnu.org ([2001:4830:134:3::10]:53056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddEiW-0002Jl-Sc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddEiT-00025N-7L
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:55:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ddEiS-00023n-Tj
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:55:01 -0400
Date: Thu, 3 Aug 2017 12:54:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170803115457.GD22685@stefanha-x1.localdomain>
References: <20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
	<20170802110400.GI5531@stefanha-x1.localdomain>
	<CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
	<20170802144943.GF10101@stefanha-x1.localdomain>
	<87lgn2q9oe.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <87lgn2q9oe.fsf@frigg.lan>
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
To: Peter Maydell <peter.maydell@linaro.org>, Alessandro Di Federico <ale+qemu@clearmind.me>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 06:19:29PM +0300, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Wed, Aug 02, 2017 at 12:10:14PM +0100, Peter Maydell wrote:
> >> On 2 August 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >> > On Tue, Aug 01, 2017 at 02:54:29PM +0100, Peter Maydell wrote:
> >> >> and I don't need the TCG engine to be a library to do that...
> >> >
> >> > You do need TCG APIs if you want TCG-level instrumentation, tuning
> >> > options, callbacks, etc.
> >>=20
> >> I need an API; that doesn't necessarily look like the kind
> >> of API you want to be able to embed the TCG engine into
> >> other things, I think.
> >>=20
> >> >> I agree that we want to provide something that is at least
> >> >> closer to a stable API than "just expose trace events",
> >> >> though.
> >> >
> >> > libqemu has at least three parts:
> >> >
> >> > 1. VM API (i.e. qemu_init(argc, argv), qemu_run(), qemu_vcpu_get_reg=
32())
> >> > 2. TCG engine
> >> > 3. Device models
> >> >
> >> > Like I said in my email, start with what matters for the instrumenta=
tion
> >> > use case (VM API at a minimum to control guest execution).  Other pe=
ople
> >> > can flesh out the other parts later, as needed.
> >> >
> >> > Other attempts to provide a stable API will be essentially the same
> >> > thing as libqemu.
> >>=20
> >> I don't think this is the case -- you could have a stable
> >> instrumentation API without it looking anything like
> >> libqemu. In particular I don't think you need to have
> >> something that sits at the top level and says 'run'.
> >>=20
> >> In particular I think that pulling TCG out of QEMU
> >> is an enormous and painful undertaking that you just
> >> don't need to do at all to allow this kind of
> >> instrumentation API.
>=20
> > Please post an example of the API you'd like.
>=20
> In my opinion, the instrumentation support in this series provides an API=
 that
> works in the opposite way you're suggesting (let's ignore the fact that i=
t's
> built on tracing events).
>=20
> When QEMU loads an instrumentation library (which can happen at any time)=
, some
> initialization function is called on the library so that it can establish=
 what
> events to instrument. This also has the advantage that a user can hook in=
to a
> running QEMU instance at any time to perform some instrumentation.
>=20
> I think this is the bare minimum necessary to make it work, and has the u=
pside
> of being completely orthogonal to the libqemu approach. We could reuse mo=
st of
> the stable instrumentation API there too, except for the instrumentation =
code
> initialization.
>=20
> That being said, the libqemu approach *might* make it a bit easier to pro=
vide an
> API for things such as "run for this many instructions and return control=
 to
> instrumentor", but I don't think that's mandatory for a first prototype (=
and can
> definitely be implemented using both approaches).

The main concern I have is that a feature for loading shared libraries
and hooking QEMU will be abused.  This can be mostly solved by offering
only a stable API without the ability to hook trace events.  There are
still ways to abuse this and that's why I prefer the libqemu approach.

The libqemu approach also avoids the "how do I enable my
instrumentation?" step for new users because they just need to run their
program after compiling it.  The workflow is simpler.

As a next step I suggest defining the stable instrumentation API and
dropping the tracing hooks.  We can still work out whether shared
library loading or libqemu is okay later but the stable API is most
important.

Stefan

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgw8RAAoJEJykq7OBq3PIqrgH/2MxXYtZQ/AlF8tpxRFcJ/dp
cgNxZvXAthl3OUk82EXeu4fUiwBssPEr9B76vBJ6rkVyNBEK9+TP4eTYgYBPrLcV
MEjBBaGyGRVsjyi/YGCLw/keTsX5jNoFM5YJ4mFgvo9ZaNJnv9QjTT5K+5+Thg7A
nKwGEO5/JJ5YuMLCFjE6lBTYsdQSr6q3WyycdHe/4yC2CNnhJ3fgzXEiVo7vLa+w
8ED8gUHlkEraZtlz6FkgUUW8IJP4D02OrvxGYAftLN6YpMpnl+21KLkMv7SjUSik
vN97t6m65NWp34e+Iw9k4xoQv/HbXKp4JRqH0RlPaFKJczLgWjo65w2+isIZAX8=
=sq5n
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
