Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cL-0003fg-37
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cH-0004Vs-WC
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:45 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:47264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cO4cH-0004VN-O3
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:41 -0500
Date: Mon, 2 Jan 2017 10:33:41 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1395411328.20370.1483371221701.JavaMail.zimbra@redhat.com>
In-Reply-To: <1051274c-0d34-fc33-4eb8-3777c586f527@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-3-marcandre.lureau@redhat.com>
	<1051274c-0d34-fc33-4eb8-3777c586f527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/54] char: use a const CharDriver
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



----- Original Message -----
> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > No need to allocate & copy fileds, let's use static const struct
>=20
> s/fileds/fields/
>=20

ok

> > instead.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  backends/baum.c       |   8 +++-
> >  backends/msmouse.c    |   7 +++-
> >  backends/testdev.c    |   7 +++-
> >  qemu-char.c           | 100
> >  ++++++++++++++++++++++++--------------------------
> >  spice-qemu-char.c     |  14 +++++--
> >  ui/console.c          |   9 +++--
> >  include/sysemu/char.h |  19 +++++-----
> >  7 files changed, 90 insertions(+), 74 deletions(-)
> >=20
>=20
> > +++ b/backends/baum.c
> > @@ -686,8 +686,12 @@ fail_handle:
> > =20
> >  static void register_types(void)
> >  {
> > -    register_char_driver("braille", CHARDEV_BACKEND_KIND_BRAILLE, NULL=
,
> > -                         chr_baum_init);
> > +    static const CharDriver driver =3D {
> > +        .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
> > +        .parse =3D NULL, .create =3D chr_baum_init
>=20
> Why did the "braille" string disappear?  Oh, I see... [1]
>=20
> No need to specify .parse, since C99 initialization guarantees
> zero-assignment to any field omitted.
>=20
> I kind of prefer one struct member per line when doing C99
> initialization, rather than bunching two in one line.
>=20
> I also prefer a trailing comma, as then adding a new (non-zero) member
> initialization in a later patch is a one-line addition, rather than
> modifying an existing line to add a trailing comma.

ok fixed

>=20
>=20
> > +++ b/backends/msmouse.c
> > @@ -179,8 +179,11 @@ static CharDriverState *qemu_chr_open_msmouse(cons=
t
> > char *id,
> > =20
> >  static void register_types(void)
> >  {
> > -    register_char_driver("msmouse", CHARDEV_BACKEND_KIND_MSMOUSE, NULL=
,
> > -                         qemu_chr_open_msmouse);
> > +    static const CharDriver driver =3D {
> > +        .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
> > +        .parse =3D NULL, .create =3D qemu_chr_open_msmouse
>=20
> Looks like my comments are repeated throughout the patch.
>=20
>=20
> > -void register_char_driver(const char *name, ChardevBackendKind kind,
> > -                          CharDriverParse *parse, CharDriverCreate
> > *create)
> > +void register_char_driver(const CharDriver *driver)
> >  {
> > -    CharDriver *s;
> > -
> > -    s =3D g_malloc0(sizeof(*s));
> > -    s->name =3D g_strdup(name);
> > -    s->kind =3D kind;
> > -    s->parse =3D parse;
> > -    s->create =3D create;
> > -
> > -    backends =3D g_slist_append(backends, s);
> > +    backends =3D g_slist_append(backends, (void *)driver);
>=20
> Might be worth a comment that this is casting away const (as my first
> reaction is "oh, you forgot that C allows automatic conversion of any
> pointer to void*")

ok (note: this going away the next patch)

>=20
> >  }
> > =20
> >  CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
> > @@ -4139,7 +4123,7 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts
> > *opts,
> >          fprintf(stderr, "Available chardev backend types:\n");
> >          for (i =3D backends; i; i =3D i->next) {
> >              cd =3D i->data;
> > -            fprintf(stderr, "%s\n", cd->name);
> > +            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind=
]);
>=20
> ...[1] Your series is already long, so don't feel like you have to do
> this, but: if I were working on it, I might have done the elimination of
> cd->name, the name parameter, and the use of ChardevBackendKind_lookup[]
> in one patch (getting rid of JUST the "braille" parameter and friends at
> the call sites), and then the const'ification of the remaining
> parameters in the second patch.

The series is pretty long already (second version even longer), I don't see=
 much need to split this patch

>=20
> > +++ b/include/sysemu/char.h
>=20
> Laszlo's suggestion of the git order file would have promoted this part
> of the patch first :)
>=20

done

thanks
