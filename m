Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D213C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88F5206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THdnKdbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88F5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUjM-00085O-7l
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXUfw-0003E4-V3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXUfu-00083B-QM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXUfu-00082z-GY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574274357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwDhdEKbvhPI4E+lO3EFnw1XGCZjsr0NO7FQUkNKXB8=;
 b=THdnKdbtHBCtf28YtejJLU8V56/dSSaw8wmB5kvuUtQTVPwuHNtBo5tY/Tsg5cgPaXrQgZ
 ydEkg7IXwnSQHr93LA4Mo4y8wTY3zIEeJxiRPG4wlDnafa2i+crVH2KcDadBkAFhSZTvFg
 7wQek7yziX0Rt6pRcYMCAGXtOO+1Rbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-RL9yjuAiMf-E4_AQx1IwVw-1; Wed, 20 Nov 2019 13:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70A0D107ACC5;
 Wed, 20 Nov 2019 18:25:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B9060BB8;
 Wed, 20 Nov 2019 18:25:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DCDA11366CF; Wed, 20 Nov 2019 19:25:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] qapi: Generate command registration stuff into separate
 files
Date: Wed, 20 Nov 2019 19:25:48 +0100
Message-Id: <20191120182551.23795-4-armbru@redhat.com>
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com>
References: <20191120182551.23795-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RL9yjuAiMf-E4_AQx1IwVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having to include qapi-commands.h just for qmp_init_marshal() is
suboptimal.  Generate it into separate files.  This lets
monitor/misc.c, qga/main.c, and the generated qapi-commands-FOO.h
include less.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 19 ++++++++++++++++---
 Makefile                     |  4 +++-
 monitor/misc.c               |  7 ++++++-
 qga/main.c                   |  2 +-
 tests/test-qmp-cmds.c        |  1 +
 .gitignore                   |  1 +
 qapi/Makefile.objs           |  1 +
 qga/Makefile.objs            |  1 +
 scripts/qapi/commands.py     | 15 +++++++++++----
 tests/.gitignore             |  1 +
 tests/Makefile.include       |  5 ++++-
 11 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 45c93a43cc..3f37339d16 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1493,6 +1493,10 @@ $(prefix)qapi-commands.c: Command marshal/dispatch f=
unctions for each
 $(prefix)qapi-commands.h: Function prototypes for the QMP commands
                           specified in the schema
=20
+$(prefix)qapi-init-commands.h - Command initialization prototype
+
+$(prefix)qapi-init-commands.h - Command initialization code
+
 Example:
=20
     $ cat qapi-generated/example-qapi-commands.h
@@ -1502,11 +1506,9 @@ Example:
     #define EXAMPLE_QAPI_COMMANDS_H
=20
     #include "example-qapi-types.h"
-    #include "qapi/qmp/dispatch.h"
=20
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp);
-    void example_qmp_init_marshal(QmpCommandList *cmds);
=20
     #endif /* EXAMPLE_QAPI_COMMANDS_H */
     $ cat qapi-generated/example-qapi-commands.c
@@ -1566,7 +1568,19 @@ Example:
         visit_end_struct(v, NULL);
         visit_free(v);
     }
+[Uninteresting stuff omitted...]
+    $ cat qapi-generated/example-qapi-init-commands.h
+[Uninteresting stuff omitted...]
+    #ifndef EXAMPLE_QAPI_INIT_COMMANDS_H
+    #define EXAMPLE_QAPI_INIT_COMMANDS_H
=20
+    #include "qapi/qmp/dispatch.h"
+
+    void example_qmp_init_marshal(QmpCommandList *cmds);
+
+    #endif /* EXAMPLE_QAPI_INIT_COMMANDS_H */
+    $ cat qapi-generated/example-qapi-init-commands.
+[Uninteresting stuff omitted...]
     void example_qmp_init_marshal(QmpCommandList *cmds)
     {
         QTAILQ_INIT(cmds);
@@ -1574,7 +1588,6 @@ Example:
         qmp_register_command(cmds, "my-command",
                              qmp_marshal_my_command, QCO_NO_OPTIONS);
     }
-
 [Uninteresting stuff omitted...]
=20
 For a modular QAPI schema (see section Include directives), code for
diff --git a/Makefile b/Makefile
index b437a346d7..8dad949483 100644
--- a/Makefile
+++ b/Makefile
@@ -117,6 +117,7 @@ GENERATED_QAPI_FILES +=3D qapi/qapi-builtin-visit.h qap=
i/qapi-builtin-visit.c
 GENERATED_QAPI_FILES +=3D qapi/qapi-visit.h qapi/qapi-visit.c
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.h)
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.c)
+GENERATED_QAPI_FILES +=3D qapi/qapi-init-commands.h qapi/qapi-init-command=
s.c
 GENERATED_QAPI_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.h)
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.c)
@@ -610,6 +611,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-command=
s.c \
+qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-in=
it-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(=
qapi-py)
@@ -628,7 +630,7 @@ qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 =09=09"GEN","$(@:%-timestamp=3D%)")
 =09@>$@
