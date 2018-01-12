Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYf-0007Jl-Kf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYb-0004e7-TZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:37 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:40320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYb-0004bg-M3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:33 -0500
Received: by mail-wm0-x231.google.com with SMTP id v123so2002244wmd.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:35 +0100
Message-Id: <1515756676-3860-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/52] build-sys: add a rule to print a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

$ make print-CFLAGS
CFLAGS=-fsanitize=address -Og -g

Trick from various sources:
https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable-in-makefile
https://www.cmcrossroads.com/article/printing-value-makefile-variable

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180104160523.22995-4-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  5 ++++-
 docs/devel/build-system.txt | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1671db3..f26ef1b 100644
--- a/Makefile
+++ b/Makefile
@@ -8,9 +8,12 @@ SRC_PATH=.
 
 UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
     html info pdf txt \
-    help check-help \
+    help check-help print-% \
     docker docker-% vm-test vm-build-%
 
+print-%:
+	@echo '$*=$($*)'
+
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
 # Put the all: rule here so that config-host.mak can contain dependencies.
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 386ef36..52501f2 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -510,3 +510,16 @@ default-configs/$TARGET-NAME file as input.
 This is the entrypoint used when make recurses to build a single system
 or userspace emulator target. It is merely a symlink back to the
 Makefile.target in the top level.
+
+
+Useful make targets
+===================
+
+- help
+
+  Print a help message for the most common build targets.
+
+- print-VAR
+
+  Print the value of the variable VAR. Useful for debugging the build
+  system.
-- 
1.8.3.1
