Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db7dF-0007jX-He
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db7dE-0000wS-Lm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db7dE-0000vp-Bf
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:56:52 -0400
Date: Fri, 28 Jul 2017 16:56:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170728155649.GA15534@stefanha-x1.localdomain>
References: <20170728092053.10122-1-stefanha@redhat.com>
	<20170728092053.10122-3-stefanha@redhat.com>
	<20170728110544.GL31495@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20170728110544.GL31495@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] trace: check backend dstate in
 trace_event_get_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 12:05:44PM +0100, Daniel P. Berrange wrote:
> On Fri, Jul 28, 2017 at 10:20:53AM +0100, Stefan Hajnoczi wrote:
> > Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
> > the following trace event will not fire when solely enabled by SystemTap
> > or LTTng UST:
> >=20
> >   if (trace_event_get_state(TRACE_MY_EVENT)) {
> >       str =3D g_strdup_printf("Expensive string to generate ...",
> >                             ...);
> >       trace_my_event(str);
> >       g_free(str);
> >   }
> >=20
> > Most users of trace_event_get_state() want to know both QEMU and backend
> > dstate for the event.  Update the macro to include backend dstate.
> >=20
> > Introduce trace_event_get_state_qemu() for those callers who really only
> > want QEMU dstate.  This includes the trace backends (like 'log') which
> > should only trigger when event are enabled via QEMU.
>=20
> I'm not convinced this is quite right as is.
>=20
> The QEMU state for an event is set via cli flags to -trace and that
> is intended for use with with things like simpletrace or log which
> have no other way to filter which events are turned on at runtime.
> For these calling trace_event_get_state_dynamic_by_id() is right.
>=20
> For DTrace / LTT-NG, and event is active if the kernel has turned
> on the dynamic probe location.  Any command line args like -trace
> should not influence this at all, so we should *not* involve QEMU
> state at all - only the backend state. So for these we should only
> be calling the backend specific test and ignoring
> trace_event_get_state_dynamic_by_id() entirely. Your patch though
> makes it consider both.

I think you're referring to this:

  #define trace_event_get_state(id)                       \
      ((id ##_ENABLED) && (trace_event_get_state_dynamic_by_id(id) || \
                           id ##_BACKEND_DSTATE()))

We could change it to:

  #define trace_event_get_state(id)                       \
      ((id ##_ENABLED) && id ##_BACKEND_DSTATE())

and modify the log, syslog, ftrace, etc backends to emit
trace_event_get_state_dynamic_by_id(id) as their backend dstate.

However, in the multi-backend case with ./configure
--enable-trace-backends=3Dlog,syslog this expands to:

  ((id ##_ENABLED) && (trace_event_get_state_dynamic_by_id(id) || \
                       trace_event_get_state_dynamic_by_id(id) || \
		       false))

I couldn't bring myself to have multiple calls to
trace_event_get_state_dynamic_by_id() :).

What do you think?

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZe17BAAoJEJykq7OBq3PIM6EIAMVHGOd+3kTWn9pABbN4Qlux
sjT2xbsH3yY3xwrp5uPP5i+JcYVILxUZ+bOk5NgQfN5BDXQcDXkI0gpA+ZLaQlpK
KimLubV/+Cleq7B7MMu5Jssl+r74hU8n0joJnXQBP+fXa1h8Xx5NqqQD2gIe8TvH
npLj7132h8QyREuyS9wZIRWtpM+90ldCIZ370AyGfWa9/Qcad6HXTeVoWOGJ75xz
me3l4BEI7UTuP3RtesWMZ0LjKADn4usnCG3CkzaPmZEYb+JYmsaYuMHlOfApF5+2
rEnUYhfGq99rfyw+3yHbg1tBG+xb9t4FAe6Oi30EonRg6MMGQkUbBySAdKmVV9M=
=VwXk
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
