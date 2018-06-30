Received: from eggs.gnu.org ([2001:4830:134:3::10]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiz-0008Th-MH
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIix-0007Yq-A6
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZIix-0007Y2-64
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBDDA400B454
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 Jun 2018 18:27:40 +0200
Message-Id: <20180630162744.15920-2-armbru@redhat.com>
In-Reply-To: <20180630162744.15920-1-armbru@redhat.com>
References: <20180630162744.15920-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] chardev: comment details for CLOSED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Peter Xu <peterx@redhat.com>

It was unclear before on what does the CLOSED event mean.  Meanwhile we
add a TODO to fix up the CLOSED event in the future when the in/out
ports are different for a chardev.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180620073223.31964-2-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 04de45795e..6f0576e214 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,7 +22,16 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
-    CHR_EVENT_CLOSED /* connection closed */
+    CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
+                      * is only bound to the read port of the chardev.
+                      * Normally the read port and write port of a
+                      * chardev should be the same, but it can be
+                      * different, e.g., for fd chardevs, when the two
+                      * fds are different.  So when we received the
+                      * CLOSED event it's still possible that the out
+                      * port is still open.  TODO: we should only send
+                      * the CLOSED event when both ports are closed.
+                      */
 } QEMUChrEvent;
=20
 #define CHR_READ_BUF_LEN 4096
--=20
2.17.1
