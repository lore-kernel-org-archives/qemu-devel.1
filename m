Received: from eggs.gnu.org ([2001:4830:134:3::10]:59752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHYVy-0006ho-4s
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHYVw-0004LF-Ox
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:08:46 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7572daf-a3dc-a6bf-ae60-a2e825bfc38d@redhat.com>
Date: Wed, 22 Nov 2017 11:08:35 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gWXxKEcChkRP2EFpRssb0wUsQ7dpd9vVe"
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd/server: add nbd_opt_{read,
 drop} to track client->optlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWXxKEcChkRP2EFpRssb0wUsQ7dpd9vVe
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <a7572daf-a3dc-a6bf-ae60-a2e825bfc38d@redhat.com>
Subject: Re: [PATCH 2/5] nbd/server: add nbd_opt_{read,drop} to track
 client->optlen
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The subject line says what and sort of implies why, but the commit
message body is rather sparse.

> ---
>  nbd/server.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Not a net win in lines of code, so a bit more justification may be helpfu=
l.

>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index bccc0274e7..c9445a89e9 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -139,6 +139,19 @@ static void nbd_client_receive_next_request(NBDCli=
ent *client);
> =20
>  */
> =20
> +static inline int nbd_opt_read(NBDClient *client, void *buffer, size_t=
 size,
> +                               Error **errp)
> +{
> +    client->optlen -=3D size;
> +    return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ?=
 -EIO : 0;

Should this code check that client->optlen >=3D size, and issue the
appropriate error message if not? That may centralize some of the error
checking repeated elsewhere.

> +}
> +
> +static inline int nbd_opt_drop(NBDClient *client, size_t size, Error *=
*errp)
> +{
> +    client->optlen -=3D size;
> +    return nbd_drop(client->ioc, size, errp);

Same question on size validation.

> +}
> +
>  /* Send a reply header, including length, but no payload.
>   * Return -errno on error, 0 on success. */
>  static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type=
,
> @@ -299,7 +312,7 @@ static int nbd_negotiate_handle_export_name(NBDClie=
nt *client,
>          error_setg(errp, "Bad length received");
>          return -EINVAL;
>      }
> -    if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
> +    if (nbd_opt_read(client, name, client->optlen, errp) < 0) {
>          error_prepend(errp, "read failed: ");
>          return -EINVAL;

Here's an example caller that had a previous size validation.

>      }
> @@ -383,40 +396,36 @@ static int nbd_negotiate_handle_info(NBDClient *c=
lient, uint16_t myflags,
>          msg =3D "overall request too short";
>          goto invalid;
>      }
> -    if (nbd_read(client->ioc, &namelen, sizeof(namelen), errp) < 0) {
> +    if (nbd_opt_read(client, &namelen, sizeof(namelen), errp) < 0) {
>          return -EIO;

And again, a size validation right before the call.

>      }
>      be32_to_cpus(&namelen);
> -    client->optlen -=3D sizeof(namelen);

Okay, part of the refactoring means you don't have to remember to track
remaining size separately from reading; that's a nice feature.  I
suspect it is also possible to assert that client->optlen is zero before
reading the next opt (I'm reviewing the patch in order, we'll see if I
come back here). [1]

>      if (namelen > client->optlen - sizeof(requests) ||
>          (client->optlen - namelen) % 2)
>      {
>          msg =3D "name length is incorrect";
>          goto invalid;
>      }
> -    if (nbd_read(client->ioc, name, namelen, errp) < 0) {
> +    if (nbd_opt_read(client, name, namelen, errp) < 0) {
>          return -EIO;
>      }

Another size check prior to the call (actually checking multiple
conditions)...

>      name[namelen] =3D '\0';
> -    client->optlen -=3D namelen;
>      trace_nbd_negotiate_handle_export_name_request(name);
> =20
> -    if (nbd_read(client->ioc, &requests, sizeof(requests), errp) < 0) =
{
> +    if (nbd_opt_read(client, &requests, sizeof(requests), errp) < 0) {=

>          return -EIO;

=2E..and no direct size check before this call, because the earlier size
checks already covered it.  Arguably, the in-place size check error
messages may be slightly more precise, but any message at all about
unexpected sizing is appropriate (given that only broken clients should
be sending incorrect sizes) - so I'm still leaning towards a stronger
refactoring that puts the size check in the helper function.

> @@ -521,7 +530,7 @@ static int nbd_negotiate_handle_info(NBDClient *cli=
ent, uint16_t myflags,
>      return rc;
> =20
>   invalid:
> -    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
> +    if (nbd_opt_drop(client, client->optlen, errp) < 0) {
>          return -EIO;
>      }
>      return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
> @@ -715,7 +724,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 uint16_t myflags,
>                  return -EINVAL;
> =20
>              default:
> -                if (nbd_drop(client->ioc, length, errp) < 0) {
> +                if (nbd_opt_drop(client, length, errp) < 0) {

Isn't length =3D=3D client->optlen here? If so, can we omit the length
parameter to nbd_opt_drop(), and instead have it defined as dropping to
the end of the current option?

> @@ -821,6 +830,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 uint16_t myflags,
>          if (ret < 0) {
>              return ret;
>          }
> +        assert(client->optlen =3D=3D 0);

[1] Ah, you did add the assertion.

I'm going to propose a variant on this patch, to cover the points I made
above about ease-of-use (and to hopefully show a net win in lines of code=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gWXxKEcChkRP2EFpRssb0wUsQ7dpd9vVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloVrxMACgkQp6FrSiUn
Q2oaWwf/SKwZJQMZcxIM/nPxKdgJmKmGgn5Ary7iweVGRkgkfHz4rSrKstR9MlvX
x+thPHm1mm9aCYWIean/E23OaNilz5L5bsl7+lPsKBzAvh5bU/cdg3BQsB5+6sTG
ngKNEAQ3T+auizzEp7Qpo+lUkqyKGre0qL1n+b4fOTCiiCSinnPO7WuFpZ+0LTfa
YvLm+7pHzbo9CBsAFNOXlna/THa1zsCRCqP7/GAQZ0ChFrPdZnGykJekHeJfom6R
TkGC9O5NJxyJ+ONrgnxqgeEkfTFZB29rzQIvYd9w3DnWNqY6iYPZWSMp6ZrYOSWr
pLaDouLzR1RdJYioAnQheyBp9WuS+g==
=6S0F
-----END PGP SIGNATURE-----

--gWXxKEcChkRP2EFpRssb0wUsQ7dpd9vVe--
