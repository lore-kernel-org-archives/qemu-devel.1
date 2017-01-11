Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQWc-0005Jw-Q8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQWZ-0006hP-IG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:33:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRQWZ-0006g4-9G
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:33:39 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A0B6C04B926
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:33:39 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-17-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <994f02f5-8272-b420-1912-5cb8f55a40ca@redhat.com>
Date: Wed, 11 Jan 2017 15:33:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-17-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eaRjI7lKvUubN2L8Jk0Dc6wmCp2db48Ib"
Subject: Re: [Qemu-devel] [PATCH 16/40] char: get rid of CharDriver
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
--eaRjI7lKvUubN2L8Jk0Dc6wmCp2db48Ib
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <994f02f5-8272-b420-1912-5cb8f55a40ca@redhat.com>
Subject: Re: [PATCH 16/40] char: get rid of CharDriver
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> qemu_chr_new_from_opts() is modified to not need CharDriver backend[]
> array, but uses instead objectified qmp_query_chardev_backends() and
> char_get_class(). The alias field is moved outside in a ChardevAlias[],=

> similar to QDevAlias for devices.
>=20
> "kind" and "parse" are moved to ChardevClass ("kind" is to be removed
> next)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---


>  Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>                                  Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    const CharDriver *cd =3D NULL;
> +    const ChardevClass *cc;
>      Chardev *chr;
>      int i;
>      ChardevReturn *ret =3D NULL;
> @@ -4180,16 +4196,13 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,=

