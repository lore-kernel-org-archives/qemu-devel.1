Received: from eggs.gnu.org ([2001:4830:134:3::10]:41402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej5Pl-0006X3-JD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej5Pg-0006OH-C5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ej5Pg-0006NV-3r
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:44:04 -0500
Date: Tue, 6 Feb 2018 15:44:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180206154400.GE13343@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
	<CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
	<20180205155108.GF28241@stefanha-x1.localdomain>
	<CAFEAcA-vd3vEJ0i=2LtaR-NQjHoJVYWCNDHOmh3iREPcQsqR4A@mail.gmail.com>
	<20180206091700.GB4942@stefanha-x1.localdomain>
	<CAFEAcA-o3b0B1BhzTP5YdsXLyq50_WC7hzZU8vb-EmTOBKjhWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-o3b0B1BhzTP5YdsXLyq50_WC7hzZU8vb-EmTOBKjhWA@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 10:55:57AM +0000, Peter Maydell wrote:
> On 6 February 2018 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Mon, Feb 05, 2018 at 03:55:01PM +0000, Peter Maydell wrote:
> >> ...and "online processing of traces" is pretty much exactly
> >> what an instrumentation plugin API is for.
> >
> > There are two cases for online processing:
> >
> > 1. Synchronous - this is what the instrumentation plugins will be able
> >    to do.  It means that QEMU waits until the event has been processed,
> >    and the plugin is therefore able to control QEMU.
> >
> > 2. Asynchronous - this is what LTTng UST does.  It means that the
> >    process analyzing the trace does not hold up QEMU, but it cannot
> >    control QEMU without some delay between trace events firing and
> >    reacting to them.  I think Nesrine's use case is this one.
> >
> > #2 is useful for "real-time" graphs, for example.  That is still
> > "oneline" but it doesn't require instrumentation plugins.
> >
> > Given that the instrumentation plugin API is still in early development,
> > it would delay Nesrine's work and I recommend against depending on it.
>=20
> I don't really want us to end up with two separate ways of doing
> basically the same thing that have been implemented entirely
> independently.

I agree it shouldn't be duplicated.  The instrumentation plugin
infrastructure can use tracing.

What I'm not convinced of is that Nesrine's use case requires a plugin
that can react to events within QEMU.  It seems like it just needs to
export a stream of events to an external process - instrumentation
plugins aren't needed for that, just use LTTng UST.

> A lot of the problems you need to solve (like "how do we
> configurably add tracing of things like guest register changes
> into the generated code in a maintainable and efficient way")
> are the same both ways.

Tracing already has special "tcg" events, which can be planted in
generated code as well as triggered at translation time.  So I think
this is already solved?

> >> It would also let you put the logic of "how do we know what a
> >> guest OS task switch is anyway" somewhere other than QEMU,
> >> which is nice because that's very guest-OS specific.
> >
> > How do you envision that instrumentation plugins will monitor guest OS
> > task switches if QEMU does not know about them?
>=20
> The plugin can register for information like changes of the
> relevant system registers (and could potentially do cleverer
> things like looking at guest in-memory task data structures).
> QEMU doesn't need to know (and shouldn't know) that x86 CR3 or
> Arm CONTEXTIDR are how you identify a guest OS task switch.
>=20
> > Without instrumentation plugins I would add a guest_x86_cr3_write trace
> > event, for example.  Then the trace consumer can interpret that event as
> > a task switch if it knows the guest OS always writes to the cr3 register
> > on a task switch.  No instrumentation plugins are necessary in order to
> > do this and it doesn't hardcode knowledge of guest OS task switching
> > into QEMU either.
>=20
> This only works if you have a trace event for the register change,
> which we don't.

Adding a trace event for cr3 updates looks easy.

Stefan

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaec1AAAoJEJykq7OBq3PIeB0IAKeCPMYo0dFtc9KWvV0imhla
YvBHxgP47vb1SOj8LzvNTcAGVsabq2CYGvcS6FOKP4VxLMbkF+imYuYg5cWTQYuM
EqVFanZng1fv3RNEsfuCwDGh9PE7k71SBluHtxcLZ14McR6e3+QxsIfDwXuwwP3G
Yw0IiOddSWDHS7OtjjQbTgrqg3+xD0U3W5bcQSNAkmUp0g3H8hY0b32WhcPaskrh
bsgDbBuNpWoYYuQcMMVIdcorBrGMTFPh6Bw3ZoWeEbLq2RQHkhk4Z9gaPPogyfeS
Bn2swvefLFpZv4ce8KisLsTi1j6Dt59WCJfl4WSz/2YIGAbL8nWqOfz/jQ19tVA=
=832a
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
