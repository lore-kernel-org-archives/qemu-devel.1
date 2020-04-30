Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A25AC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FB1206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTUENHc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FB1206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUA2a-00014B-DN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:19:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU9xK-0000LL-Ev
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU9vl-0001qG-Lb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:14:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jU9vl-0001lN-1U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588255967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EW7SV7tyHMTh5KF/4X/eMJTljtUBK5Lj7FvkxV0jDH8=;
 b=CTUENHc2mbpMv8M1XJoCyPyG0dIJh1ZX0/NJ/Zs/t1Kdaw7cKOdLQOqGeEBf1h50i4ktKm
 VzI3Taz0zyxLdRHK8YFt5QUffarv8HV/gPSKPnUNH1FsEiwPmsEFanwDy85rS8JtCtU7f+
 Ql5H+K/uX07E91b/tg2uRRzUB8U0GFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-fJUrMs0_NHSwW8R-KlDW2w-1; Thu, 30 Apr 2020 10:12:45 -0400
X-MC-Unique: fJUrMs0_NHSwW8R-KlDW2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9934DEC1A2;
 Thu, 30 Apr 2020 14:12:44 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6018951151;
 Thu, 30 Apr 2020 14:12:42 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:12:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3] migration/throttle: Add cpu-throttle-tailslow
 migration parameter
Message-ID: <20200430141239.GH2874@work-vm>
References: <20200413101508.54793-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200413101508.54793-1-zhukeqian1@huawei.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
> At the tail stage of throttling, the Guest is very sensitive to
> CPU percentage while the @cpu-throttle-increment is excessive
> usually at tail stage.
>=20
> If this parameter is true, we will compute the ideal CPU percentage
> used by the Guest, which may exactly make the dirty rate match the
> dirty rate threshold. Then we will choose a smaller throttle increment
> between the one specified by @cpu-throttle-increment and the one
> generated by ideal CPU percentage.
>=20
> Therefore, it is compatible to traditional throttling, meanwhile
> the throttle increment won't be excessive at tail stage. This may
> make migration time longer, and is disabled by default.
>=20
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

So I think this is OK; see comment below.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration.c | 13 ++++++++++++
>  migration/ram.c       | 25 +++++++++++++++++-----
>  monitor/hmp-cmds.c    |  8 ++++++++
>  qapi/migration.json   | 48 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 187ac0410c..d478a87290 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -785,6 +785,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
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
> @@ -1324,6 +1326,10 @@ static void migrate_params_test_apply(MigrateSetPa=
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
> @@ -1412,6 +1418,10 @@ static void migrate_params_apply(MigrateSetParamet=
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
> @@ -3594,6 +3604,8 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
>                        parameters.cpu_throttle_increment,
>                        DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
> +    DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
> +                      parameters.cpu_throttle_tailslow, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
>      DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
> @@ -3700,6 +3712,7 @@ static void migration_instance_init(Object *obj)
>      params->has_throttle_trigger_threshold =3D true;
>      params->has_cpu_throttle_initial =3D true;
>      params->has_cpu_throttle_increment =3D true;
> +    params->has_cpu_throttle_tailslow =3D true;
>      params->has_max_bandwidth =3D true;
>      params->has_downtime_limit =3D true;
>      params->has_x_checkpoint_delay =3D true;
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..3317c99786 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -616,20 +616,34 @@ static size_t save_page_header(RAMState *rs, QEMUFi=
le *f,  RAMBlock *block,
>   * able to complete migration. Some workloads dirty memory way too
>   * fast and will not effectively converge, even with auto-converge.
>   */
> -static void mig_throttle_guest_down(void)
> +static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
> +                                    uint64_t bytes_dirty_threshold)
>  {
>      MigrationState *s =3D migrate_get_current();
>      uint64_t pct_initial =3D s->parameters.cpu_throttle_initial;
> -    uint64_t pct_icrement =3D s->parameters.cpu_throttle_increment;
> +    uint64_t pct_increment =3D s->parameters.cpu_throttle_increment;
> +    bool pct_tailslow =3D s->parameters.cpu_throttle_tailslow;
>      int pct_max =3D s->parameters.max_cpu_throttle;
> =20
> +    uint64_t throttle_now =3D cpu_throttle_get_percentage();
> +    uint64_t cpu_now, cpu_ideal, throttle_inc;
> +
>      /* We have not started throttling yet. Let's start it. */
>      if (!cpu_throttle_active()) {
>          cpu_throttle_set(pct_initial);
>      } else {
>          /* Throttling already on, just increase the rate */
> -        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icremen=
t,
> -                         pct_max));
> +        if (!pct_tailslow) {
> +            throttle_inc =3D pct_increment;
> +        } else {
> +            /* Compute the ideal CPU percentage used by Guest, which may
> +             * make the dirty rate match the dirty rate threshold. */
> +            cpu_now =3D 100 - throttle_now;
> +            cpu_ideal =3D cpu_now * (bytes_dirty_threshold * 1.0 /
> +                        bytes_dirty_period);

I worry if we need a divide-by-0 check; but that seems unlikely.
Now if that worked out as huge, then I think the MIN's guard it even
with overflow below, so I think we're OK.

> +            throttle_inc =3D MIN(cpu_now - cpu_ideal, pct_increment);
> +        }
> +        cpu_throttle_set(MIN(throttle_now + throttle_inc, pct_max));
>      }
>  }
> =20
> @@ -919,7 +933,8 @@ static void migration_trigger_throttle(RAMState *rs)
>              (++rs->dirty_rate_high_cnt >=3D 2)) {
>              trace_migration_throttle();
>              rs->dirty_rate_high_cnt =3D 0;
> -            mig_throttle_guest_down();
> +            mig_throttle_guest_down(bytes_dirty_period,
> +                                    bytes_dirty_threshold);
>          }
>      }
>  }
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9b94e67879..acd7539273 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -419,6 +419,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
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
> @@ -1271,6 +1275,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
>          p->has_cpu_throttle_increment =3D true;
>          visit_type_int(v, param, &p->cpu_throttle_increment, &err);
>          break;
> +    case MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW:
> +        p->has_cpu_throttle_tailslow =3D true;
> +        visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
> +        break;
>      case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
>          p->has_max_cpu_throttle =3D true;
>          visit_type_int(v, param, &p->max_cpu_throttle, &err);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eca2981d0a..ee6c5a0cae 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -552,6 +552,21 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. The default value is 10. (Since 2.7=
)
>  #
> +# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
> +#                         At the tail stage of throttling, the Guest is =
very
> +#                         sensitive to CPU percentage while the @cpu-thr=
ottle
> +#                         -increment is excessive usually at tail stage.
> +#                         If this parameter is true, we will compute the=
 ideal
