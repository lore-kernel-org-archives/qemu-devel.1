Received: from eggs.gnu.org ([2001:4830:134:3::10]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jferlan@redhat.com>) id 1cjQds-0003rA-LE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jferlan@redhat.com>) id 1cjQdo-0002qR-Mr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:19:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jferlan@redhat.com>) id 1cjQdo-0002px-H3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:19:32 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDE03C05AA56
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 13:19:31 +0000 (UTC)
References: <20170302123746.9694-1-berrange@redhat.com>
	<20170302123746.9694-3-berrange@redhat.com>
From: John Ferlan <jferlan@redhat.com>
Message-ID: <5991e348-68f5-23f6-ef69-4fbc3c3c62b5@redhat.com>
Date: Thu, 2 Mar 2017 08:19:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170302123746.9694-3-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: always report tls-creds
 & tls-hostname migrate parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jiri Denemark <jdenemar@redhat.com>



On 03/02/2017 07:37 AM, Daniel P. Berrange wrote:
> Currently the query-migrate-parameters command will omit reporting
> of the tls-creds & tls-hostname parameters if their value is NULL.
> This makes it impossible for an app to detect if these parameters
> are supported by QEMU, without trying to actually set them and
> catching the error. Since the code is treating "" and NULL as
> equivalent, we can simply always report these values and give them
> a value of "". This allows apps like libvirt to detect the fact
> that these parameters are supported by QEMU.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  migration/migration.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Should the query-migrate-parameters description in qapi-schema.json also
be updated?  Anywhere else I haven't found yet either...

Naively asking - would the plan be to also get these changes accepted
for previous releases w/ tls-creds/hostname support? (2.7, 2.8). Mostly
curious - not that it matters since the query will tell me the answer.

John

> diff --git a/migration/migration.c b/migration/migration.c
> index a8cb56e..760f104 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -581,10 +581,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
>      params->has_cpu_throttle_increment = true;
>      params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
> -    params->has_tls_creds = !!s->parameters.tls_creds;
> -    params->tls_creds = g_strdup(s->parameters.tls_creds);
> -    params->has_tls_hostname = !!s->parameters.tls_hostname;
> -    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
> +    params->has_tls_creds = true;
> +    params->tls_creds = g_strdup(s->parameters.tls_creds ?
> +                                 s->parameters.tls_creds : "");
> +    params->has_tls_hostname = true;
> +    params->tls_hostname = g_strdup(s->parameters.tls_hostname ?
> +                                    s->parameters.tls_hostname : "");
>      params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
>      params->has_downtime_limit = true;
> 
