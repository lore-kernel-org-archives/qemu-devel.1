Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPdEb-0001oc-17
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPdEX-0007qq-1u
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:43:41 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:43320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cPdEW-0007qg-Jc
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:43:36 -0500
Date: Fri, 6 Jan 2017 17:43:35 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <141506467.3651056.1483742615696.JavaMail.zimbra@redhat.com>
In-Reply-To: <8307ba01-95a6-d507-fec3-9619298ca6dd@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-6-marcandre.lureau@redhat.com>
	<8307ba01-95a6-d507-fec3-9619298ca6dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/20] char: use a const CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>

Hi

----- Original Message -----
> On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> > No need to allocate & copy fields, let's use static const struct
> > instead.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/sysemu/char.h |  19 +++----
> >  backends/baum.c       |   8 ++-
> >  backends/msmouse.c    |   7 ++-
> >  backends/testdev.c    |   7 ++-
> >  qemu-char.c           | 141
> >  +++++++++++++++++++++++++++++++-------------------
> >  spice-qemu-char.c     |  16 ++++--
> >  ui/console.c          |  10 ++--
> >  7 files changed, 134 insertions(+), 74 deletions(-)
> >=20
> > diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> > index b6e361860a..c05a896578 100644
> > --- a/include/sysemu/char.h
> > +++ b/include/sysemu/char.h
> > @@ -475,15 +475,16 @@ void qemu_chr_set_feature(CharDriverState *chr,
> >                            CharDriverFeature feature);
> >  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e);
> > =20
> > -typedef void CharDriverParse(QemuOpts *opts, ChardevBackend *backend,
> > -                             Error **errp);
> > -typedef CharDriverState *CharDriverCreate(const char *id,
> > -                                          ChardevBackend *backend,
> > -                                          ChardevReturn *ret, bool
> > *be_opened,
> > -                                          Error **errp);
> > -
> > -void register_char_driver(const char *name, ChardevBackendKind kind,
> > -                          CharDriverParse *parse, CharDriverCreate
> > *create);
>=20
> The old code takes a name...
>=20
> > +typedef struct CharDriver {
> > +    ChardevBackendKind kind;
> > +    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **err=
p);
> > +    CharDriverState *(*create)(const char *id,
> > +                               ChardevBackend *backend,
> > +                               ChardevReturn *ret, bool *be_opened,
> > +                               Error **errp);
> > +} CharDriver;
> > +
> > +void register_char_driver(const CharDriver *driver);
>=20
> ...the new code does not. Let's see why:
>=20
> > +++ b/qemu-char.c
> > @@ -4094,27 +4094,12 @@ static void qemu_chr_parse_udp(QemuOpts *opts,
> > ChardevBackend *backend,
> >      }
> >  }
> > =20
> > -typedef struct CharDriver {
> > -    const char *name;
> > -    ChardevBackendKind kind;
> > -    CharDriverParse *parse;
> > -    CharDriverCreate *create;
> > -} CharDriver;
>=20
> In fact, you are moving the struct from private to public, AND dropping
> a member at the same time.
>=20
> > -
> >  static GSList *backends;
> > =20
> > -void register_char_driver(const char *name, ChardevBackendKind kind,
> > -                          CharDriverParse *parse, CharDriverCreate
> > *create)
> > +void register_char_driver(const CharDriver *driver)
> >  {
> > -    CharDriver *s;
> > -
> > -    s =3D g_malloc0(sizeof(*s));
> > -    s->name =3D g_strdup(name);
>=20
> The old code copies the name, the new code has no name to copy.
>=20
> > -    s->kind =3D kind;
> > -    s->parse =3D parse;
> > -    s->create =3D create;
> > -
> > -    backends =3D g_slist_append(backends, s);
> > +    /* casting away const */
> > +    backends =3D g_slist_append(backends, (void *)driver);
> >  }
> > =20
> >  CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
> > @@ -4139,7 +4124,7 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts
> > *opts,
> >          fprintf(stderr, "Available chardev backend types:\n");
> >          for (i =3D backends; i; i =3D i->next) {
> >              cd =3D i->data;
> > -            fprintf(stderr, "%s\n", cd->name);
> > +            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind=
]);
>=20
> The old code reused the name copied during registration, the new code
> uses kind to look up the name from the QAPI enum type.  That means the
> output changes: it now outputs the canonical name instead of the alias
> name.  I can live with that (even if the output is temporarily weird for
> listing a canonical name more than once).

Hmm good catch, I didn't realize that, the next patch fixes most of it, rig=
ht?

