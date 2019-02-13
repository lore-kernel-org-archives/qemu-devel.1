Received: from eggs.gnu.org ([209.51.188.92]:36925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtrB8-0000SJ-P1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtrB6-0000LP-VA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:50:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtrB5-0000E3-HG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:50:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA6FDC062C6A
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:49:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 13 Feb 2019 10:49:53 +0100
Message-ID: <871s4chvb2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Seeking QEMU makefile advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Paolo,

I'm trying to resolve a FIXME in a patch I recently posted.  Here's what
I want to do:

    QAPI_COMMON_MODULES = block-core block char common crypto introspect
    QAPI_COMMON_MODULES += job migration misc net rdma rocker run-state
    QAPI_COMMON_MODULES += sockets tpm trace transaction ui
    QAPI_TARGET_MODULES = target
    QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)

    util-obj-y += qapi/qapi-builtin-types.o
    util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-types-%.o)
    util-obj-y += qapi/qapi-builtin-visit.o
    util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-visit-%.o)
    util-obj-y += qapi/qapi-emit-events.o
    util-obj-y += $(QAPI_COMMON_MODULES:%=qapi/qapi-events-%.o)

    obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-types-%.o)
    obj-y += qapi/qapi-types.o
    obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-visit-%.o)
    obj-y += qapi/qapi-visit.o
    obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-events-%.o)
    obj-y += qapi/qapi-events.o
    obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-commands-%.o)
    obj-y += qapi/qapi-commands.o
    obj-y += qapi/qapi-introspect.o

Simple enough, except which part goes where?

First attempt:

* Define QAPI_COMMON_MODULES, QAPI_TARGET_MODULES and QAPI_MODULES in
  Makefile.obj

* Add to util-obj-y in Makefile.obj

* Add to obj-y in Makefile.target

  No go, because QAPI_TARGET_MODULES is blank there.  To make progress,
  I duplicated its definition there, marked FIXME.

Message-Id: <20190206181725.14337-8-armbru@redhat.com>
https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01652.html
Diff appended for your convenience.

I've since realized QAPI_TARGET_MODULES is blank there because it only
gets defined further down, via include $(SRC_PATH)/Makefile.objs.

This leads me to my problem:

* On the one hand, I want to add to obj-y after the include defines
  QAPI_TARGET_MODULES.

* On the other hand, I need to be done with adding to obj-y before the
  all-obj-y := $(obj-y) line.

Can't satisfy both.  Any ideas on how to better distribute the work
between the makefiles?



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
