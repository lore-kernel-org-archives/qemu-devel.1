Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3i-0000r7-96
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexY-0007Kj-BL
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexY-0007KY-76
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:54 +0200
Message-Id: <1535704738-8986-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1535704738-8986-1-git-send-email-thuth@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] tests/libqos: Utilize newer glib spawn check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Eric Blake <eblake@redhat.com>

During development, I got a 'make check' failure that claimed:

qemu-img returned status code 32512
**
ERROR:tests/libqos/libqos.c:202:mkimg: assertion failed: (!rc)

But 32512 is too big for a normal exit status value, which means we
failed to use WEXITSTATUS() to shift the bits to the desired value
for printing.  However, instead of worrying about how to portably
parse g_spawn()'s rc in the proper platform-dependent manner, it's
better to just rely on the fact that we now require glib 2.40 (since
commit e7b3af815) and can therefore use glib's portable checker
instead, where the message under my same condition improves to:

Child process exited with code 127
**
ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/libqos.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 013ca68..c514187 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -185,22 +185,12 @@ void mkimg(const char *file, const char *fmt, unsigned size_mb)
     cli = g_strdup_printf("%s create -f %s %s %uM", qemu_img_abs_path,
                           fmt, file, size_mb);
     ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
-    if (err) {
+    if (err || !g_spawn_check_exit_status(rc, &err)) {
         fprintf(stderr, "%s\n", err->message);
         g_error_free(err);
     }
     g_assert(ret && !err);
 
-    /* In glib 2.34, we have g_spawn_check_exit_status. in 2.12, we don't.
-     * glib 2.43.91 implementation assumes that any non-zero is an error for
-     * windows, but uses extra precautions for Linux. However,
-     * 0 is only possible if the program exited normally, so that should be
-     * sufficient for our purposes on all platforms, here. */
-    if (rc) {
-        fprintf(stderr, "qemu-img returned status code %d\n", rc);
-    }
-    g_assert(!rc);
-
     g_free(out);
     g_free(out2);
     g_free(cli);
-- 
1.8.3.1
