Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cQdLN-0000ad-2Y
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cQdLM-0005Tn-5h
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:02:49 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cQdLM-0005Td-0g
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:02:48 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so5380133pge.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:02:47 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon,  9 Jan 2017 22:32:45 +0530
Message-Id: <1483981368-9965-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v4 1/4] migration: Add a new option to enable
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
index c534a2f..1e16ae8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3574,6 +3574,15 @@ be used to change settings (such as migration parameters) prior to issuing
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
