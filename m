Received: from eggs.gnu.org ([2001:4830:134:3::10]:40603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZv-0005p9-7v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZn-0000i7-7U
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:19 +0300
Message-Id: <3c1951092c88d594c365fc7d570e8417a6f56a07.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/31] qga: fix erroneous argument to strerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

process_command returns a negative value in case of error.  Make this
clear in the "if" statement and fix the strerror argument to flip it
to positive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qga/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 6caf215..538e4ee 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -558,8 +558,8 @@ static void process_command(GAState *s, QDict *req)
     rsp =3D qmp_dispatch(QOBJECT(req));
     if (rsp) {
         ret =3D send_response(s, rsp);
-        if (ret) {
-            g_warning("error sending response: %s", strerror(ret));
+        if (ret < 0) {
+            g_warning("error sending response: %s", strerror(-ret));
         }
         qobject_decref(rsp);
     }
--=20
2.1.4
