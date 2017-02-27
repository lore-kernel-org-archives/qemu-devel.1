Received: from eggs.gnu.org ([2001:4830:134:3::10]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOQs-0000y9-E1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOQp-0004u8-3H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:45:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciOQo-0004tn-QB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:45:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A237D4E4CF
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:45:50 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-13-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed45fe0d-edd5-e201-e876-11af0c3e954a@redhat.com>
Date: Mon, 27 Feb 2017 10:45:48 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-13-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KDkHWquxaHwxC3VOXFGOHb8RagUrhKTU5"
Subject: Re: [Qemu-devel] [PATCH v2 12/26] qapi: Improve qobject input
 visitor error reporting
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
--KDkHWquxaHwxC3VOXFGOHb8RagUrhKTU5
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ed45fe0d-edd5-e201-e876-11af0c3e954a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/26] qapi: Improve qobject input visitor
 error reporting
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-13-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
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

%zu here, but...


>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor.h       |   6 ---
>  qapi/qobject-input-visitor.c | 121 +++++++++++++++++++++++++++++++----=
--------
>  2 files changed, 87 insertions(+), 40 deletions(-)
>=20

> =20
> -typedef struct StackObject
> -{
> -    QObject *obj; /* Object being visited */
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

> +    QSLIST_FOREACH(so , &qiv->stack, node) {
> +        if (qobject_type(so->obj) =3D=3D QTYPE_QDICT) {
> +            g_string_prepend(qiv->errname, name);
> +            g_string_prepend_c(qiv->errname, '.');
> +        } else {
> +            snprintf(buf, sizeof(buf), "[%u]", so->index);

=2E..%u here.  Minor inconsistency in the commit message, but I'm okay
mere 'unsigned' in the code, as we'd probably have other problems long
before hitting a list with 2 billion entries, even on platforms where
size_t is 64-bit.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KDkHWquxaHwxC3VOXFGOHb8RagUrhKTU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFe8AAoJEKeha0olJ0Nq3xkH/02jHenXRBO9p4lQhsenqh5b
nTMK5/nZ9qNsc5BJLAbjJbtuRMcmuKJwU7j2GbYOxVhbBcgsEnZqJYhCs44+y4F9
PvWsegT1hz9AxyTXR0MetvEfpqXGdS4vwzsWGd1uKmM+lDYlsdtZLwsRiGIJkVju
RuQZBFUQciRJhZr+dl6KMvDEuL1IXge0BfRz9caKSNNeUWOj0GsC/GZdpTf4rjrJ
ZqAxraFcogdygTkKX5mDsCinvKLnxtXvQggFFiJ304OelQLW5JlwYyrNhkkK13aL
InmGpbGljgrUWJUUPoFw0sxSGjIWWDWgIglXAXqzt1Utygk5RDtKKeB2ONTtk34=
=pT9/
-----END PGP SIGNATURE-----

--KDkHWquxaHwxC3VOXFGOHb8RagUrhKTU5--
