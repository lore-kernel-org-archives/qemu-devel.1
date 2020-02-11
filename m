Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C79C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFC7214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwNWdtQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFC7214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aae-0007Nw-0T
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1aZo-0006wA-Fa
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1aZl-0006Xj-AQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:48:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1aZl-0006Uu-0S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581446879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EurBYT7GIXDbu1Mwu12Oz3we1Mv6OvAAjfOR1qH1kgE=;
 b=fwNWdtQnJRiG+60WQwtHpnnepTBPdFT1tjm108jJFzkzr3eAxpch132DHWqC2+u6tUStlU
 jK+EEpGEMjHtNs6T0IGl+kWRR24HQOrohJsnNXDQo06HqD8lSrfkL96zWs79FZyJAWrlS4
 2D6ud23wsD2g4X3SoGND/WAEEE+LMf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-sXeln_8GMQybANNSXZTw9w-1; Tue, 11 Feb 2020 13:47:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A05800D5B
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 18:47:54 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3703560499;
 Tue, 11 Feb 2020 18:47:52 +0000 (UTC)
Date: Tue, 11 Feb 2020 18:47:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 7/8] multifd: Add multifd-zstd-level parameter
Message-ID: <20200211184749.GI2751@work-vm>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-8-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129115655.10414-8-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: sXeln_8GMQybANNSXZTw9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 15 +++++++++++++++
>  monitor/hmp-cmds.c    |  4 ++++
>  qapi/migration.json   | 29 ++++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 3b081e8147..b690500545 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -91,6 +91,8 @@
>  #define DEFAULT_MIGRATE_MULTIFD_METHOD MULTIFD_METHOD_NONE
>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> +/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
> +#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
> =20
>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> @@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->multifd_method =3D s->parameters.multifd_method;
>      params->has_multifd_zlib_level =3D true;
>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
> +    params->has_multifd_zstd_level =3D true;
> +    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;

Do we really want different 'multifd_...._level's or just one
'multifd_compress_level' - or even just reuse the existing
'compress-level' parameter.

The only tricky thing about combining them is how to handle
the difference in allowed ranges;  When would the right time be
to check it?

Markus/Eric: Any idea?

Dave

>      params->has_xbzrle_cache_size =3D true;
>      params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
>      params->has_max_postcopy_bandwidth =3D true;
> @@ -1219,6 +1223,13 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
>          return false;
>      }
> =20
> +    if (params->has_multifd_zstd_level &&
> +        (params->multifd_zstd_level > 20)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_lev=
el",
> +                   "is invalid, it should be in the range of 0 to 20");
> +        return false;
> +    }
> +
>      if (params->has_xbzrle_cache_size &&
>          (params->xbzrle_cache_size < qemu_target_page_size() ||
>           !is_power_of_2(params->xbzrle_cache_size))) {
> @@ -3559,6 +3570,9 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
>                        parameters.multifd_zlib_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> +    DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
> +                      parameters.multifd_zstd_level,
> +                      DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                        parameters.xbzrle_cache_size,
>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> @@ -3651,6 +3665,7 @@ static void migration_instance_init(Object *obj)
>      params->has_multifd_channels =3D true;
>      params->has_multifd_method =3D true;
>      params->has_multifd_zlib_level =3D true;
> +    params->has_multifd_zstd_level =3D true;
>      params->has_xbzrle_cache_size =3D true;
>      params->has_max_postcopy_bandwidth =3D true;
>      params->has_max_cpu_throttle =3D true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 7f11866446..87db07694b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1840,6 +1840,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
>          p->has_multifd_zlib_level =3D true;
>          visit_type_int(v, param, &p->multifd_zlib_level, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
> +        p->has_multifd_zstd_level =3D true;
> +        visit_type_int(v, param, &p->multifd_zstd_level, &err);
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size =3D true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 032ee7d3e6..bb5cb6b4f4 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -610,6 +610,13 @@
>  #          will consume more CPU.
>  #          Defaults to 1. (Since 5.0)
>  #
> +# @multifd-zstd-level: Set the compression level to be used in live
> +#          migration, the compression level is an integer between 0
> +#          and 20, where 0 means no compression, 1 means the best
> +#          compression speed, and 20 means best compression ratio which
> +#          will consume more CPU.
> +#          Defaults to 1. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -623,7 +630,7 @@
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-method',
> -           'multifd-zlib-level' ] }
> +           'multifd-zlib-level' ,'multifd-zstd-level' ] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -723,6 +730,13 @@
>  #          will consume more CPU.
>  #          Defaults to 1. (Since 5.0)
>  #
> +# @multifd-zstd-level: Set the compression level to be used in live
> +#          migration, the compression level is an integer between 0
> +#          and 20, where 0 means no compression, 1 means the best
> +#          compression speed, and 20 means best compression ratio which
> +#          will consume more CPU.
> +#          Defaults to 1. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -750,7 +764,8 @@
>              '*max-postcopy-bandwidth': 'size',
>              '*max-cpu-throttle': 'int',
>              '*multifd-method': 'MultiFDMethod',
> -            '*multifd-zlib-level': 'int' } }
> +            '*multifd-zlib-level': 'int',
> +            '*multifd-zstd-level': 'int' } }
> =20
>  ##
>  # @migrate-set-parameters:
> @@ -870,6 +885,13 @@
>  #          will consume more CPU.
>  #          Defaults to 1. (Since 5.0)
>  #
> +# @multifd-zstd-level: Set the compression level to be used in live
> +#          migration, the compression level is an integer between 0
> +#          and 20, where 0 means no compression, 1 means the best
> +#          compression speed, and 20 means best compression ratio which
> +#          will consume more CPU.
> +#          Defaults to 1. (Since 5.0)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -895,7 +917,8 @@
>  =09    '*max-postcopy-bandwidth': 'size',
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-method': 'MultiFDMethod',
> -            '*multifd-zlib-level': 'uint8' } }
> +            '*multifd-zlib-level': 'uint8',
> +            '*multifd-zstd-level': 'uint8' } }
> =20
>  ##
>  # @query-migrate-parameters:
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


