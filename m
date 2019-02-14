Received: from eggs.gnu.org ([209.51.188.92]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMR-0003Nf-Dh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMN-0003NT-6M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDMM-0002gx-Mi
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60B2981DE4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:42 +0100
Message-Id: <20190214093053.1400-8-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/18] build: Deal with all of QAPI's .o in
 qapi/Makefile.objs
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

Adding QAPI's .o to util-obj-y, common-obj-y and obj-y is spread over
three places: Makefile.objs takes care of target-independent generated
code, Makefile.target of target-dependent generated code, and
qapi/Makefile.objs of (target-independent) hand-written code.

Do everything in qapi/Makefile.objs.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile           |  1 -
 Makefile.objs      | 13 -------------
 Makefile.target    |  3 +--
 qapi/Makefile.objs | 19 +++++++++++++++++++
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 53d161b65f..a6de28677f 100644
--- a/Makefile
+++ b/Makefile
@@ -89,7 +89,6 @@ include $(SRC_PATH)/rules.mak
 
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
 
-#see Makefile.objs for the definition of QAPI_MODULES
 GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
 GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.h)
diff --git a/Makefile.objs b/Makefile.objs
index bc78e26f55..4a266357a2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,20 +1,7 @@
-QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
-QAPI_MODULES += ui
-
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
-util-obj-y += qapi/qapi-builtin-types.o
-util-obj-y += qapi/qapi-types.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-types-%.o)
-util-obj-y += qapi/qapi-builtin-visit.o
-util-obj-y += qapi/qapi-visit.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-visit-%.o)
-util-obj-y += qapi/qapi-emit-events.o
-util-obj-y += qapi/qapi-events.o
-util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
 
 chardev-obj-y = chardev/
 slirp-obj-$(CONFIG_SLIRP) = slirp/
diff --git a/Makefile.target b/Makefile.target
index d8af835890..d6ce549388 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,6 +148,7 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o
 obj-y += hw/
+obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
@@ -164,8 +165,6 @@ endif
 
 GENERATED_FILES += hmp-commands.h hmp-commands-info.h
 
-obj-y += qapi/qapi-introspect.o
-
 endif # CONFIG_SOFTMMU
 
 dummy := $(call unnest-vars,,obj-y)
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 33906ff321..da0000cbae 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -4,3 +4,22 @@ util-obj-y += string-input-visitor.o string-output-visitor.o
 util-obj-y += opts-visitor.o qapi-clone-visitor.o
 util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
+
+QAPI_MODULES = block-core block char common crypto introspect job migration
+QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
+QAPI_MODULES += ui
+
+util-obj-y += qapi-builtin-types.o
+util-obj-y += qapi-types.o
+util-obj-y += $(QAPI_MODULES:%=qapi-types-%.o)
+util-obj-y += qapi-builtin-visit.o
+util-obj-y += qapi-visit.o
+util-obj-y += $(QAPI_MODULES:%=qapi-visit-%.o)
+util-obj-y += qapi-emit-events.o
+util-obj-y += qapi-events.o
+util-obj-y += $(QAPI_MODULES:%=qapi-events-%.o)
+
+common-obj-y += qapi-commands.o
+common-obj-y += $(QAPI_MODULES:%=qapi-commands-%.o)
+
+obj-y += qapi-introspect.o
-- 
2.17.2
