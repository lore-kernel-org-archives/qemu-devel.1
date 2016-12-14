Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHEvL-0006vK-UT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHEvI-0001gn-ON
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:09:07 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHEvI-0001dM-IJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:09:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so1509910pfb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:08:41 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 00:37:00 +0530
Message-Id: <1481742422-15969-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: Add a new option to enable
 only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Add a new option "--only-migratable" in qemu which will allow to add
only those devices which will not fail qemu after migration. Devices
set with the flag 'unmigratable' cannot be added when this option will
be used.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 include/migration/migration.h |  3 +++
 qemu-options.hx               | 10 ++++++++++
 vl.c                          |  4 ++++
 3 files changed, 17 insertions(+)

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
index c534a2f..7cc2cc5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3574,6 +3574,16 @@ be used to change settings (such as migration parameters) prior to issuing
 the migrate_incoming to allow the migration to begin.
 ETEXI
 
+DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
+    "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
+STEXI
+@item -only-migratable
+@findex -only-migratable
+Don't allow adding devices that will fail QEMU after migration. Devices set with
+the flag unmigratable are not allowed to be added neither statically nor
+dynamically
+ETEXI
+
 DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
     "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
 STEXI
diff --git a/vl.c b/vl.c
index d77dd86..82bffb9 100644
--- a/vl.c
+++ b/vl.c
@@ -180,6 +180,7 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
+int only_migratable = 0; /* turn it off unless user states otherwise */
 
 int icount_align_option;
 
@@ -3914,6 +3915,9 @@ int main(int argc, char **argv, char **envp)
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
2.6.2
