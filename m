Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPE-0008Tq-F2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyP8-00041b-Gd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36360
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyP8-000419-Bc
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB4lDC084265
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:01 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpuk7tr24-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:01 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:59 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:31 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-5-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 04/40] s390x/migration: Monitor commands for
 storage attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Add an "info" monitor command to non-destructively inspect the state of
the storage attributes of the guest, and a normal command to toggle
migration mode (useful for debugging).

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hmp-commands-info.hx                  | 16 +++++++++
 hmp-commands.hx                       | 16 +++++++++
 hw/s390x/s390-stattrib.c              | 62 +++++++++++++++++++++++++++++++++++
 include/hw/s390x/storage-attributes.h |  4 +++
 monitor.c                             |  1 +
 5 files changed, 99 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 07500ef..d9df238 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -777,6 +777,22 @@ STEXI
 Display the value of a storage key (s390 only)
 ETEXI
 
+#if defined(TARGET_S390X)
+    {
+        .name       = "cmma",
+        .args_type  = "addr:l,count:l?",
+        .params     = "address [count]",
+        .help       = "Display the values of the CMMA storage attributes for a range of pages",
+        .cmd        = hmp_info_cmma,
+    },
+#endif
+
+STEXI
+@item info cmma @var{address}
+@findex cmma
+Display the values of the CMMA storage attributes for a range of pages (s390 only)
+ETEXI
+
     {
         .name       = "dump",
         .args_type  = "",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 75f8bac..f93bc15 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1153,6 +1153,22 @@ STEXI
 Save guest storage keys to a file.
 ETEXI
 
+#if defined(TARGET_S390X)
+    {
+        .name       = "migration_mode",
+        .args_type  = "mode:i",
+        .params     = "mode",
+        .help       = "Enables or disables migration mode\n",
+        .cmd        = hmp_migrationmode,
+    },
+#endif
+
+STEXI
+@item migration_mode @var{mode}
+@findex migration_mode
+Enables or disables migration mode.
+ETEXI
+
     {
         .name       = "snapshot_blkdev",
         .args_type  = "reuse:-n,device:B,snapshot-file:s?,format:s?",
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 922b756..d14923f 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "qmp-commands.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/s390x/storage-attributes.h"
@@ -26,6 +27,15 @@
 #define STATTR_FLAG_ERROR   0x04ULL
 #define STATTR_FLAG_DONE    0x08ULL
 
+static S390StAttribState *s390_get_stattrib_device(void)
+{
+    S390StAttribState *sas;
+
+    sas = S390_STATTRIB(object_resolve_path_type("", TYPE_S390_STATTRIB, NULL));
+    assert(sas);
+    return sas;
+}
+
 void s390_stattrib_init(void)
 {
     Object *obj;
@@ -42,6 +52,58 @@ void s390_stattrib_init(void)
     qdev_init_nofail(DEVICE(obj));
 }
 
+/* Console commands: */
+
+void hmp_migrationmode(Monitor *mon, const QDict *qdict)
+{
+    S390StAttribState *sas = s390_get_stattrib_device();
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    uint64_t what = qdict_get_int(qdict, "mode");
+    int r;
+
+    r = sac->set_migrationmode(sas, what);
+    if (r < 0) {
+        monitor_printf(mon, "Error: %s", strerror(-r));
+    }
+}
+
+void hmp_info_cmma(Monitor *mon, const QDict *qdict)
+{
+    S390StAttribState *sas = s390_get_stattrib_device();
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    uint64_t addr = qdict_get_int(qdict, "addr");
+    uint64_t buflen = qdict_get_try_int(qdict, "count", 8);
+    uint8_t *vals;
+    int cx, len;
+
+    vals = g_try_malloc(buflen);
+    if (!vals) {
+        monitor_printf(mon, "Error: %s\n", strerror(errno));
+        return;
+    }
+
+    len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
+    if (len < 0) {
+        monitor_printf(mon, "Error: %s", strerror(-len));
+        goto out;
+    }
+
+    monitor_printf(mon, "  CMMA attributes, "
+                   "pages %" PRIu64 "+%d (0x%" PRIx64 "):\n",
+                   addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
+    for (cx = 0; cx < len; cx++) {
+        if (cx % 8 == 7) {
+            monitor_printf(mon, "%02x\n", vals[cx]);
+        } else {
+            monitor_printf(mon, "%02x", vals[cx]);
+        }
+    }
+    monitor_printf(mon, "\n");
+
+out:
+    g_free(vals);
+}
+
 /* Migration support: */
 
 static int cmma_load(QEMUFile *f, void *opaque, int version_id)
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 678df95..9be954d 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -13,6 +13,7 @@
 #define S390_STORAGE_ATTRIBUTES_H
 
 #include <hw/qdev.h>
+#include "monitor/monitor.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
 #define TYPE_QEMU_S390_STATTRIB "s390-storage_attributes-qemu"
@@ -74,4 +75,7 @@ static inline Object *kvm_s390_stattrib_create(void)
 }
 #endif
 
+void hmp_info_cmma(Monitor *mon, const QDict *qdict);
+void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+
 #endif /* S390_STORAGE_ATTRIBUTES_H */
diff --git a/monitor.c b/monitor.c
index 12935a7..6a7c988 100644
--- a/monitor.c
+++ b/monitor.c
@@ -81,6 +81,7 @@
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
+#include "hw/s390x/storage-attributes.h"
 #endif
 
 /*
-- 
2.7.4
