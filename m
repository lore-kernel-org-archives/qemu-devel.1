Received: from eggs.gnu.org ([2001:4830:134:3::10]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhsY-00036i-HH
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhsX-0000rW-NG
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:44:26 -0500
References: <20171115213557.3548-1-eblake@redhat.com>
	<d4ddb01f-dab0-9b5f-f2ec-78cbd975ffbe@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef8b7ed4-eee1-6947-5ad5-030356a9f841@redhat.com>
Date: Fri, 17 Nov 2017 08:44:17 -0600
MIME-Version: 1.0
In-Reply-To: <d4ddb01f-dab0-9b5f-f2ec-78cbd975ffbe@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrDeSoGh5rosnBUlbhqK0EFGXihhLa9UO"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] nbd/server: Fix error
 reporting for bad requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrDeSoGh5rosnBUlbhqK0EFGXihhLa9UO
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef8b7ed4-eee1-6947-5ad5-030356a9f841@redhat.com>
Subject: Re: [PATCH v2 for-2.11] nbd/server: Fix error reporting for bad
 requests
References: <20171115213557.3548-1-eblake@redhat.com>
 <d4ddb01f-dab0-9b5f-f2ec-78cbd975ffbe@virtuozzo.com>
In-Reply-To: <d4ddb01f-dab0-9b5f-f2ec-78cbd975ffbe@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2017 02:52 AM, Vladimir Sementsov-Ogievskiy wrote:

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request->type =3D=3D NBD_CMD_READ |=
| request->type =3D=3D
>> NBD_CMD_WRITE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request->le=
n > NBD_MAX_BUFFER_SIZE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp, "len (%" PRIu32" ) is larger than max
>> len (%u)",
>=20
> related idea here: if request->len > NBD_MAX_BUFFER_SIZE or if we faile=
d
> to allocate buffer in following if,
> we can call nbd_drop to read CMD_WRITE payload and set req->complete =3D=

> true;, to keep connection in this
> cases.
>=20
> However, it may be done later.

On the other hand, if request->len is too huge (it can be up to 4G,
where we only want 32M at the most), then we really don't want to waste
time on the nbd_drop() call.  That's why req->complete exists in the
first place.  You are right that we could nbd_drop() a padded size (for
example, I just patched nbdkit to gracefully skip up to twice the
maximum block size, and only drop the connection when it exceeds
NBD_MAX_BUFFER_SIZE*2), but again, it's all in the
quality-of-implementation area (a client sending that much data is
already in denial-of-service territory, so we are okay dropping the
connection).  So I'm not worried about any further tweaks to this code
for 2.11.


> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; this patch is now on my queue for 2.11-rc2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrDeSoGh5rosnBUlbhqK0EFGXihhLa9UO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloO9cEACgkQp6FrSiUn
Q2q+9AgAq2A68UX5nbvEROwKWgZAPmkkFohEw2Mk9uABdpMLAFNl1H17S067Dz8v
bx/TCxCv+p/V0l1GdysQEkEuThaSfiWszh3Bv/EwywC0AR9okBcvST2eMTwCALrJ
aK62E9q+569cslmTrY6rzpk8IwiiqB9wBZDE94ZSdW2d7JJPxQxzSUqVWFL/V6GS
AAhAxcDWyiXMbqhIxLDGnbOax8zQVa/5Ue/3Z9XkHY2eZhElZ/C3mS5joqwJeI32
eU96hhehVaXO7d0JrBcWk0UJnxdWaJ6ECWwqqzrI6sRzyQCEeilhbY4YkmVes+oL
QpuBVsue7fDp6wwbPCGiXw0qEqOriw==
=/f0g
-----END PGP SIGNATURE-----

--LrDeSoGh5rosnBUlbhqK0EFGXihhLa9UO--
