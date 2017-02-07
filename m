Received: from eggs.gnu.org ([2001:4830:134:3::10]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb8gc-0005Bz-9u
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb8ga-0006Nf-VS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:32:10 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
Date: Tue, 7 Feb 2017 10:32:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v3DlCPL5OaT8vNXB4ojaK1dMlnNKk0wiX"
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v3DlCPL5OaT8vNXB4ojaK1dMlnNKk0wiX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
Subject: Re: [PATCH 04/18] nbd/client: refactor nbd_receive_starttls
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Split out nbd_receive_simple_option to be reused for structured reply
> option.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c       | 54 +++++++++++++++++++++++++++++++++++-----------=
--------
>  nbd/nbd-internal.h | 14 ++++++++++++++
>  2 files changed, 49 insertions(+), 19 deletions(-)
>=20

> +++ b/nbd/nbd-internal.h
> @@ -96,6 +96,20 @@
>  #define NBD_ENOSPC     28
>  #define NBD_ESHUTDOWN  108
> =20
> +static inline const char *nbd_opt_name(int opt)
> +{
> +    switch (opt) {
> +    case NBD_OPT_EXPORT_NAME: return "export_name";

Does this really get past checkpatch?

> +    case NBD_OPT_ABORT: return "abort";
> +    case NBD_OPT_LIST: return "list";
> +    case NBD_OPT_PEEK_EXPORT: return "peek_export";
> +    case NBD_OPT_STARTTLS: return "tls";

Why just 'tls' instead of 'starttls'?

> +    case NBD_OPT_STRUCTURED_REPLY: return "structured_reply";
> +    }
> +
> +    return "<unknown option>";

Can you please consider making this include the %d representation of the
unknown option; perhaps by snprintf'ing into static storage?  While it
is unlikely that a well-behaved server will respond to a client with an
option the client doesn't recognize, it is much more likely that this
reverse lookup function will be used in a server to respond to an
unknown option from a client.

In fact, I might have split this into two patches: one providing
nbd_opt_name() and using it throughout the code base where appropriate,
and the other refactoring starttls in the client.

I'm not sure if the reverse lookup function needs to be inline in the
header; it could reasonably live in nbd/common.c, particularly if you
are going to take my advice to have it format a message for unknown value=
s.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--v3DlCPL5OaT8vNXB4ojaK1dMlnNKk0wiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmfaAAAoJEKeha0olJ0NqEFgH/37ZUQXzYYLuhfsoI7AACUtV
J5PrFcVwoDBUru/evO/sOrd3QwMyiGq7rgjTiv+VolpPNS0fz1tN3eJkfdCWCx2l
DgUc5HMgWh3Ly98hNmyAW3/qgXgnNIqxdmsNScIhVizb7GC1OBtwuqGhmIctvvAi
IdzzGptfC4awtveDCFHZ5zVitpB5JDk1H716k8MnaHOX1f/kok6+bUdCkFl6vvS/
aqxXMfuZ894Rg+UeO+KaaNYJjL05OnOK2qMHS0IJHdWVh0MJGYV7un2FfswNoN0h
MkV+9W8RIocQcotIcObsBFQyF+uaInbo1eXD+3IOUoL6BBpTt+OlUv7AjT/8kMs=
=zUde
-----END PGP SIGNATURE-----

--v3DlCPL5OaT8vNXB4ojaK1dMlnNKk0wiX--
