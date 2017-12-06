Received: from eggs.gnu.org ([2001:4830:134:3::10]:60965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMd4s-0001la-VC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMd4r-0000Ia-Vz
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:01:47 -0500
References: <20171117150556.16947-1-eblake@redhat.com>
	<20171117150556.16947-4-eblake@redhat.com>
	<151257931348.8987.3352482385411558267@sif>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5743a286-4f94-1944-55eb-955191d0bf18@redhat.com>
Date: Wed, 6 Dec 2017 11:01:34 -0600
MIME-Version: 1.0
In-Reply-To: <151257931348.8987.3352482385411558267@sif>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h3VTav11BkWNeTSRLCeSXB6XuilTeDwJ7"
Subject: Re: [Qemu-devel] [PULL 3/4] nbd/client: Don't hard-disconnect on
 ESHUTDOWN from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3VTav11BkWNeTSRLCeSXB6XuilTeDwJ7
From: Eric Blake <eblake@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <5743a286-4f94-1944-55eb-955191d0bf18@redhat.com>
Subject: Re: [Qemu-devel] [PULL 3/4] nbd/client: Don't hard-disconnect on
 ESHUTDOWN from server
References: <20171117150556.16947-1-eblake@redhat.com>
 <20171117150556.16947-4-eblake@redhat.com>
 <151257931348.8987.3352482385411558267@sif>
In-Reply-To: <151257931348.8987.3352482385411558267@sif>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 10:55 AM, Michael Roth wrote:
> Quoting Eric Blake (2017-11-17 09:05:55)
>> The NBD spec says that a server may fail any transmission request
>> with ESHUTDOWN when it is apparent that no further request from
>> the client can be successfully honored.  The client is supposed
>> to then initiate a soft shutdown (wait for all remaining in-flight
>> requests to be answered, then send NBD_CMD_DISC).  However, since
>> qemu's server never uses ESHUTDOWN errors, this code was mostly
>> untested since its introduction in commit b6f5d3b5.
>>
>> More recently, I learned that nbdkit as the NBD server is able to
>> send ESHUTDOWN errors, so I finally tested this code, and noticed
>> that our client was special-casing ESHUTDOWN to cause a hard
>> shutdown (immediate disconnect, with no NBD_CMD_DISC), but only
>> if the server sends this error as a simple reply.  Further
>> investigation found that commit d2febedb introduced a regression
>> where structured replies behave differently than simple replies -
>> but that the structured reply behavior is more in line with the
>> spec (even if we still lack code in nbd-client.c to properly quit
>> sending further requests).  So this patch reverts the portion of
>> b6f5d3b5 that introduced an improper hard-disconnect special-case
>> at the lower level, and leaves the future enhancement of a nicer
>> soft-disconnect at the higher level for another day.
>>
>> CC: qemu-stable@nongnu.org
>=20
> Since 2.10.x lacks d2febedb, the patch would look something like:
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 4caff77119..f04e95542f 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -945,12 +945,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDRepl=
y *reply, Error **errp)
>      reply->handle =3D ldq_be_p(buf + 8);
> =20
>      reply->error =3D nbd_errno_to_system_errno(reply->error);
> -
> -    if (reply->error =3D=3D ESHUTDOWN) {
> -        /* This works even on mingw which lacks a native ESHUTDOWN */
> -        error_setg(errp, "server shutting down");
> -        return -EINVAL;
> -    }
>      trace_nbd_receive_reply(magic, reply->error, reply->handle);
> =20
>      if (magic !=3D NBD_REPLY_MAGIC) {
>=20
> If that seems reasonable I can apply it as such.

Your backport looks correct to me; thanks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--h3VTav11BkWNeTSRLCeSXB6XuilTeDwJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlooIm4ACgkQp6FrSiUn
Q2qUHgf+KdEKPSJIFtZDtAgcmTylp8dG6LRwNMwrxexgLpvZ4R4A40K/BFDFQ9v4
2q6KWGJgXf2wIXK6sfr1DVa6tHt6Irsqe0ZRzJ1UFJSR547PiP7pSiQbH3kRN62M
aVlhtFtIXU/rsjJKPBP2bxPaiwp/UURnORN3NGrF47pS81k8rOUYjsEcol3c4koc
iT92VgxwEjm8F9HLFUPz7ofFtsNtGkDjVxU5+2hcULT/1j7rOdY6P5DHJrCOn8OQ
GhqUtIsh2Ol99ikiwSJmgne+224UOPJezqZYaevcHgFSgsrspfdvh4cOIsU8ceuB
Q07yyIkpmM9TPe+obg/fPdPnXfSJYg==
=4sEZ
-----END PGP SIGNATURE-----

--h3VTav11BkWNeTSRLCeSXB6XuilTeDwJ7--
