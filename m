Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDFC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973E324695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAAm0dwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973E324695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bwT-0003tN-Gs
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7btY-0007ot-4A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7btW-000436-Jl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7btV-00042o-Fx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xsd4VVycDhAV3MVKF8+s4aTYKkltuXMZi5Z3cvzxxBQ=;
 b=iAAm0dwvtNdJbrzBcSQWlSHwlgu75rhaRs6eynadAkDGkMCYkTUE48YZJrKRY3MZgEFdud
 KU/SWwfJ0UBNYDdwYgNrQtOXdkxjrIPloXdG3qcJHBGsfGKHsPgzNxlOgSCIeBYItgVVtK
 acOAx6JS/BYN50gJtepdFpNVuQT1eOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-tPz--BktPUmGcU466iyjRg-1; Fri, 28 Feb 2020 04:25:12 -0500
X-MC-Unique: tPz--BktPUmGcU466iyjRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34D83801F75;
 Fri, 28 Feb 2020 09:25:11 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B05E60BE0;
 Fri, 28 Feb 2020 09:24:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] multifd: Add multifd-zstd-level parameter
Date: Fri, 28 Feb 2020 10:24:12 +0100
Message-Id: <20200228092420.103757-8-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
References: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This parameter specifies the zstd compression level. The next patch
will put it to use.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/migration.h |  1 +
 monitor/hmp-cmds.c    |  4 ++++
 qapi/migration.json   | 29 ++++++++++++++++++++++++++---
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a09726f679..c1814a6861 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -91,6 +91,8 @@
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
+/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
+#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->multifd_compression =3D s->parameters.multifd_compression;
     params->has_multifd_zlib_level =3D true;
     params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
+    params->has_multifd_zstd_level =3D true;
+    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1219,6 +1223,13 @@ static bool migrate_params_check(MigrationParameters=
 *params, Error **errp)
         return false;
     }
=20
+    if (params->has_multifd_zstd_level &&
+        (params->multifd_zstd_level > 20)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level=
",
+                   "is invalid, it should be in the range of 0 to 20");
+        return false;
+    }
+
     if (params->has_xbzrle_cache_size &&
         (params->xbzrle_cache_size < qemu_target_page_size() ||
          !is_power_of_2(params->xbzrle_cache_size))) {
@@ -2274,6 +2285,15 @@ int migrate_multifd_zlib_level(void)
     return s->parameters.multifd_zlib_level;
 }
=20
+int migrate_multifd_zstd_level(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_zstd_level;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -3567,6 +3587,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
+    DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
+                      parameters.multifd_zstd_level,
+                      DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3659,6 +3682,7 @@ static void migration_instance_init(Object *obj)
     params->has_multifd_channels =3D true;
     params->has_multifd_compression =3D true;
     params->has_multifd_zlib_level =3D true;
+    params->has_multifd_zstd_level =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/migration/migration.h b/migration/migration.h
index c363ef9334..507284e563 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -302,6 +302,7 @@ bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_zstd_level(void);
=20
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 409ebb2b03..30313858c2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1841,6 +1841,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
         p->has_multifd_zlib_level =3D true;
         visit_type_int(v, param, &p->multifd_zlib_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
+        p->has_multifd_zstd_level =3D true;
+        visit_type_int(v, param, &p->multifd_zstd_level, &err);
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index 3fb9e59bce..f2da5cfa0f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -610,6 +610,13 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @multifd-zstd-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 20, where 0 means no compression, 1 means the best
+#          compression speed, and 20 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -623,7 +630,7 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level' ] }
+           'multifd-zlib-level' ,'multifd-zstd-level' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -723,6 +730,13 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @multifd-zstd-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 20, where 0 means no compression, 1 means the best
+#          compression speed, and 20 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -750,7 +764,8 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'int',
             '*multifd-compression': 'MultiFDCompression',
-            '*multifd-zlib-level': 'int' } }
+            '*multifd-zlib-level': 'int',
+            '*multifd-zstd-level': 'int' } }
=20
 ##
 # @migrate-set-parameters:
@@ -870,6 +885,13 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @multifd-zstd-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 20, where 0 means no compression, 1 means the best
+#          compression speed, and 20 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -895,7 +917,8 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
-            '*multifd-zlib-level': 'uint8' } }
+            '*multifd-zlib-level': 'uint8',
+            '*multifd-zstd-level': 'uint8' } }
=20
 ##
 # @query-migrate-parameters:
--=20
2.24.1


