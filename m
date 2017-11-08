Received: from eggs.gnu.org ([2001:4830:134:3::10]:40076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCUMe-0003Fz-CX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCUMZ-0003WZ-Nw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:42:12 -0500
References: <20171107223708.17935-1-eblake@redhat.com>
	<20171108154226.GC6118@stefanha-x1.localdomain>
	<462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
	<061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
	<20171108173621.GB8403@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34d8f43a-483a-fb2d-13b3-994d0a67f464@redhat.com>
Date: Wed, 8 Nov 2017 11:42:01 -0600
MIME-Version: 1.0
In-Reply-To: <20171108173621.GB8403@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ew6eqX2AKd9niUbLCdtr1egiGbMQxTGtJ"
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ew6eqX2AKd9niUbLCdtr1egiGbMQxTGtJ
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-trivial@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <34d8f43a-483a-fb2d-13b3-994d0a67f464@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
References: <20171107223708.17935-1-eblake@redhat.com>
 <20171108154226.GC6118@stefanha-x1.localdomain>
 <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
 <061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
 <20171108173621.GB8403@stefanha-x1.localdomain>
In-Reply-To: <20171108173621.GB8403@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 11:36 AM, Stefan Hajnoczi wrote:

>> This function uses timers and hence needs to know the event loop
>> (#AioContext) to place the timer on.  After the time elapses, the
>> current coroutine will restart with the same #AioContext it is current=
ly
>> running in, even if that is different than the timer context passed to=

>> co_aio_sleep_ns().
>=20
> These complicated semantics are a clue that the API should be
> simplified.  QEMU has changed since this function was first introduced.=

> Now we can do the following:
>=20
>   void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
>   {
>       AioContext *ctx =3D qemu_get_current_aio_context();
>       CoSleepCB sleep_cb =3D {
>           .co =3D qemu_coroutine_self(),
>       };
>       sleep_cb.ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &=
sleep_cb);
>       timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
>       qemu_coroutine_yield();
>       timer_del(sleep_cb.ts);
>       timer_free(sleep_cb.ts);
>   }
>=20
> I don't see a reason for the caller to pass in an AioContext.
>=20
> Any objections?  Will send a patch if this is okay.

Makes sense to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ew6eqX2AKd9niUbLCdtr1egiGbMQxTGtJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDQekACgkQp6FrSiUn
Q2qy6Af/RIB0a/WZ3VRjJkFzMdrgFL93ZTIIlPEDSCHlGlxncgXU3W1QkO51/1sa
Mo6BcTELjLTEPlg3j+2Cvh4sJBSaZbiGZXwr92ojKFqasbSoDaoAeb7J6vVFH3O7
kb1CyVYibzpb/ERzfIyB4hyNrF3MU+Ji85EKZs/4bdrMxXbbsJezzR1Y7evehaND
Uuaz6iz8NgAuMmsOLSOa7ANKdWmfUNQrNo6Lxb6b5rT/FKQjeq6oh2wX+rcJ/hBz
MVHAqJ0VTqpkIwVKhVcE9BTO4LW3Tf2zOmEHVO2/20yl7bUvYBf2ruVaaWu57+S/
ZQnq9MpCKgGU9hKmuK4pO+pYXoy7LQ==
=6wcQ
-----END PGP SIGNATURE-----

--ew6eqX2AKd9niUbLCdtr1egiGbMQxTGtJ--
