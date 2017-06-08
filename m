Received: from eggs.gnu.org ([2001:4830:134:3::10]:56823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuk1-0006tj-Lb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIujx-0004KY-FZ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:32:37 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIujx-0004KF-6f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:32:33 -0400
Received: by mail-wm0-x22a.google.com with SMTP id x70so74484525wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:32:33 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:32:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608103229.GF4145@stefanha-x1.localdomain>
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<20170608072228.GA2232@stefanha-x1.localdomain>
	<20170608074149.4qhb66k6ujyonlo4@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <20170608074149.4qhb66k6ujyonlo4@postretch>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, kwolf@redhat.com, berto@igalia.com, qemu-devel@nongnu.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 10:41:49AM +0300, Manos Pitsidianakis wrote:
> On Thu, Jun 08, 2017 at 08:22:28AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jun 07, 2017 at 04:06:19PM +0300, Manos Pitsidianakis wrote:
> > > +#define QEMU_OPT_IOPS_TOTAL "iops-total"
> > > +#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
> > > +#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
> > > +#define QEMU_OPT_IOPS_READ "iops-read"
> > > +#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
> > > +#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
> > > +#define QEMU_OPT_IOPS_WRITE "iops-write"
> > > +#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
> > > +#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
> > > +#define QEMU_OPT_BPS_TOTAL "bps-total"
> > > +#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
> > > +#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
> > > +#define QEMU_OPT_BPS_READ "bps-read"
> > > +#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
> > > +#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
> > > +#define QEMU_OPT_BPS_WRITE "bps-write"
> > > +#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
> > > +#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
> > > +#define QEMU_OPT_IOPS_SIZE "iops-size"
> > > +#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
> >=20
> > Please reuse include/qemu/throttle-options.h.
>=20
> This would make the options too verbose, ie -drive
> driver=3Dthrottle,file=3D..,throttling.iops-total=3D..,throttling. Eventu=
ally of
> course throttle-options.h will be replaced.
>=20
> However, this can't be done at this point anyway, since the throttling.[.=
=2E.]
> options are consumed by the already existing throttling code, and are
> unavailable for the driver.

There are ways of reusing include/qemu/throttle-options.h, I'm just not
sure if they are worth it.

In block/block-backend.c:

  #define THROTTLE_OPTION_PREFIX "throttling."
  #include "qemu/throttle-options.h"

In block/throttle.c:

  #include "qemu/throttle-options.h"

In include/qemu/throttle-options.h:

  #define THROTTLE_OPTION_IOPS_TOTAL (THROTTLE_OPTION_PREFIX "iops-total")

  #define THROTTLE_OPTS \
        { \
            .name =3D THROTTLE_OPTION_IOPS_TOTAL,\
            .type =3D QEMU_OPT_NUMBER,\
            .help =3D "limit total I/O operations per second",\
        },{ \

to generate either "throttling.iops-total" or "iops-total", depending on
the environment in which the file was included.

This reuses the same .h file but it's also a little ugly because of the
C macro (ab)use.

> > > diff --git a/include/block/throttle.h b/include/block/throttle.h
> > > new file mode 100644
> > > index 0000000000..fed24f02a6
> > > --- /dev/null
> > > +++ b/include/block/throttle.h
> >=20
> > What is the purpose of this header?
> >=20
> > Header files in include/* are "public" APIs that other parts of QEMU can
> > use.  There is no user other than block/throttle.c so please keep it
> > private in the .c file.
>=20
> Eventually the qmp/hmp/qom related stuff will be in a header file, and th=
is
> is why I put them from the beginning separately. But yes, in this case it=
 is
> not needed. Also, these probably should go to include/qemu/throttle.h
> instead of a separate header file.

Patches must be self-contained because reviewers don't necessarily know
future plans and if those future patches are never merged then the
source tree is in an incomplete state.

There are rare cases where it's really necessary for a patch to add
something that is unused.  In that case the intention should be clear
=66rom the patch or commit description (e.g. "let's change this now so
the next patch can take advantage of it").

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSe9AAoJEJykq7OBq3PI6woIAKufl46ggyADRltXDvtqPdpq
iNBRJwhaKFnimZknD2ATvdt8QOsf9BWtePJ84QTfju8/igEO8/KaZG/55ZRWqAC6
trZOoD7O4MaAl6GqGfSz6vqZq56zf9eUTMaN6/fbN0ZeCIpOGB9kWhF0R/iYkz4k
wD8u5QY3tbRZtaLSS0UPIYhnnepUULTF5ufNzj0uCgWkuLSQcV2zczPOEzb+vjUe
H2iF7M6x6u3Hv6ARqN2V2I9+Mhu73G+jBq+OlKyuxdV2rWglWMmF3wBmkqJqSiXb
I7H7Oxohwf3cKJON9Tiwgr0Oh/FZ4RaUXNS3GBi7uPbRhoiTswCe4LSVvx5sHnI=
=oXOY
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
