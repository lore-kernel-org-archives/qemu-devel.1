Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cU-0007jF-5P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cT-0000AE-7o
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cT-00009v-2k
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18EDD7E9CB
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:03 +0100
Message-Id: <20170323204544.12015-11-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/51] ram: Move iterations_prev into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 migration/ram.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 826ba6d..d8428c1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -163,6 +163,8 @@ struct RAMState {
     int64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+    /* number of iterations at the beginning of period */
+    uint64_t iterations_prev;
 };
 typedef struct RAMState RAMState;
=20
@@ -625,16 +627,13 @@ static void migration_bitmap_sync_range(RAMState *r=
s, ram_addr_t start,
                              start, length, &rs->num_dirty_pages_period)=
;
 }
=20
-/* Fix me: there are too many global variables used in migration process=
. */
-static uint64_t iterations_prev;
-
 static void migration_bitmap_sync_init(RAMState *rs)
 {
     rs->start_time =3D 0;
     rs->bytes_xfer_prev =3D 0;
     rs->num_dirty_pages_period =3D 0;
     rs->xbzrle_cache_miss_prev =3D 0;
-    iterations_prev =3D 0;
+    rs->iterations_prev =3D 0;
 }
=20
 /**
@@ -712,13 +711,13 @@ static void migration_bitmap_sync(RAMState *rs)
         }
=20
         if (migrate_use_xbzrle()) {
-            if (iterations_prev !=3D acct_info.iterations) {
+            if (rs->iterations_prev !=3D acct_info.iterations) {
                 acct_info.xbzrle_cache_miss_rate =3D
                    (double)(acct_info.xbzrle_cache_miss -
                             rs->xbzrle_cache_miss_prev) /
-                   (acct_info.iterations - iterations_prev);
+                   (acct_info.iterations - rs->iterations_prev);
             }
-            iterations_prev =3D acct_info.iterations;
+            rs->iterations_prev =3D acct_info.iterations;
             rs->xbzrle_cache_miss_prev =3D acct_info.xbzrle_cache_miss;
         }
         s->dirty_pages_rate =3D rs->num_dirty_pages_period * 1000
--=20
2.9.3