=20
-QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-vi=
sit.h qga-qapi-commands.h)
+QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-vi=
sit.h qga-qapi-commands.h qga-qapi-init-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
=20
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f3bf..7c4b599342 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -66,8 +66,13 @@
 #include "qemu/option.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
-#include "qapi/qapi-commands.h"
+#include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-qom.h"
+#include "qapi/qapi-commands-trace.h"
 #include "qapi/qapi-emit-events.h"
+#include "qapi/qapi-init-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
diff --git a/qga/main.c b/qga/main.c
index c35c2a2120..e5c39c189a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -24,7 +24,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "guest-agent-core.h"
-#include "qga-qapi-commands.h"
+#include "qga-qapi-init-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "channel.h"
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 27b0afe55a..79507d9e54 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -7,6 +7,7 @@
 #include "tests/test-qapi-types.h"
 #include "tests/test-qapi-visit.h"
 #include "test-qapi-commands.h"
+#include "test-qapi-init-commands.h"
=20
 static QmpCommandList qmp_commands;
=20
diff --git a/.gitignore b/.gitignore
index 7de868d1ea..efad605e1a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -37,6 +37,7 @@
 /qapi/qapi-emit-events.[ch]
 /qapi/qapi-events-*.[ch]
 /qapi/qapi-events.[ch]
+/qapi/qapi-init-commands.[ch]
 /qapi/qapi-introspect.[ch]
 /qapi/qapi-types-*.[ch]
 /qapi/qapi-types.[ch]
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index dd3f5e6f94..a8f1f4c35e 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -30,3 +30,4 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
 obj-y +=3D qapi-events.o
 obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
 obj-y +=3D qapi-commands.o
+obj-y +=3D qapi-init-commands.o
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 80e6bb3c2e..9c558ae51c 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -5,5 +5,6 @@ qga-obj-$(CONFIG_WIN32) +=3D commands-win32.o channel-win32=
.o service-win32.o
 qga-obj-$(CONFIG_WIN32) +=3D vss-win32.o
 qga-obj-y +=3D qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-vis=
it.o
 qga-obj-y +=3D qapi-generated/qga-qapi-commands.o
+qga-obj-y +=3D qapi-generated/qga-qapi-init-commands.o
=20
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) +=3D vss-win32/
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index ab98e504f3..47f4a18cfe 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -263,18 +263,25 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
                              commands=3Dcommands, visit=3Dvisit))
         self._genh.add(mcgen('''
 #include "%(types)s.h"
-#include "qapi/qmp/dispatch.h"
=20
 ''',
                              types=3Dtypes))
=20
     def visit_end(self):
-        (genc, genh) =3D self._module[self._main_module]
-        genh.add(mcgen('''
+        self._add_system_module('init', ' * QAPI Commands initialization')
+        self._genh.add(mcgen('''
+#include "qapi/qmp/dispatch.h"
+
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse)))
-        genc.add(gen_registry(self._regy.get_content(), self._prefix))
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(prefix)sqapi-commands.h"
+#include "%(prefix)sqapi-init-commands.h"
+''',
+                                      prefix=3Dself._prefix))
+        self._genc.add(gen_registry(self._regy.get_content(), self._prefix=
))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
diff --git a/tests/.gitignore b/tests/.gitignore
index f9c0170881..7306866f21 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -12,6 +12,7 @@ test-*
 !test-*.c
 !docker/test-*
 test-qapi-commands.[ch]
+test-qapi-init-commands.[ch]
 include/test-qapi-commands-sub-module.[ch]
 test-qapi-commands-sub-sub-module.[ch]
 test-qapi-emit-events.[ch]
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 75b377d1a9..ce854ee556 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -501,6 +501,7 @@ generated-files-y +=3D tests/test-qapi-visit.h
 generated-files-y +=3D tests/include/test-qapi-visit-sub-module.h
 generated-files-y +=3D tests/test-qapi-visit-sub-sub-module.h
 generated-files-y +=3D tests/test-qapi-commands.h
+generated-files-y +=3D tests/test-qapi-init-commands.h
 generated-files-y +=3D tests/include/test-qapi-commands-sub-module.h
 generated-files-y +=3D tests/test-qapi-commands-sub-sub-module.h
 generated-files-y +=3D tests/test-qapi-emit-events.h
@@ -613,6 +614,8 @@ tests/test-qapi-commands-sub-sub-module.h \
 tests/test-qapi-commands-sub-sub-module.c \
 tests/test-qapi-emit-events.c tests/test-qapi-emit-events.h \
 tests/test-qapi-events.c tests/test-qapi-events.h \
+tests/test-qapi-init-commands.c \
+tests/test-qapi-init-commands.h \
 tests/include/test-qapi-events-sub-module.c \
 tests/include/test-qapi-events-sub-module.h \
 tests/test-qapi-events-sub-sub-module.c \
@@ -643,7 +646,7 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $=
(test-qapi-obj-y) tests/t
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-=
obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visito=
r.o $(test-qapi-obj-y)
-tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-comman=
ds.o $(test-qapi-obj-y)
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-comman=
ds.o tests/test-qapi-init-commands.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializatio=
n.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-ob=
j-y)
=20
--=20
2.21.0


