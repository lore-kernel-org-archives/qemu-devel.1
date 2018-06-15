Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTsvi-0006BY-Uo
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTsvh-0003SC-P6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:54:35 -0400
Date: Fri, 15 Jun 2018 18:54:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615175423.GI2615@work-vm>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180615155103.11924-4-berrange@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The QEMU instance that runs as the server for the migration data
> transport (ie the target QEMU) needs to be able to configure access
> control so it can prevent unauthorized clients initiating an incoming
> migration. This adds a new 'tls-authz' migration parameter that is used
> to provide the QOM ID of a QAuthZ subclass instance that provides the
> access control check. This is checked against the x509 certificate
> obtained during the TLS handshake.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

I'd appreciate an example of using it, either in the migration docs or
the commit message.

> ---
>  hmp.c                 |  9 +++++++++
>  migration/migration.c |  8 ++++++++
>  migration/tls.c       |  2 +-
>  qapi/migration.json   | 12 +++++++++++-
>  4 files changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index 74e18db103..bef8ea2531 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -370,6 +370,9 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SI=
ZE),
>              params->xbzrle_cache_size);
> +        monitor_printf(mon, " %s: '%s'\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> +            params->has_tls_authz ? params->tls_authz : "");
>      }
> =20
>      qapi_free_MigrationParameters(params);
> @@ -1632,6 +1635,12 @@ void hmp_migrate_set_parameter(Monitor *mon, con=
st QDict *qdict)
>          p->tls_hostname->type =3D QTYPE_QSTRING;
>          visit_type_str(v, param, &p->tls_hostname->u.s, &err);
>          break;
> +    case MIGRATION_PARAMETER_TLS_AUTHZ:
> +        p->has_tls_authz =3D true;
> +        p->tls_authz =3D g_new0(StrOrNull, 1);
> +        p->tls_authz->type =3D QTYPE_QSTRING;
> +        visit_type_str(v, param, &p->tls_authz->u.s, &err);
> +        break;
>      case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>          p->has_max_bandwidth =3D true;
>          /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 1e99ec9b7e..d14c8d7003 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -645,6 +645,8 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
>      params->tls_creds =3D g_strdup(s->parameters.tls_creds);
>      params->has_tls_hostname =3D true;
>      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
> +    params->has_tls_authz =3D true;
> +    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
>      params->has_max_bandwidth =3D true;
>      params->max_bandwidth =3D s->parameters.max_bandwidth;
>      params->has_downtime_limit =3D true;
> @@ -1106,6 +1108,12 @@ static void migrate_params_apply(MigrateSetParam=
eters *params, Error **errp)
>          s->parameters.tls_hostname =3D g_strdup(params->tls_hostname->=
u.s);
>      }
> =20
> +    if (params->has_tls_authz) {
> +        g_free(s->parameters.tls_authz);
> +        assert(params->tls_authz->type =3D=3D QTYPE_QSTRING);
> +        s->parameters.tls_authz =3D g_strdup(params->tls_authz->u.s);
> +    }
> +
>      if (params->has_max_bandwidth) {
>          s->parameters.max_bandwidth =3D params->max_bandwidth;
>          if (s->to_dst_file) {
> diff --git a/migration/tls.c b/migration/tls.c
> index 3b9e8c9263..5171afc6c4 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -94,7 +94,7 @@ void migration_tls_channel_process_incoming(Migration=
State *s,
> =20
>      tioc =3D qio_channel_tls_new_server(
>          ioc, creds,
> -        NULL, /* XXX pass ACL name */
> +        s->parameters.tls_authz,
>          errp);
>      if (!tioc) {
>          return;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f7e10ee90f..b9ba34e3a6 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -488,6 +488,10 @@
>  #                hostname must be provided so that the server's x509
>  #                certificate identity can be validated. (Since 2.7)
>  #
> +# @tls-authz: ID of the 'authz' object subclass that provides access c=
ontrol
> +#             checking of the TLS x509 certificate distinguished name.=
 (Since
> +#             2.13)
> +#

Oops, 2.13 strikes again :-)

Other than that, OK from migration and HMP.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  # @max-bandwidth: to set maximum speed for migration. maximum speed in
>  #                 bytes per second. (Since 2.8)
>  #
> @@ -522,7 +526,7 @@
>  { 'enum': 'MigrationParameter',
>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'tls-creds', 'tls-hostname', 'max-bandwidth',
> +           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental'=
,
>             'x-multifd-channels', 'x-multifd-page-count',
>             'xbzrle-cache-size' ] }
> @@ -605,6 +609,7 @@
>              '*cpu-throttle-increment': 'int',
>              '*tls-creds': 'StrOrNull',
>              '*tls-hostname': 'StrOrNull',
> +            '*tls-authz': 'StrOrNull',
>              '*max-bandwidth': 'int',
>              '*downtime-limit': 'int',
>              '*x-checkpoint-delay': 'int',
> @@ -667,6 +672,10 @@
>  #                associated with the migration URI, if any. (Since 2.9=
)
>  #                Note: 2.8 reports this by omitting tls-hostname inste=
ad.
>  #
> +# @tls-authz: ID of the 'authz' object subclass that provides access c=
ontrol
> +#             checking of the TLS x509 certificate distinguished name.=
 (Since
> +#             2.13)
> +#
>  # @max-bandwidth: to set maximum speed for migration. maximum speed in
>  #                 bytes per second. (Since 2.8)
>  #
> @@ -704,6 +713,7 @@
>              '*cpu-throttle-increment': 'uint8',
>              '*tls-creds': 'str',
>              '*tls-hostname': 'str',
> +            '*tls-authz': 'str',
>              '*max-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': 'uint32',
> --=20
> 2.17.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
