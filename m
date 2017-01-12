Received: from eggs.gnu.org ([2001:4830:134:3::10]:49721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkAS-0000ac-09
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRkAO-0005z5-Ox
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRkAO-0005ya-FS
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:32:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B1DD61BB5
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 18:32:04 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-19-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc5e4f20-9ea2-fe8b-eafc-3b35aa4e9aa4@redhat.com>
Date: Thu, 12 Jan 2017 12:32:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-19-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F1Q5A0Qm6VrQIMOOAmPcFL90e7g1g67af"
Subject: Re: [Qemu-devel] [PATCH 18/40] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F1Q5A0Qm6VrQIMOOAmPcFL90e7g1g67af
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <fc5e4f20-9ea2-fe8b-eafc-3b35aa4e9aa4@redhat.com>
Subject: Re: [PATCH 18/40] char: remove class kind field
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> The class kind is necessary to lookup the chardev name in
> qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
> the appropriate ChardevBackend (mainly to free the right
> fields).
>=20
> qemu_chr_new_from_opts() can be changed to use a non-qmp function
> using the chardev class typename. Introduce qemu_chardev_add() to be
> called from qemu_chr_new_from_opts() and remove the class chardev kind
> field. Set the backend->type in the parse callback (when non-common
> fields are added).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> =20
> +static Chardev *qemu_chardev_add(const char *id, const char *typename,=

> +                                 ChardevBackend *backend, Error **errp=
)
> +{
> +    Chardev *chr;
> +
> +    chr =3D qemu_chr_find(id);
> +    if (chr) {
> +        error_setg(errp, "Chardev '%s' already exists", id);
> +        return NULL;
> +    }
> +
> +    chr =3D qemu_chardev_new(id, typename, backend, errp);
> +    if (!chr) {
> +        return NULL;
> +    }
> +
> +    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
> +    return chr;
> +}
> +

This part seems okay.

> @@ -4222,22 +4235,22 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,=

> =20
>      cc =3D char_get_class(name, errp);
>      if (cc =3D=3D NULL) {
> -        goto err;
> +        return NULL;
>      }
> =20
>      backend =3D g_new0(ChardevBackend, 1);
> +    backend->type =3D CHARDEV_BACKEND_KIND_NULL;
> =20
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>          bid =3D g_strdup_printf("%s-base", id);
>      }
> =20
>      chr =3D NULL;
> -    backend->type =3D cc->kind;

I'm not sure I follow this hunk - we used to set backend->type
dynamically and now it is forced to KIND_NULL.  Is the point that we
don't need to set backend->type here because the later call to
qemu_chardev_add()...

> @@ -4245,37 +4258,33 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,=

>          backend->u.null.data =3D ccom; /* Any ChardevCommon member wou=
ld work */
>      }
> =20
> -    ret =3D qmp_chardev_add(bid ? bid : id, backend, errp);
> -    if (!ret) {
> -        goto qapi_out;
> +    chr =3D qemu_chardev_add(bid ? bid : id,
> +                           object_class_get_name(OBJECT_CLASS(cc)),
> +                           backend, errp);

=2E..now passes the Object type which can be used to derive the same same=

information?  In that case, was the assignment to backend->type =3D
KIND_NULL dead?

> +    if (chr =3D=3D NULL) {
> +        goto out;
>      }
> =20
>      if (bid) {
> +        Chardev *mux;
>          qapi_free_ChardevBackend(backend);
> -        qapi_free_ChardevReturn(ret);
>          backend =3D g_new0(ChardevBackend, 1);
> -        backend->u.mux.data =3D g_new0(ChardevMux, 1);
>          backend->type =3D CHARDEV_BACKEND_KIND_MUX;
> +        backend->u.mux.data =3D g_new0(ChardevMux, 1);

Why the churn on the assignment to backend->u.mux.data?

>          backend->u.mux.data->chardev =3D g_strdup(bid);
> -        ret =3D qmp_chardev_add(id, backend, errp);
> -        if (!ret) {
> -            chr =3D qemu_chr_find(bid);
> +        mux =3D qemu_chardev_add(id, TYPE_CHARDEV_MUX, backend, errp);=

> +        if (mux =3D=3D NULL) {
>              qemu_chr_delete(chr);
>              chr =3D NULL;
> -            goto qapi_out;
> +            goto out;
>          }
> +        chr =3D mux;
>      }
> =20
> -    chr =3D qemu_chr_find(id);
> -
> -qapi_out:
> +out:
>      qapi_free_ChardevBackend(backend);
> -    qapi_free_ChardevReturn(ret);
>      g_free(bid);
>      return chr;
> -
> -err:
> -    return NULL;
>  }
> =20

> @@ -5010,24 +5014,18 @@ Chardev *qemu_chardev_new(const char *id, const=
 char *typename,
>  ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
>                                 Error **errp)
>  {
> -    const ChardevClass *cc;
>      ChardevReturn *ret;
> +    const ChardevClass *cc;

Why the churn on this declaration?

>      Chardev *chr;
> =20
> -    chr =3D qemu_chr_find(id);
> -    if (chr) {
> -        error_setg(errp, "Chardev '%s' already exists", id);
> -        return NULL;
> -    }
> -
>      cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], er=
rp);
> -    if (!cc) {
> +    if (cc =3D=3D NULL) {

Why the churn on this conditional?

>          return NULL;
>      }
> =20
> -    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc=
)),
> +    chr =3D qemu_chardev_add(id, object_class_get_name(OBJECT_CLASS(cc=
)),
>                             backend, errp);
> -    if (!chr) {
> +    if (chr =3D=3D NULL) {

and again


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--F1Q5A0Qm6VrQIMOOAmPcFL90e7g1g67af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd8uhAAoJEKeha0olJ0Nq0qgH/2LWzPfS+yem6fNVFCdMHOu8
/v2KcoghlsWRBo+IACGoBvYJDO8pGPlIDoF+tG9WR76gBS0sXdBuO6uNdtOxbY+8
+ZuSDJ/FQiPAwgfoWfjD6iNik6X1OP7RvGmKgI+2orc3ZR5VOmClUJ3c9TkD4JyD
bNIB6cdiwVTi4O4H5g4XXfXyxZg1EFGgVZ32JuB2VKhiEdmjj8yY0Fi878siKITA
SMrM7InUYr+XziOs564HoFYjponA5grd175IIlToYq01e8vm6+jHjw7Fs79Dngjp
BCIe5DWj/+j2J/PLk7Al56xDdfGOcAKzaPeU0VRSIEjslMc03spwE+o2YOKTfDs=
=ASYa
-----END PGP SIGNATURE-----

--F1Q5A0Qm6VrQIMOOAmPcFL90e7g1g67af--
