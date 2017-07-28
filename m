Received: from eggs.gnu.org ([2001:4830:134:3::10]:33270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8fH-0000Zq-DW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8fG-0002L3-L8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 28 Jul 2017 12:02:54 -0500
Message-Id: <20170728170255.13270-2-eblake@redhat.com>
In-Reply-To: <20170728170255.13270-1-eblake@redhat.com>
References: <20170728170255.13270-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] nbd: fix memory leak in nbd_opt_go()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

nbd/client.c:385:12: warning: Potential leak of memory pointed to by 'buf=
'

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170727024224.22900-5-f4bug@amsat.org>
[introduced in commit 8ecaeae8]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 509ed5e4ba..0a17de80b5 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -376,9 +376,11 @@ static int nbd_opt_go(QIOChannel *ioc, const char *w=
antname,
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
-    if (nbd_send_option_request(ioc, NBD_OPT_GO,
-                                4 + len + 2 + 2 * info->request_sizes, b=
uf,
-                                errp) < 0) {
+    error =3D nbd_send_option_request(ioc, NBD_OPT_GO,
+                                    4 + len + 2 + 2 * info->request_size=
s,
+                                    buf, errp);
+    g_free(buf);
+    if (error < 0) {
         return -1;
     }

--=20
2.13.3
