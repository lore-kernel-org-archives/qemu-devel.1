Received: from eggs.gnu.org ([2001:4830:134:3::10]:57649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esuP4-0000L7-6d
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esuP0-0002FI-D5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:00:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1esuP0-0002FB-8P
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:59:58 -0500
Date: Mon, 5 Mar 2018 17:59:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180305175944.GC17368@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180305172951.2150-1-marcandre.lureau@redhat.com>
	<20180305172951.2150-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305172951.2150-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Mar 05, 2018 at 06:29:51PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Replace the generated json string with a literal qobject. The later is
> easier to deal with, at run time as well as compile time: adding #if
> conditionals will be easier than in a json string.
>=20
> The output of query-qmp-schema is not changed.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/introspect.py         | 76 +++++++++++++++++-------------
>  monitor.c                          |  2 +-
>  tests/test-qobject-input-visitor.c | 11 +++--
>  docs/devel/qapi-code-gen.txt       | 29 ++++++++----
>  4 files changed, 70 insertions(+), 48 deletions(-)
>=20
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f66c397fb0..4df730377f 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py


>      elif isinstance(obj, dict):
> -        elts =3D ['"%s": %s' % (key.replace('"', r'\"'),
> -                              to_json(obj[key], level + 1))
> -                for key in sorted(obj.keys())]
> -        ret =3D '{' + ', '.join(elts) + '}'
> +        elts =3D []
> +        for key, value in sorted(obj.iteritems()):

s/iteritems/items/  for dual Python 2+3 compatibility  which is what the
patchew failure was complaining about.

> +            elts.append(indent(level + 1) + '{ %s, %s }' %
> +                        (to_c_string(key), to_qlit(value, level + 1, T=
rue)))
> +        elts.append(indent(level + 1) + '{}')
> +        ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
> +        ret +=3D ',\n'.join(elts) + '\n'
> +        ret +=3D indent(level) + '}))'

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
