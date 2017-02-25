Received: from eggs.gnu.org ([2001:4830:134:3::10]:33728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheuB-0001Hm-4o
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheu7-0001Mu-5s
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:09:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cheu6-0001Mm-Sr
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:09:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 865FE4E4D2
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 16:09:02 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-13-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d05878a3-d77a-627d-9f94-a0fdf175e280@redhat.com>
Date: Sat, 25 Feb 2017 10:08:59 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-13-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UIBAIvbR4eBaHtEdq8W3SQermfqLFnLlh"
Subject: Re: [Qemu-devel] [PATCH 12/21] qapi: Improve qobject input visitor
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UIBAIvbR4eBaHtEdq8W3SQermfqLFnLlh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d05878a3-d77a-627d-9f94-a0fdf175e280@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/21] qapi: Improve qobject input visitor
 error reporting
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-13-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> Error messages refer to nodes of the QObject being visited by name.
> Trouble is the names are sometimes less than helpful:
>=20

> Improve error messages by referring to nodes by path instead, as
> follows:
>=20
> * The path of the root QObject is whatever @name argument got passed
>   to the visitor, except NULL gets mapped to "<anonymous>".
>=20
> * The path of a root QDict's member is the member key.
>=20
> * The path of a root QList's member is "[%zu]", where %zu is the list
>   index, starting at zero.
>=20
> * The path of a non-root QDict's member is the path of the QDict
>   concatenated with "." and the member key.
>=20
> * The path of a non-root QList's member is the path of the QList
>   concatenated with "[%zu]", where %zu is the list index.
>=20

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor.h       |   6 ---
>  qapi/qobject-input-visitor.c | 121 +++++++++++++++++++++++++++++++----=
--------
>  2 files changed, 87 insertions(+), 40 deletions(-)
>=20

> +typedef struct StackObject {
> +    const char *name;            /* Name of @obj in its parent, if any=
 */
> +    QObject *obj;                /* QDict or QList being visited */
>      void *qapi; /* sanity check that caller uses same pointer */
> =20
> -    GHashTable *h;           /* If obj is dict: unvisited keys */
> -    const QListEntry *entry; /* If obj is list: unvisited tail */
> +    GHashTable *h;              /* If @obj is QDict: unvisited keys */=

> +    const QListEntry *entry;    /* If @obj is QList: unvisited tail */=

> +    unsigned index;             /* If @obj is QList: list index of @en=
try */

Could perhaps make the QDict vs. QList fields shared through a union if
we were tight on storage space or cache line pressure. I don't think
that's the case, though, so no need to change it.

> +static const char *full_name(QObjectInputVisitor *qiv, const char *nam=
e)
> +{
> +    StackObject *so;
> +    char buf[32];
> +
> +    if (qiv->errname) {
> +        g_string_truncate(qiv->errname, 0);
> +    } else {
> +        qiv->errname =3D g_string_new("");
> +    }
> +
> +    QSLIST_FOREACH(so , &qiv->stack, node) {
> +        if (qobject_type(so->obj) =3D=3D QTYPE_QDICT) {
> +            g_string_prepend(qiv->errname, name);
> +            g_string_prepend_c(qiv->errname, '.');
> +        } else {
> +            snprintf(buf, sizeof(buf), "[%u]", so->index);
> +            g_string_prepend(qiv->errname, buf);
> +        }
> +        name =3D so->name;
> +    }

Building the string from back to front requires quite a bit of memory
reshuffling, as well as the temporary buffer for integer formatting. Is
there any way to build it from front to back? But this code is only
triggered on error paths, so I don't care if it is slow.  I'm fine with
what you have.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UIBAIvbR4eBaHtEdq8W3SQermfqLFnLlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsawbAAoJEKeha0olJ0Nq/kUIAJALjSVhlyl48IwHumVdz103
2ELHnls26Ggsj6/zzdLETD2Ci6sj+Ea8ZB21xwuirxp2QADIdwpVRwA3zR+ZjmSc
boepV2ChEdMmGaMrQojGXyuGzGUBixcEWSwOKYepMEaaUcCx+VRToUfEOTyo+gDp
5YNyZtqzi7Nx13f3V2i4fNZbKxy7cI1W1QnMWyXKLd1AQIeC0vDgY7XCjCnQHKc4
bQEtCl55i7YUDLvcFpkORq/Xe+rMsF1LYm1c+6GvhUctIafTAQuCcTAG2b+cydGA
moAaCMEVUq3aInuGV85tKgYaV2V0HgZogJy+dN4xEm1B85O837Ic6wScumdo19A=
=yomH
-----END PGP SIGNATURE-----

--UIBAIvbR4eBaHtEdq8W3SQermfqLFnLlh--
