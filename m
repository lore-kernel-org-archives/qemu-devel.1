Received: from eggs.gnu.org ([2001:4830:134:3::10]:46119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqk40-00044g-Fo
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqk3r-0002z8-5J
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:28:44 -0400
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
	<1490198748-4753-17-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de690e38-11f0-9474-b862-72619aec602e@redhat.com>
Date: Wed, 22 Mar 2017 12:28:34 -0500
MIME-Version: 1.0
In-Reply-To: <1490198748-4753-17-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7KsfgUtxgeo5xUFImxNJuVJL2KUtcbcU1"
Subject: Re: [Qemu-devel] [PULL for-2.9 16/17] qom: Avoid unvisited
 'id'/'qom-type' in user_creatable_add_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7KsfgUtxgeo5xUFImxNJuVJL2KUtcbcU1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <de690e38-11f0-9474-b862-72619aec602e@redhat.com>
Subject: Re: [PULL for-2.9 16/17] qom: Avoid unvisited 'id'/'qom-type' in
 user_creatable_add_opts
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
 <1490198748-4753-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 11:05 AM, Markus Armbruster wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> A regression in commit 15c2f669e caused us to silently ignore
> excess input to the QemuOpts visitor.  Later, commit ea4641
> accidentally abused that situation, by removing "qom-type" and
> "id" from the corresponding QDict but leaving them defined in
> the QemuOpts, when using the pair of containers to create a
> user-defined object. Note that since we are already traversing
> two separate items (a QDict and a QemuOpts), we are already
> able to flag bogus arguments, as in:
>=20

> +++ b/qom/object_interfaces.c
> @@ -114,7 +114,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Err=
or **errp)
>      QDict *pdict;
>      Object *obj;
>      const char *id =3D qemu_opts_id(opts);
> -    const char *type =3D qemu_opt_get(opts, "qom-type");
> +    char *type =3D qemu_opt_get_del(opts, "qom-type");
> =20
>      if (!type) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
> @@ -125,14 +125,15 @@ Object *user_creatable_add_opts(QemuOpts *opts, E=
rror **errp)
>          return NULL;
>      }

Shoot - I missed the memory leak of type if id is not present. I'll post
the fixup, but depending on timing, it may have to be a separate patch
rather than a v2 pull request.

> =20
> +    qemu_opts_set_id(opts, NULL);
>      pdict =3D qemu_opts_to_qdict(opts, NULL);
> -    qdict_del(pdict, "qom-type");
> -    qdict_del(pdict, "id");
> =20
>      v =3D opts_visitor_new(opts);
>      obj =3D user_creatable_add_type(type, id, pdict, v, errp);
>      visit_free(v);
> =20
> +    qemu_opts_set_id(opts, (char *) id);
> +    g_free(type);
>      QDECREF(pdict);
>      return obj;
>  }
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7KsfgUtxgeo5xUFImxNJuVJL2KUtcbcU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0rRCAAoJEKeha0olJ0Nq07EH/Ai0iuan0vkD5dlVRjLACywQ
PeN2c2H2GRneeZagnQ8Fkt2ggtq+AW7tIsk/LcWBZQRNe/pp84bdMgCGyoctkcOJ
Ap7hXDcLA9KY1vRxmdlXXH6gNb4tw2U7cisn6B+u/6V0LBktFxmk/M58anBqeaUe
XXNp9HdEJJC8TgK3D1lekH7wUXm7ZJdD+XoFyi12eGuqgeixyLlfaOL9XlTLaVAw
Mil/DnoCK4VQutHzFjjFq8awODDVWDvLR8uKZyanB3E5cs3O5KEA2joEeCybnVmX
EQRxpDJpou4Cjx5xgIq4EMGp7HJMDAe4MOTl29+OfbRsdy6eqIj15Eo/oKJQldY=
=0tPF
-----END PGP SIGNATURE-----

--7KsfgUtxgeo5xUFImxNJuVJL2KUtcbcU1--
