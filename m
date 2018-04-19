Received: from eggs.gnu.org ([2001:4830:134:3::10]:32914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I60-00008I-Uq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I5x-0001U7-0Y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9I5w-0001Sg-PV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 484B3EBFE5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 22:32:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 19 Apr 2018 17:31:50 -0500
Message-Id: <20180419223151.623174-2-eblake@redhat.com>
In-Reply-To: <20180419223151.623174-1-eblake@redhat.com>
References: <20180419223151.623174-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: Rename QMP and QGA schema files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Having two files in the tree both named qapi-schema.json just adds
confusion.  Rename these files to {qmp,qga}-schema to make it
obvious which schema is in effect, and relocate qga into the common
qapi/ subdirectory.  Update all build rules that refer to the file
names, and adjust other documentation and comment references that
need to refer to the new file names.

Maintainer-wise, this means that qapi/qga-schema.json continues
to belong to Michael as QGA maintainer, but now also notifies
Markus and Eric as QAPI maintainers, alongside all the other
QMP QAPI files, matching how other .json QAPI modules belong
to multiple maintainer blurbs.  Also, fix a stale reference to
a file removed in commit eb815e248f.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
v2: rebase on top of Markus' work that already moved
qapi-schema.json to qapi/
---
 docs/devel/writing-qmp-commands.txt          |  2 +-
 docs/interop/qmp-intro.txt                   |  6 +++---
 Makefile                                     | 12 ++++++------
 qga/qapi-schema.json => qapi/qga-schema.json |  0
 qapi/{qapi-schema.json => qmp-schema.json}   |  0
 MAINTAINERS                                  |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)
 rename qga/qapi-schema.json => qapi/qga-schema.json (100%)
 rename qapi/{qapi-schema.json => qmp-schema.json} (100%)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 9dfc62bf5a3..1cd3dbf48ac 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -13,7 +13,7 @@ start with docs/interop/qmp-intro.txt.
 == Overview ==

 Generally speaking, the following steps should be taken in order to write a
-new QMP command.
+new QMP command (similar steps for QGA).

 1. Define the command and any types it needs in the appropriate QAPI
    schema module.
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 900d69d6128..19ac6c573b6 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -72,14 +72,14 @@ Escape character is '^]'.
 { "execute": "query-status" }
 {
     "return": {
-        "status": "prelaunch", 
-        "singlestep": false, 
+        "status": "prelaunch",
+        "singlestep": false,
         "running": false
     }
 }

 Please refer to docs/interop/qemu-qmp-ref.* for a complete command
-reference, generated from qapi/qapi-schema.json.
+reference, generated from qapi/qmp-schema.json.

 QMP wiki page
 -------------
diff --git a/Makefile b/Makefile
index d71dd5bea41..f5c2ace8b30 100644
--- a/Makefile
+++ b/Makefile
@@ -570,14 +570,14 @@ qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
-qga/qapi-generated/qapi-gen-timestamp ;
-qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+qga/qapi-generated/qga-gen-timestamp ;
+qga/qapi-generated/qga-gen-timestamp: $(SRC_PATH)/qapi/qga-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@

-qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
+qmp-modules = $(SRC_PATH)/qapi/qmp-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
@@ -665,8 +665,8 @@ qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
-qapi-gen-timestamp ;
-qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
+qmp-gen-timestamp ;
+qmp-gen-timestamp: $(qmp-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o "qapi" -b $<, \
 		"GEN","$(@:%-timestamp=%)")
@@ -730,7 +730,7 @@ clean:
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
-	rm -f qapi-gen-timestamp
+	rm -f qmp-gen-timestamp
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
diff --git a/qga/qapi-schema.json b/qapi/qga-schema.json
similarity index 100%
rename from qga/qapi-schema.json
rename to qapi/qga-schema.json
diff --git a/qapi/qapi-schema.json b/qapi/qmp-schema.json
similarity index 100%
rename from qapi/qapi-schema.json
rename to qapi/qmp-schema.json
diff --git a/MAINTAINERS b/MAINTAINERS
index 24b70169bc3..4a4b7aa2a64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1581,7 +1581,6 @@ QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: qapi-schema.json
 F: qapi/*.json
 T: git git://repo.or.cz/qemu/armbru.git qapi-next

@@ -1603,6 +1602,7 @@ QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
+F: qapi/qga-schema.json
 F: qemu-ga.texi
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-- 
2.14.3
