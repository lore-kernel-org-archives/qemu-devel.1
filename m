Received: from eggs.gnu.org ([2001:4830:134:3::10]:57194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUH-0001IZ-A4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUG-0003PJ-Eq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiUG-0003P1-6F
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33C85C145C1F
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:17 +0200
Message-Id: <20170613095120.11373-12-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] migration: ram_control_* are implemented
 in qemu_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 include/migration/migration.h | 18 ------------------
 migration/qemu-file.h         | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.=
h
index 108212c..cb894b8 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -171,24 +171,6 @@ void migrate_send_rp_pong(MigrationIncomingState *mi=
s,
 void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* =
rbname,
                               ram_addr_t start, size_t len);
=20
-void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
-void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
-void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
-
-/* Whenever this is found in the data stream, the flags
- * will be passed to ram_control_load_hook in the incoming-migration
- * side. This lets before_ram_iterate/after_ram_iterate add
- * transport-specific sections to the RAM migration data.
- */
-#define RAM_SAVE_FLAG_HOOK     0x80
-
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
-#define RAM_SAVE_CONTROL_DELAYED  -2000
-
-size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                             ram_addr_t offset, size_t size,
-                             uint64_t *bytes_sent);
-
 void savevm_skip_section_footers(void);
 void register_global_state(void);
 void global_state_set_optional(void);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 49fd697..aae4e5e 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -156,5 +156,22 @@ void qemu_file_set_blocking(QEMUFile *f, bool block)=
;
=20
 size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
=20
+void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
+void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
+void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
+
+/* Whenever this is found in the data stream, the flags
+ * will be passed to ram_control_load_hook in the incoming-migration
+ * side. This lets before_ram_iterate/after_ram_iterate add
+ * transport-specific sections to the RAM migration data.
+ */
+#define RAM_SAVE_FLAG_HOOK     0x80
+
+#define RAM_SAVE_CONTROL_NOT_SUPP -1000
+#define RAM_SAVE_CONTROL_DELAYED  -2000
+
+size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                             ram_addr_t offset, size_t size,
+                             uint64_t *bytes_sent);
=20
 #endif
--=20
2.9.4
