Received: from eggs.gnu.org ([2001:4830:134:3::10]:49839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKv-0006lF-Ji
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKu-0003ec-Bk
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:28:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsuKu-0003eM-6T
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCA3E40216E7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 18:27:59 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Aug 2018 12:27:59 -0600
Message-ID: <153504887923.3676.17354149092034837658.stgit@gimli.home>
In-Reply-To: <153504858585.3676.10222732707932789866.stgit@gimli.home>
References: <153504858585.3676.10222732707932789866.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/3] postcopy: Synchronize usage of the balloon
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

While the qemu_balloon_inhibit() interface appears rather general purpose,
postcopy uses it in a last-caller-wins approach with no guarantee of balanced
inhibits and de-inhibits.  Wrap postcopy's usage of the inhibitor to give it
one vote overall, using the same last-caller-wins approach as previously
implemented at the balloon level.

Fixes: 01ccbec7bdf6 ("balloon: Allow multiple inhibit users")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
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
 
