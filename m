Received: from eggs.gnu.org ([2001:4830:134:3::10]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbb9-0001ni-Kf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbb6-0004mC-Hm
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dZbb6-0004lw-9C
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:24 -0400
Date: Mon, 24 Jul 2017 12:32:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724113221.GB2784@stefanha-x1.localdomain>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<87a83xlo1a.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <87a83xlo1a.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, den@openvz.org, dgilbert@redhat.com, armbru@redhat.com


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 08:04:17PM +0300, Llu=EDs Vilanova wrote:
> Vladimir Sementsov-Ogievskiy writes:
>=20
> > Current trace system have a drawback: parameters of trace functions
> > are calculated even if corresponding tracepoint is disabled. Also, it
> > looks like trace function are not actually inlined by compiler (at
> > least for me).
>=20
> > Here is a fix proposal: move from function call to macros. Patch 02
> > is an example, of how to reduce extra calculations with help of
> > patch 01.
>=20
> The tracing functions *were* inlined last time I checked, although things
> changed quite a lot since then. Not sure that will make a lot of differen=
ce in
> terms of overall performance (needs measuring).
>=20
> As for arguments, each trace event has a define TRACE_{NAME}_ENABLED that=
 you
> can use for that purpose. If this is not explained in tracing.txt, that i=
s a
> documentation bug.

It is described in docs/devel/tracing.txt:

In addition, there might be cases where relatively complex computations mus=
t be
performed to generate values that are only used as arguments for a trace
function. In these cases you can use the macro 'TRACE_${EVENT_NAME}_ENABLED=
' to
guard such computations and avoid its compilation when the event is disable=
d:

    #include "trace.h"  /* needed for trace event prototype */
   =20
    void *qemu_vmalloc(size_t size)
    {
        void *ptr;
        size_t align =3D QEMU_VMALLOC_ALIGN;
   =20
        if (size < align) {
            align =3D getpagesize();
        }
        ptr =3D qemu_memalign(align, size);
        if (TRACE_QEMU_VMALLOC_ENABLED) { /* preprocessor macro */
            void *complex;
            /* some complex computations to produce the 'complex' value */
            trace_qemu_vmalloc(size, ptr, complex);
        }
        return ptr;
    }

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZddrFAAoJEJykq7OBq3PIp2YIAJHOzK9pwfUdUsd8LBu370rr
bFsdCVMQro2fxruzptw+bf0u97sur6Sc3RsltALTCDtkjtuvpWkDcc8FnT3hg0c8
w1SN3AxAGsjrzxwvpVHP5BTNcazY+ZdsK+ZEA5LGT+RVKLQ3wBSByYWouAKgMmBI
bRJeTcHcVBdFIaZawWlgE46m7KjJ2dJyINn7i5kWmmzGAOXnllsdRqNx665/f1X+
mEN7sizeWvXe7emWN7hGdfM29fYYrHSrP3w+c+KXlxbuofWROsTYKSHiwyMIigwO
J/UoqY+h0fLaJsV6GM4vHTxg5aG7nH1wwT21qnXnZYRap9hmEldAg6aLjD9Ci40=
=jJnn
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
