Received: from eggs.gnu.org ([2001:4830:134:3::10]:35250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWP-00048Z-OZ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWP-0005lk-19
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWO-0005l9-OT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5C40C04B311
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:46 +0100
Message-Id: <1486399909-16338-4-git-send-email-quintela@redhat.com>
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] migration: Check for ID length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The qdev id of a device can be huge if it's on the end of a chain
of bridges; in reality such chains shouldn't occur but they can
be made to by chaining PCIe bridges together.

The migration format has a number of 256 character long format
limits; check we don't hit them (we already use pstrcat/cpy but
that just protects us from buffer overruns, we fairly quickly
hit an assert).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20170202125956.21942-3-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h |  2 ++
 migration/savevm.c          | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c38b00a..6233fe2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -985,12 +985,14 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,

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
index b11b4a2..8b8c74d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -590,8 +590,14 @@ int register_savevm_live(DeviceState *dev,
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
@@ -674,9 +680,14 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
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
2.7.4
