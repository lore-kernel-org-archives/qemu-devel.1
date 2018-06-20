Received: from eggs.gnu.org ([2001:4830:134:3::10]:56765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVa24-0001Pg-DU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVa23-0001Rc-7U
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:08 -0400
Date: Wed, 20 Jun 2018 11:07:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620100755.GH3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-4-berrange@redhat.com>
	<87efh1lqpq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efh1lqpq.fsf@secure.mitica>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] migration: add support for a
 "tls-authz" migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 20, 2018 at 12:03:45PM +0200, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> .....
>=20
>=20
> It is not just the fault of this patch, but as you are the one doing th=
e
> tls bits on migration...
>=20
>=20
> > @@ -1106,6 +1108,12 @@ static void migrate_params_apply(MigrateSetPar=
ameters *params, Error **errp)
> >          s->parameters.tls_hostname =3D g_strdup(params->tls_hostname=
->u.s);
> >      }
> > =20
> > +    if (params->has_tls_authz) {
> > +        g_free(s->parameters.tls_authz);
> > +        assert(params->tls_authz->type =3D=3D QTYPE_QSTRING);
>=20
> We really try  hard not to use assert() on migration code (yes, it is a=
n
> ongoing effort).  The code around this is something like:
>=20
> static void migrate_params_test_apply(MigrateSetParameters *params,
>                                       MigrationParameters *dest)
> {
>     [...]
>=20
>     if (params->has_compress_level) {
>         dest->compress_level =3D params->compress_level;
>     }
>=20
>     [...]
>=20
>     if (params->has_tls_creds) {
>         assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
>         dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
>     }
>     [...]
> }
>=20
> Ok, tls code is the one with strings, but still.

My understanding is that because we declared this parameter to
have "str" type in the QAPI schema, the QAPI code should already
guarantee that  "params->tls_creds->type =3D=3D QTYPE_QSTRING" is
true.

IOW, the assert should never fail, and if it does, that would
be a good thing as if QAPI wasn't validating input correctly
something very bad has gone wrong.


> static bool migrate_params_check(MigrationParameters *params, Error **e=
rrp)
> {
>     if (params->has_compress_level &&
>         (params->compress_level > 9)) {
>         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level"=
,
>                    "is invalid, it should be in the range of 0 to 9");
>         return false;

This is different because QAPI schema merely declares it to be an
int, so nothing in the QAPI input validation will do range checking.
So this codepath is definitely reachable by users feeding bad input.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
