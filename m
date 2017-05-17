Received: from eggs.gnu.org ([2001:4830:134:3::10]:56297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyw-0004E9-Kr
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApys-0000n8-3h
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApyr-0000me-UB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hjAj108890
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:33 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agcwb4qsa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:33 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:30 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:18 +0530
In-Reply-To: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494992962-6929-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 2/6] migration: Introduce
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
 hw/net/vmxnet3.c            |  2 +-
 hw/s390x/s390-skeys.c       |  2 +-
 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          | 12 ++++++++++--
 slirp/slirp.c               |  2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8b1fab2..2b923be 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2350,7 +2350,7 @@ static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
 
     VMW_CBPRN("Starting uninit...");
 
-    unregister_savevm(dev, "vmxnet3-msix", s);
+    unregister_savevm(dev, "vmxnet3-msix", s, false);
 
     vmxnet3_net_uninit(s);
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index e2d4e1a..32b6435 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -379,7 +379,7 @@ static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
         register_savevm(NULL, TYPE_S390_SKEYS, 0, 1, s390_storage_keys_save,
                         s390_storage_keys_load, ss);
     } else {
-        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
+        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss, false);
     }
 }
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f4bf3f1..ba81b3e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -78,7 +78,9 @@ int register_savevm_live(DeviceState *dev,
                          SaveVMHandlers *ops,
                          void *opaque);
 
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque);
+void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque,
+                       bool live);
+void unregister_savevm_live(DeviceState *dev, const char *idstr, void *opaque);
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
diff --git a/migration/savevm.c b/migration/savevm.c
index 7a268ec..fa7c3db 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -630,7 +630,8 @@ int register_savevm(DeviceState *dev,
                                 ops, opaque);
 }
 
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
+void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque,
+                       bool live)
 {
     SaveStateEntry *se, *new_se;
     char id[256] = "";
@@ -651,12 +652,19 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
             if (dev) {
                 g_free(se->compat);
             }
-            g_free(se->ops);
+            if (!live) {
+                g_free(se->ops);
+            }
             g_free(se);
         }
     }
 }
 
+void unregister_savevm_live(DeviceState *dev, const char *idstr, void *opaque)
+{
+    unregister_savevm(dev, idstr, opaque, true);
+}
+
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 2f2ec2c..108e669 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -333,7 +333,7 @@ void slirp_cleanup(Slirp *slirp)
 {
     QTAILQ_REMOVE(&slirp_instances, slirp, entry);
 
-    unregister_savevm(NULL, "slirp", slirp);
+    unregister_savevm(NULL, "slirp", slirp, false);
 
     ip_cleanup(slirp);
     ip6_cleanup(slirp);
-- 
2.7.4
