Received: from eggs.gnu.org ([209.51.188.92]:40949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvR-00070v-Ek
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvQ-0005V9-K7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvQ-0005Un-E6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:48 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:25 +0000
Message-Id: <20190123155830.8459-5-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] migration: add more error handling for
 postcopy_ram_enable_notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Fei Li <fli@suse.com>

Call postcopy_ram_incoming_cleanup() to do the cleanup when
postcopy_ram_enable_notify fails. Besides, report the error
message when qemu_ram_foreach_migratable_block() fails.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190113140849.38339-5-lifei1214@126.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 1 +
 migration/savevm.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e5c02a32c5..fa09dba534 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1117,6 +1117,7 @@ int postcopy_ram_enable_notify(MigrationIncomingSta=
te *mis)
=20
     /* Mark so that we get notified of accesses to unwritten areas */
     if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis))=
 {
+        error_report("ram_block_enable_notify failed");
         return -1;
     }
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index 9e45fb4f3f..d784e8aa40 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1729,6 +1729,7 @@ static int loadvm_postcopy_handle_listen(MigrationI=
ncomingState *mis)
      */
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_enable_notify(mis)) {
+            postcopy_ram_incoming_cleanup(mis);
             return -1;
         }
     }
--=20
2.20.1
