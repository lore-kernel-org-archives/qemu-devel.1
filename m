Received: from eggs.gnu.org ([2001:4830:134:3::10]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKC-0005M1-N0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKB-0001KJ-Po
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQgKB-0001Jx-Gt
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE3487F7A5
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 20:13:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  9 Jan 2017 20:13:39 +0000
Message-Id: <20170109201340.16593-3-dgilbert@redhat.com>
In-Reply-To: <20170109201340.16593-1-dgilbert@redhat.com>
References: <20170109201340.16593-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: Check for ID length
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

The qdev id of a device can be huge if it's on the end of a chain
of bridges; in reality such chains shouldn't occur but they can
be made to by chaining PCIe bridges together.

The migration format has a number of 256 character long format
limits; check we don't hit them (we already use pstrcat/cpy but
that just protects us from buffer overruns, we fairly quickly
hit an assert).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h |  2 ++
 migration/savevm.c          | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 73f3182..93b4722 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -949,12 +949,14 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
+/* Returns: 0 on success, -1 on failure */
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
                                    Error **errp);
 
+/* Returns: 0 on success, -1 on failure */
 static inline int vmstate_register(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
diff --git a/migration/savevm.c b/migration/savevm.c
index ae3ab2c..84324b2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -559,8 +559,14 @@ int register_savevm_live(DeviceState *dev,
     if (dev) {
         char *id = qdev_get_dev_path(dev);
         if (id) {
-            pstrcpy(se->idstr, sizeof(se->idstr), id);
-            pstrcat(se->idstr, sizeof(se->idstr), "/");
+            if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=
+                sizeof(se->idstr)) {
+                error_report("Path too long for VMState (%s)", id);
+                g_free(id);
+                g_free(se);
+
+                return -1;
+            }
             g_free(id);
 
             se->compat = g_new0(CompatEntry, 1);
@@ -644,9 +650,14 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
     if (dev) {
         char *id = qdev_get_dev_path(dev);
         if (id) {
-            pstrcpy(se->idstr, sizeof(se->idstr), id);
-            pstrcat(se->idstr, sizeof(se->idstr), "/");
-            g_free(id);
+            if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=
+                sizeof(se->idstr)) {
+                error_setg(errp, "Path too long for VMState (%s)", id);
+                g_free(id);
+                g_free(se);
+
+                return -1;
+            }
 
             se->compat = g_new0(CompatEntry, 1);
             pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd->name);
-- 
2.9.3
