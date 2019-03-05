Received: from eggs.gnu.org ([209.51.188.92]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Eca-0001RD-86
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcY-0002C2-CY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcW-0002Ap-G5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:16:01 +0000
Message-Id: <20190305181602.9051-21-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/21] Migration/colo.c: Make COLO node running
 after failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Zhang Chen <chen.zhang@intel.com>

Delay to close COLO for auto start VM after failover.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190303145021.2962-4-chen.zhang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 1 -
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index a916dc178c..5ba610dc01 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -874,7 +874,6 @@ out:
         qemu_fclose(mis->to_src_file);
         mis->to_src_file =3D NULL;
     }
-    migration_incoming_disable_colo();
=20
     rcu_unregister_thread();
     return NULL;
diff --git a/migration/migration.c b/migration/migration.c
index 501319aa14..b6f5de198b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -411,6 +411,9 @@ static void process_incoming_migration_bh(void *opaqu=
e)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
+    } else if (migration_incoming_colo_enabled()) {
+        migration_incoming_disable_colo();
+        vm_start();
     } else {
         runstate_set(global_state_get_runstate());
     }
--=20
2.20.1
