Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18461C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FA2222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwUQAoDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FA2222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Lxl-0004ui-55
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2Lrc-0005W8-4W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2LrY-0004ll-LI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2LrY-0004iy-FR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIHT3SvTaWFi+I8rdHRF85QIE4IroWCRSlWrm42jaDo=;
 b=BwUQAoDRQhjtPQgwGqZ7TAE6Xdi6DIr63FG5UNX7wER7or/O+AT2UKjFQ6p+Ojg49RG1dg
 /gUXy1c7euKr7PQ08UQ+790UyP7iG9M7xrgydf6ryVJFDUxApPIFPJfzVhZZbVJaMZcwQs
 VKy5l3lWnCgdUl6uZZxmfr/x83Liq2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Sg3bJBYaNhq_P1knx6xpig-1; Thu, 13 Feb 2020 16:17:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1580718AB2C2;
 Thu, 13 Feb 2020 21:17:29 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C9C619C7F;
 Thu, 13 Feb 2020 21:17:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/8] multifd: Add multifd-zlib-level parameter
Date: Thu, 13 Feb 2020 22:17:05 +0100
Message-Id: <20200213211709.59065-5-quintela@redhat.com>
In-Reply-To: <20200213211709.59065-1-quintela@redhat.com>
References: <20200213211709.59065-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Sg3bJBYaNhq_P1knx6xpig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

This parameter specifies the zlib compression level. The next patch
will put it to use.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/migration.h |  1 +
 monitor/hmp-cmds.c    |  4 ++++
 qapi/migration.json   | 30 +++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index eb7b0a2df0..a09726f679 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -89,6 +89,8 @@
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
+/* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
+#define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -801,6 +803,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->multifd_channels =3D s->parameters.multifd_channels;
     params->has_multifd_compression =3D true;
     params->multifd_compression =3D s->parameters.multifd_compression;
+    params->has_multifd_zlib_level =3D true;
+    params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1208,6 +1212,13 @@ static bool migrate_params_check(MigrationParameters=
 *params, Error **errp)
         return false;
     }
=20
+    if (params->has_multifd_zlib_level &&
+        (params->multifd_zlib_level > 9)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level=
",
+                   "is invalid, it should be in the range of 0 to 9");
+        return false;
+    }
+
     if (params->has_xbzrle_cache_size &&
         (params->xbzrle_cache_size < qemu_target_page_size() ||
          !is_power_of_2(params->xbzrle_cache_size))) {
@@ -2254,6 +2265,15 @@ MultiFDCompression migrate_multifd_compression(void)
     return s->parameters.multifd_compression;
 }
=20
+int migrate_multifd_zlib_level(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_zlib_level;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -3544,6 +3564,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
                       parameters.multifd_compression,
                       DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
+    DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
+                      parameters.multifd_zlib_level,
+                      DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3635,6 +3658,7 @@ static void migration_instance_init(Object *obj)
     params->has_block_incremental =3D true;
     params->has_multifd_channels =3D true;
     params->has_multifd_compression =3D true;
+    params->has_multifd_zlib_level =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/migration/migration.h b/migration/migration.h
index 59fea02482..c363ef9334 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -301,6 +301,7 @@ bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
+int migrate_multifd_zlib_level(void);
=20
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 40525b5e95..8a39dff589 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1836,6 +1836,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
         }
         p->multifd_compression =3D compress_type;
         break;
+    case MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL:
+        p->has_multifd_zlib_level =3D true;
+        visit_type_int(v, param, &p->multifd_zlib_level, &err);
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index 28593e2a2c..0845d926f2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -602,6 +602,13 @@
 # @multifd-compression: Which compression method to use.
 #                       Defaults to none. (Since 5.0)
 #
+# @multifd-zlib-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 9, where 0 means no compression, 1 means the best
+#          compression speed, and 9 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -614,7 +621,8 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression' ] }
+           'max-cpu-throttle', 'multifd-compression',
+           'multifd-zlib-level' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -707,6 +715,13 @@
 # @multifd-compression: Which compression method to use.
 #                       Defaults to none. (Since 5.0)
 #
+# @multifd-zlib-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 9, where 0 means no compression, 1 means the best
+#          compression speed, and 9 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -733,7 +748,8 @@
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'int',
-            '*multifd-compression': 'MultiFDCompression' } }
+            '*multifd-compression': 'MultiFDCompression',
+            '*multifd-zlib-level': 'int' } }
=20
 ##
 # @migrate-set-parameters:
@@ -846,6 +862,13 @@
 # @multifd-compression: Which compression method to use.
 #                       Defaults to none. (Since 5.0)
 #
+# @multifd-zlib-level: Set the compression level to be used in live
+#          migration, the compression level is an integer between 0
+#          and 9, where 0 means no compression, 1 means the best
+#          compression speed, and 9 means best compression ratio which
+#          will consume more CPU.
+#          Defaults to 1. (Since 5.0)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -870,7 +893,8 @@
             '*xbzrle-cache-size': 'size',
 =09    '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
-            '*multifd-compression': 'MultiFDCompression' } }
+            '*multifd-compression': 'MultiFDCompression',
+            '*multifd-zlib-level': 'uint8' } }
=20
 ##
 # @query-migrate-parameters:
--=20
2.24.1


