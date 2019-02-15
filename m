Received: from eggs.gnu.org ([209.51.188.92]:44062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYy-000645-Sk
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYy-0002HB-3s
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:12 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:55741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1guhYx-0002FQ-Oq
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:12 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 15 Feb 2019 20:45:45 +0300
Message-Id: <20190215174548.2630-3-yury-kotov@yandex-team.ru>
In-Reply-To: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] migration: Introduce ignore-shared
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

We want to use local migration to update QEMU for running guests.
In this case we don't need to migrate shared (file backed) RAM.
So, add a capability to ignore such blocks during live migration.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c | 14 ++++++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   |  5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 37e06b76dc..0fadd97fb9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -957,6 +957,11 @@ static bool migrate_caps_check(bool *cap_list,
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
@@ -1983,6 +1988,15 @@ bool migrate_dirty_bitmaps(void)
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
index dcd05d9f87..4211995c53 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -261,6 +261,7 @@ bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 bool migrate_dirty_bitmaps(void);
+bool migrate_ignore_shared(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ecc16..7105570cd3 100644
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