> =20
>      if (is_help_option(name)) {
>          GString *str =3D g_string_new("");
> -        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> -            cd =3D backends[i];
> -            if (cd) {
> -                g_string_append_printf(str, "\n%s", ChardevBackendKind=
_lookup[cd->kind]);
> -                if (cd->alias) {
> -                    g_string_append_printf(str, "\n%s", cd->alias);
> -                }
> -            }
> +        ChardevBackendInfoList *l, *il =3D qmp_query_chardev_backends(=
NULL);
> +
> +        for (l =3D il; l !=3D NULL; l =3D l->next) {
> +            g_string_append_printf(str, "\n%s", l->value->name);
>          }
> =20
> +        qapi_free_ChardevBackendInfoList(l);

Is this really the most efficient way to do it?  I guess it works, but
consider what qmp_query_chardev_backends() is doing: it is iterating
through a list of chardevs, and for each one (or its alias), calling a
callback qmp_prepend_backend().  Would a better factorization be to have
a common function that takes care of the iteration and takes a function
pointer for what to do on each element of the iteration, and then
qmp_query_chardev_backend calls helper(qmp_prepend_backup) while this
code calls helper(append_name), so that you aren't wasting the creation
of an entire ChardevBackendInfoList item just for the action of
appending the name?

> @@ -4407,21 +4417,23 @@ qmp_prepend_backend(ChardevBackendInfoList *lis=
t, const char *name)
>  ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
>  {
>      ChardevBackendInfoList *backend_list =3D NULL;
> -    const CharDriver *c;
> +    GSList *l, *list =3D object_class_get_list(TYPE_CHARDEV, false);
>      int i;
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> -        c =3D backends[i];
> -        if (!c) {
> +    for (l =3D list; l; l =3D l->next) {
> +        ObjectClass *klass =3D l->data;
> +        assert(g_str_has_prefix(object_class_get_name(klass), "chardev=
-"));
> +        if (CHARDEV_CLASS(klass)->internal) {
>              continue;
>          }
> -
>          backend_list =3D qmp_prepend_backend(backend_list,
> -                                           ChardevBackendKind_lookup[c=
->kind]);
> -        if (c->alias) {
> -            backend_list =3D qmp_prepend_backend(backend_list, c->alia=
s);
> -        }
> +                                           object_class_get_name(klass=
) + 8);
> +    }
> +    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
> +        backend_list =3D qmp_prepend_backend(backend_list,
> +                                           chardev_alias_table[i].alia=
s);

This changes the order of the list which is output to the user
(shouldn't matter in practice, but may be worth mentioning in the commit
message as intentionally safe).

Again, I think that a little more refactoring to have the iteration over
object_class_get_list() and chardev_alias_table[], coupled with a
callback passed in by the client (with clients qemu_chr_new_from_opts
and qmp_query_chardev_backends), will separate the iteration from the
action, so that you don't always have to create a ChardevBackendInfoList
that will just be thrown away.

>      }
> +    g_slist_free(l);

Shouldn't this be g_slist_free(list)?

> @@ -4983,35 +4978,6 @@ void qemu_chr_set_feature(Chardev *chr,
>      return set_bit(feature, chr->features);
>  }
> =20
> -static const ChardevClass *char_get_class(const char *driver, Error **=
errp)
> -{

This function is just moved earlier, which gets a little messy with the
rest of the patch. Can you split the code motion into a separate patch
for ease of review?  In fact, since it was just barely added in "[PATCH
v2 20/20] chardev: qom-ify]" and that patch hasn't landed yet, can't you
just amend that patch to hoist it early enough in the first place,
rather than churning it?


> @@ -5107,45 +5073,34 @@ void qemu_chr_cleanup(void)
> =20
>  static void register_types(void)
>  {
> -    static const struct {
> -        const CharDriver *driver;
> -        const TypeInfo *type;
> -    } chardevs[] =3D {
> -        { &null_driver, &char_null_type_info },
> -        { &socket_driver, &char_socket_type_info },
> -        { &udp_driver, &char_udp_type_info },
> -        { &ringbuf_driver, &char_ringbuf_type_info },
> -        { &file_driver, &char_file_type_info },
> -        { &stdio_driver, &char_stdio_type_info },
> +    type_register_static(&char_type_info);
> +#ifndef _WIN32
> +    type_register_static(&char_fd_type_info);
> +#else
> +    type_register_static(&char_win_type_info);
> +    type_register_static(&char_win_stdio_type_info);
> +#endif

It's a bit weird that these are registered first,...

> +    type_register_static(&char_null_type_info);
> +    type_register_static(&char_socket_type_info);
> +    type_register_static(&char_udp_type_info);
> +    type_register_static(&char_ringbuf_type_info);
> +    type_register_static(&char_file_type_info);
> +    type_register_static(&char_stdio_type_info);
>  #ifdef HAVE_CHARDEV_SERIAL
> -        { &serial_driver, &char_serial_type_info },
> +    type_register_static(&char_serial_type_info);
>  #endif
>  #ifdef HAVE_CHARDEV_PARPORT
> -        { &parallel_driver, &char_parallel_type_info },
> +    type_register_static(&char_parallel_type_info);
>  #endif
>  #ifdef HAVE_CHARDEV_PTY
> -        { &pty_driver, &char_pty_type_info },
> +    type_register_static(&char_pty_type_info);
>  #endif
>  #ifdef _WIN32
> -        { &console_driver, &char_console_type_info },
> +    type_register_static(&char_console_type_info);

Any reason we can't consolidate the _WIN32 ifdefs into one place?

>  #endif
> -        { &pipe_driver, &char_pipe_type_info },
> -        { &mux_driver, &char_mux_type_info },
> -        { &memory_driver, &char_memory_type_info }
> -    };
> -    int i;
> -
> -    type_register_static(&char_type_info);
> -#ifndef _WIN32
> -    type_register_static(&char_fd_type_info);
> -#else
> -    type_register_static(&char_win_type_info);
> -    type_register_static(&char_win_stdio_type_info);
> -#endif

=2E..when they used to be last; but I don't think it hurts.

> -    for (i =3D 0; i < ARRAY_SIZE(chardevs); i++) {
> -        type_register_static(chardevs[i].type);
> -        register_char_driver(chardevs[i].driver);
> -    }
> +    type_register_static(&char_pipe_type_info);
> +    type_register_static(&char_mux_type_info);
> +    type_register_static(&char_memory_type_info);
> =20
>      /* this must be done after machine init, since we register FEs wit=
h muxes
>       * as part of realize functions like serial_isa_realizefn when -no=
graphic
> diff --git a/spice-qemu-char.c b/spice-qemu-char.c

Enough bugs that I'll want to see a v2, but it's headed in the right
direction.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eaRjI7lKvUubN2L8Jk0Dc6wmCp2db48Ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdqSwAAoJEKeha0olJ0NqLrUIAIvNoWhmhtBImzJLz34b4zdm
M+SGYJJT0TJfdPlHTfQ7f3kW8uzjkMZgoREm5v0EvssDR4CXxmHYCEmnGJH4AXW/
p0h3w7cqrz7/t6haEQ9xHKB5l+4TDvYzqu5+GdIV5lKK+PRCOz6hgowhd3bqUI0N
JoY8d7EHyaiR6ZvTOom2bvSkPmLE8o+XK8NC1aUp6L+d4lPG+tJH6zMyVlMf3TTn
9XLc/zWYXrk/iNZAXt0bi/c+Z1zeAfrVEL6YEOEwJVvig5zrSM2yoy/iM4GQvO+N
uhwWx82/x47ZEdIfgxIn2T4Q0BVbaEWFPBR3iDRItFO7i3siL1JLNhi4k0E0AcE=
=6D1i
-----END PGP SIGNATURE-----

--eaRjI7lKvUubN2L8Jk0Dc6wmCp2db48Ib--
