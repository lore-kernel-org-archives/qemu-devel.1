Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC4C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B5A2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNcIynft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B5A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2a5s-0000sd-PS
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2a51-0000F3-AP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2a4z-0004rS-BN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:28:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2a4y-0004qF-U3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581683300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxZ0N9umzDuTrAsWT82Y7cD+fh8vqmOKaNrzDg/9or0=;
 b=FNcIynft88qOGc/VXO2MZeIrtFSqpag0dOIBMKTydQMYSV5JsJ8KNxZ5yhC1CLXtyNMIrJ
 WE0WqoyYeK7FysAGiB4AnxPlapEVjCrQX3RetAEN5txhLg0KysnHXx1t2cdhbGmynlz3it
 wAOPhEx0ls19Bs9fW1JrK8nUmbT7jxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-nSPrJIwuPUCR5i-BG32EEg-1; Fri, 14 Feb 2020 07:28:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD1F1800D5A;
 Fri, 14 Feb 2020 12:28:14 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA2B560BE2;
 Fri, 14 Feb 2020 12:28:12 +0000 (UTC)
Date: Fri, 14 Feb 2020 12:28:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH] migration/throttle: Make throttle slower at tail stage
Message-ID: <20200214122810.GE3283@work-vm>
References: <20200214032700.25011-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200214032700.25011-1-zhukeqian1@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nSPrJIwuPUCR5i-BG32EEg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Keqian Zhu (zhukeqian1@huawei.com) wrote:
> At the tail stage of throttle, VM is very sensitive to
> CPU percentage. We just throttle 30% of remaining CPU
> when throttle is more than 80 percentage.

This is a bit unusual;  all of the rest of the throttling has no
fixed constants; all values are set by parameters.

You've got the two, the '80' and the '0.3'

I thinkt he easy solution is to replace your parameter 'tailslow' by two
new parameters; 'tailstart' and 'tailrate';  both defaulting to 100%.

