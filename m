Received: from eggs.gnu.org ([2001:4830:134:3::10]:50644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEk-00033K-5M
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEi-0006k5-R2
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.136]:59012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEi-0006il-K3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:24 -0400
Date: Wed, 15 Mar 2017 20:01:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-2-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] Bugfix: Handle error if VM Generation ID
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
MST
