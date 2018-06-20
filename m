Received: from eggs.gnu.org ([2001:4830:134:3::10]:54929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZy4-0007AS-Ah
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZy3-000786-8C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:04:00 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180615155103.11924-4-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 15 Jun 2018 16:51:00
	+0100")
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-4-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Jun 2018 12:03:45 +0200
Message-ID: <87efh1lqpq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-?= =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>

.....


It is not just the fault of this patch, but as you are the one doing the
tls bits on migration...


> @@ -1106,6 +1108,12 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
>          s->parameters.tls_hostname =3D g_strdup(params->tls_hostname->u.=
s);
>      }
>=20=20
> +    if (params->has_tls_authz) {
> +        g_free(s->parameters.tls_authz);
> +        assert(params->tls_authz->type =3D=3D QTYPE_QSTRING);

We really try  hard not to use assert() on migration code (yes, it is an
ongoing effort).  The code around this is something like:

static void migrate_params_test_apply(MigrateSetParameters *params,
                                      MigrationParameters *dest)
{
    [...]

    if (params->has_compress_level) {
        dest->compress_level =3D params->compress_level;
    }

    [...]

    if (params->has_tls_creds) {
        assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
        dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
    }
    [...]
}

Ok, tls code is the one with strings, but still.

static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
{
    [...]
    if (params->has_compress_level) {
        s->parameters.compress_level =3D params->compress_level;
    }
    [...]

    if (params->has_tls_creds) {
        g_free(s->parameters.tls_creds);
        assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
        s->parameters.tls_creds =3D g_strdup(params->tls_creds->u.s);
    }
}

And this other function:

static bool migrate_params_check(MigrationParameters *params, Error **errp)
{
    if (params->has_compress_level &&
        (params->compress_level > 9)) {
        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
                   "is invalid, it should be in the range of 0 to 9");
        return false;
    }
    [...]
}

Where we don't check anything for tls.

Perhaps we can move the asserts here?

We can also try to merge migrate_params_check and
migrate_params_test_apply() into a single function, but it is not
completely trivial at the moment.

Wondering if we can do it better.

Later, Juan.
