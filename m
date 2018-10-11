Received: from eggs.gnu.org ([2001:4830:134:3::10]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaZ-0004vf-PT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001dS-Tz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001X0-Fm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:34 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:09 +0100
Message-Id: <20181011192513.63634-4-dgilbert@redhat.com>
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] migration: Stop postcopy fault thread
 before notifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: Ilya Maximets <i.maximets@samsung.com>

POSTCOPY_NOTIFY_INBOUND_END handlers will remove userfault fds
from the postcopy_remote_fds array which could be still in
use by the fault thread. Let's stop the thread before
notification to avoid possible accessing wrong memory.

Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Message-Id: <20181008160536.6332-2-i.maximets@samsung.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 853d8b32ca..e5c02a32c5 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -533,6 +533,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingS=
tate *mis)
     if (mis->have_fault_thread) {
         Error *local_err =3D NULL;
=20
+        /* Let the fault thread quit */
+        atomic_set(&mis->fault_thread_quit, 1);
+        postcopy_fault_thread_notify(mis);
+        trace_postcopy_ram_incoming_cleanup_join();
+        qemu_thread_join(&mis->fault_thread);
+
         if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
             error_report_err(local_err);
             return -1;
@@ -541,11 +547,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingS=
tate *mis)
         if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
             return -1;
         }
-        /* Let the fault thread quit */
-        atomic_set(&mis->fault_thread_quit, 1);
-        postcopy_fault_thread_notify(mis);
-        trace_postcopy_ram_incoming_cleanup_join();
-        qemu_thread_join(&mis->fault_thread);
=20
         trace_postcopy_ram_incoming_cleanup_closeuf();
         close(mis->userfault_fd);
--=20
2.19.0
