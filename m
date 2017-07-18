Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXWfp-0007b8-HP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXWfo-0003hP-D5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:41 -0400
Date: Tue, 18 Jul 2017 18:52:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170718175229.GF2106@work-vm>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500385286-21142-11-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> migrate-set-parameters sets migration parameters according to is
> arguments like this:
> 
> * Present means "set the parameter to this value"
> 
> * Absent means "leave the parameter unchanged"
> 
> * Except for parameters tls_creds and tls_hostname, "" means "reset
>   the parameter to its default value

Is this really what's happening? IMHO the tls_creds and tls_hostname
behaviour isn't that "" resets to the default, it just is the default.
I don't think there's anything special cased for tls_creds and
tls_hostname in the existing code.    It's this patch that's
adding more special casing.

(I'm not going to nack this, but I just don't get why it's such a big
deal)

Dave


> The first two are perfectly normal: presence of the parameter makes
> the command do something.
> 
> The third one overloads the parameter with a second meaning.  The
> overloading is *implicit*, i.e. it's not visible in the types.  Works
> here, because "" is neither a valid TLS credentials ID, nor a valid
> host name.
> 
> Pressing argument values the schema accepts, but are semantically
> invalid, into service to mean "reset to default" is not general, as
> suitable invalid values need not exist.  I also find it ugly.
> 
> To clean this up, we could add a separate flag argument to ask for
> "reset to default", or add a distinct value to @tls_creds and
> @tls_hostname.  This commit implements the latter: add JSON null to
> the values of @tls_creds and @tls_hostname, deprecate "".
> 
> Because we're so close to the 2.10 freeze, implement it in the
> stupidest way possible: have qmp_migrate_set_parameters() rewrite null
> to "" before anything else can see the null.  The proper way to do it
> would be rewriting "" to null, but that requires fixing up code to
> work with null.  Add TODO comments for that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  8 ++++++--
>  migration/migration.c | 18 ++++++++++++++++--
>  qapi-schema.json      | 11 +++++++++--
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 0a5de75..40ebeef 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1541,11 +1541,15 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>                  break;
>              case MIGRATION_PARAMETER_TLS_CREDS:
>                  p->has_tls_creds = true;
> -                visit_type_str(v, param, &p->tls_creds, &err);
> +                p->tls_creds = g_new0(StrOrNull, 1);
> +                p->tls_creds->type = QTYPE_QSTRING;
> +                visit_type_str(v, param, &p->tls_creds->u.s, &err);
>                  break;
>              case MIGRATION_PARAMETER_TLS_HOSTNAME:
>                  p->has_tls_hostname = true;
> -                visit_type_str(v, param, &p->tls_hostname, &err);
> +                p->tls_hostname = g_new0(StrOrNull, 1);
> +                p->tls_hostname->type = QTYPE_QSTRING;
> +                visit_type_str(v, param, &p->tls_hostname->u.s, &err);
>                  break;
>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>                  p->has_max_bandwidth = true;
> diff --git a/migration/migration.c b/migration/migration.c
> index f6a9443..e2cfb99 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -703,6 +703,20 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>                      "x_checkpoint_delay",
>                      "is invalid, it should be positive");
>      }
> +    /* TODO Rewrite "" to null instead */
> +    if (params->has_tls_creds
> +        && params->tls_creds->type == QTYPE_QNULL) {
> +        QDECREF(params->tls_creds->u.n);
> +        params->tls_creds->type = QTYPE_QSTRING;
> +        params->tls_creds->u.s = strdup("");
> +    }
> +    /* TODO Rewrite "" to null instead */
> +    if (params->has_tls_hostname
> +        && params->tls_hostname->type == QTYPE_QNULL) {
> +        QDECREF(params->tls_hostname->u.n);
> +        params->tls_hostname->type = QTYPE_QSTRING;
> +        params->tls_hostname->u.s = strdup("");
> +    }
>  
>      /*
>       * TODO if we fuse MigrateSetParameters back into
> @@ -726,11 +740,11 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>      }
>      if (params->has_tls_creds) {
>          g_free(s->parameters.tls_creds);
> -        s->parameters.tls_creds = g_strdup(params->tls_creds);
> +        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
>      }
>      if (params->has_tls_hostname) {
>          g_free(s->parameters.tls_hostname);
> -        s->parameters.tls_hostname = g_strdup(params->tls_hostname);
> +        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
>      }
>      if (params->has_max_bandwidth) {
>          s->parameters.max_bandwidth = params->max_bandwidth;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index b5ec942..247af24 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -116,6 +116,13 @@
>  { 'command': 'qmp_capabilities' }
>  
>  ##
> +# @StrOrNull:
> +##
> +{ 'alternate': 'StrOrNull',
> +  'data': { 's': 'str',
> +            'n': 'null' } }
> +
> +##
>  # @LostTickPolicy:
>  #
>  # Policy for handling lost ticks in timer devices.
> @@ -1098,8 +1105,8 @@
>              '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
> -            '*tls-creds': 'str',
> -            '*tls-hostname': 'str',
> +            '*tls-creds': 'StrOrNull',
> +            '*tls-hostname': 'StrOrNull',
>              '*max-bandwidth': 'int',
>              '*downtime-limit': 'int',
>              '*x-checkpoint-delay': 'int',
> -- 
> 2.7.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
