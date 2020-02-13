Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A3C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0E4206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL4zb+2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LxN-0004XM-N5
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2Lrt-0005qd-4n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2Lrq-0005FB-DC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35482
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2Lrq-00058w-2W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bk0eYKapoPLtbKAcJuykvB4IMf3GQZPBvSP3q8CPYFo=;
 b=dL4zb+2VLYaTOo+3aj2ylL+tqsVhf1dX2vdwBHTii3MLAJ3JGIZV8m6SqaAsoSTOXsEK97
 dJKarT1euyUTwpvFM0f/niL6mXQiymkniszfdxtUcA/P4t/EmUjGpGDG9RgJYI2n+W7i8s
 /5F7GCZT5CQf8H8cUTLShw2rioaB+cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-sJ_0sV0wOUOZ8Rr5OqXDxA-1; Thu, 13 Feb 2020 16:17:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9681DDB21;
 Thu, 13 Feb 2020 21:17:43 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AECCE19C7F;
 Thu, 13 Feb 2020 21:17:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/8] multifd: Add multifd-zstd-level parameter
Date: Thu, 13 Feb 2020 22:17:08 +0100
Message-Id: <20200213211709.59065-8-quintela@redhat.com>
In-Reply-To: <20200213211709.59065-1-quintela@redhat.com>
References: <20200213211709.59065-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sJ_0sV0wOUOZ8Rr5OqXDxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This parameter specifies the zstd compression level. The next patch
will put it to use.

Signed-off-by: Juan Quintela <quintela@redhat.com>
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
index 8a39dff589..f9f2c4446a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1840,6 +1840,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
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
index 860609231b..1fba695e2e 100644
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
 =09    '*max-postcopy-bandwidth': 'size',
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


