Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A84C32767
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526FD215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bypIk+xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526FD215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inRD6-00084B-CZ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inRCK-0007aM-DP
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inRCH-0006BZ-IS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:57:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inRCH-00065G-BH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578074236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UD/2NOJHscoImo3VZRLG2XTRN/Hw1Kewl0c8z9XsgBE=;
 b=bypIk+xAMuvZ1ETWVmV9tgGKhVG49YGxFXIW0nTjR5E/Hx1hQeuuU4uWeooLJcDQ2di5DG
 EIk9Apu4ajGTLm6b2d71o9UqhFCRJlsC20RWSzs9JP5gFt+iBzlBWh3jCK+h080GhMMTAq
 WpfLzyIeNLMRJFM9GIoABn5cLo+65Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-7DRqDqDFOJWTtXo2axcGyA-1; Fri, 03 Jan 2020 12:57:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 824801005510
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 17:57:13 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67C495C548;
 Fri,  3 Jan 2020 17:57:11 +0000 (UTC)
Date: Fri, 3 Jan 2020 17:57:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 06/10] migration: Add multifd-compress parameter
Message-ID: <20200103175708.GR3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-7-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-7-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7DRqDqDFOJWTtXo2axcGyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
>=20
> ---
> Rename it to NONE
> Fix typos (dave)
> We don't need to chek values returned by visit_type_MultifdCompress (mark=
us)
> Fix yet more typos (wei)
> ---
>  hw/core/qdev-properties.c    | 13 +++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  migration/migration.c        | 13 +++++++++++++
>  monitor/hmp-cmds.c           | 13 +++++++++++++
>  qapi/migration.json          | 30 +++++++++++++++++++++++++++---
>  tests/migration-test.c       | 13 ++++++++++---
>  6 files changed, 79 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ac28890e5a..644705235e 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -8,6 +8,7 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/ctype.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "hw/block/block.h"
>  #include "net/hub.h"
>  #include "qapi/visitor.h"
> @@ -648,6 +649,18 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>      .set_default_value =3D set_default_value_enum,
>  };
> =20
> +/* --- MultifdCompress --- */
> +
> +const PropertyInfo qdev_prop_multifd_compress =3D {
> +    .name =3D "MultifdCompress",
> +    .description =3D "multifd_compress values, "
> +                   "none",
> +    .enum_table =3D &MultifdCompress_lookup,
> +    .get =3D get_enum,
> +    .set =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
> +};
> +
>  /* --- pci address --- */
> =20
>  /*
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index c6a8cb5516..07d7bba682 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -21,6 +21,7 @@ extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_ptr;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_on_off_auto;
> +extern const PropertyInfo qdev_prop_multifd_compress;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> @@ -204,6 +205,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, Multi=
fdCompress)
>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>                          LostTickPolicy)
> diff --git a/migration/migration.c b/migration/migration.c
> index cf6cec5fb6..93c6ed10a6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -87,6 +87,7 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 16
> +#define DEFAULT_MIGRATE_MULTIFD_COMPRESS MULTIFD_COMPRESS_NONE
> =20
>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> @@ -774,6 +775,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
>      params->block_incremental =3D s->parameters.block_incremental;
>      params->has_multifd_channels =3D true;
>      params->multifd_channels =3D s->parameters.multifd_channels;
> +    params->has_multifd_compress =3D true;
> +    params->multifd_compress =3D s->parameters.multifd_compress;
>      params->has_xbzrle_cache_size =3D true;
>      params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
>      params->has_max_postcopy_bandwidth =3D true;
> @@ -1281,6 +1284,9 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
>      if (params->has_multifd_channels) {
>          dest->multifd_channels =3D params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        dest->multifd_compress =3D params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
>      }
> @@ -1377,6 +1383,9 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels =3D params->multifd_channels;
>      }
> +    if (params->has_multifd_compress) {
> +        s->parameters.multifd_compress =3D params->multifd_compress;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> @@ -3474,6 +3483,9 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("multifd-channels", MigrationState,
>                        parameters.multifd_channels,
>                        DEFAULT_MIGRATE_MULTIFD_CHANNELS),
> +    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
> +                      parameters.multifd_compress,
> +                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                        parameters.xbzrle_cache_size,
>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> @@ -3564,6 +3576,7 @@ static void migration_instance_init(Object *obj)
>      params->has_x_checkpoint_delay =3D true;
>      params->has_block_incremental =3D true;
>      params->has_multifd_channels =3D true;
> +    params->has_multifd_compress =3D true;
>      params->has_xbzrle_cache_size =3D true;
>      params->has_max_postcopy_bandwidth =3D true;
>      params->has_max_cpu_throttle =3D true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index b2551c16d1..caf06b0668 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -39,6 +39,7 @@
>  #include "qapi/qapi-commands-tpm.h"
>  #include "qapi/qapi-commands-ui.h"
>  #include "qapi/qapi-visit-net.h"
> +#include "qapi/qapi-visit-migration.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/string-input-visitor.h"
> @@ -448,6 +449,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS)=
,
>              params->multifd_channels);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS)=
,
> +            MultifdCompress_str(params->multifd_compress));
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
>              params->xbzrle_cache_size);
> @@ -1739,6 +1743,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
>      MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
>      uint64_t valuebw =3D 0;
>      uint64_t cache_size;
> +    MultifdCompress compress_type;
>      Error *err =3D NULL;
>      int val, ret;
> =20
> @@ -1824,6 +1829,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
>          p->has_multifd_channels =3D true;
>          visit_type_int(v, param, &p->multifd_channels, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
> +        p->has_multifd_compress =3D true;
> +        visit_type_MultifdCompress(v, param, &compress_type, &err);
> +        if (err) {
> +            break;
> +        }
> +        p->multifd_compress =3D compress_type;
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size =3D true;
>          visit_type_size(v, param, &cache_size, &err);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..430a39382e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -488,6 +488,19 @@
>  ##
>  { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
> =20
> +##
> +# @MultifdCompress:
> +#
> +# An enumeration of multifd compression.
> +#
> +# @none: no compression.
> +#
> +# Since: 4.1
> +#
> +##
> +{ 'enum': 'MultifdCompress',
> +  'data': [ 'none' ] }
> +
>  ##
>  # @MigrationParameter:
>  #
> @@ -586,6 +599,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#

5.0 I guess!

>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -598,7 +614,7 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle', 'multifd-compress' ] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -688,6 +704,9 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make
> @@ -713,7 +732,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -=09    '*max-cpu-throttle': 'int' } }
> +            '*max-cpu-throttle': 'int',
> +            '*multifd-compress': 'MultifdCompress' } }
> =20
>  ##
>  # @migrate-set-parameters:
> @@ -823,6 +843,9 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multifd-compress: Which compression method to use.
> +#                    Defaults to none. (Since 4.1)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> @@ -846,7 +869,8 @@
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
>  =09    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-compress': 'MultifdCompress' } }
> =20
>  ##
>  # @query-migrate-parameters:
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index fc221f172a..e5b6e54cfa 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -482,7 +482,6 @@ static void migrate_check_parameter_str(QTestState *w=
ho, const char *parameter,
>      g_free(result);
>  }
> =20
> -__attribute__((unused))
>  static void migrate_set_parameter_str(QTestState *who, const char *param=
eter,
>                                        const char *value)
>  {
> @@ -1398,7 +1397,7 @@ static void test_migrate_auto_converge(void)
>      test_migrate_end(from, to, true);
>  }
> =20
> -static void test_multifd_tcp(void)
> +static void test_multifd_tcp(const char *method)
>  {
>      MigrateStart *args =3D migrate_start_new();
>      QTestState *from, *to;
> @@ -1422,6 +1421,9 @@ static void test_multifd_tcp(void)
>      migrate_set_parameter_int(from, "multifd-channels", 16);
>      migrate_set_parameter_int(to, "multifd-channels", 16);
> =20
> +    migrate_set_parameter_str(from, "multifd-compress", method);
> +    migrate_set_parameter_str(to, "multifd-compress", method);
> +
>      migrate_set_capability(from, "multifd", "true");
>      migrate_set_capability(to, "multifd", "true");
> =20
> @@ -1453,6 +1455,11 @@ static void test_multifd_tcp(void)
>      free(uri);
>  }
> =20
> +static void test_multifd_tcp_none(void)
> +{
> +    test_multifd_tcp("none");
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] =3D "/tmp/migration-test-XXXXXX";
> @@ -1517,7 +1524,7 @@ int main(int argc, char **argv)
>                     test_validate_uuid_dst_not_set);
> =20
>      qtest_add_func("/migration/auto_converge", test_migrate_auto_converg=
e);
> -    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
> +    qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none)=
;
> =20
>      ret =3D g_test_run();

Except for the Since 4.1's:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> =20
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


