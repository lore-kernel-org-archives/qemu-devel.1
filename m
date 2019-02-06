Received: from eggs.gnu.org ([209.51.188.92]:46286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRll-0004rK-Ge
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlh-00024q-N9
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlf-0001qF-Pn
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3BB4474
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:15 +0100
Message-Id: <20190206181725.14337-8-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/17] qapi: New module target.json
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
 Makefile.objs         | 20 +++++++++-----------
 Makefile.target       | 10 ++++++++++
 qapi/qapi-schema.json |  1 +
 qapi/target.json      | 13 +++++++++++++
 4 files changed, 33 insertions(+), 11 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/Makefile.objs b/Makefile.objs
index 70ee51742f..5f0a7a8ca5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,20 +1,19 @@
-QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
-QAPI_MODULES += ui
+QAPI_COMMON_MODULES = block-core block char common crypto introspect
+QAPI_COMMON_MODULES += job migration misc net rdma rocker run-state
+QAPI_COMMON_MODULES += sockets tpm trace transaction ui
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
 util-obj-y += qapi/qapi-emit-events.o
-util-obj-y += qapi/qapi-events.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
+util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-events-%.o)
 
 chardev-obj-y = chardev/
 slirp-obj-$(CONFIG_SLIRP) = slirp/
@@ -92,8 +91,7 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qapi/qapi-commands.o
-common-obj-y += $(QAPI_MODULES:%=qapi/qapi-commands-%.o)
+common-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-commands-%.o)
 common-obj-y += qmp.o hmp.o
 endif
 
diff --git a/Makefile.target b/Makefile.target
index d8af835890..f908477040 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -164,6 +164,16 @@ endif
 
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
