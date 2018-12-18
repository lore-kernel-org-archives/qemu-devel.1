Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK16-0003dL-Le
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0002jU-TN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK13-0002QW-Am
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DC3E5A1EC
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:24 +0100
Message-Id: <20181218182234.28876-6-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 05/15] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

We can't add appropriate target-specific conditionals to misc.json,
because that would make all of misc.json unusable in
target-independent code.  To keep misc.json target-independent, we
need to split off target-dependent target.json.

This commit doesn't actually split off anything, it merely creates the
empty module.  The next few patches will move stuff from misc.json
there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile.objs         | 19 +++++++++----------
 Makefile.target       | 10 ++++++++++
 qapi/qapi-schema.json |  1 +
 qapi/target.json      | 13 +++++++++++++
 4 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/Makefile.objs b/Makefile.objs
index 93dc86f2e6..b7d46083e7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,19 +1,19 @@
-QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rocker run-state sockets tpm trace transaction ui
+QAPI_COMMON_MODULES = block-core block char common crypto introspect
+QAPI_COMMON_MODULES += job migration misc net rocker run-state sockets
+QAPI_COMMON_MODULES += tpm trace transaction ui
+QAPI_TARGET_MODULES = target
+QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
 
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
 util-obj-y += qapi/qapi-builtin-types.o
-util-obj-y += qapi/qapi-types.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-types-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-types-%.o)
 util-obj-y += qapi/qapi-builtin-visit.o
-util-obj-y += qapi/qapi-visit.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-visit-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-visit-%.o)
 util-obj-y += qapi/qapi-events-FIXME.o
-util-obj-y += qapi/qapi-events.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-events-%.o)
 
 chardev-obj-y = chardev/
 
@@ -92,8 +92,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qapi/qapi-commands.o
-common-obj-y += $(QAPI_MODULES:%=qapi/qapi-commands-%.o)
+common-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-commands-%.o)
 common-obj-y += qmp.o hmp.o
 endif
 
diff --git a/Makefile.target b/Makefile.target
index c882292ae1..7884fca2be 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,6 +156,16 @@ endif
 
 GENERATED_FILES += hmp-commands.h hmp-commands-info.h
 
+# FIXME duplicates Makefile.obj's
+QAPI_TARGET_MODULES = target
+obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-types-%.o)
+obj-y += qapi/qapi-types.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-visit-%.o)
+obj-y += qapi/qapi-visit.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-events-%.o)
+obj-y += qapi/qapi-events.o
+obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-commands-%.o)
+obj-y += qapi/qapi-commands.o
 obj-y += qapi/qapi-introspect.o
 
 endif # CONFIG_SOFTMMU
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..4a836d6c9f 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -94,3 +94,4 @@
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
