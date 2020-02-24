Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCBC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD98520828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPJ0DhKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD98520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Eu0-0002nh-PM
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6Elh-0002jm-9y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6Elf-0003Y7-8H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6Elf-0003T7-3o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1PiXaJSVmbx1ulS/jG8WY8v3Np8wI3+5WYAWlKThsY=;
 b=EPJ0DhKOrtQE+7g/Mlh4WR2dj8CAn423MGIcFLLxkZkGGz7RnpSb55i7Hw+YGytknPUWh3
 TEj3pcWkpg59GDVZ+rY688O1yEWQ8RYAUh4G/H/X3uzyCvTB2sdQOmizTvcrt4dW7IuiEi
 NdPmih55fI7uudoGG7yvMdWVFsAqs20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-HRmDJzHYPJGEEd9xnI6B-A-1; Mon, 24 Feb 2020 09:31:25 -0500
X-MC-Unique: HRmDJzHYPJGEEd9xnI6B-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F88DB60;
 Mon, 24 Feb 2020 14:31:24 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABB735C13F;
 Mon, 24 Feb 2020 14:31:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 20/20] qemu-storage-daemon: Add --monitor option
Date: Mon, 24 Feb 2020 15:30:08 +0100
Message-Id: <20200224143008.13362-21-kwolf@redhat.com>
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

This adds and parses the --monitor option, so that a QMP monitor can be
used in the storage daemon. The monitor offers commands defined in the
QAPI schema at storage-daemon/qapi/qapi-schema.json.

The --monitor options currently allows to create multiple monitors with
the same ID. This part of the interface is considered unstable. We will
reject such configurations as soon as we have a design for the monitor
subsystem to perform these checks. (In the system emulator, we depend on
QemuOpts rejecting duplicate IDs.)

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/transaction.json                |  2 +-
 qemu-storage-daemon.c                | 47 ++++++++++++++++++++++++++--
 scripts/qapi/gen.py                  |  5 +++
 Makefile                             | 33 +++++++++++++++++++
 Makefile.objs                        |  4 +--
 monitor/Makefile.objs                |  2 ++
 qapi/Makefile.objs                   |  5 +++
 storage-daemon/Makefile.objs         |  1 +
 storage-daemon/qapi/Makefile.objs    |  1 +
 storage-daemon/qapi/qapi-schema.json | 26 +++++++++++++++
 10 files changed, 121 insertions(+), 5 deletions(-)
 create mode 100644 storage-daemon/Makefile.objs
 create mode 100644 storage-daemon/qapi/Makefile.objs
 create mode 100644 storage-daemon/qapi/qapi-schema.json

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 04301f1be7..b6c11158f0 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -5,7 +5,7 @@
 # =3D Transactions
 ##
=20
-{ 'include': 'block.json' }
+{ 'include': 'block-core.json' }
=20
 ##
 # @Abort:
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 82fe6cd5f2..dd128978cc 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -31,13 +31,15 @@
 #include "block/nbd.h"
 #include "chardev/char.h"
 #include "crypto/init.h"
+#include "monitor/monitor.h"
+#include "monitor/monitor-internal.h"
=20
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block.h"
-#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
=20
 #include "qemu-common.h"
@@ -51,6 +53,9 @@
 #include "qemu/option.h"
 #include "qom/object_interfaces.h"
=20
+#include "storage-daemon/qapi/qapi-commands.h"
+#include "storage-daemon/qapi/qapi-init-commands.h"
+
 #include "sysemu/runstate.h"
 #include "trace/control.h"
=20
@@ -61,6 +66,11 @@ void qemu_system_killed(int signal, pid_t pid)
     exit_requested =3D true;
 }
