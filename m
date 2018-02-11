Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekfgz-0002v2-5c
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekfgv-0006qQ-Vz
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekfgv-0006nr-M5
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:25 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 10 Feb 2018 18:40:12 -0600
Message-Id: <20180211004013.10784-3-eblake@redhat.com>
In-Reply-To: <20180211004013.10784-1-eblake@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qapi: Rename QMP and QGA schema files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Having two files in the tree both named qapi-schema.json just adds
confusion.  Rename these files, and relocate them into the common
qapi/ subdirectory.  Update all build rules that refer to the file
names, and adjust other documentation and comment references to
either track the new name or be rewritten so as to not mention
the file name.

Maintainer-wise, this means that qapi/qga-schema.json continues
to belong to Michael as QGA maintainer, but now also notifies
Markus and Eric as QAPI maintainers, alongside all the other
QMP QAPI files, matching how other .json QAPI modules belong
to multiple maintainer blurbs.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-qmp-commands.txt          | 13 ++++++-----
 docs/interop/qmp-intro.txt                   |  3 ++-
 Makefile                                     | 10 ++++----
 qga/qapi-schema.json => qapi/qga-schema.json |  0
 qapi-schema.json => qapi/qmp-schema.json     | 34 ++++++++++++++--------------
 tpm.c                                        |  2 +-
 MAINTAINERS                                  |  2 +-
 7 files changed, 33 insertions(+), 31 deletions(-)
 rename qga/qapi-schema.json => qapi/qga-schema.json (100%)
 rename qapi-schema.json => qapi/qmp-schema.json (99%)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 4f5b24c0c4c..53a668817f5 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -13,10 +13,11 @@ start with docs/interop/qmp-intro.txt.
 == Overview ==

 Generally speaking, the following steps should be taken in order to write a
-new QMP command.
+new QMP command (similar steps for QGA).

-1. Write the command's and type(s) specification in the QAPI schema file
-   (qapi-schema.json in the root source directory)
+1. Write the command's and type(s) specification in the appropriate
+   QAPI schema file (qapi/qmp-schema.json, or one of the module .json
+   files it includes)

 2. Write the QMP command itself, which is a regular C function. Preferably,
    the command should be exported by some QEMU subsystem. But it can also be
@@ -89,7 +90,7 @@ Our command will be called "hello-world". It takes no arguments, nor does it
 return any data.

 The first step is to add the following line to the bottom of the
-qapi-schema.json file:
+qapi/qmp-schema.json file:

 { 'command': 'hello-world' }

@@ -234,7 +235,7 @@ this rule:
 If the failure you want to report falls into one of the two cases above,
 use error_set() with a second argument of an ErrorClass value.

- * All existing ErrorClass values are defined in the qapi-schema.json file
+ * All existing ErrorClass values are defined in the qapi/qmp-schema.json file

 === Command Documentation ===

@@ -245,7 +246,7 @@ This is very important. No QMP command will be accepted in QEMU without proper
 documentation.

 There are many examples of such documentation in the schema file already, but
-here goes "hello-world"'s new entry for the qapi-schema.json file:
+here goes "hello-world"'s new entry for the qapi/qmp-schema.json file:

 ##
 # @hello-world
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index adbc94abb1d..06d9c85a2cd 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -78,7 +78,8 @@ Escape character is '^]'.
     }
 }

-Please, refer to the qapi-schema.json file for a complete command reference.
+Please, refer to the qapi/qmp-schema.json file for a complete command
+reference.

 QMP wiki page
 -------------
diff --git a/Makefile b/Makefile
index 4ec7a3cb825..33d554a0801 100644
--- a/Makefile
+++ b/Makefile
@@ -488,22 +488,22 @@ gen-out-type = $(subst .,-,$(suffix $@))
 qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py

 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+$(SRC_PATH)/qapi/qga-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h :\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+$(SRC_PATH)/qapi/qga-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-visit.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
 qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c :\
-$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
+$(SRC_PATH)/qapi/qga-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")

-qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
+qapi-modules = $(SRC_PATH)/qapi/qmp-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
@@ -815,7 +815,7 @@ docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/scri
 docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")

-docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
+docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qapi/qga-schema.json
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")

 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
diff --git a/qga/qapi-schema.json b/qapi/qga-schema.json
similarity index 100%
rename from qga/qapi-schema.json
rename to qapi/qga-schema.json
diff --git a/qapi-schema.json b/qapi/qmp-schema.json
similarity index 99%
rename from qapi-schema.json
rename to qapi/qmp-schema.json
index 5c06745c792..daf748a60ba 100644
--- a/qapi-schema.json
+++ b/qapi/qmp-schema.json
@@ -76,22 +76,22 @@
 # included sub-schemas inserted at the first include directive
 # (subsequent include directives have no effect).  To get a sane and
 # stable order, it's best to include each sub-schema just once, or
-# include it first in qapi-schema.json.
+# include it first in qapi/qmp-schema.json.

-{ 'include': 'qapi/common.json' }
-{ 'include': 'qapi/sockets.json' }
-{ 'include': 'qapi/run-state.json' }
-{ 'include': 'qapi/crypto.json' }
-{ 'include': 'qapi/block.json' }
-{ 'include': 'qapi/char.json' }
-{ 'include': 'qapi/net.json' }
-{ 'include': 'qapi/rocker.json' }
-{ 'include': 'qapi/tpm.json' }
-{ 'include': 'qapi/ui.json' }
-{ 'include': 'qapi/migration.json' }
-{ 'include': 'qapi/transaction.json' }
-{ 'include': 'qapi/trace.json' }
-{ 'include': 'qapi/introspect.json' }
+{ 'include': 'common.json' }
+{ 'include': 'sockets.json' }
+{ 'include': 'run-state.json' }
+{ 'include': 'crypto.json' }
+{ 'include': 'block.json' }
+{ 'include': 'char.json' }
+{ 'include': 'net.json' }
+{ 'include': 'rocker.json' }
+{ 'include': 'tpm.json' }
+{ 'include': 'ui.json' }
+{ 'include': 'migration.json' }
+{ 'include': 'transaction.json' }
+{ 'include': 'trace.json' }
+{ 'include': 'introspect.json' }

 ##
 # = Miscellanea
@@ -1710,7 +1710,7 @@
 #
 # Emitted when background dump has completed
 #
-# @result: DumpQueryResult type described in qapi-schema.json.
+# @result: DumpQueryResult type.
 #
 # @error: human-readable error string that provides
 #         hint on why dump failed. Only presents on failure. The
@@ -2925,7 +2925,7 @@
 #
 # Emitted when guest executes ACPI _OST method.
 #
-# @info: ACPIOSTInfo type as described in qapi-schema.json
+# @info: ACPIOSTInfo type.
 #
 # Since: 2.1
 #
diff --git a/tpm.c b/tpm.c
index d11b10bed86..9440ce29899 100644
--- a/tpm.c
+++ b/tpm.c
@@ -182,7 +182,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)

 /*
  * Walk the list of active TPM backends and collect information about them
- * following the schema description in qapi-schema.json.
+ * following the QAPI schema description.
  */
 TPMInfoList *qmp_query_tpm(Error **errp)
 {
diff --git a/MAINTAINERS b/MAINTAINERS
index 54feb956467..b5960869eb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1543,7 +1543,6 @@ QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: qapi-schema.json
 F: qapi/*.json
 T: git git://repo.or.cz/qemu/armbru.git qapi-next

@@ -1565,6 +1564,7 @@ QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
+F: qapi/qga-schema.json
 F: qemu-ga.texi
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-- 
2.14.3