>=20
> > @@ -4152,7 +4137,8 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts
> > *opts,
> >      for (i =3D backends; i; i =3D i->next) {
> >          cd =3D i->data;
> > =20
> > -        if (strcmp(cd->name, qemu_opt_get(opts, "backend")) =3D=3D 0) =
{
> > +        if (strcmp(ChardevBackendKind_lookup[cd->kind],
> > +                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
>=20
> But this change means any driver that does NOT have a name in the QAPI
> enum type CANNOT be constructed from the command line, at least for the
> duration of this patch.  Let's see what is impacted by this:
>=20
> >  #if defined HAVE_CHARDEV_SERIAL
> > -    register_char_driver("serial", CHARDEV_BACKEND_KIND_SERIAL,
> > -                         qemu_chr_parse_serial, qmp_chardev_open_seria=
l);
> > -    register_char_driver("tty", CHARDEV_BACKEND_KIND_SERIAL,
> > -                         qemu_chr_parse_serial, qmp_chardev_open_seria=
l);
>=20
> The old code registered two different names for a serial driver;
>=20
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> > +            .parse =3D qemu_chr_parse_serial,
> > +            .create =3D qmp_chardev_open_serial,
> > +        },
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> > +            .parse =3D qemu_chr_parse_serial,
> > +            .create =3D qmp_chardev_open_serial,
> > +        },
>=20
> the new code just registers the SAME driver contents twice, but both
> tied to the QAPI name "serial".  Either we want _this_ patch to keep the
> "tty" name around (but that's churn, because it does go away later in
> the series when we add aliasing), or we can drop the second registration
> as redundant, and just document that we temporarily lose access to the
> aliased name until fixed in a later patch.

Hmm, bad patch split.=20

>=20
> >  #endif
> >  #ifdef HAVE_CHARDEV_PARPORT
> > -    register_char_driver("parallel", CHARDEV_BACKEND_KIND_PARALLEL,
> > -                         qemu_chr_parse_parallel,
> > qmp_chardev_open_parallel);
> > -    register_char_driver("parport", CHARDEV_BACKEND_KIND_PARALLEL,
> > -                         qemu_chr_parse_parallel,
> > qmp_chardev_open_parallel);
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> > +            .parse =3D qemu_chr_parse_parallel,
> > +            .create =3D qmp_chardev_open_parallel,
> > +        },
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> > +            .parse =3D qemu_chr_parse_parallel,
> > +            .create =3D qmp_chardev_open_parallel,
> > +        },
>=20
> And again.
>=20
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_PIPE,
> > +            .parse =3D qemu_chr_parse_pipe,
> > +            .create =3D qemu_chr_open_pipe,
> > +        },
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_MUX,
> > +            .parse =3D qemu_chr_parse_mux,
> > +            .create =3D qemu_chr_open_mux,
> > +        },
> > +        /* Bug-compatibility: */
> > +        {
> > +            .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
> > +            .parse =3D qemu_chr_parse_ringbuf,
> > +            .create =3D qemu_chr_open_ringbuf,
>=20
> What's weird here is that CHARDEV_BACKEND_KIND_MEMORY and
> CHARDEV_BACKEND_KIND_RINGBUF are also using the same callbacks, but this
> time appear as separate names in the QAPI enum.  A different approach
> would be to modify qapi-schema.json to add 'tty':'ChardevHostdev' and
> 'parport':'ChardevHostdev' aliases, the way it already has a
> 'memory':ChardevRingbuf' alias, so that the above registrations that I
> complained were duplicates could use the right enum values. But is it
> really worth dirtying the QAPI with an enum value we don't want?

No

> Conversely, should we remove 'memory' from QAPI as no longer supported
> (yes, it breaks back-compat, but we've documented that new code should
> not be using it)?
>=20
> I still think you need more in the commit message to justify this code.
> Option 1, minimizing code churn, documenting the temporary regression:
>=20
> =3D=3D=3D=3D=3D
> No need to allocate & copy fields, let's use static const struct
> instead.
>=20
> Note that this promotes CharDriver to a public struct, but eliminates
> the 'name' parameter in the process; this is because in most cases, we
> can use the QAPI enum for ChardevBackend to come up with the same names,
> with the only exceptions being older aliases 'tty' (for 'serial') and
> 'parport' (for 'parallel') where outputting the canonical name is better
> anyways.  This causes a temporary regression in the ability to create a
> char driver from the command line using the older spellings, but that
> will be fixed in a later patch that cleans up how aliases are handled.

I think your option 2 is better

> =3D=3D=3D=3D=3D
>=20
> along with this patch squashed in:
> =3D=3D=3D=3D=3D
> diff --git i/qemu-char.c w/qemu-char.c
> index 14ab287..1a39331 100644
> --- i/qemu-char.c
> +++ w/qemu-char.c
> @@ -4930,11 +4930,7 @@ static void register_types(void)
>              .parse =3D qemu_chr_parse_serial,
>              .create =3D qmp_chardev_open_serial,
>          },
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> -            .parse =3D qemu_chr_parse_serial,
> -            .create =3D qmp_chardev_open_serial,
> -        },
> +        /* FIXME: Need a "tty" alias */
>  #endif
>  #ifdef HAVE_CHARDEV_PARPORT
>          {
> @@ -4942,11 +4938,7 @@ static void register_types(void)
>              .parse =3D qemu_chr_parse_parallel,
>              .create =3D qmp_chardev_open_parallel,
>          },
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> -            .parse =3D qemu_chr_parse_parallel,
> -            .create =3D qmp_chardev_open_parallel,
> -        },
> +        /* FIXME: Need a "parport" alias */
>  #endif
>  #ifdef HAVE_CHARDEV_PTY
>          {
> =3D=3D=3D=3D=3D
>=20
>=20
> Option 2, hoisting part of 6/20 earlier in the series to avoid the
> temporary regression altogether:
>=20
> =3D=3D=3D=3D=3D
> No need to allocate & copy fields, let's use static const struct
> instead.
>=20
> Note that this promotes CharDriver to a public struct, and replaces a
> 'name' parameter with an 'alias' field to handle the fact that we were
> previously registering the 'serial' and 'parallel' drivers twice to pick
> up their older 'tty' and 'parport' aliases (we still register the
> 'memory' driver as an alias for 'ringbuf', but that's because that alias
> is public in the ChardevBackend QAPI type).
> =3D=3D=3D=3D=3D
>=20
> along with this patch squashed in:

ok
> =3D=3D=3D=3D=3D
> diff --git i/include/sysemu/char.h w/include/sysemu/char.h
> index c05a896..fee2c34 100644
> --- i/include/sysemu/char.h
> +++ w/include/sysemu/char.h
> @@ -477,6 +477,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label,
> const char *filename);
>=20
>  typedef struct CharDriver {
>      ChardevBackendKind kind;
> +    const char *alias;
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
>      CharDriverState *(*create)(const char *id,
>                                 ChardevBackend *backend,
> diff --git i/qemu-char.c w/qemu-char.c
> index 14ab287..37219b2 100644
> --- i/qemu-char.c
> +++ w/qemu-char.c
> @@ -4111,22 +4111,27 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts
> *opts,
>      GSList *i;
>      ChardevReturn *ret =3D NULL;
>      ChardevBackend *backend;
> +    const char *name;
>      const char *id =3D qemu_opts_id(opts);
>      char *bid =3D NULL;
>=20
> -    if (qemu_opt_get(opts, "backend") =3D=3D NULL) {
> +    name =3D qemu_opt_get(opts, "backend");
> +    if (name =3D=3D NULL) {
>          error_setg(errp, "chardev: \"%s\" missing backend",
>                     qemu_opts_id(opts));
>          goto err;
>      }
>=20
> -    if (is_help_option(qemu_opt_get(opts, "backend"))) {
> +    if (is_help_option(name)) {
>          fprintf(stderr, "Available chardev backend types:\n");
>          for (i =3D backends; i; i =3D i->next) {
>              cd =3D i->data;
>              fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind])=
;
> +            if (cd->alias) {
> +                fprintf(stderr, "%s\n", cd->alias);
> +            }
>          }
> -        exit(!is_help_option(qemu_opt_get(opts, "backend")));
> +        exit(0);
>      }
>=20
>      if (id =3D=3D NULL) {
> @@ -4137,14 +4142,13 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts
> *opts,
>      for (i =3D backends; i; i =3D i->next) {
>          cd =3D i->data;
>=20
> -        if (strcmp(ChardevBackendKind_lookup[cd->kind],
> -                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
> +        if (strcmp(ChardevBackendKind_lookup[cd->kind], name) =3D=3D 0 |=
|
> +            g_strcmp0(cd->alias, name) =3D=3D 0) {
>              break;
>          }
>      }
>      if (i =3D=3D NULL) {
> -        error_setg(errp, "chardev: backend \"%s\" not found",
> -                   qemu_opt_get(opts, "backend"));
> +        error_setg(errp, "chardev: backend \"%s\" not found", name);
>          goto err;
>      }
>=20
> @@ -4927,11 +4931,7 @@ static void register_types(void)
>  #if defined HAVE_CHARDEV_SERIAL
>          {
>              .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> -            .parse =3D qemu_chr_parse_serial,
> -            .create =3D qmp_chardev_open_serial,
> -        },
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> +            .alias =3D "tty",
>              .parse =3D qemu_chr_parse_serial,
>              .create =3D qmp_chardev_open_serial,
>          },
> @@ -4939,11 +4939,7 @@ static void register_types(void)
>  #ifdef HAVE_CHARDEV_PARPORT
>          {
>              .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> -            .parse =3D qemu_chr_parse_parallel,
> -            .create =3D qmp_chardev_open_parallel,
> -        },
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> +            .alias =3D "parport",
>              .parse =3D qemu_chr_parse_parallel,
>              .create =3D qmp_chardev_open_parallel,
>          },
> =3D=3D=3D=3D=3D
>=20
>=20
> If you agree with either of those options, then you can add:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks, I took option 2, and fixed the remaining issues mentionned in patch=
 6.

> If anyone else has a strong opinion (such as changing qapi to add the
> aliases 'tty' and 'parport', or even cleaning up qapi to remove 'memory'
> in favor of 'ringbuf') on which of my two options is preferred, or even
> going with a third option, then speak up now.
>=20
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
