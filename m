Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEM2H-0007zl-8K
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEM2G-0003Nc-6D
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:40:37 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e290a5f6-665c-79e1-cf34-d9eb622050d9@redhat.com>
Date: Fri, 26 May 2017 15:40:27 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GAvBAm7ek0SPmwN1N789UfP73Wn1RH84U"
Subject: Re: [Qemu-devel] [PATCH 01/29] qed: Use bottom half to resume
 waiting requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GAvBAm7ek0SPmwN1N789UfP73Wn1RH84U
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <e290a5f6-665c-79e1-cf34-d9eb622050d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/29] qed: Use bottom half to resume waiting
 requests
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> The qed driver serialises allocating write requests. When the active
> allocation is finished, the AIO callback is called, but after this, the=

> next allocating request is immediately processed instead of leaving the=

> coroutine. Resuming another allocation request in the same request
> coroutine means that the request now runs in the wrong coroutine.
>=20
> The following is one of the possible effects of this: The completed
> request will generally reenter its request coroutine in a bottom half,
> expecting that it completes the request in bdrv_driver_pwritev().
> However, if the second request actually yielded before leaving the
> coroutine, the reused request coroutine is in an entirely different
> place and is reentered prematurely. Not a good idea.
>=20
> Let's make sure that we exit the coroutine after completing the first
> request by resuming the next allocating request only with a bottom
> half.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GAvBAm7ek0SPmwN1N789UfP73Wn1RH84U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJK7AAoJEKeha0olJ0NqqsYIAK+8zIN57ZQd6nTZTV6k2E3V
evoBhzc5ftnHDiiTEokuc2AvUDdh3nzD261Odk5tRpN9rDUUPqEdxPrrAsWiX3l+
Rj9K92bZEfQkZoWTlHWQlW7SRfgwDdyQNwagliDd3cK6VIa2gwf1HGAWNKsiZS+C
zHSoRp64U9d6ZG069232EVQYahB8+Cm96ceWoanyQL52GuFGujFBnvxMO+UpAcL+
MAes0vF0jEe4GeIqubwtusvpKp6SjBLsNfqvLC7Bba8zr30GGld7J2SDT+mXMXAq
YA9wj9u61rJYX9K8SZtOMNDIrinjDRQ1sI6crIOr7QL2YgV0Q5oytU2xJrOzp30=
=H0cl
-----END PGP SIGNATURE-----

--GAvBAm7ek0SPmwN1N789UfP73Wn1RH84U--
