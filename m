Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D73C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324F320658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO671U49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324F320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGgp-0007qt-Bi
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZR-0004sd-PO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007oS-86
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZN-0007bZ-Ao
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrGbiQzS51UahfnmWeKqS0q0ozeE43ff9NeocMrkrpM=;
 b=TO671U49ZIaNdQPq0ypNsv4KnkXnoxMYT11WGWpysTNt3SxBVtbXMIEtclAwwxTj4JLNu1
 9LcyE5ZwhfJxNItN7dWiVl08S6Y/N2g5YUG4UVPIKIH0pFL87CP6uVlr9t6Q1ucWQQkDyb
 Thc3nhJpSJfh4YeoskSTtcWfpfdibGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ytIUMpC2PQakGXy24jpGtA-1; Fri, 06 Mar 2020 12:15:26 -0500
X-MC-Unique: ytIUMpC2PQakGXy24jpGtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E901005509;
 Fri,  6 Mar 2020 17:15:25 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A81C73873;
 Fri,  6 Mar 2020 17:15:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/29] qemu-storage-daemon: Add --nbd-server option
Date: Fri,  6 Mar 2020 18:14:44 +0100
Message-Id: <20200306171458.1848-16-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a --nbd-server option to qemu-storage-daemon to start the built-in
NBD server right away. It maps the arguments for nbd-server-start to the
command line, with the exception that it uses SocketAddress instead of
SocketAddressLegacy: New interfaces shouldn't use legacy types, and the
additional nesting would be nasty on the command line.

Example (only with required options):

    --nbd-server addr.type=3Dinet,addr.host=3Dlocalhost,addr.port=3D10809

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-10-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json  | 24 ++++++++++++++++++++++++
 include/block/nbd.h   |  1 +
 blockdev-nbd.c        |  5 +++++
 qemu-storage-daemon.c | 26 +++++++++++++++++++++++++-
 Makefile.objs         |  2 +-
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b65b6a9f49..f8888f06c8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5062,6 +5062,27 @@
              'iothread': 'StrOrNull',
              '*force': 'bool' } }
=20
+##
+# @NbdServerOptions:
+#
+# @addr: Address on which to listen.
+# @tls-creds: ID of the TLS credentials object (since 2.6).
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access (since 4.0).
+#
+# Keep this type consistent with the nbd-server-start arguments. The only
+# intended difference is using SocketAddress instead of SocketAddressLegac=
y.
+#
+# Since: 4.2
+##
+{ 'struct': 'NbdServerOptions',
+  'data': { 'addr': 'SocketAddress',
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
+
 ##
 # @nbd-server-start:
 #
@@ -5080,6 +5101,9 @@
 #
 # Returns: error if the server is already running.
 #
+# Keep this type consistent with the NbdServerOptions type. The only inten=
ded
+# difference is using SocketAddressLegacy instead of SocketAddress.
+#
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-start',
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 7f46932d80..20363280ae 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -353,6 +353,7 @@ void nbd_client_put(NBDClient *client);
=20
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       const char *tls_authz, Error **errp);
+void nbd_server_start_options(NbdServerOptions *arg, Error **errp);
=20
 /* nbd_read
  * Reads @size bytes from @ioc. Returns 0 on success.
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index de2f2ff713..d8c892f7da 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -132,6 +132,11 @@ void nbd_server_start(SocketAddress *addr, const char =
*tls_creds,
     nbd_server =3D NULL;
 }
=20
+void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
+{
+    nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz, errp);
+}
+
 void qmp_nbd_server_start(SocketAddressLegacy *addr,
                           bool has_tls_creds, const char *tls_creds,
                           bool has_tls_authz, const char *tls_authz,
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 0cd8144c81..276a412915 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -28,11 +28,14 @@
 #include <getopt.h>
=20
 #include "block/block.h"
+#include "block/nbd.h"
 #include "crypto/init.h"
=20
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-visit-block.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
=20
@@ -67,6 +70,12 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n"
+"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
+"  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
+"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
+"                         start an NBD server for exporting block nodes\n"
+"\n"
 "  --object help          list object types that can be added\n"
 "  --object <type>,help   list properties for the given object type\n"
 "  --object <type>[,<property>=3D<value>...]\n"
@@ -82,6 +91,7 @@ QEMU_HELP_BOTTOM "\n",
=20
 enum {
     OPTION_BLOCKDEV =3D 256,
+    OPTION_NBD_SERVER,
     OPTION_OBJECT,
 };
=20
@@ -101,6 +111,7 @@ static void process_options(int argc, char *argv[])
     static const struct option long_options[] =3D {
         {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
         {"help", no_argument, NULL, 'h'},
+        {"nbd-server", required_argument, NULL, OPTION_NBD_SERVER},
         {"object", required_argument, NULL, OPTION_OBJECT},
         {"trace", required_argument, NULL, 'T'},
         {"version", no_argument, NULL, 'V'},
@@ -145,6 +156,19 @@ static void process_options(int argc, char *argv[])
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_NBD_SERVER:
+            {
+                Visitor *v;
+                NbdServerOptions *options;
+
+                v =3D qobject_input_visitor_new_str(optarg, NULL, &error_f=
atal);
+                visit_type_NbdServerOptions(v, NULL, &options, &error_fata=
l);
+                visit_free(v);
+
+                nbd_server_start_options(options, &error_fatal);
+                qapi_free_NbdServerOptions(options);
+                break;
+            }
         case OPTION_OBJECT:
             {
                 QemuOpts *opts;
diff --git a/Makefile.objs b/Makefile.objs
index b5d9e1e134..bacbdb55bc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -32,7 +32,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # used for system emulation, too, but specified separately there)
=20
 storage-daemon-obj-y =3D block/ qom/
-storage-daemon-obj-y +=3D blockdev.o iothread.o
+storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
=20
 ######################################################################
 # Target independent part of system emulation. The long term path is to
--=20
2.20.1


