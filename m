Received: from eggs.gnu.org ([209.51.188.92]:56407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMO-0003Mz-PY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMM-0003Kl-Fd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDML-0002gz-UZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62F7CC058CB0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:43 +0100
Message-Id: <20190214093053.1400-9-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/18] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

We can't add appropriate target-specific conditionals to misc.json,
because that would make all of misc.json unusable in
target-independent code.  To keep misc.json target-independent, we
need to split off target-dependent target.json.

This commit doesn't actually split off anything, it merely creates the
empty module.  The next few patches will move stuff from misc.json
there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile.objs         |  3 +--
 qapi/Makefile.objs    | 28 +++++++++++++++++-----------
 qapi/qapi-schema.json |  1 +
 qapi/target.json      | 13 +++++++++++++
 4 files changed, 32 insertions(+), 13 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/Makefile.objs b/Makefile.objs
index 4a266357a2..95150d7173 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,8 +79,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qapi/qapi-commands.o
-common-obj-y += $(QAPI_MODULES:%=qapi/qapi-commands-%.o)
+common-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-commands-%.o)
 common-obj-y += qmp.o hmp.o
 endif
 
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index da0000cbae..654321de94 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,21 +5,27 @@ util-obj-y += opts-visitor.o qapi-clone-visitor.o
 util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
 
-QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
-QAPI_MODULES += ui
+QAPI_COMMON_MODULES = block-core block char common crypto introspect
+QAPI_COMMON_MODULES += job migration misc net rdma rocker run-state
+QAPI_COMMON_MODULES += sockets tpm trace transaction ui
+QAPI_TARGET_MODULES = target
+QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
 
 util-obj-y += qapi-builtin-types.o
-util-obj-y += qapi-types.o
-util-obj-y += $(QAPI_MODULES:%=qapi-types-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-types-%.o)
 util-obj-y += qapi-builtin-visit.o
-util-obj-y += qapi-visit.o
-util-obj-y += $(QAPI_MODULES:%=qapi-visit-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-visit-%.o)
 util-obj-y += qapi-emit-events.o
-util-obj-y += qapi-events.o
-util-obj-y += $(QAPI_MODULES:%=qapi-events-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-events-%.o)
 
-common-obj-y += qapi-commands.o
-common-obj-y += $(QAPI_MODULES:%=qapi-commands-%.o)
+common-obj-y += $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
 
+obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
+obj-y += qapi-types.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi-visit-%.o)
+obj-y += qapi-visit.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
+obj-y += qapi-events.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
+obj-y += qapi-commands.o
 obj-y += qapi-introspect.o
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 1845aa78ff..db61bfd688 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -97,3 +97,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'target.json' }
diff --git a/qapi/target.json b/qapi/target.json
new file mode 100644
index 0000000000..8054926293
--- /dev/null
+++ b/qapi/target.json
@@ -0,0 +1,13 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Target-specific commands & events
+##
+
+##
+# @TARGET-TEMPORARY-DUMMY:
+# Will go away in the next commit.  Needed in this one because empty
+# modules don't generate anything, defeating this commit's purpose.
+##
+{ 'event': 'TARGET-TEMPORARY-DUMMY' }
-- 
2.17.2
