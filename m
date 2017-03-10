Received: from eggs.gnu.org ([2001:4830:134:3::10]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmRTh-0002yb-VQ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmRTg-0001t3-M3
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:49:34 -0500
References: <20170310031521.630-1-eblake@redhat.com>
	<033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
Date: Fri, 10 Mar 2017 14:49:22 -0600
MIME-Version: 1.0
In-Reply-To: <033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MmQUkTcXrbBiEI5q318aeOx3hUvD6BnjM"
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
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MmQUkTcXrbBiEI5q318aeOx3hUvD6BnjM
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
References: <20170310031521.630-1-eblake@redhat.com>
 <033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
In-Reply-To: <033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2017 09:25 PM, Eric Blake wrote:
> [adding Stefan in cc, as trace maintainer]
>=20
> On 03/09/2017 09:15 PM, Eric Blake wrote:
>=20
> Perhaps I should update the subject to mention trace?
>=20
>> trace-events lists the parameters for mirror_yield consistently
>> with other events (cnt just after s, like in mirror_before_sleep;
>> in_flight last, like in mirror_yield_in_flight).  But the callers
>> were passing parameters in the wrong order, leading to poor trace
>> messages, including type truncation when there are more than 4G
>> dirty sectors involved.

I traced it back to commit bd48bde. And I started auditing for more,
finding at least a bad caller to trace_megasas_iovec_underflow since
commit e8f943ce, so I'll be submitting a v2 that turns this into a
full-blown series.

My v2 will turn on -Wformat checking to catch any more instances of type
mismatch between callers and trace-events (I'm turning up LOTS of places
where the caller and trace-events disagree on types, leading to silent
truncation such as a caller's uint64_t passed to the trace's uint32_t),
so it's turning into rather a large series.  The obvious wrong
parameters and probably even the type mismatch cleanups are probably 2.9
material (although many of the things I'm fixing have been wrong in 2.8
or earlier, and are not necessarily 2.9 regressions), but the code to
actually enable -Wformat flagging may best be left for 2.10 material,
since there may be latent type mismatches in files that I'm not
compiling due to my configure/installed-library settings, but which
would break builds for others (we'll see what the buildbots say, at any
rate).  Stay tuned for v2...

Oh, how am I enabling -Wformat checking, you ask?  Our existing code
generates:

static inline void trace_foo(int param)
{
    if (cond) {
         do stuff, including with the log tracer...
         qemu_log_mask(LOG_TRACE, "%d@%zd.%06zd:mirror_start " "bs %p s
%p opaque %p" "\n", ..., param);
    }
}

and qemu-log_mask() already does -Wformat checking - but ONLY for the
types declared as the parameters to trace_foo.  It is NOT detecting type
mismatches at the caller, such as if I call trace_foo(my_long).

So my trick: I taught the generator to output the inline trace_foo() as
before, but now follow it up with:

#define trace_foo(...) \
  do { \
    if (0) { \
      printf(<format> "\n", ## __VA_ARGS__); \
    } \
    trace_foo(__VA_ARGS__); \
  } while (0)

which creates a dead-code printf for the desired compile-time type
validations, using the format from the trace-events file.

And here's where I'm stuck: the makefiles are broken.  Touching
scripts/tracetool/format/h.py does NOT cause tracetool to be re-run by a
mere 'make'; I've had to resort to 'make -B block/trace.h-timestamp' to
get things to rebuild.  And this is in spite of the fact that h.py
_should_ be getting listed in $(tracetool-y) by trace/Makefile.objs, and
$(tracetool-y) is listed as a dependency of %/trace.h-timestamp in the
top-level Makefile.  I would appreciate anyone with advice or an idea on
how to patch Makefile to get the dependency working without me having to
manually kick it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MmQUkTcXrbBiEI5q318aeOx3hUvD6BnjM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwxFSAAoJEKeha0olJ0NqVgYIAK3OUsoUwNHHDVuo/sfhwmbq
oXFmOM016gGiip7Uam4npxigIoFQ3Ovfn9dIG21uysWBMOW+Iur5z+3w+pSuYIku
v4TTrziMyaPZ8yH6ICtW4mrlqJ3u8fh7Ue4mBrSmuJi+t9HQdlY9fSQ6LZK8uR2S
PrwFF6/8J+oTJn8emwlZE6pINinqIZYhqD6RriKyI8JVcNNaOGSVuLpQY3zOygWH
L7ha+QQHQT/onoK3sgrrHn8VOnifohmMu6aP3VIwNU/zMIv3kJlUNtL4DTGgbZeK
FtHXXaoOQ0/0DxBT5uCzTvaDsnYDEkQ5oyWEJAqXrO/shdges1/tozGWCEdCCiY=
=IfVU
-----END PGP SIGNATURE-----

--MmQUkTcXrbBiEI5q318aeOx3hUvD6BnjM--
