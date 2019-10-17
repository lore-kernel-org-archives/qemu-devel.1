Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC45ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5001F20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5001F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5Xq-0000Ci-Au
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SA-0000md-DU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5S8-0008Ti-Q3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5S1-0008PA-V0; Thu, 17 Oct 2019 09:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17D3D3082E72;
 Thu, 17 Oct 2019 13:04:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CE91001B11;
 Thu, 17 Oct 2019 13:04:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 08/18] qemu-storage-daemon: Add --export option
Date: Thu, 17 Oct 2019 15:01:54 +0200
Message-Id: <20191017130204.16131-9-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 13:04:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a --export option to qemu-storage-daemon to export a block node. For
now, only NBD exports are implemented. Apart from the 'type' option
(which is the implied key), it maps the arguments for nbd-server-add to
the command line. Example:

    --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block.json       | 27 +++++++++++++++++++++++++++
 qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 567f116875..d9b1f16fbf 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -481,3 +481,30 @@
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
             'sector-num': 'int', 'sectors-count': 'int' } }
+
+##
+# @BlockExportType:
+#
+# An enumeration of block export types
+#
+# @nbd: NBD export
+#
+# Since: 4.2
+##
+{ 'enum': 'BlockExportType',
+  'data': [ 'nbd' ] }
+
+##
+# @BlockExport:
+#
+# Describes a block export, i.e. how single node should be exported on a=
n
+# external interface.
+#
+# Since: 4.2
+##
+{ 'union': 'BlockExport',
+  'base': { 'type': 'BlockExportType' },
+  'discriminator': 'type',
+  'data': {
+      'nbd': 'BlockExportNbd'
+   } }
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 51882452f3..9e5f474fd0 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -67,6 +67,11 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --export [type=3D]nbd,device=3D<node-name>[,name=3D<export-name>]\n"
+"           [,writable=3Don|off][,bitmap=3D<name>]\n"
+"                         export the specified block node over NBD\n"
+"                         (requires --nbd-server)\n"
+"\n"
 "  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n=
"
 "               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
 "  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
@@ -84,6 +89,7 @@ enum {
     OPTION_OBJECT =3D 256,
     OPTION_BLOCKDEV,
     OPTION_NBD_SERVER,
+    OPTION_EXPORT,
 };
=20
 static QemuOptsList qemu_object_opts =3D {
@@ -95,6 +101,17 @@ static QemuOptsList qemu_object_opts =3D {
     },
 };
=20
+static void init_export(BlockExport *export, Error **errp)
+{
+    switch (export->type) {
+    case BLOCK_EXPORT_TYPE_NBD:
+        qmp_nbd_server_add(&export->u.nbd, errp);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int process_options(int argc, char *argv[], Error **errp)
 {
     int c;
@@ -106,6 +123,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
         {"object", required_argument, 0, OPTION_OBJECT},
         {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
         {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
+        {"export", required_argument, 0, OPTION_EXPORT},
         {"version", no_argument, 0, 'V'},
         {"trace", required_argument, NULL, 'T'},
         {0, 0, 0, 0}
@@ -176,6 +194,19 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
                 qapi_free_NbdServerOptions(options);
                 break;
             }
+        case OPTION_EXPORT:
+            {
+                Visitor *v;
+                BlockExport *export;
+
+                v =3D qobject_input_visitor_new_str(optarg, "type", &err=
or_fatal);
+                visit_type_BlockExport(v, NULL, &export, &error_fatal);
+                visit_free(v);
+
+                init_export(export, &error_fatal);
+                qapi_free_BlockExport(export);
+                break;
+            }
         }
     }
     if (optind !=3D argc) {
--=20
2.20.1


