Received: from eggs.gnu.org ([2001:4830:134:3::10]:43089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS3hw-0000tv-2V
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS3hr-0006t3-6U
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:24:00 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:42539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cS3hq-0006sG-To
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:23:55 -0500
Date: Fri, 13 Jan 2017 10:23:54 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <724848068.2316978.1484321034557.JavaMail.zimbra@redhat.com>
In-Reply-To: <fc5e4f20-9ea2-fe8b-eafc-3b35aa4e9aa4@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-19-marcandre.lureau@redhat.com>
	<fc5e4f20-9ea2-fe8b-eafc-3b35aa4e9aa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/40] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi

----- Original Message -----
> On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> > The class kind is necessary to lookup the chardev name in
> > qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
> > the appropriate ChardevBackend (mainly to free the right
> > fields).
> >=20
> > qemu_chr_new_from_opts() can be changed to use a non-qmp function
> > using the chardev class typename. Introduce qemu_chardev_add() to be
> > called from qemu_chr_new_from_opts() and remove the class chardev kind
> > field. Set the backend->type in the parse callback (when non-common
> > fields are added).
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
>=20
> > =20
> > +static Chardev *qemu_chardev_add(const char *id, const char *typename,
> > +                                 ChardevBackend *backend, Error **errp=
)
> > +{
> > +    Chardev *chr;
> > +
> > +    chr =3D qemu_chr_find(id);
> > +    if (chr) {
> > +        error_setg(errp, "Chardev '%s' already exists", id);
> > +        return NULL;
> > +    }
> > +
> > +    chr =3D qemu_chardev_new(id, typename, backend, errp);
> > +    if (!chr) {
> > +        return NULL;
> > +    }
> > +
> > +    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
> > +    return chr;
> > +}
> > +
>=20
> This part seems okay.
>=20
> > @@ -4222,22 +4235,22 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> > =20
> >      cc =3D char_get_class(name, errp);
> >      if (cc =3D=3D NULL) {
> > -        goto err;
> > +        return NULL;
> >      }
> > =20
> >      backend =3D g_new0(ChardevBackend, 1);
> > +    backend->type =3D CHARDEV_BACKEND_KIND_NULL;
> > =20
> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
> >          bid =3D g_strdup_printf("%s-base", id);
> >      }
> > =20
> >      chr =3D NULL;
> > -    backend->type =3D cc->kind;
>=20
> I'm not sure I follow this hunk - we used to set backend->type
> dynamically and now it is forced to KIND_NULL.  Is the point that we
> don't need to set backend->type here because the later call to
> qemu_chardev_add()...

I tried to explain some of the reasons in the commit message.

We need backend->type to be set correctly for the qapi_free_ChardevBackend(=
) to work. The kind field used to be on a class member, but we try to get r=
id of it. So we move that information to _parse(), and change the backend t=
ype appropriately there.

KIND_NULL is the common backend (sharing ChardevCommon).

>=20
> > @@ -4245,37 +4258,33 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> >          backend->u.null.data =3D ccom; /* Any ChardevCommon member wou=
ld
> >          work */
> >      }
> > =20
> > -    ret =3D qmp_chardev_add(bid ? bid : id, backend, errp);
> > -    if (!ret) {
> > -        goto qapi_out;
> > +    chr =3D qemu_chardev_add(bid ? bid : id,
> > +                           object_class_get_name(OBJECT_CLASS(cc)),
> > +                           backend, errp);
>=20
> ...now passes the Object type which can be used to derive the same same
> information?  In that case, was the assignment to backend->type =3D
> KIND_NULL dead?

0 is KIND_FILE, which would lead to invalid free.
=20
> > +    if (chr =3D=3D NULL) {
> > +        goto out;
> >      }
> > =20
> >      if (bid) {
> > +        Chardev *mux;
> >          qapi_free_ChardevBackend(backend);
> > -        qapi_free_ChardevReturn(ret);
> >          backend =3D g_new0(ChardevBackend, 1);
> > -        backend->u.mux.data =3D g_new0(ChardevMux, 1);
> >          backend->type =3D CHARDEV_BACKEND_KIND_MUX;
> > +        backend->u.mux.data =3D g_new0(ChardevMux, 1);
>=20
> Why the churn on the assignment to backend->u.mux.data?

fixed

>=20
> >          backend->u.mux.data->chardev =3D g_strdup(bid);
> > -        ret =3D qmp_chardev_add(id, backend, errp);
> > -        if (!ret) {
> > -            chr =3D qemu_chr_find(bid);
> > +        mux =3D qemu_chardev_add(id, TYPE_CHARDEV_MUX, backend, errp);
> > +        if (mux =3D=3D NULL) {
> >              qemu_chr_delete(chr);
> >              chr =3D NULL;
> > -            goto qapi_out;
> > +            goto out;
> >          }
> > +        chr =3D mux;
> >      }
> > =20
> > -    chr =3D qemu_chr_find(id);
> > -
> > -qapi_out:
> > +out:
> >      qapi_free_ChardevBackend(backend);
> > -    qapi_free_ChardevReturn(ret);
> >      g_free(bid);
> >      return chr;
> > -
> > -err:
> > -    return NULL;
> >  }
> > =20
>=20
> > @@ -5010,24 +5014,18 @@ Chardev *qemu_chardev_new(const char *id, const
> > char *typename,
> >  ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
> >                                 Error **errp)
> >  {
> > -    const ChardevClass *cc;
> >      ChardevReturn *ret;
> > +    const ChardevClass *cc;
>=20
> Why the churn on this declaration?

sorry, too many rebases, conflicts.. fixed

>=20
> >      Chardev *chr;
> > =20
> > -    chr =3D qemu_chr_find(id);
> > -    if (chr) {
> > -        error_setg(errp, "Chardev '%s' already exists", id);
> > -        return NULL;
> > -    }
> > -
> >      cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], er=
rp);
> > -    if (!cc) {
> > +    if (cc =3D=3D NULL) {
>=20
> Why the churn on this conditional?
>=20
> >          return NULL;
> >      }
> > =20
> > -    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc=
)),
> > +    chr =3D qemu_chardev_add(id, object_class_get_name(OBJECT_CLASS(cc=
)),
> >                             backend, errp);
> > -    if (!chr) {
> > +    if (chr =3D=3D NULL) {
>=20
> and again
>=20
>=20
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
