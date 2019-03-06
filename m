Received: from eggs.gnu.org ([209.51.188.92]:43958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uxu-00075a-9A
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uxl-0005mJ-4o
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Uxh-0005k8-Bj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:51 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:26 +0000
Message-Id: <20190306114227.9125-22-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/22] Migration/colo.c: Make COLO node running
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
Cc: eblake@redhat.com, armbru@redhat.com

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
index 952d29243e..df6fd8e0e5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -417,6 +417,9 @@ static void process_incoming_migration_bh(void *opaqu=
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
