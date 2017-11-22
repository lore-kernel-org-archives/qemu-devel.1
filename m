Received: from eggs.gnu.org ([2001:4830:134:3::10]:47973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHbFA-0005QO-Hm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHbF9-0004tX-CP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:03:36 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a07578ae-f57b-cb82-e87e-23b6c39cbd10@redhat.com>
Date: Wed, 22 Nov 2017 14:03:25 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PImqWjFIqbiGF3CsLRT07Flb4XwmXNuJd"
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
--PImqWjFIqbiGF3CsLRT07Flb4XwmXNuJd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <a07578ae-f57b-cb82-e87e-23b6c39cbd10@redhat.com>
Subject: Re: [PATCH 2/5] nbd/server: add nbd_opt_{read,drop} to track
 client->optlen
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>=20

Hmm, revisiting my idea about moving more of the error checking into the
helper function.  As of this patch, we only have two clients of
nbd_opt_read:

> @@ -299,7 +312,7 @@ static int nbd_negotiate_handle_export_name(NBDClie=
nt *client,
>          error_setg(errp, "Bad length received");
>          return -EINVAL;
>      }
> -    if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
> +    if (nbd_opt_read(client, name, client->optlen, errp) < 0) {
>          error_prepend(errp, "read failed: ");
>          return -EINVAL;

1. NBD_OPT_EXPORT_NAME, where the length check is based on the maximum
size name we're willing to accept (and NOT on comparison to the header
size, as we request the entire client->optlen).  This call cannot send
an error reply (so if the length is bogus, we can just drop the
connection by returning -EINVAL).  Furthermore, once we handle this
option, option processing is done; we do not reach the assert that
client->optlen =3D=3D 0.

>      }
> @@ -383,40 +396,36 @@ static int nbd_negotiate_handle_info(NBDClient *c=
lient, uint16_t myflags,
>          msg =3D "overall request too short";
>          goto invalid;
>      }
> -    if (nbd_read(client->ioc, &namelen, sizeof(namelen), errp) < 0) {
> +    if (nbd_opt_read(client, &namelen, sizeof(namelen), errp) < 0) {
>          return -EIO;
>      }

2. Multiple calls within NBD_OPT_INFO/NBD_OPT_GO.  Here, the length
check is based on our read being a subset of client->optlen, and our
desired response on a failed check is whatever is at the invalid: label,
namely:

 invalid:
    if (nbd_opt_drop(client, client->optlen, errp) < 0) {
        return -EIO;
    }
    return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
                                      errp, "%s", msg);

We want to drop all remaining data, reply to the client, and return 0 to
keep the connection alive (or -EIO if the read or write failed).

You are planning on adding more calls withing NBD_OPT_LIST_META_CONTEXT,
which will have semantics more like 2 (if we detect an inconsistent
size, we want to consume the rest of the input and return an EINVAL
reply to the client, but keep the connection alive unless there is an
I/O error in the meantime).

I think that means we need a tri-state return from nbd_opt_read(): < 0
on I/O failure, 0 if the EINVAL message has been sent, and 1 if the read
was successful; I also think it means that the handler for
NBD_OPT_EXPORT_NAME does not really fit the bill for using the same
handler.  Hopefully this explanation will give you more insight into the
counter-proposal patch I'm about to post.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PImqWjFIqbiGF3CsLRT07Flb4XwmXNuJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloV2A0ACgkQp6FrSiUn
Q2r8bgf+KKkKD6wKrrhoO8m3BdSxQlbc9Dsalfc2aVj6Qq4fh98u7MgIE0kTXCcx
hyuQiRP5TvaUeDYwfMYtOw2YiTK8/7VelwS057sfsbh++HD+G9PwJzxAuclEDsRK
vK/fEwf0R0mK7d/SzVFKg0McibAem/LMhymrNaEyke15PjFbDY8u16eyHumZ/6BR
QWhCvIXzo7rHC0O81EvAqi11EdQJv42VtBNzt5wPDhHCw6/V19+/DuHTKZxxYL2E
4s7HG5AHvAWGz8Hpxn1XYF/lRHMl0l8wb5a0DdTI6QKxdlka/gcLOv4RetQLoYI+
uX6b7HMthxpl/Fv+NECqBxIgpkPslw==
=aPZt
-----END PGP SIGNATURE-----

--PImqWjFIqbiGF3CsLRT07Flb4XwmXNuJd--
