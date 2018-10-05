Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMF-0006fN-Fm
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006Fj-TY
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM9-00068C-El
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id z204-v6so2374589wmc.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:05 +0100
Message-Id: <20181005154910.3099-17-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 16/21] trace: add infrastructure for
 building plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

This allows us to build any bundled plugins in the source tree.
Out-of-tree builds can call Makefile.plugins to build in their own
source tree:

  make -f $(QEMU_PATH)/trace/plugins/Makefile.plugins QEMU_SRC=$(QEMU_PATH)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile                       |  5 ++++-
 trace/Makefile.objs            | 24 ++++++++++++++++++++++++
 trace/plugins/Makefile.plugins | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 trace/plugins/Makefile.plugins

diff --git a/Makefile b/Makefile
index 1144d6e3ba..e04d1c5124 100644
--- a/Makefile
+++ b/Makefile
@@ -438,7 +438,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules plugins
 
 qemu-version.h: FORCE
 	$(call quiet-command, \
@@ -1091,6 +1091,9 @@ help:
 	@echo  '  all             - Build all'
 ifdef CONFIG_MODULES
 	@echo  '  modules         - Build all modules'
+endif
+ifdef CONFIG_TRACE_PLUGIN
+	@echo  '  plugins         - Build all plugins'
 endif
 	@echo  '  dir/file.o      - Build specified target only'
 	@echo  '  install         - Install QEMU, documentation and tools'
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 4977f654a5..4f62022595 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -58,3 +58,27 @@ util-obj-$(CONFIG_TRACE_PLUGIN) += plugins.o
 util-obj-y += control.o
 target-obj-y += control-target.o
 util-obj-y += qmp.o
+
+######################################################################
+# Plugins
+ifdef CONFIG_TRACE_PLUGIN
+
+PLUGINS=$(dir $(wildcard $(SRC_PATH)/trace/plugins/*/.))
+
+.PHONY: plugins $(PLUGINS)
+
+plugins: $(PLUGINS)
+	$(info built all plugins $(PLUGINS))
+
+$(PLUGINS):
+	$(call quiet-command, 							\
+	   (cd $@ && $(MAKE) -f $(SRC_PATH)/trace/plugins/Makefile.plugins 	\
+				QEMU_SRC=$(SRC_PATH) 				\
+				BUILD_DIR=$(BUILD_DIR)/trace/plugins), 		\
+	"PLUGIN","in $@")
+
+else
+
+plugins:
+
+endif
diff --git a/trace/plugins/Makefile.plugins b/trace/plugins/Makefile.plugins
new file mode 100644
index 0000000000..0056d91c74
--- /dev/null
+++ b/trace/plugins/Makefile.plugins
@@ -0,0 +1,32 @@
+# -*- Mode: makefile -*-
+#
+# QEMU plugins
+#
+# This Makefile is used to build plugins for QEMU. Unlike the rest of
+# the object files we build we don't have visibility of QEMU's
+# internals. When called from the main makefile we build plugins into
+# BUILD_DIR/plugins otherwise where ever the Makefile was called from.
+# QEMU_SRC
+#
+
+BUILD_DIR ?= $(CURDIR)
+CC ?= cc
+
+ifndef QEMU_SRC
+$(error need to define QEMU_SRC for the build)
+endif
+
+GLIB_CFLAGS = $(shell pkg-config --cflags glib-2.0)
+CFLAGS = -I$(QEMU_SRC)/include/plugins $(GLIB_CFLAGS) -fno-PIE -fPIC -O3 -g
+LDFLAGS = $(shell pkg-config --libs glib-2.0) -shared
+
+SRC = $(wildcard *.c)
+PLUGINS = $(addprefix $(BUILD_DIR)/,$(SRC:.c=.so))
+
+$(BUILD_DIR)/%.so: %.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
+
+all: $(PLUGINS)
+
+clean:
+	rm -f $(PLUGIN_SO) $(PLUGIN_OBJ)
-- 
2.17.1
