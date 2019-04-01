Received: from eggs.gnu.org ([209.51.188.92]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgM-00061U-63
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgG-0006v8-FG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:02 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:19 +0200
Message-Id: <20190401141222.30034-3-lvivier@redhat.com>
In-Reply-To: <20190401141222.30034-1-lvivier@redhat.com>
References: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] build: replace GENERATED_FILES by
 generated-files-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>

When possible use generated-files-$(FLAG) to disable
some targets (like KEYCODEMAP_FILES).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 Makefile                   | 36 +++++++++++++++++-------------------
 Makefile.target            |  6 +++---
 target/s390x/Makefile.objs |  2 +-
 tests/Makefile.include     | 26 +++++++++++++-------------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index 04a0d4505085..10ae5e31fc0a 100644
--- a/Makefile
+++ b/Makefile
@@ -101,7 +101,7 @@ QEMU_PKGVERSION :=3D $(if $(PKGVERSION),$(PKGVERSION)=
,$(shell \
 # Either "version (pkgversion)", or just "version" if pkgversion not set
 FULL_VERSION :=3D $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)=
),$(VERSION))
=20
-GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
+generated-files-y =3D qemu-version.h config-host.h qemu-options.def
=20
 GENERATED_QAPI_FILES =3D qapi/qapi-builtin-types.h qapi/qapi-builtin-typ=
es.c
 GENERATED_QAPI_FILES +=3D qapi/qapi-types.h qapi/qapi-types.c
@@ -121,20 +121,18 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/q=
api-events-%.c)
 GENERATED_QAPI_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
=20
-GENERATED_FILES +=3D $(GENERATED_QAPI_FILES)
+generated-files-y +=3D $(GENERATED_QAPI_FILES)
=20
-GENERATED_FILES +=3D trace/generated-tcg-tracers.h
+generated-files-y +=3D trace/generated-tcg-tracers.h
=20
-GENERATED_FILES +=3D trace/generated-helpers-wrappers.h
-GENERATED_FILES +=3D trace/generated-helpers.h
-GENERATED_FILES +=3D trace/generated-helpers.c
+generated-files-y +=3D trace/generated-helpers-wrappers.h
+generated-files-y +=3D trace/generated-helpers.h
+generated-files-y +=3D trace/generated-helpers.c
=20
-ifdef CONFIG_TRACE_UST
-GENERATED_FILES +=3D trace-ust-all.h
-GENERATED_FILES +=3D trace-ust-all.c
-endif
+generated-files-$(CONFIG_TRACE_UST) +=3D trace-ust-all.h
+generated-files-$(CONFIG_TRACE_UST) +=3D trace-ust-all.c
=20
-GENERATED_FILES +=3D module_block.h
+generated-files-y +=3D module_block.h
=20
 TRACE_HEADERS =3D trace-root.h $(trace-events-subdirs:%=3D%/trace.h)
 TRACE_SOURCES =3D trace-root.c $(trace-events-subdirs:%=3D%/trace.c)
@@ -147,10 +145,10 @@ ifdef CONFIG_TRACE_UST
 TRACE_HEADERS +=3D trace-ust-root.h $(trace-events-subdirs:%=3D%/trace-u=
st.h)
 endif
=20
-GENERATED_FILES +=3D $(TRACE_HEADERS)
-GENERATED_FILES +=3D $(TRACE_SOURCES)
-GENERATED_FILES +=3D $(BUILD_DIR)/trace-events-all
-GENERATED_FILES +=3D .git-submodule-status
+generated-files-y +=3D $(TRACE_HEADERS)
+generated-files-y +=3D $(TRACE_SOURCES)
+generated-files-y +=3D $(BUILD_DIR)/trace-events-all
+generated-files-y +=3D .git-submodule-status
=20
 trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
=20
@@ -281,7 +279,7 @@ KEYCODEMAP_FILES =3D \
 		 ui/input-keymap-osx-to-qcode.c \
 		 $(NULL)
=20
-GENERATED_FILES +=3D $(KEYCODEMAP_FILES)
+generated-files-$(CONFIG_SOFTMMU) +=3D $(KEYCODEMAP_FILES)
=20
 ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/=
Makefile.objs
 	$(call quiet-command,\
@@ -637,10 +635,10 @@ clean:
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
-	@# May not be present in GENERATED_FILES
+	@# May not be present in generated-files-y
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
-	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
+	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
@@ -1032,7 +1030,7 @@ endif # CONFIG_WIN
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGO=
ALS),,fail))
-Makefile: $(GENERATED_FILES)
+Makefile: $(generated-files-y)
 endif
 endif
=20
diff --git a/Makefile.target b/Makefile.target
index ae02495951df..fdbe7c89f4a0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -166,7 +166,7 @@ else
 obj-y +=3D hw/$(TARGET_BASE_ARCH)/
 endif
=20
-GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
+generated-files-y +=3D hmp-commands.h hmp-commands-info.h
=20
 endif # CONFIG_SOFTMMU
=20
@@ -236,5 +236,5 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../syst=
emtap/tapset/$(QEMU_PROG)-log.stp"
 endif
=20
-GENERATED_FILES +=3D config-target.h
-Makefile: $(GENERATED_FILES)
+generated-files-y +=3D config-target.h
+Makefile: $(generated-files-y)
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 68eeee3d2f9b..312bf4f6baa0 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -12,7 +12,7 @@ obj-$(call lnot,$(CONFIG_TCG)) +=3D tcg-stub.o
 feat-src =3D $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst =3D $(BUILD_DIR)/$(TARGET_DIR)
 ifneq ($(MAKECMDGOALS),clean)
-GENERATED_FILES +=3D $(feat-dst)gen-features.h
+generated-files-y +=3D $(feat-dst)gen-features.h
 endif
=20
 $(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6b904d74303c..428a9eaaf762 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -468,19 +468,19 @@ qapi-schema +=3D unknown-expr-key.json
=20
 check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema))
=20
-GENERATED_FILES +=3D tests/test-qapi-types.h \
-	tests/include/test-qapi-types-sub-module.h \
-	tests/test-qapi-types-sub-sub-module.h \
-	tests/test-qapi-visit.h \
-	tests/include/test-qapi-visit-sub-module.h \
-	tests/test-qapi-visit-sub-sub-module.h \
-	tests/test-qapi-commands.h \
-	tests/include/test-qapi-commands-sub-module.h \
-	tests/test-qapi-commands-sub-sub-module.h \
-	tests/test-qapi-events.h \
-	tests/include/test-qapi-events-sub-module.h \
-	tests/test-qapi-events-sub-sub-module.h \
-	tests/test-qapi-introspect.h
+generated-files-y +=3D tests/test-qapi-types.h
+generated-files-y +=3D tests/include/test-qapi-types-sub-module.h
+generated-files-y +=3D tests/test-qapi-types-sub-sub-module.h
+generated-files-y +=3D tests/test-qapi-visit.h
+generated-files-y +=3D tests/include/test-qapi-visit-sub-module.h
+generated-files-y +=3D tests/test-qapi-visit-sub-sub-module.h
+generated-files-y +=3D tests/test-qapi-commands.h
+generated-files-y +=3D tests/include/test-qapi-commands-sub-module.h
+generated-files-y +=3D tests/test-qapi-commands-sub-sub-module.h
+generated-files-y +=3D tests/test-qapi-events.h
+generated-files-y +=3D tests/include/test-qapi-events-sub-module.h
+generated-files-y +=3D tests/test-qapi-events-sub-sub-module.h
+generated-files-y +=3D tests/test-qapi-introspect.h
=20
 test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
 	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
--=20
2.20.1
