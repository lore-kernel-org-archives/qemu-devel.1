Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C06C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C1A20658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qxba1+p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C1A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGgK-0006SA-A8
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-0004zJ-1p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZR-0007wA-AN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007nW-E6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbiw7ViEEU1KfN5mtAV3IGyjNqQC+EGx8FNxWzm7jPA=;
 b=Qxba1+p2YPY/AvBmATAcUqvEzJ9yxtzyM5EELg6XDIRhnH1i3We9KpDLCkAVgH/gbF9q4/
 2XUHXwO5XDoGDtHWutV0Dz79L3/8MCZm1d3e2Dw3TbVURVqGz1OTdhMYDiRBC8GboJkZ+h
 yvf8Yhwxo8+dfdyaAUjQtM3byqq2DeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-mxwFAvv6Pge9A-rAbBTotw-1; Fri, 06 Mar 2020 12:15:29 -0500
X-MC-Unique: mxwFAvv6Pge9A-rAbBTotw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC382801E67;
 Fri,  6 Mar 2020 17:15:27 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E055673884;
 Fri,  6 Mar 2020 17:15:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/29] qemu-storage-daemon: Add --export option
Date: Fri,  6 Mar 2020 18:14:46 +0100
Message-Id: <20200306171458.1848-18-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a --export option to qemu-storage-daemon to export a block node. For
now, only NBD exports are implemented. Apart from the 'type' option
(which is the implied key), it maps the arguments for nbd-server-add to
the command line. Example:

    --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-12-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json  | 27 +++++++++++++++++++++++++++
 qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cdc585385c..48631218fa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5201,6 +5201,33 @@
 ##
 { 'command': 'nbd-server-stop' }
=20
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
+# Describes a block export, i.e. how single node should be exported on an
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
+
 ##
 # @QuorumOpType:
 #
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 276a412915..5904d3c5b4 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -70,6 +70,11 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --export [type=3D]nbd,device=3D<node-name>[,name=3D<export-name>]\n"
+"           [,writable=3Don|off][,bitmap=3D<name>]\n"
+"                         export the specified block node over NBD\n"
+"                         (requires --nbd-server)\n"
+"\n"
 "  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n"
 "               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
 "  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
@@ -91,6 +96,7 @@ QEMU_HELP_BOTTOM "\n",
=20
 enum {
     OPTION_BLOCKDEV =3D 256,
+    OPTION_EXPORT,
     OPTION_NBD_SERVER,
     OPTION_OBJECT,
 };
@@ -104,12 +110,24 @@ static QemuOptsList qemu_object_opts =3D {
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
 static void process_options(int argc, char *argv[])
 {
     int c;
=20
     static const struct option long_options[] =3D {
         {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
+        {"export", required_argument, NULL, OPTION_EXPORT},
         {"help", no_argument, NULL, 'h'},
         {"nbd-server", required_argument, NULL, OPTION_NBD_SERVER},
         {"object", required_argument, NULL, OPTION_OBJECT},
@@ -156,6 +174,19 @@ static void process_options(int argc, char *argv[])
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_EXPORT:
+            {
+                Visitor *v;
+                BlockExport *export;
+
+                v =3D qobject_input_visitor_new_str(optarg, "type", &error=
_fatal);
+                visit_type_BlockExport(v, NULL, &export, &error_fatal);
+                visit_free(v);
+
+                init_export(export, &error_fatal);
+                qapi_free_BlockExport(export);
+                break;
+            }
         case OPTION_NBD_SERVER:
             {
                 Visitor *v;
--=20
2.20.1


