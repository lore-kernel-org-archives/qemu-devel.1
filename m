Received: from eggs.gnu.org ([2001:4830:134:3::10]:41615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYh-0007KN-4T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYg-0004ot-By
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:39 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYg-0004n5-6F
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:38 -0500
Received: by mail-wr0-x22d.google.com with SMTP id x1so857320wrb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:39 +0100
Message-Id: <1515756676-3860-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/52] build-sys: add some sanitizers when
 --enable-debug if possible
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

Enable ASAN/UBSan by default if the compiler supports it.

Typical slowdown introduced by AddressSanitizer is 2x.
UBSan shouldn't have much impact on runtime cost.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-8-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index 6f1b7cd..d033286 100755
--- a/configure
+++ b/configure
@@ -5195,6 +5195,13 @@ if test "$gcov" = "yes" ; then
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
 elif test "$debug" = "yes"; then
+  write_c_skeleton;
+  if compile_prog "-fsanitize=address" ""; then
+      CFLAGS="-fsanitize=address $CFLAGS"
+  fi
+  if compile_prog "-fsanitize=undefined" ""; then
+      CFLAGS="-fsanitize=undefined $CFLAGS"
+  fi
   if compile_prog "-Og" ""; then
       CFLAGS="-Og $CFLAGS"
   elif compile_prog "-O1" ""; then
-- 
1.8.3.1
