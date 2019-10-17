Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA3FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0D920640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0D920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5Tq-0002Rz-Sw
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5Ry-0000Vp-2c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5Rx-0008MY-0M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Rq-0008IM-Q6; Thu, 17 Oct 2019 09:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 136B7C050DFF;
 Thu, 17 Oct 2019 13:04:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85E621001938;
 Thu, 17 Oct 2019 13:04:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 02/18] qemu-storage-daemon: Add --object option
Date: Thu, 17 Oct 2019 15:01:48 +0200
Message-Id: <20191017130204.16131-3-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 17 Oct 2019 13:04:10 +0000 (UTC)
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

Add a command line option to create user-creatable QOM objects.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index a251dc255c..48d6af43a6 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -35,6 +35,8 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
+#include "qom/object_interfaces.h"
=20
 #include "trace/control.h"
=20
@@ -51,10 +53,26 @@ static void help(void)
 "                         specify tracing options\n"
 "  -V, --version          output version information and exit\n"
 "\n"
+"  --object <properties>  define a QOM object such as 'secret' for\n"
+"                         passwords and/or encryption keys\n"
+"\n"
 QEMU_HELP_BOTTOM "\n",
     error_get_progname());
 }
=20
+enum {
+    OPTION_OBJECT =3D 256,
+};
+
+static QemuOptsList qemu_object_opts =3D {
+    .name =3D "object",
+    .implied_opt_name =3D "qom-type",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
+    .desc =3D {
+        { }
+    },
+};
+
 static int process_options(int argc, char *argv[], Error **errp)
 {
     int c;
@@ -63,6 +81,7 @@ static int process_options(int argc, char *argv[], Erro=
r **errp)
=20
     static const struct option long_options[] =3D {
         {"help", no_argument, 0, 'h'},
+        {"object", required_argument, 0, OPTION_OBJECT},
         {"version", no_argument, 0, 'V'},
         {"trace", required_argument, NULL, 'T'},
         {0, 0, 0, 0}
@@ -88,6 +107,22 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
             g_free(trace_file);
             trace_file =3D trace_opt_parse(optarg);
             break;
+        case OPTION_OBJECT:
+            {
+                QemuOpts *opts;
+                const char *type;
+
+                opts =3D qemu_opts_parse(&qemu_object_opts,
+                                       optarg, true, &error_fatal);
+                type =3D qemu_opt_get(opts, "qom-type");
+
+                if (user_creatable_print_help(type, opts)) {
+                    exit(EXIT_SUCCESS);
+                }
+                user_creatable_add_opts(opts, &error_fatal);
+                qemu_opts_del(opts);
+                break;
+            }
         }
     }
     if (optind !=3D argc) {
--=20
2.20.1


