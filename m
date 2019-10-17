Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75195ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A64920640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A64920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5WQ-0006UC-2r
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S6-0000hK-M8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5S5-0008RV-5p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Ry-0008Mm-4U; Thu, 17 Oct 2019 09:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62B4E307C64C;
 Thu, 17 Oct 2019 13:04:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D623010027AB;
 Thu, 17 Oct 2019 13:04:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
Date: Thu, 17 Oct 2019 15:01:52 +0200
Message-Id: <20191017130204.16131-7-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 17 Oct 2019 13:04:17 +0000 (UTC)
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

Add a --nbd-server option to qemu-storage-daemon to start the built-in
NBD server right away. It maps the arguments for nbd-server-start to the
command line. Example (only with required options):

    --nbd-server addr.type=3Dinet,addr.host=3Dlocalhost,addr.port=3D10809

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block.json       | 18 ++++++++++++++++++
 include/block/nbd.h   |  1 +
 blockdev-nbd.c        |  5 +++++
 qemu-storage-daemon.c | 26 +++++++++++++++++++++++++-
 Makefile.objs         |  2 +-
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb6..7fe0cf6538 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -215,6 +215,24 @@
             '*id': 'str',
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
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 316fd705a9..2a7441491a 100644
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
index 6a8b206e1d..d4c1fd4166 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -132,6 +132,11 @@ void nbd_server_start(SocketAddress *addr, const cha=
r *tls_creds,
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
index 904e3c3a46..51882452f3 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -25,11 +25,14 @@
 #include "qemu/osdep.h"
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
 #include "qapi/qobject-input-visitor.h"
=20
 #include "qemu-common.h"
@@ -64,6 +67,12 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n=
"
+"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
+"  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
+"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
+"                         start an NBD server for exporting block nodes\=
n"
+"\n"
 "  --object <properties>  define a QOM object such as 'secret' for\n"
 "                         passwords and/or encryption keys\n"
 "\n"
@@ -74,6 +83,7 @@ QEMU_HELP_BOTTOM "\n",
 enum {
     OPTION_OBJECT =3D 256,
     OPTION_BLOCKDEV,
+    OPTION_NBD_SERVER,
 };
=20
 static QemuOptsList qemu_object_opts =3D {
@@ -95,6 +105,7 @@ static int process_options(int argc, char *argv[], Err=
or **errp)
         {"help", no_argument, 0, 'h'},
         {"object", required_argument, 0, OPTION_OBJECT},
         {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
+        {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
         {"version", no_argument, 0, 'V'},
         {"trace", required_argument, NULL, 'T'},
         {0, 0, 0, 0}
@@ -152,6 +163,19 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_NBD_SERVER:
+            {
+                Visitor *v;
+                NbdServerOptions *options;
+
+                v =3D qobject_input_visitor_new_str(optarg, NULL, &error=
_fatal);
+                visit_type_NbdServerOptions(v, NULL, &options, &error_fa=
tal);
+                visit_free(v);
+
+                nbd_server_start_options(options, &error_fatal);
+                qapi_free_NbdServerOptions(options);
+                break;
+            }
         }
     }
     if (optind !=3D argc) {
diff --git a/Makefile.objs b/Makefile.objs
index 00fdf54500..cc262e445f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -42,7 +42,7 @@ io-obj-y =3D io/
 # used for system emulation, too, but specified separately there)
=20
 storage-daemon-obj-y =3D block/
-storage-daemon-obj-y +=3D blockdev.o iothread.o
+storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
=20
 ######################################################################
 # Target independent part of system emulation. The long term path is to
--=20
2.20.1


