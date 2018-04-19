Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bf4-0003Lz-W8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bf1-0006QY-Ou
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:39:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9Bf1-0006Po-G9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 421D3818533A
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:39:43 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-6-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <316596cd-46f1-4422-dbd3-8ca16b39b798@redhat.com>
Date: Thu, 19 Apr 2018 10:39:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180419150145.24795-6-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sPRUTIrRzTbrptlhQ16IkBoY3VYsawNvg"
Subject: Re: [Qemu-devel] [PATCH v6 5/5] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sPRUTIrRzTbrptlhQ16IkBoY3VYsawNvg
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <316596cd-46f1-4422-dbd3-8ca16b39b798@redhat.com>
Subject: Re: [PATCH v6 5/5] qobject: modify qobject_ref() to assert on NULL
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
 <20180419150145.24795-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> While it may be convenient to accept NULL value in
> qobject_unref() (for similar reasons as free() accepts NULL), it is
> not such a good idea for qobject_ref(): now assert() on NULL.
>=20
> Some places relied on that behaviour (the monitor request id for
> example), and it's best to be explicit that NULL is accepted there.
> We have to rely on testing, and manual inspection of qobject_ref()
> usage:
>=20

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Again, you've made a substantial change since v5 (more hunks added, and
justification in the commit message that needs double-checking that your
audit was sane), so I would have dropped R-b.

> ---
>  include/qapi/qmp/qobject.h | 7 ++++---
>  block.c                    | 9 +++++----
>  block/blkdebug.c           | 3 ++-
>  block/quorum.c             | 3 ++-
>  monitor.c                  | 2 +-
>  5 files changed, 14 insertions(+), 10 deletions(-)
>=20

> @@ -104,6 +103,7 @@ static inline void qobject_unref_impl(QObject *obj)=

> =20
>  /**
>   * qobject_ref(): Increment QObject's reference count
> + * @obj: a #QObject or child type instance (must not be NULL)
>   *
>   * Returns: the same @obj. The type of @obj will be propagated to the
>   * return type.
> @@ -117,6 +117,7 @@ static inline void qobject_unref_impl(QObject *obj)=

>  /**
>   * qobject_unref(): Decrement QObject's reference count, deallocate
>   * when it reaches zero
> + * @obj: a #QObject or children type instance (can be NULL)

s/children/child/

> +++ b/block.c
> @@ -5110,8 +5110,9 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
>      const char *p;
> =20
>      for (entry =3D qdict_first(bs->options); entry;
> -         entry =3D qdict_next(bs->options, entry))
> -    {
> +         entry =3D qdict_next(bs->options, entry)) {
> +        QObject *val;
> +
>          /* Exclude options for children */
>          QLIST_FOREACH(child, &bs->children, next) {
>              if (strstart(qdict_entry_key(entry), child->name, &p)
> @@ -5134,8 +5135,8 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
>              continue;
>          }
> =20
> -        qdict_put_obj(d, qdict_entry_key(entry),
> -                      qobject_ref(qdict_entry_value(entry)));
> +        val =3D qdict_entry_value(entry);
> +        qdict_put_obj(d, qdict_entry_key(entry), val ? qobject_ref(val=
) : NULL);

I don't think we allow pushing NULL into qdict; we should probably beef
up the testsuite and/or add asserts to qdict_put_obj(), at which point
this hunk is spurious.

> +++ b/block/blkdebug.c
> @@ -845,7 +845,8 @@ static void blkdebug_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
>      opts =3D qdict_new();
>      qdict_put_str(opts, "driver", "blkdebug");
> =20
> -    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_optio=
ns));
> +    qdict_put(opts, "image", bs->file->bs->full_open_options ?
> +              qobject_ref(bs->file->bs->full_open_options) : NULL);

Likewise, this hunk is spurious if we can't push NULL into a QDict.

> +++ b/block/quorum.c
> @@ -1083,7 +1083,8 @@ static void quorum_refresh_filename(BlockDriverSt=
ate *bs, QDict *options)
>      children =3D qlist_new();
>      for (i =3D 0; i < s->num_children; i++) {
>          qlist_append(children,
> -                     qobject_ref(s->children[i]->bs->full_open_options=
));
> +                     s->children[i]->bs->full_open_options ?
> +                     qobject_ref(s->children[i]->bs->full_open_options=
) : NULL);

And again, but for QList.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sPRUTIrRzTbrptlhQ16IkBoY3VYsawNvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYuDcACgkQp6FrSiUn
Q2pTFggAqYwbXnQ9ROoy3pwYJ0VoGK6K7B7aJJHfUT7MiPHmgRoaduo384FqBMTM
mT47T6Igl5NsjKEStIAcZjrcyTUQ/PzsHr5G77DQrfbi0WGUWhsM/EMOzxIXtX77
cLbv/9yZlp8ce7rOkWOZTJkHANmKPNoYCkARU6Tca1abcYjq8B+CF3btyc6RBokN
7f+/y9nja/LQBdk7MlaeJU88siyYdVd4NbfAGFqq0y+cFVHV6smdNH4D80BpP1wJ
ml3BXZTpijbm+IdafGwC627L9Oih3Kb9MfCLpMfuXyFAZmbF8LV+o2ZgxesRi1SG
MNoBsquXU/8Ehaq0T4hD95t0vNvkCA==
=LKK+
-----END PGP SIGNATURE-----

--sPRUTIrRzTbrptlhQ16IkBoY3VYsawNvg--
