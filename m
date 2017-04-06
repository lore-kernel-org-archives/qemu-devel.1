Received: from eggs.gnu.org ([2001:4830:134:3::10]:43346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9R9-0004xh-5m
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9R8-0000IG-2h
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:35:03 -0400
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-6-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbd7c403-ae8e-0092-7a2b-9a516146428b@redhat.com>
Date: Thu, 6 Apr 2017 10:34:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170406142527.25835-6-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PVP1hJc0CLQFFJQ79DNWBxKdpvOtIHeT3"
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] coroutine: Explicitly specify
 AioContext when creating coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PVP1hJc0CLQFFJQ79DNWBxKdpvOtIHeT3
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fbd7c403-ae8e-0092-7a2b-9a516146428b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] coroutine: Explicitly specify
 AioContext when creating coroutine
References: <20170406142527.25835-1-famz@redhat.com>
 <20170406142527.25835-6-famz@redhat.com>
In-Reply-To: <20170406142527.25835-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 09:25 AM, Fam Zheng wrote:
> Coroutine in block layer should always be waken up in bs->aio_context

s/waken up/awakened/

> rather than the "current" context where it is entered. They differ when=

> the main loop is doing QMP tasks.
>=20
> Race conditions happen without this patch, because the wrong context is=

> acquired in co_schedule_bh_cb, while the entered coroutine works on a
> different one.
>=20
> Make the block layer explicitly specify a desired context for each crea=
ted
> coroutine. For the rest, always use qemu_get_aio_context().
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---

The meat of the change is here (using an order file to present your diff
with the interesting changes first can aid review)...

> +++ b/util/qemu-coroutine.c
> @@ -43,7 +43,8 @@ static void coroutine_pool_cleanup(Notifier *n, void =
*value)
>      }
>  }
> =20
> -Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
> +Coroutine *qemu_coroutine_create(AioContext *ctx,
> +                                 CoroutineEntry *entry, void *opaque)
>  {
>      Coroutine *co =3D NULL;
> =20
> @@ -78,6 +79,7 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entr=
y, void *opaque)
> =20
>      co->entry =3D entry;
>      co->entry_arg =3D opaque;
> +    co->ctx =3D ctx;
>      QSIMPLEQ_INIT(&co->co_queue_wakeup);
>      return co;
>  }
> @@ -107,6 +109,7 @@ void qemu_coroutine_enter(Coroutine *co)
>      Coroutine *self =3D qemu_coroutine_self();
>      CoroutineAction ret;
> =20
> +    assert(co->ctx);
>      trace_qemu_coroutine_enter(self, co, co->entry_arg);
> =20
>      if (co->caller) {
> @@ -115,7 +118,6 @@ void qemu_coroutine_enter(Coroutine *co)
>      }
> =20
>      co->caller =3D self;
> -    co->ctx =3D qemu_get_current_aio_context();

Basically, you close the race by assigning co->ctx sooner (during
creation, rather than entering the coroutine), where non-block callers
still end up with the same context, and block callers now have a chance
to provide their desired context up front.

Makes for a big patch due to the fallout, but the result seems sane to me=
=2E

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PVP1hJc0CLQFFJQ79DNWBxKdpvOtIHeT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5mAZAAoJEKeha0olJ0NqaWQIAKvunA8bSC4dm6DG8Q8uSSJK
umvhnAym99+g4yPc+a7zKxv90k51Dfg103s+AOIJiCCX+80VXNbGXys+2K2KaV/C
5J0kQnrhdiKV0fx8QG09Uw6vswqxCibNo7UU61LHxjA2X7qX/XBr3arfj40LPkBX
nAzi16GHfGjA5m87ex6T8q/zBBk2qPD2OCUyk5UlC056UT8evnqxqOui8Dj2eGEF
uQPDHvFyqEi5MRsrdiPpD+iqQqLENwiwQ8ECLNZaBWpeM1F410JH5IscVm19xb5v
3RM3jRTEEryaGabGPNZOnQTPZGAjD2oXq+npFB8h1nhwnLc23fbxRlMvj9nf+8o=
=dpSI
-----END PGP SIGNATURE-----

--PVP1hJc0CLQFFJQ79DNWBxKdpvOtIHeT3--
