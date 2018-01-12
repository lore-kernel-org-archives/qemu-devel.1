Received: from eggs.gnu.org ([2001:4830:134:3::10]:41510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYa-0007E7-Hg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYZ-0004Ys-M8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYZ-0004Wg-Fj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:31 -0500
Received: by mail-wm0-x241.google.com with SMTP id g1so11397110wmg.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:33 +0100
Message-Id: <1515756676-3860-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/52] build-sys: fix qemu-ga -pthread linking
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

When linking qemu-ga under some configuration (when gthread-2.0.pc
doesn't have -pthread, as happening atm with meson build), you may
have this linking issue:

/usr/bin/ld: libqemuutil.a(qemu-thread-posix.o): undefined reference to symbol 'pthread_setname_np@@GLIBC_2.12'
/usr/lib64/libpthread.so.0: error adding symbols: DSO missing from command line

Make sure qemu-ga links with the pthread library, by adding correct
flags to libs_qga.

This is really a QEMU bug, because it's QEMU code that's using pthread
functions, and so we must explicitly link against pthreads. The bug
was just masked by the fact that often some pkg-config or another for
one of our dependencies will add -pthread to the link line anyway.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180104160523.22995-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 89bd662..ac392d2 100755
--- a/configure
+++ b/configure
@@ -3464,6 +3464,7 @@ else
       done
       if test "$found" = "no"; then
         LIBS="$pthread_lib $LIBS"
+        libs_qga="$pthread_lib $libs_qga"
       fi
       PTHREAD_LIB="$pthread_lib"
       break
-- 
1.8.3.1
