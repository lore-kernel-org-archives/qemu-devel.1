Received: from eggs.gnu.org ([2001:4830:134:3::10]:43214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRPH-0000uQ-6e
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRPC-0007yC-9I
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:38:11 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 26 Jun 2017 11:37:56 +0100
Message-Id: <20170626103756.22974-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] sockets: avoid formatting buffer that may
 not be NUL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 'sun_path' field in the sockaddr_un struct is not required
to be NUL termianted, so when reporting an error, we must use
the separate 'path' variable which is guaranteed terminated.

Fixes a bug spotted by coverity that was introduced in

  commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Thu May 25 16:53:00 2017 +0100

    sockets: improve error reporting if UNIX socket path is too long

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 51bf279..37d386f 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -930,7 +930,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     strncpy(un.sun_path, path, sizeof(un.sun_path));
 
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
-        error_setg_errno(errp, errno, "Failed to bind socket to %s", un.sun_path);
+        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
         goto err;
     }
     if (listen(sock, 1) < 0) {
-- 
2.9.3
