Received: from eggs.gnu.org ([209.51.188.92]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHtoI-000174-Ap
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHtZV-0006Zv-M3
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:14:38 -0400
Received: from mout.web.de ([212.227.17.12]:34047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hHtZV-0006TY-Cn
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 13:14:37 -0400
Date: Sat, 20 Apr 2019 19:14:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20190420191425.7d1dab82@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Zhang, Chen" <chen.zhang@intel.com>

From: Lukas Straub <lukasstraub2@web.de>
Because event_unhandled_count may be accessed concurrently, it needs
to be protected by taking the lock. However the assert is outside the
lock, probably causing it to read garbage and aborting Qemu erroneously.

The Bug only happens when running Qemu in COLO mode.

This Patch fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1=
824622

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 net/colo-compare.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index bf10526f05..fcb491121b 100644
=2D-- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
         break;
     }

-    assert(event_unhandled_count > 0);
-
     qemu_mutex_lock(&event_mtx);
+    assert(event_unhandled_count > 0);
     event_unhandled_count--;
     qemu_cond_broadcast(&event_complete_cond);
     qemu_mutex_unlock(&event_mtx);
=2D-
2.20.1
