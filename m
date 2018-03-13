Received: from eggs.gnu.org ([2001:4830:134:3::10]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshx-0005eO-Cl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshw-0003As-0u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshv-00039j-Ls
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:47 -0400
Received: by mail-wm0-x242.google.com with SMTP id t6so879301wmt.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:30 +0100
Message-Id: <20180313224719.4954-21-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/69] Polish the version strings containing the
 package version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since commit 67a1de0d195a there is no space anymore between the
version number and the parentheses when running configure with
--with-pkgversion=foo :

 $ qemu-system-s390x --version
 QEMU emulator version 2.11.50(foo)

But the space is included when building without that option
when building from a git checkout:

 $ qemu-system-s390x --version
 QEMU emulator version 2.11.50 (v2.11.0-1494-gbec9c64-dirty)

The same confusion exists with the "query-version" QMP command.
Let's fix this by introducing a proper QEMU_FULL_VERSION definition
that includes the space and parentheses, while the QEMU_PKGVERSION
should just cleanly contain the package version string itself.
Note that this also changes the behavior of the "query-version" QMP
command (the space and parentheses are not included there anymore),
but that's supposed to be OK since the strings there are not meant
to be parsed by other tools.

Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1518692807-25859-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              | 20 +++++++++++---------
 bsd-user/main.c       |  2 +-
 configure             |  2 +-
 linux-user/main.c     |  2 +-
 qemu-img.c            |  2 +-
 qemu-io.c             |  2 +-
 qemu-nbd.c            |  2 +-
 qga/main.c            |  2 +-
 scsi/qemu-pr-helper.c |  2 +-
 ui/cocoa.m            |  2 +-
 vl.c                  |  2 +-
 11 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 5d9ef3b8fd..416a81c7ca 100644
--- a/Makefile
+++ b/Makefile
@@ -434,21 +434,23 @@ all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
 qemu-version.h: FORCE
 	$(call quiet-command, \
 		(cd $(SRC_PATH); \
-		printf '#define QEMU_PKGVERSION '; \
 		if test -n "$(PKGVERSION)"; then \
-			printf '"$(PKGVERSION)"\n'; \
+			pkgvers="$(PKGVERSION)"; \
 		else \
 			if test -d .git; then \
-				printf '" ('; \
-				git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
+				pkgvers=$$(git describe --match 'v*' 2>/dev/null | tr -d '\n');\
 				if ! git diff-index --quiet HEAD &>/dev/null; then \
-					printf -- '-dirty'; \
+					pkgvers="$${pkgvers}-dirty"; \
 				fi; \
-				printf ')"\n'; \
-			else \
-				printf '""\n'; \
 			fi; \
-		fi) > $@.tmp)
+		fi; \
+		printf "#define QEMU_PKGVERSION \"$${pkgvers}\"\n"; \
+		if test -n "$${pkgvers}"; then \
+			printf '#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"\n'; \
+		else \
+			printf '#define QEMU_FULL_VERSION QEMU_VERSION\n'; \
+		fi; \
+		) > $@.tmp)
 	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
 	  mv $@.tmp $@; \
 	 else \
diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff8c5..05aa5594a9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -649,7 +649,7 @@ void cpu_loop(CPUSPARCState *env)
 
 static void usage(void)
 {
-    printf("qemu-" TARGET_NAME " version " QEMU_VERSION QEMU_PKGVERSION
+    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
            "\n" QEMU_COPYRIGHT "\n"
            "usage: qemu-" TARGET_NAME " [options] program [arguments...]\n"
            "BSD CPU emulator (compiled for %s emulation)\n"
diff --git a/configure b/configure
index f74e1f3b7c..26d56eb5bb 100755
--- a/configure
+++ b/configure
@@ -1163,7 +1163,7 @@ for opt do
   ;;
   --disable-blobs) blobs="no"
   ;;
-  --with-pkgversion=*) pkgversion=" ($optarg)"
+  --with-pkgversion=*) pkgversion="$optarg"
   ;;
   --with-coroutine=*) coroutine="$optarg"
   ;;
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc79b0..abbd14e208 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4163,7 +4163,7 @@ static void handle_arg_strace(const char *arg)
 
 static void handle_arg_version(const char *arg)
 {
-    printf("qemu-" TARGET_NAME " version " QEMU_VERSION QEMU_PKGVERSION
+    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
            "\n" QEMU_COPYRIGHT "\n");
     exit(EXIT_SUCCESS);
 }
diff --git a/qemu-img.c b/qemu-img.c
index 088d89043e..855fa52514 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -46,7 +46,7 @@
 #include "crypto/init.h"
 #include "trace/control.h"
 
-#define QEMU_IMG_VERSION "qemu-img version " QEMU_VERSION QEMU_PKGVERSION \
+#define QEMU_IMG_VERSION "qemu-img version " QEMU_FULL_VERSION \
                           "\n" QEMU_COPYRIGHT "\n"
 
 typedef struct img_cmd_t {
diff --git a/qemu-io.c b/qemu-io.c
index 160fb2a89f..e692c555e0 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -558,7 +558,7 @@ int main(int argc, char **argv)
             trace_file = trace_opt_parse(optarg);
             break;
         case 'V':
-            printf("%s version " QEMU_VERSION QEMU_PKGVERSION "\n"
+            printf("%s version " QEMU_FULL_VERSION "\n"
                    QEMU_COPYRIGHT "\n", progname);
             exit(0);
         case 'h':
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5d9b5062..0af0560ad1 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -130,7 +130,7 @@ QEMU_HELP_BOTTOM "\n"
 static void version(const char *name)
 {
     printf(
-"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
+"%s " QEMU_FULL_VERSION "\n"
 "Written by Anthony Liguori.\n"
 "\n"
 QEMU_COPYRIGHT "\n"
diff --git a/qga/main.c b/qga/main.c
index f9c83050c5..837a75a46a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -218,7 +218,7 @@ static void usage(const char *cmd)
 {
     printf(
 "Usage: %s [-m <method> -p <path>] [<options>]\n"
-"QEMU Guest Agent " QEMU_VERSION QEMU_PKGVERSION "\n"
+"QEMU Guest Agent " QEMU_FULL_VERSION "\n"
 QEMU_COPYRIGHT "\n"
 "\n"
 "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9fe615c73c..3facbba170 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -102,7 +102,7 @@ QEMU_HELP_BOTTOM "\n"
 static void version(const char *name)
 {
     printf(
-"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
+"%s " QEMU_FULL_VERSION "\n"
 "Written by Paolo Bonzini.\n"
 "\n"
 QEMU_COPYRIGHT "\n"
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 18de0bb3ea..110b393e4e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1330,7 +1330,7 @@ QemuCocoaView *cocoaView;
     /* Create the version string*/
     NSString *version_string;
     version_string = [[NSString alloc] initWithFormat:
-    @"QEMU emulator version %s%s", QEMU_VERSION, QEMU_PKGVERSION];
+    @"QEMU emulator version %s", QEMU_FULL_VERSION];
     [version_label setStringValue: version_string];
     [superView addSubview: version_label];
 
diff --git a/vl.c b/vl.c
index 26662eb9e7..e81152417a 100644
--- a/vl.c
+++ b/vl.c
@@ -1948,7 +1948,7 @@ static void main_loop(void)
 
 static void version(void)
 {
-    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"
+    printf("QEMU emulator version " QEMU_FULL_VERSION "\n"
            QEMU_COPYRIGHT "\n");
 }
 
-- 
2.14.3
