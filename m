Received: from eggs.gnu.org ([2001:4830:134:3::10]:51513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSb-0007Za-Up
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSa-0004mp-U4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:29 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:14 +0000
Message-ID: <20181205134243.4791-2-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 01/14] migration: Add post_save function to
 VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <aclindsa@gmail.com>

In some cases it may be helpful to modify state before saving it for
migration, and then modify the state back after it has been saved. The
existing pre_save function provides half of this functionality. This
patch adds a post_save function to provide the second half.

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/migration.rst    |  9 +++++++--
 include/migration/vmstate.h |  1 +
 migration/vmstate.c         | 13 ++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e7658ab050..220059679a 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -419,8 +419,13 @@ The functions to do that are inside a vmstate definiti=
on, and are called:
=20
   This function is called before we save the state of one device.
=20
-Example: You can look at hpet.c, that uses the three function to
-massage the state that is transferred.
+- ``int (*post_save)(void *opaque);``
+
+  This function is called after we save the state of one device
+  (even upon failure, unless the call to pre_save returned an error).
+
+Example: You can look at hpet.c, that uses the first three functions
+to massage the state that is transferred.
=20
 The ``VMSTATE_WITH_TMP`` macro may be useful when the migration
 data doesn't match the stored device data well; it allows an
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 61bef3ef5c..067b126cf1 100644
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
index 80b59009aa..e2bbb7b5f7 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -390,6 +390,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDesc=
ription *vmsd,
                 if (ret) {
                     error_report("Save of field %s/%s failed",
                                  vmsd->name, field->name);
+                    if (vmsd->post_save) {
+                        vmsd->post_save(opaque);
+                    }
                     return ret;
                 }
=20
@@ -415,7 +418,15 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDes=
cription *vmsd,
         json_end_array(vmdesc);
     }
=20
-    return vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+    ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+
+    if (vmsd->post_save) {
+        int ps_ret =3D vmsd->post_save(opaque);
+        if (!ret) {
+            ret =3D ps_ret;
+        }
+    }
+    return ret;
 }
=20
 static const VMStateDescription *
--=20
2.19.1
