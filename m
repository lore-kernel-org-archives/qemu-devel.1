Received: from eggs.gnu.org ([2001:4830:134:3::10]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mAL-0000uh-6F
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mAI-0008Fi-K3
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d2mAI-0008Ed-CG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3OM3sb6122065
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:09:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1qnw4w31-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:08:59 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 24 Apr 2017 19:08:57 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 19:08:25 -0300
In-Reply-To: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
References: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170424220828.1472-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] migration: alternative way to set
 instance_id in SaveStateEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

In QOM (QEMU Object Model) migrated objects are identified with instance_id
which is calculated automatically using their path in the QOM composition
tree. For some objects, this path could change from source to target in
migration. To migrate such objects, we need to make sure the instance_id does
not change from source to target. We add a hook in DeviceClass to do customized
instance_id calculation in such cases.

As a result, in these cases compat will not be set in the concerned
SaveStateEntry. This will prevent the inconsistent idstr to be sent over in
migration. We could have set alias_id in a similar way. But that will be
overloading the purpose of alias_id.

The first application will be setting instance_id for pseries DRC objects using
its unique index. Doing this makes the instance_id of DRC to be consistent
across migration and supports flexible management of DRC objects in migration.

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 include/hw/qdev-core.h | 6 ++++++
 migration/savevm.c     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 4bf86b0..9b3914c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -127,6 +127,12 @@ typedef struct DeviceClass {
     qdev_initfn init; /* TODO remove, once users are converted to realize */
     qdev_event exit; /* TODO remove, once users are converted to unrealize */
     const char *bus_type;
+
+    /* When this field is set, qemu will use it to get an unique instance_id
+     * instead of calculating an auto idstr and instance_id for the relevant
+     * SaveStateEntry
+     */
+    int (*dev_get_instance_id)(DeviceState *dev);
 } DeviceClass;
 
 typedef struct NamedGPIOList NamedGPIOList;
diff --git a/migration/savevm.c b/migration/savevm.c
index 03ae1bd..5d8135f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -606,6 +606,9 @@ int register_savevm_live(DeviceState *dev,
                          calculate_compat_instance_id(idstr) : instance_id;
             instance_id = -1;
         }
+        if (DEVICE_GET_CLASS(dev)->dev_get_instance_id) {
+            instance_id = DEVICE_GET_CLASS(dev)->dev_get_instance_id(dev);
+        }
     }
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
 
@@ -696,6 +699,9 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                          calculate_compat_instance_id(vmsd->name) : instance_id;
             instance_id = -1;
         }
+        if (DEVICE_GET_CLASS(dev)->dev_get_instance_id) {
+            instance_id = DEVICE_GET_CLASS(dev)->dev_get_instance_id(dev);
+        }
     }
     pstrcat(se->idstr, sizeof(se->idstr), vmsd->name);
 
-- 
2.9.3