> +#                         CPU percentage used by the Guest, which may ex=
actly make
> +#                         the dirty rate match the dirty rate threshold.=
 Then we
> +#                         will choose a smaller throttle increment betwe=
en the
> +#                         one specified by @cpu-throttle-increment and t=
he one
> +#                         generated by ideal CPU percentage.
> +#                         Therefore, it is compatible to traditional thr=
ottling,
> +#                         meanwhile the throttle increment won't be exce=
ssive
> +#                         at tail stage.
> +#                         The default value is false. (Since 5.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials for
>  #             establishing a TLS connection over the migration data chan=
nel.
>  #             On the outgoing side of the migration, the credentials mus=
t
> @@ -631,6 +646,7 @@
>             'compress-level', 'compress-threads', 'decompress-threads',
>             'compress-wait-thread', 'throttle-trigger-threshold',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
> +           'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
> @@ -676,6 +692,21 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. The default value is 10. (Since 2.7=
)
>  #
> +# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
> +#                         At the tail stage of throttling, the Guest is =
very
> +#                         sensitive to CPU percentage while the @cpu-thr=
ottle
> +#                         -increment is excessive usually at tail stage.
> +#                         If this parameter is true, we will compute the=
 ideal
> +#                         CPU percentage used by the Guest, which may ex=
actly make
> +#                         the dirty rate match the dirty rate threshold.=
 Then we
> +#                         will choose a smaller throttle increment betwe=
en the
> +#                         one specified by @cpu-throttle-increment and t=
he one
> +#                         generated by ideal CPU percentage.
> +#                         Therefore, it is compatible to traditional thr=
ottling,
> +#                         meanwhile the throttle increment won't be exce=
ssive
> +#                         at tail stage.
> +#                         The default value is false. (Since 5.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #             for establishing a TLS connection over the migration data
>  #             channel. On the outgoing side of the migration, the creden=
tials
> @@ -763,6 +794,7 @@
>              '*throttle-trigger-threshold': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
> +            '*cpu-throttle-tailslow': 'bool',
>              '*tls-creds': 'StrOrNull',
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
> @@ -834,6 +866,21 @@
>  #                          auto-converge detects that migration is not m=
aking
>  #                          progress. (Since 2.7)
>  #
> +# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
> +#                         At the tail stage of throttling, the Guest is =
very
> +#                         sensitive to CPU percentage while the @cpu-thr=
ottle
> +#                         -increment is excessive usually at tail stage.
> +#                         If this parameter is true, we will compute the=
 ideal
> +#                         CPU percentage used by the Guest, which may ex=
actly make
> +#                         the dirty rate match the dirty rate threshold.=
 Then we
> +#                         will choose a smaller throttle increment betwe=
en the
> +#                         one specified by @cpu-throttle-increment and t=
he one
> +#                         generated by ideal CPU percentage.
> +#                         Therefore, it is compatible to traditional thr=
ottling,
> +#                         meanwhile the throttle increment won't be exce=
ssive
> +#                         at tail stage.
> +#                         The default value is false. (Since 5.1)
> +#
>  # @tls-creds: ID of the 'tls-creds' object that provides credentials
>  #             for establishing a TLS connection over the migration data
>  #             channel. On the outgoing side of the migration, the creden=
tials
> @@ -921,6 +968,7 @@
>              '*throttle-trigger-threshold': 'uint8',
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


