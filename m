Received: from eggs.gnu.org ([2001:4830:134:3::10]:40911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKB-0005Lq-Ft
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKA-0001Jq-CQ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQgKA-0001Jk-3X
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BE6B7F7AE
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 20:13:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  9 Jan 2017 20:13:38 +0000
Message-Id: <20170109201340.16593-2-dgilbert@redhat.com>
In-Reply-To: <20170109201340.16593-1-dgilbert@redhat.com>
References: <20170109201340.16593-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] vmstate_register_with_alias_id: Take an
 Error **
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I'll be adding an error to it in a subsequent patch.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/core/qdev.c              | 3 ++-
 hw/intc/apic_common.c       | 2 +-
 include/migration/vmstate.h | 5 +++--
 migration/savevm.c          | 3 ++-
 stubs/vmstate.c             | 3 ++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5783442..ea97b15 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -935,7 +935,8 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (qdev_get_vmsd(dev)) {
             vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
                                            dev->instance_id_alias,
-                                           dev->alias_required_for_version);
+                                           dev->alias_required_for_version,
+                                           NULL);
         }
 
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d78c885..9b40af1 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -328,7 +328,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         instance_id = -1;
     }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
-                                   s, -1, 0);
+                                   s, -1, 0, NULL);
 }
 
 static void apic_common_unrealize(DeviceState *dev, Error **errp)
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1638ee5..73f3182 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -952,14 +952,15 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
-                                   int required_for_version);
+                                   int required_for_version,
+                                   Error **errp);
 
 static inline int vmstate_register(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
 {
     return vmstate_register_with_alias_id(dev, instance_id, vmsd,
-                                          opaque, -1, 0);
+                                          opaque, -1, 0, NULL);
 }
 
 void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
diff --git a/migration/savevm.c b/migration/savevm.c
index 0363372..ae3ab2c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -626,7 +626,8 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
-                                   int required_for_version)
+                                   int required_for_version,
+                                   Error **errp)
 {
     SaveStateEntry *se;
 
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6590627..bbe158f 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -8,7 +8,8 @@ int vmstate_register_with_alias_id(DeviceState *dev,
                                    int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
-                                   int required_for_version)
+                                   int required_for_version,
+                                   Error **errp)
 {
     return 0;
 }
-- 
2.9.3
