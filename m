Received: from eggs.gnu.org ([2001:4830:134:3::10]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrU-0002dl-Va
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrQ-0008PV-6Y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVyrP-0008PJ-UF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:00 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:01:44 +0000
Message-Id: <20170124110151.937-2-berrange@redhat.com>
In-Reply-To: <20170124110151.937-1-berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/8] make: move top level dir to end of
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently the search path is

  1. source dir corresponding to input file (implicit by compiler)
  2. top level build dir
  3. top level source dir
  4. top level source include/ dir
  5. source dir corresponding to input file
  6. build dir corresponding to output file

This causes a semantic difference in behaviour for builds
where srcdir == builddir vs srcdir != builddir, because
item 5 moves from end to start, when srcdir == builddir.

As a general rule we also want to move to have all shared
headers in the include/ dir, so move that ahead of the
top level dirs in the search order.

Thus we now have:

  1. source dir corresponding to input file
  2. build dir corresponding to output file
  3. top level build dir
  4. top level source dir
  5. top level source include/ dir

and items 1+2 and 4+5 collapse into a single dir when srcdir==builddir
so overall order remains the same.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 rules.mak | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/rules.mak b/rules.mak
index d5c516c..e09aabe 100644
--- a/rules.mak
+++ b/rules.mak
@@ -26,8 +26,10 @@ QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out -Wstrict-prototypes -Wmissing
 # Flags for dependency generation
 QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
-# Same as -I$(SRC_PATH) -I., but for the nested source/object directories
-QEMU_INCLUDES += -I$(<D) -I$(@D)
+# Compiler searches the source file dir first, but in vpath builds
+# we need to make it search the build dir too, before any other
+# explicit search paths.
+QEMU_LOCAL_INCLUDES = -I$(BUILD_DIR)/$(@D)
 
 WL_U := -Wl,-u,
 find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
@@ -61,7 +63,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
                   $(filter-out %.o %.mo,$1))
 
 %.o: %.c
-	$(call quiet-command,$(CC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
 %.o: %.rc
 	$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
 
@@ -74,16 +76,16 @@ LINK = $(call quiet-command, $(LINKPROG) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o
        $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
 %.o: %.S
-	$(call quiet-command,$(CCAS) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CCAS) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
 
 %.o: %.cc
-	$(call quiet-command,$(CXX) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.cpp
-	$(call quiet-command,$(CXX) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.m
-	$(call quiet-command,$(OBJCC) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"OBJC","$(TARGET_DIR)$@")
+	$(call quiet-command,$(OBJCC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) -c -o $@ $<,"OBJC","$(TARGET_DIR)$@")
 
 %.o: %.dtrace
 	$(call quiet-command,dtrace -o $@ -G -s $<,"GEN","$(TARGET_DIR)$@")
@@ -359,6 +361,7 @@ define unnest-vars
                 $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
                 $(error $o added in $v but $o-objs is not set)))
         $(shell mkdir -p ./ $(sort $(dir $($v))))
+        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
         # Include all the .d files
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
         $(eval $v := $(filter-out %/,$($v))))
-- 
2.9.3
