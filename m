Received: from eggs.gnu.org ([2001:4830:134:3::10]:52328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsZ1n-000820-CB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 15:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsYrj-0003KH-FW
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 15:32:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsYrj-0003J7-83
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 15:32:27 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 22 Aug 2018 13:32:24 -0600
Message-ID: <153496608036.29987.17320139395542439335.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] postcopy: Synchronize usage of the balloon
 inhibitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, peter.maydell@linaro.org

While the qemu_balloon_inhibit() interface appears rather general purpose,
postcopy uses it in a last-caller-wins approach with no guarantee of balanced
inhibits and de-inhibits.  Wrap postcopy's usage of the inhibitor to give it
one vote overall, using the same last-caller-wins approach as previously
implemented at the balloon level.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 01ccbec7bdf6 ("balloon: Allow multiple inhibit users")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Note that checkpatch.pl doesn't appreciate the initialization of the
static variable to false, imo it improves the readability of the code
in this instance, so I've left it.  Shout if you disagree.

If this gets acks I can include it with a pull request for a couple
other fixes to the original series.  Thanks

 migration/postcopy-ram.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 932f18894990..c2e387ed44b4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -509,6 +509,20 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
     return 0;
 }
 
+/*
+ * Manage a single vote to the QEMU balloon inhibitor for all postcopy usage,
+ * last caller wins.
+ */
+static void postcopy_balloon_inhibit(bool state)
+{
+    static bool cur_state = false;
+
+    if (state != cur_state) {
+        qemu_balloon_inhibit(state);
+        cur_state = state;
+    }
+}
+
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
  */
@@ -539,7 +553,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_fault_thread = false;
     }
 
-    qemu_balloon_inhibit(false);
+    postcopy_balloon_inhibit(false);
 
     if (enable_mlock) {
         if (os_mlock() < 0) {
@@ -1107,7 +1121,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
      * Ballooning can mark pages as absent while we're postcopying
      * that would cause false userfaults.
      */
-    qemu_balloon_inhibit(true);
+    postcopy_balloon_inhibit(true);
 
     trace_postcopy_ram_enable_notify();
 