Then you make it:

        if (cpu_throttle_now >=3D pct_tailstart) {
            /* Eat some scale of CPU from remaining */
            cpu_throttle_inc =3D ceil((100 - cpu_throttle_now) * pct_tailra=
te);

(with percentage scaling added).

Then setting 'tailstart' to 80 and 'tailrate' to 30 is equivalent to
what you have, but means we have no magical constants in the code.

Dave


> This doesn't conflict with cpu_throttle_increment.
>=20
> This may make migration time longer, and is disabled
> by default.
>=20
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration.c | 13 +++++++++++++
>  migration/ram.c       | 18 ++++++++++++++++--
>  monitor/hmp-cmds.c    |  4 ++++
>  qapi/migration.json   | 21 +++++++++++++++++++++
>  4 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 3a21a4686c..37b569cee9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -782,6 +782,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->cpu_throttle_initial =3D s->parameters.cpu_throttle_initial;
>      params->has_cpu_throttle_increment =3D true;
>      params->cpu_throttle_increment =3D s->parameters.cpu_throttle_increm=
ent;
> +    params->has_cpu_throttle_tailslow =3D true;
> +    params->cpu_throttle_tailslow =3D s->parameters.cpu_throttle_tailslo=
w;
>      params->has_tls_creds =3D true;
>      params->tls_creds =3D g_strdup(s->parameters.tls_creds);
>      params->has_tls_hostname =3D true;
> @@ -1287,6 +1289,10 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
>          dest->cpu_throttle_increment =3D params->cpu_throttle_increment;
>      }
> =20
> +    if (params->has_cpu_throttle_tailslow) {
> +        dest->cpu_throttle_tailslow =3D params->cpu_throttle_tailslow;
> +    }
> +
>      if (params->has_tls_creds) {
>          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
>          dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
> @@ -1368,6 +1374,10 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
>          s->parameters.cpu_throttle_increment =3D params->cpu_throttle_in=
crement;
>      }
> =20
> +    if (params->has_cpu_throttle_tailslow) {
> +        s->parameters.cpu_throttle_tailslow =3D params->cpu_throttle_tai=
lslow;
> +    }
> +
>      if (params->has_tls_creds) {
>          g_free(s->parameters.tls_creds);
>          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
> @@ -3504,6 +3514,8 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
>                        parameters.cpu_throttle_increment,
>                        DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
> +    DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
> +                      parameters.cpu_throttle_tailslow, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
>      DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
> @@ -3600,6 +3612,7 @@ static void migration_instance_init(Object *obj)
>      params->has_decompress_threads =3D true;
>      params->has_cpu_throttle_initial =3D true;
>      params->has_cpu_throttle_increment =3D true;
> +    params->has_cpu_throttle_tailslow =3D true;
>      params->has_max_bandwidth =3D true;
>      params->has_downtime_limit =3D true;
>      params->has_x_checkpoint_delay =3D true;
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..d86413a5d1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -29,6 +29,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include <zlib.h>
> +#include <math.h>
>  #include "qemu/cutils.h"
>  #include "qemu/bitops.h"
>  #include "qemu/bitmap.h"
> @@ -620,15 +621,28 @@ static void mig_throttle_guest_down(void)
>  {
>      MigrationState *s =3D migrate_get_current();
>      uint64_t pct_initial =3D s->parameters.cpu_throttle_initial;
> -    uint64_t pct_icrement =3D s->parameters.cpu_throttle_increment;
> +    uint64_t pct_increment =3D s->parameters.cpu_throttle_increment;
> +    bool pct_tailslow =3D s->parameters.cpu_throttle_tailslow;
>      int pct_max =3D s->parameters.max_cpu_throttle;
> =20
> +    const uint64_t cpu_throttle_now =3D cpu_throttle_get_percentage();
> +    uint64_t cpu_throttle_inc;
> +
>      /* We have not started throttling yet. Let's start it. */
>      if (!cpu_throttle_active()) {
>          cpu_throttle_set(pct_initial);
>      } else {
>          /* Throttling already on, just increase the rate */
> -        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icremen=
t,
> +        if (cpu_throttle_now >=3D 80 && pct_tailslow) {
> +            /* Eat some scale of CPU from remaining */
> +            cpu_throttle_inc =3D ceil((100 - cpu_throttle_now) * 0.3);
> +            if (cpu_throttle_inc > pct_increment) {
> +                cpu_throttle_inc =3D pct_increment;
> +            }
> +        } else {
> +            cpu_throttle_inc =3D pct_increment;
> +        }
> +        cpu_throttle_set(MIN(cpu_throttle_now + cpu_throttle_inc,
>                           pct_max));
>      }
>  }
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 558fe06b8f..b5f5c0b382 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -416,6 +416,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCR=
EMENT),
>              params->cpu_throttle_increment);
> +        assert(params->has_cpu_throttle_tailslow);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAIL=
SLOW),
> +            params->cpu_throttle_tailslow ? "on" : "off");
>          assert(params->has_max_cpu_throttle);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE)=
,
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..0ac94e00f2 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -532,6 +532,12 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. The default value is 10. (Since 2.7=
)
>  #
> +# @cpu-throttle-tailslow: Make throttle slower at tail stage
> +#                         At the tail stage of throttle, VM is very sens=
itive to
> +#                         CPU percentage. We just throttle 30% of remain=
ing CPU
> +#                         when throttle is more than 80 percentage. The =
default
> +#                         value is false. (Since 4.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials for
>  #             establishing a TLS connection over the migration data chan=
nel.
>  #             On the outgoing side of the migration, the credentials mus=
t
> @@ -594,6 +600,7 @@
>             'compress-level', 'compress-threads', 'decompress-threads',
>             'compress-wait-thread',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
> +           'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
> @@ -634,6 +641,12 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. The default value is 10. (Since 2.7=
)
>  #
> +# @cpu-throttle-tailslow: Make throttle slower at tail stage
> +#                         At the tail stage of throttle, VM is very sens=
itive to
> +#                         CPU percentage. We just throttle 30% of remain=
ing CPU
> +#                         when throttle is more than 80 percentage. The =
default
> +#                         value is false. (Since 4.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #             for establishing a TLS connection over the migration data
>  #             channel. On the outgoing side of the migration, the creden=
tials
> @@ -703,6 +716,7 @@
>              '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
> +            '*cpu-throttle-tailslow': 'bool',
>              '*tls-creds': 'StrOrNull',
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
> @@ -767,6 +781,12 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. (Since 2.7)
>  #
> +# @cpu-throttle-tailslow: Make throttle slower at tail stage
> +#                         At the tail stage of throttle, VM is very sens=
itive to
> +#                         CPU percentage. We just throttle 30% of remain=
ing CPU
> +#                         when throttle is more than 80 percentage. The =
default
> +#                         value is false. (Since 4.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #             for establishing a TLS connection over the migration data
>  #             channel. On the outgoing side of the migration, the creden=
tials
> @@ -836,6 +856,7 @@
>              '*decompress-threads': 'uint8',
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
> +            '*cpu-throttle-tailslow': 'bool',
>              '*tls-creds': 'str',
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str',
> --=20
> 2.19.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


