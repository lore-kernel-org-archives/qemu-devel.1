Received: from eggs.gnu.org ([2001:4830:134:3::10]:42896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0L-0000FS-4E
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0H-0007sQ-UF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:33 -0400
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 08 Oct 2018 19:05:35 +0300
Message-id: <20181008160536.6332-2-i.maximets@samsung.com>
In-reply-to: <20181008160536.6332-1-i.maximets@samsung.com>
MIME-version: 1.0
References: <20181008160536.6332-1-i.maximets@samsung.com>
	<CGME20181008160325eucas1p23bd6b6ce112175d274db884fb2a83f54@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 1/2] migration: Stop postcopy fault thread before
 notifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Ilya Maximets <i.maximets@samsung.com>, qemu-stable@nongnu.org

POSTCOPY_NOTIFY_INBOUND_END handlers will remove userfault fds
from the postcopy_remote_fds array which could be still in
use by the fault thread. Let's stop the thread before
notification to avoid possible accessing wrong memory.

Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
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
2.17.1
