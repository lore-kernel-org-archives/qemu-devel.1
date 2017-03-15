Received: from eggs.gnu.org ([2001:4830:134:3::10]:35784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co611-00065e-8Q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co610-0003gE-3u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:18:47 -0400
Date: Wed, 15 Mar 2017 18:18:35 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170315101835.GF8147@stefanha-x1.localdomain>
References: <20170310031521.630-1-eblake@redhat.com>
	<033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
	<19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Daniel Berrange <berrange@redhat.com>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 02:49:22PM -0600, Eric Blake wrote:
> On 03/09/2017 09:25 PM, Eric Blake wrote:
> > [adding Stefan in cc, as trace maintainer]
> >=20
> > On 03/09/2017 09:15 PM, Eric Blake wrote:
> >=20
> > Perhaps I should update the subject to mention trace?
> >=20
> >> trace-events lists the parameters for mirror_yield consistently
> >> with other events (cnt just after s, like in mirror_before_sleep;
> >> in_flight last, like in mirror_yield_in_flight).  But the callers
> >> were passing parameters in the wrong order, leading to poor trace
> >> messages, including type truncation when there are more than 4G
> >> dirty sectors involved.
>=20
> I traced it back to commit bd48bde. And I started auditing for more,
> finding at least a bad caller to trace_megasas_iovec_underflow since
> commit e8f943ce, so I'll be submitting a v2 that turns this into a
> full-blown series.
>=20
> My v2 will turn on -Wformat checking to catch any more instances of type
> mismatch between callers and trace-events (I'm turning up LOTS of places
> where the caller and trace-events disagree on types, leading to silent
> truncation such as a caller's uint64_t passed to the trace's uint32_t),
> so it's turning into rather a large series.  The obvious wrong
> parameters and probably even the type mismatch cleanups are probably 2.9
> material (although many of the things I'm fixing have been wrong in 2.8
> or earlier, and are not necessarily 2.9 regressions), but the code to
> actually enable -Wformat flagging may best be left for 2.10 material,
> since there may be latent type mismatches in files that I'm not
> compiling due to my configure/installed-library settings, but which
> would break builds for others (we'll see what the buildbots say, at any
> rate).  Stay tuned for v2...
>=20
> Oh, how am I enabling -Wformat checking, you ask?  Our existing code
> generates:
>=20
> static inline void trace_foo(int param)
> {
>     if (cond) {
>          do stuff, including with the log tracer...
>          qemu_log_mask(LOG_TRACE, "%d@%zd.%06zd:mirror_start " "bs %p s
> %p opaque %p" "\n", ..., param);
>     }
> }
>=20
> and qemu-log_mask() already does -Wformat checking - but ONLY for the
> types declared as the parameters to trace_foo.  It is NOT detecting type
> mismatches at the caller, such as if I call trace_foo(my_long).
>=20
> So my trick: I taught the generator to output the inline trace_foo() as
> before, but now follow it up with:
>=20
> #define trace_foo(...) \
>   do { \
>     if (0) { \
>       printf(<format> "\n", ## __VA_ARGS__); \
>     } \
>     trace_foo(__VA_ARGS__); \
>   } while (0)
>=20
> which creates a dead-code printf for the desired compile-time type
> validations, using the format from the trace-events file.
>=20
> And here's where I'm stuck: the makefiles are broken.  Touching
> scripts/tracetool/format/h.py does NOT cause tracetool to be re-run by a
> mere 'make'; I've had to resort to 'make -B block/trace.h-timestamp' to
> get things to rebuild.  And this is in spite of the fact that h.py
> _should_ be getting listed in $(tracetool-y) by trace/Makefile.objs, and
> $(tracetool-y) is listed as a dependency of %/trace.h-timestamp in the
> top-level Makefile.  I would appreciate anyone with advice or an idea on
> how to patch Makefile to get the dependency working without me having to
> manually kick it.

Also CCing Daniel Berrange.  He recently touched the tracing Makefiles
and may have ideas.

Stefan

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyRT7AAoJEJykq7OBq3PI2w4H/Rt5XaIfWIae22DbZqcTrkvV
hG1MKiPXad1vEP0Ig7A1tipeOg5dBhnv+5froUKU23g1CmqmXvG/OyZnDfKHz1eb
NixUxIsLTSvL4mb4Yn9ahWYd4CYKzFp5pebqr703UM17lEDFwGnRrX3wJuG75/2L
KgTABZt9F3ehyRL3c3KDC7TB7OMoiZsxcsQnX304II5v9DTrDg6U6IDrkXjs81WI
FDPFNJ0K6Zt8Y+ipr4rtj3Ik5DA5Y1O2PLBZAmg56hFluO1ASLBw7yr8EY7vfYJY
907koTGyrB7Ev8SxcJdy0jOteZ0KOWyR973VbN/Og94RJG0ItqtBCtBpHcUi2Tc=
=WKK7
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