=20
+void qmp_quit(Error **errp)
+{
+    exit_requested =3D true;
+}
+
 static void help(void)
 {
     printf(
@@ -87,6 +97,9 @@ static void help(void)
 "                         export the specified block node over NBD\n"
 "                         (requires --nbd-server)\n"
 "\n"
+"  --monitor [chardev=3D]name[,mode=3Dcontrol][,pretty[=3Don|off]]\n"
+"                         configure a QMP monitor\n"
+"\n"
 "  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n"
 "               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
 "  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
@@ -110,6 +123,7 @@ enum {
     OPTION_BLOCKDEV =3D 256,
     OPTION_CHARDEV,
     OPTION_EXPORT,
+    OPTION_MONITOR,
     OPTION_NBD_SERVER,
     OPTION_OBJECT,
 };
@@ -125,6 +139,17 @@ static QemuOptsList qemu_object_opts =3D {
     },
 };
=20
+static void init_qmp_commands(void)
+{
+    qmp_init_marshal(&qmp_commands);
+    qmp_register_command(&qmp_commands, "query-qmp-schema",
+                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
+
+    QTAILQ_INIT(&qmp_cap_negotiation_commands);
+    qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities"=
,
+                         qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG=
);
+}
+
 static void init_export(BlockExport *export, Error **errp)
 {
     switch (export->type) {
@@ -145,6 +170,7 @@ static void process_options(int argc, char *argv[])
         {"chardev", required_argument, NULL, OPTION_CHARDEV},
         {"export", required_argument, NULL, OPTION_EXPORT},
         {"help", no_argument, NULL, 'h'},
+        {"monitor", required_argument, NULL, OPTION_MONITOR},
         {"nbd-server", required_argument, NULL, OPTION_NBD_SERVER},
         {"object", required_argument, NULL, OPTION_OBJECT},
         {"trace", required_argument, NULL, 'T'},
@@ -219,6 +245,21 @@ static void process_options(int argc, char *argv[])
                 qapi_free_BlockExport(export);
                 break;
             }
+        case OPTION_MONITOR:
+            {
+                Visitor *v;
+                MonitorOptions *monitor;
+
+                v =3D qobject_input_visitor_new_str(optarg, "chardev",
+                                                  &error_fatal);
+                visit_type_MonitorOptions(v, NULL, &monitor, &error_fatal)=
;
+                visit_free(v);
+
+                /* TODO Catch duplicate monitor IDs */
+                monitor_init(monitor, false, &error_fatal);
+                qapi_free_MonitorOptions(monitor);
+                break;
+            }
         case OPTION_NBD_SERVER:
             {
                 Visitor *v;
@@ -280,6 +321,8 @@ int main(int argc, char *argv[])
     qemu_add_opts(&qemu_trace_opts);
     qcrypto_init(&error_fatal);
     bdrv_init();
+    monitor_init_globals_core();
+    init_qmp_commands();
=20
     if (!trace_init_backends()) {
         return EXIT_FAILURE;
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 95afae0615..e20cdbc503 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -45,6 +45,11 @@ class QAPIGen(object):
         return ''
=20
     def write(self, output_dir):
+        # Include paths starting with ../ are used to reuse modules of the=
 main
+        # schema in specialised schemas. Don't overwrite the files that ar=
e
+        # already generated for the main schema.
+        if self.fname.startswith('../'):
+            return
         pathname =3D os.path.join(output_dir, self.fname)
         dir =3D os.path.dirname(pathname)
         if dir:
diff --git a/Makefile b/Makefile
index 50056faf52..b253ad5863 100644
--- a/Makefile
+++ b/Makefile
@@ -128,7 +128,28 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi=
-events-%.c)
 GENERATED_QAPI_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
=20
+# The following list considers only the storage daemon main module. All ot=
her
+# modules are currently shared with the main schema, so we don't actually
+# generate additional files.
+
+GENERATED_STORAGE_DAEMON_QAPI_FILES =3D storage-daemon/qapi/qapi-commands.=
h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-commands=
.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit-eve=
nts.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit-eve=
nts.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-events.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-events.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-init-com=
mands.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-init-com=
mands.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-introspe=
ct.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-introspe=
ct.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-types.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-types.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visit.h
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visit.c
+GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-doc.texi
+
 generated-files-y +=3D $(GENERATED_QAPI_FILES)
+generated-files-y +=3D $(GENERATED_STORAGE_DAEMON_QAPI_FILES)
=20
 generated-files-y +=3D trace/generated-tcg-tracers.h
=20
@@ -638,6 +659,17 @@ qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 =09=09"GEN","$(@:%-timestamp=3D%)")
 =09@>$@
=20
+qapi-modules-storage-daemon =3D \
+=09$(SRC_PATH)/storage-daemon/qapi/qapi-schema.json \
+    $(QAPI_MODULES_STORAGE_DAEMON:%=3D$(SRC_PATH)/qapi/%.json)
+
+$(GENERATED_STORAGE_DAEMON_QAPI_FILES): storage-daemon/qapi/qapi-gen-times=
tamp ;
+storage-daemon/qapi/qapi-gen-timestamp: $(qapi-modules-storage-daemon) $(q=
api-py)
+=09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+=09=09-o "storage-daemon/qapi" $<, \
+=09=09"GEN","$(@:%-timestamp=3D%)")
+=09@>$@
+
 QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-vi=
sit.h qga-qapi-commands.h qga-qapi-init-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
=20
@@ -736,6 +768,7 @@ clean: recurse-clean
 =09rm -f trace/generated-tracers-dtrace.h*
 =09rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 =09rm -f qapi-gen-timestamp
+=09rm -f storage-daemon/qapi/qapi-gen-timestamp
 =09rm -rf qga/qapi-generated
 =09rm -f config-all-devices.mak
=20
diff --git a/Makefile.objs b/Makefile.objs
index 5b30537fd9..9b2b01587d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -31,8 +31,8 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # storage-daemon-obj-y is code used by qemu-storage-daemon (these objects =
are
 # used for system emulation, too, but specified separately there)
=20
-storage-daemon-obj-y =3D block/ qom/
-storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
+storage-daemon-obj-y =3D block/ monitor/ qapi/ qom/ storage-daemon/
+storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o job-qmp.o
 storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
 storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index 9244d90859..a8533c9dd7 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -2,3 +2,5 @@ obj-y +=3D misc.o
 common-obj-y +=3D monitor.o qmp.o hmp.o
 common-obj-y +=3D qmp-cmds.o qmp-cmds-control.o
 common-obj-y +=3D hmp-cmds.o
+
+storage-daemon-obj-y +=3D monitor.o qmp.o qmp-cmds-control.o
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index cf33fd9cc0..4673ab7490 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -31,3 +31,8 @@ obj-y +=3D qapi-events.o
 obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
 obj-y +=3D qapi-commands.o
 obj-y +=3D qapi-init-commands.o
+
+QAPI_MODULES_STORAGE_DAEMON =3D block-core char common control crypto
+QAPI_MODULES_STORAGE_DAEMON +=3D introspect job qom sockets pragma transac=
tion
+
+storage-daemon-obj-y +=3D $(QAPI_MODULES_STORAGE_DAEMON:%=3Dqapi-commands-=
%.o)
diff --git a/storage-daemon/Makefile.objs b/storage-daemon/Makefile.objs
new file mode 100644
index 0000000000..cfe6beee52
--- /dev/null
+++ b/storage-daemon/Makefile.objs
@@ -0,0 +1 @@
+storage-daemon-obj-y +=3D qapi/
diff --git a/storage-daemon/qapi/Makefile.objs b/storage-daemon/qapi/Makefi=
le.objs
new file mode 100644
index 0000000000..8a4b220c96
--- /dev/null
+++ b/storage-daemon/qapi/Makefile.objs
@@ -0,0 +1 @@
+storage-daemon-obj-y +=3D qapi-commands.o qapi-init-commands.o qapi-intros=
pect.o
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qap=
i-schema.json
new file mode 100644
index 0000000000..14f4f8fe61
--- /dev/null
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -0,0 +1,26 @@
+# -*- Mode: Python -*-
+
+# Note that modules are shared with the QEMU main schema under the assumpt=
ion
+# that the storage daemon schema is a subset of the main schema. For the s=
hared
+# modules, no code is generated here, but we reuse the code files generate=
d
+# from the main schema.
+#
+# If you wish to extend the storage daemon schema to contain things that a=
re
+# not in the main schema, be aware that array types of types defined in sh=
ared
+# modules are only generated if an array of the respective type is already=
 used
+# in the main schema. Therefore, if you use such arrays, you may need to d=
efine
+# the array type in the main schema, even if it is unused outside of the
+# storage daemon.
+
+{ 'include': '../../qapi/pragma.json' }
+
+{ 'include': '../../qapi/block-core.json' }
+{ 'include': '../../qapi/char.json' }
+{ 'include': '../../qapi/common.json' }
+{ 'include': '../../qapi/control.json' }
+{ 'include': '../../qapi/crypto.json' }
+{ 'include': '../../qapi/introspect.json' }
+{ 'include': '../../qapi/job.json' }
+{ 'include': '../../qapi/qom.json' }
+{ 'include': '../../qapi/sockets.json' }
+{ 'include': '../../qapi/transaction.json' }
--=20
2.20.1


