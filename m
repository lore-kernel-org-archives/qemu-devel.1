Received: from eggs.gnu.org ([2001:4830:134:3::10]:49563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRiCt-0005Zd-W5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRiCq-0006ly-6T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:35:35 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRiCp-0006do-Nh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:35:32 -0500
Received: by mail-lj1-x242.google.com with SMTP id 83-v6so21003402ljf.10
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:35:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 19:35:26 +0100
Message-Id: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] glib-compat: work around g_test_message bug
 with subprocess tests
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

Subprocesses are created by glib without leaving the file descriptors
open.  Therefore, g_test_message (and assertion failures, but those
trigger when things are going bad anyway) will think that it is writing
to the log file descriptor, but while actually stomping on the QMP
file descriptor or similar.  This causes spurious failures, which are
as nice to debug as the reader can imagine.  While I have opened a
pull request on GLib, this will probably take a while to propagate
to distros.

I found this while working on qgraph, but the fix is generic.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/glib-compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fdf95a2..989b9ef 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -113,4 +113,10 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 
 #pragma GCC diagnostic pop
 
+/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
+#define g_test_message(...)							\
+	do {									\
+		if (!g_test_subprocess()) g_test_message(__VA_ARGS__);		\
+	} while (0)
+
 #endif
-- 
1.8.3.1
