Received: from eggs.gnu.org ([2001:4830:134:3::10]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSC1-0008RX-BQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSBv-0006eC-Jp
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPSBn-0006Mb-AU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 21 Nov 2018 13:04:56 +0000
Message-Id: <20181121130456.35661-3-dgilbert@redhat.com>
In-Reply-To: <20181121130456.35661-1-dgilbert@redhat.com>
References: <20181121130456.35661-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] migration/migration.c: Add COLO dependency
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, zhangckid@gmail.com, quintela@redhat.com
Cc: peterx@redhat.com

From: Zhang Chen <chen.zhang@intel.com>

Current COLO mode(independent disk mode) need replication module work
together. Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20181114190912.7242-1-chen.zhang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b261c1e4ce..49ffb9997a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -918,6 +918,15 @@ static bool migrate_caps_check(bool *cap_list,
     }
 #endif
=20
+#ifndef CONFIG_REPLICATION
+    if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {
+        error_setg(errp, "QEMU compiled without replication module"
+                   " can't enable COLO");
+        error_append_hint(errp, "Please enable replication before COLO.\=
n");
+        return false;
+    }
+#endif
+
     if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
         if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
             /* The decompression threads asynchronously write into RAM
--=20
2.19.1
