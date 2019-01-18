Received: from eggs.gnu.org ([209.51.188.92]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbe-0002xQ-L5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbd-0007Yo-KO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbd-0007Y9-DQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so15418836wrt.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:52 +0000
Message-Id: <20190118145805.6852-37-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/49] migration: Add post_save function to
 VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

In some cases it may be helpful to modify state before saving it for
migration, and then modify the state back after it has been saved. The
existing pre_save function provides half of this functionality. This
patch adds a post_save function to provide the second half.

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20181211151945.29137-2-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h |  1 +
 migration/vmstate.c         | 13 ++++++++++++-
 docs/devel/migration.rst    |  9 +++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 61bef3ef5c0..067b126cf16 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -185,6 +185,7 @@ struct VMStateDescription {
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
     int (*pre_save)(void *opaque);
+    int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
     const VMStateField *fields;
     const VMStateDescription **subsections;
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 80b59009aab..e2bbb7b5f7f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -390,6 +390,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_report("Save of field %s/%s failed",
                                  vmsd->name, field->name);
+                    if (vmsd->post_save) {
+                        vmsd->post_save(opaque);
+                    }
                     return ret;
                 }
 
@@ -415,7 +418,15 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_end_array(vmdesc);
     }
 
-    return vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+
+    if (vmsd->post_save) {
+        int ps_ret = vmsd->post_save(opaque);
+        if (!ret) {
+            ret = ps_ret;
+        }
+    }
+    return ret;
 }
 
 static const VMStateDescription *
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e7658ab0506..220059679ac 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -419,8 +419,13 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called before we save the state of one device.
 
-Example: You can look at hpet.c, that uses the three function to
-massage the state that is transferred.
+- ``int (*post_save)(void *opaque);``
+
+  This function is called after we save the state of one device
+  (even upon failure, unless the call to pre_save returned an error).
+
+Example: You can look at hpet.c, that uses the first three functions
+to massage the state that is transferred.
 
 The ``VMSTATE_WITH_TMP`` macro may be useful when the migration
 data doesn't match the stored device data well; it allows an
-- 
2.20.1
