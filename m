Received: from eggs.gnu.org ([2001:4830:134:3::10]:46501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWi-0004Z6-Vg
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWg-0007aK-L8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:08 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWg-0007ZW-Fu
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:06 -0400
Received: by mail-wm0-x236.google.com with SMTP id t70so1597780wmt.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:16 +0200
Message-Id: <1499238885-26161-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/42] sockets: avoid formatting buffer that may
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

From: "Daniel P. Berrange" <berrange@redhat.com>

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
Message-Id: <20170626103756.22974-1-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-sockets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 82290cb..d3e5108 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -897,7 +897,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     strncpy(un.sun_path, path, sizeof(un.sun_path));
 
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
-        error_setg_errno(errp, errno, "Failed to bind socket to %s", un.sun_path);
+        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
         goto err;
     }
     if (listen(sock, 1) < 0) {
-- 
1.8.3.1
