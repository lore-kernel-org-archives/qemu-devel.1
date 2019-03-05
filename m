Received: from eggs.gnu.org ([209.51.188.92]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ec1-0000zy-CM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ebz-0001k1-UJ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Ebz-0001jG-EB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:19 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:46 +0000
Message-Id: <20190305181602.9051-6-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/21] migration: Introduce ignore-shared
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Yury Kotov <yury-kotov@yandex-team.ru>

We want to use local migration to update QEMU for running guests.
In this case we don't need to migrate shared (file backed) RAM.
So, add a capability to ignore such blocks during live migration.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190215174548.2630-3-yury-kotov@yandex-team.ru>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 14 ++++++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   |  5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e44f77af02..4ff195c901 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -989,6 +989,11 @@ static bool migrate_caps_check(bool *cap_list,
             error_setg(errp, "Postcopy is not supported");
             return false;
         }
+
+        if (cap_list[MIGRATION_CAPABILITY_X_IGNORE_SHARED]) {
+            error_setg(errp, "Postcopy is not compatible with ignore-sha=
red");
+            return false;
+        }
     }
=20
     return true;
@@ -2068,6 +2073,15 @@ bool migrate_dirty_bitmaps(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
 }
=20
+bool migrate_ignore_shared(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED]=
;
+}
+
 bool migrate_use_events(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index c99154dea2..443051adb0 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -265,6 +265,7 @@ bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 bool migrate_dirty_bitmaps(void);
+bool migrate_ignore_shared(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 1fd7bbea9b..eab87340b2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -409,13 +409,16 @@
 #           devices (and thus take locks) immediately at the end of migr=
ation.
 #           (since 3.0)
 #
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory (sin=
ce 4.0)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
            'block', 'return-path', 'pause-before-switchover', 'x-multifd=
',
-           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' =
] }
+           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
+           'x-ignore-shared' ] }
=20
 ##
 # @MigrationCapabilityStatus:
--=20
2.20.1
