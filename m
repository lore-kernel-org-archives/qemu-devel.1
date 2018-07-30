Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHMb-00011s-DI
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHMY-0006PP-8o
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkHMY-0006P6-1b
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:02 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 30 Jul 2018 17:13:46 -0600
Message-ID: <153299242656.14411.14216251294160965283.stgit@gimli.home>
In-Reply-To: <153299204130.14411.11438396195753743913.stgit@gimli.home>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/4] balloon: Allow nested inhibits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, mst@redhat.com, david@redhat.com

A simple true/false internal state does not allow multiple users.  Fix
this within the existing interface by converting to a counter, so long
as the counter is elevated, ballooning is inhibited.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 balloon.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/balloon.c b/balloon.c
index 6bf0a9681377..931987983858 100644
--- a/balloon.c
+++ b/balloon.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/atomic.h"
 #include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
@@ -37,16 +38,22 @@
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
 static void *balloon_opaque;
-static bool balloon_inhibited;
+static int balloon_inhibit_count;
 
 bool qemu_balloon_is_inhibited(void)
 {
-    return balloon_inhibited;
+    return atomic_read(&balloon_inhibit_count) > 0;
 }
 
 void qemu_balloon_inhibit(bool state)
 {
-    balloon_inhibited = state;
+    if (state) {
+        atomic_inc(&balloon_inhibit_count);
+    } else {
+        atomic_dec(&balloon_inhibit_count);
+    }
+
+    assert(atomic_read(&balloon_inhibit_count) >= 0);
 }
 
 static bool have_balloon(Error **errp)
