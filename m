Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQDM-0001uY-Vr
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQDL-0003U8-LY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWQDL-0003U0-D8
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:27 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 25 Jan 2017 16:14:10 +0000
Message-Id: <20170125161417.31949-2-berrange@redhat.com>
In-Reply-To: <20170125161417.31949-1-berrange@redhat.com>
References: <20170125161417.31949-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/8] make: move top level dir to end of
 include search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently the search path is

  1. source dir corresponding to input file (implicit by compiler)
  2. top level build dir
  3. top level source dir
  4. top level source include/ dir
  5. source dir corresponding to input file
  6. build dir corresponding to output file

Search item 5 is an effective no-op, since it duplicates item 1.
When srcdir == builddir, item 6 also duplicates item 1, which
causes a semantic difference between VPATH and non-VPATH builds.

Thus to ensure consistent semantics we need item 6 to be present
immediately after item 1. e.g.

  1. source dir corresponding to input file (implicit by compiler)
  2. build dir corresponding to output file
  3. top level build dir
  4. top level source dir
  5. top level source include/ dir

When srcdir == builddir, items 1 & 2 collapse into one, and items
3 & 4 collapse into one, but the overall search order is still
consistent with srcdir != builddir

A further complication is that while most of the source files
are built with a current directory of $BUILD_DIR, target dependant
files are built with a current directory of $BUILD_DIR/$TARGET.

As a result, search item 2 resolves to a different location for
target independant vs target dependant files. For example when
building 'migration/ram.o', the use of '-I$(@D)' (which expands
to '-Imigration') would not find '$BUILD_DIR/migration', but
rather '$BUILD_DIR/$TARGET/migration'.

If there are generated headers files to be used by the migration
code in '$BUILD_DIR/migration', these will not be found by the
relative include, an absolute include is needed instead. This
has not been a problem so far, since nothing has been generating
headers in sub-dirs, but the trace code will shortly be doing
that. So it is needed to list '-I$(BUILD_DIR)/$(@D)' as well as
'-I$(@D)' to ensure both directories are searched when building
target dependant code. So the search order ends up being:

  1. source dir corresponding to input file (implicit by compiler)
  2. build dir corresponding to output file (absolute)
  3. build dir corresponding to output file (relative to cwd)
  4. top level build dir
  5. top level source dir
  6. top level source include/ dir

One final complication is that the absolute '-I$(BUILD_DIR)/$(@D)'
will sometimes end up pointing to a non-existant directory if
that sub-dir does not have any target-independant files to be
built. Rather than try to dynamically filter this, a simple
'mkdir' ensures $(BUILD_DIR)/$(@D) is guaranteed to exist at
all times.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 rules.mak | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/rules.mak b/rules.mak
index d5c516c..575a3af 100644
--- a/rules.mak
+++ b/rules.mak
@@ -26,8 +26,13 @@ QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out -Wstrict-prototypes -Wmissing
 # Flags for dependency generation
 QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
-# Same as -I$(SRC_PATH) -I., but for the nested source/object directories
-QEMU_INCLUDES += -I$(<D) -I$(@D)
+# Compiler searches the source file dir first, but in vpath builds
+# we need to make it search the build dir too, before any other
+# explicit search paths. There are two search locations in the build
+# dir, one absolute and the other relative to the compiler working
+# directory. These are the same for target-independent files, but
+# different for target-dependent ones.
+QEMU_LOCAL_INCLUDES = -I$(BUILD_DIR)/$(@D) -I$(@D)
 
 WL_U := -Wl,-u,
 find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
@@ -61,7 +66,9 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
                   $(filter-out %.o %.mo,$1))
 
 %.o: %.c
-	$(call quiet-command,$(CC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
 %.o: %.rc
 	$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
 
@@ -74,16 +81,24 @@ LINK = $(call quiet-command, $(LINKPROG) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o
        $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
 %.o: %.S
-	$(call quiet-command,$(CCAS) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CCAS) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+	       -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
 
 %.o: %.cc
-	$(call quiet-command,$(CXX) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.cpp
-	$(call quiet-command,$(CXX) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.m
-	$(call quiet-command,$(OBJCC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"OBJC","$(TARGET_DIR)$@")
+	$(call quiet-command,$(OBJCC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       -c -o $@ $<,"OBJC","$(TARGET_DIR)$@")
 
 %.o: %.dtrace
 	$(call quiet-command,dtrace -o $@ -G -s $<,"GEN","$(TARGET_DIR)$@")
@@ -359,6 +374,7 @@ define unnest-vars
                 $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
                 $(error $o added in $v but $o-objs is not set)))
         $(shell mkdir -p ./ $(sort $(dir $($v))))
+        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
         # Include all the .d files
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
         $(eval $v := $(filter-out %/,$($v))))
-- 
2.9.3
