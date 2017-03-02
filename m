Received: from eggs.gnu.org ([2001:4830:134:3::10]:60341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cjYPJ-00033B-AE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cjYPG-0006Ei-6o
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:37:05 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cjYPG-0006E5-0f
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:37:02 -0500
Received: by mail-pg0-x235.google.com with SMTP id s67so36230235pgb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 13:37:01 -0800 (PST)
From: ben@skyportsystems.com
Date: Thu,  2 Mar 2017 13:36:50 -0800
Message-Id: <20170302213650.86211-1-ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH] Bugfix: Handle error if VM Generation ID
 device not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, pbonzini@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This was crashing due to NULL-pointer dereference

QMP Test case:
==============

(QEMU) query-vm-generation-id
{"error": {"class": "GenericError", "desc": "VM Generation ID device not
found"}}

HMP Test case:
==============
virsh # qemu-monitor-command --hmp 3 info vm-generation-id
VM Generation ID device not found

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hmp.c             | 4 +++-
 hw/acpi/vmgenid.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 261843f..edb8970 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2608,9 +2608,11 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
 {
-    GuidInfo *info = qmp_query_vm_generation_id(NULL);
+    Error *err = NULL;
+    GuidInfo *info = qmp_query_vm_generation_id(&err);
     if (info) {
         monitor_printf(mon, "%s\n", info->guid);
     }
+    hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 744f284..7a3ad17 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -248,6 +248,7 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     Object *obj = find_vmgenid_dev();
 
     if (!obj) {
+        error_setg(errp, "VM Generation ID device not found");
         return NULL;
     }
     vms = VMGENID(obj);
-- 
2.7.4
