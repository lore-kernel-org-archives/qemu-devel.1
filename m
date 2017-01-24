Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68F-0001Iv-J3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68E-0006qR-O1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68E-0006q3-IS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEAE3C59D0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:50 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUt020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:50 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:34 +0000
Message-Id: <20170124184742.1639-8-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] migration: Add a new option to enable
 only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ashijeet Acharya <ashijeetacharya@gmail.com>

Add a new option "--only-migratable" in qemu which will allow to add
only those devices which will not fail qemu after migration. Devices
set with the flag 'unmigratable' cannot be added when this option will
be used.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Message-Id: <1484566314-3987-3-git-send-email-ashijeetacharya@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 3 +++
 qemu-options.hx               | 9 +++++++++
 vl.c                          | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index c309d23..40b3697 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -38,6 +38,9 @@
 #define QEMU_VM_COMMAND              0x08
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
+/* for vl.c */
+extern int only_migratable;
+
 struct MigrationParams {
     bool blk;
     bool shared;
diff --git a/qemu-options.hx b/qemu-options.hx
index 780528d..48c7f22 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3585,6 +3585,15 @@ be used to change settings (such as migration parameters) prior to issuing
 the migrate_incoming to allow the migration to begin.
 ETEXI
 
+DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
+    "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
+STEXI
+@item -only-migratable
+@findex -only-migratable
+Only allow migratable devices. Devices will not be allowed to enter an
+unmigratable state.
+ETEXI
+
 DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
     "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
 STEXI
diff --git a/vl.c b/vl.c
index abb0900..68e8c00 100644
--- a/vl.c
+++ b/vl.c
@@ -182,6 +182,7 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
+int only_migratable; /* turn it off unless user states otherwise */
 
 int icount_align_option;
 
@@ -3884,6 +3885,9 @@ int main(int argc, char **argv, char **envp)
                 }
                 incoming = optarg;
                 break;
+            case QEMU_OPTION_only_migratable:
+                only_migratable = 1;
+                break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
                 break;
-- 
2.9.3
