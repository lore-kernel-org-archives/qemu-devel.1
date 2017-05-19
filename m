Received: from eggs.gnu.org ([2001:4830:134:3::10]:56086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafe-0007gI-37
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafb-0005YO-21
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBafa-0005Xy-Oc
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4J5ef6N065540
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:45 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahp1bjgym-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:44 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 19 May 2017 15:41:42 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 11:10:36 +0530
In-Reply-To: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1495172439-1504-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/4] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Introduce a new function unregister_savevm_live() to unregister the vmstate
handlers registered via register_savevm_live().

register_savevm() allocates SaveVMHandlers while register_savevm_live()
gets passed with SaveVMHandlers. During unregistration, we  want to
free SaveVMHandlers in the former case but not free in the latter case.
Hence this new API is needed to differentiate this.

This new API will be needed by PowerPC to unregister the HTAB savevm
handlers.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 include/migration/vmstate.h |  1 +
 migration/savevm.c          | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8489659..02a1bac 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -79,6 +79,7 @@ int register_savevm_live(DeviceState *dev,
                          void *opaque);
 
 void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque);
+void unregister_savevm_live(DeviceState *dev, const char *idstr, void *opaque);
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
diff --git a/migration/savevm.c b/migration/savevm.c
index f5e8194..4ef6fdc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -630,7 +630,8 @@ int register_savevm(DeviceState *dev,
                                 ops, opaque);
 }
 
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
+static void unregister_savevm_common(DeviceState *dev, const char *idstr,
+                                     void *opaque, bool free_savevmhandlers)
 {
     SaveStateEntry *se, *new_se;
     char id[256] = "";
@@ -649,12 +650,24 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
             g_free(se->compat);
-            g_free(se->ops);
+            if (free_savevmhandlers) {
+                g_free(se->ops);
+            }
             g_free(se);
         }
     }
 }
 
+void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
+{
+    unregister_savevm_common(dev, idstr, opaque, true);
+}
+
+void unregister_savevm_live(DeviceState *dev, const char *idstr, void *opaque)
+{
+    unregister_savevm_common(dev, idstr, opaque, false);
+}
+
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
-- 
2.7.4
