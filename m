Received: from eggs.gnu.org ([2001:4830:134:3::10]:48264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVh-0005Lr-4Q
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVf-0006W4-UQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:05 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVf-0006Vd-Nv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:03 -0500
Received: by mail-wr0-x242.google.com with SMTP id m12so20875546wrm.13
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:03 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.20.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:20:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:20 +0100
Message-Id: <1520342370-123606-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/34] Revert "build-sys: compile with -Og or
 -O1 when --enable-debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This reverts commit 906548689e37ab6cca1e93b3f8d9327a4e17e8af.
Even with -Og, the debug experience is noticeably worse
because gdb shows a lot more "<optimised out>" variables and
function arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 7ff00f8..ebbda23 100755
--- a/configure
+++ b/configure
@@ -5368,19 +5368,8 @@ if test "$gcov" = "yes" ; then
   LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
-elif test "$debug" = "yes"; then
-  if compile_prog "-Og" ""; then
-      CFLAGS="-Og $CFLAGS"
-  elif compile_prog "-O1" ""; then
-      CFLAGS="-O1 $CFLAGS"
-  fi
-  # Workaround GCC false-positive Wuninitialized bugs with Og or O1:
-  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=24639
-  if cc_has_warning_flag "-Wno-maybe-uninitialized"; then
-      CFLAGS="-Wno-maybe-uninitialized $CFLAGS"
-  fi
-else
-    CFLAGS="-O2 $CFLAGS"
+elif test "$debug" = "no"; then
+  CFLAGS="-O2 $CFLAGS"
 fi
 
 if test "$have_asan" = "yes"; then
-- 
1.8.3.1
