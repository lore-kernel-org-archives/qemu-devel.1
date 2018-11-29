Received: from eggs.gnu.org ([2001:4830:134:3::10]:34193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQcQ-0001fd-Mp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQcP-0006lh-NX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:00:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSQcP-0006l9-G2
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:00:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9D6531408E7
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 18:00:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 19:00:50 +0100
Message-Id: <20181129180050.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] glib-compat: work around g_test_message bug
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
Message-Id: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/glib-compat.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fdf95a255d..f675c7328f 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -113,4 +113,12 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint tim=
eout);
=20
 #pragma GCC diagnostic pop
=20
+/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
+#define g_test_message(...)                                     \
+    do {                                                        \
+        if (!g_test_subprocess()) {                             \
+            g_test_message(__VA_ARGS__);                        \
+        }                                                       \
+    } while (0)
+
 #endif
--=20
2.19.1
