Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114C6C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF17A20714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCZbpBij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF17A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Eqt-00043W-K5
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6El5-0001wm-AR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6El3-0002Mi-UG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6El3-0002Mb-Pa
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njL4p+O8e20nCibvaiBgf6Oi+xeoYFNnJeIvfkpwLfc=;
 b=JCZbpBijVkKPdj3+f0heHL6M5Xh3IrYsSCt9k6Yi+w+d5yntFXbjLPhkyp22FKsk0+bUGS
 ZbKDBoBTHEywqxbToHrULifzSw0tYrXg22kh8joN5XsyNeU/pky/ygi9dOIkuSk5nV02/8
 SqWhdlgOdwbWF/0D0XWtY85F//AZp/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-uh_IhfU7NL6kaNkgj6045w-1; Mon, 24 Feb 2020 09:30:49 -0500
X-MC-Unique: uh_IhfU7NL6kaNkgj6045w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E3FD8024DF;
 Mon, 24 Feb 2020 14:30:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDD995C114;
 Mon, 24 Feb 2020 14:30:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 08/20] qemu-storage-daemon: Add --object option
Date: Mon, 24 Feb 2020 15:29:56 +0100
Message-Id: <20200224143008.13362-9-kwolf@redhat.com>
In-Reply-To: <20200224143008.13362-1-kwolf@redhat.com>
References: <20200224143008.13362-1-kwolf@redhat.com>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a command line option to create user-creatable QOM objects.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 Makefile.objs         |  2 +-
 qom/Makefile.objs     |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index c30caaf59e..0cd8144c81 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -33,15 +33,19 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
=20
 #include "qemu-common.h"
 #include "qemu-version.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/help_option.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
+#include "qom/object_interfaces.h"
=20
 #include "trace/control.h"
=20
@@ -63,12 +67,31 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --object help          list object types that can be added\n"
+"  --object <type>,help   list properties for the given object type\n"
+"  --object <type>[,<property>=3D<value>...]\n"
+"                         create a new object of type <type>, setting\n"
+"                         properties in the order they are specified. Note=
\n"
+"                         that the 'id' property must be set.\n"
+"                         See the qemu(1) man page for documentation of th=
e\n"
+"                         objects that can be added.\n"
+"\n"
 QEMU_HELP_BOTTOM "\n",
     error_get_progname());
 }
=20
 enum {
     OPTION_BLOCKDEV =3D 256,
+    OPTION_OBJECT,
+};
+
+static QemuOptsList qemu_object_opts =3D {
+    .name =3D "object",
+    .implied_opt_name =3D "qom-type",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
+    .desc =3D {
+        { }
+    },
 };
=20
 static void process_options(int argc, char *argv[])
@@ -78,6 +101,7 @@ static void process_options(int argc, char *argv[])
     static const struct option long_options[] =3D {
         {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
         {"help", no_argument, NULL, 'h'},
+        {"object", required_argument, NULL, OPTION_OBJECT},
         {"trace", required_argument, NULL, 'T'},
         {"version", no_argument, NULL, 'V'},
         {0, 0, 0, 0}
@@ -121,6 +145,29 @@ static void process_options(int argc, char *argv[])
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_OBJECT:
+            {
+                QemuOpts *opts;
+                const char *type;
+                QDict *args;
+                QObject *ret_data =3D NULL;
+
+                /* FIXME The keyval parser rejects 'help' arguments, so we=
 must
+                 * unconditionall try QemuOpts first. */
+                opts =3D qemu_opts_parse(&qemu_object_opts,
+                                       optarg, true, &error_fatal);
+                type =3D qemu_opt_get(opts, "qom-type");
+                if (type && user_creatable_print_help(type, opts)) {
+                    exit(EXIT_SUCCESS);
+                }
+                qemu_opts_del(opts);
+
+                args =3D keyval_parse(optarg, "qom-type", &error_fatal);
+                qmp_object_add(args, &ret_data, &error_fatal);
+                qobject_unref(args);
+                qobject_unref(ret_data);
+                break;
+            }
         default:
             g_assert_not_reached();
         }
diff --git a/Makefile.objs b/Makefile.objs
index c7e1b36130..fa92b00427 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -31,7 +31,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # storage-daemon-obj-y is code used by qemu-storage-daemon (these objects =
are
 # used for system emulation, too, but specified separately there)
=20
-storage-daemon-obj-y =3D block/
+storage-daemon-obj-y =3D block/ qom/
 storage-daemon-obj-y +=3D blockdev.o iothread.o
=20
 ######################################################################
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index f9d77350ac..1b45d104ba 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,4 @@ qom-obj-y =3D object.o container.o qom-qobject.o
 qom-obj-y +=3D object_interfaces.o
=20
 common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-qmp-cmds.o
+storage-daemon-obj-y +=3D qom-qmp-cmds.o
--=20
2.20.1


