Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E45C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA3220644
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA3220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2kf-00066f-Dk
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iB2dA-0005cB-5S
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iB2QA-00026x-Ci
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iB2Q8-00025e-Cl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66B2A18C8900
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 19:48:50 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88CF45D6D0;
 Thu, 19 Sep 2019 19:48:49 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com
Subject: [RFC 1/4] Add qapi for block error injection
Date: Thu, 19 Sep 2019 14:48:44 -0500
Message-Id: <20190919194847.18518-2-tasleson@redhat.com>
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 19 Sep 2019 19:48:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Proof of concept code to dynamically create/delete media errors
for block devices using the qapi interface.  This is useful for testing
the OS and the block and FS layers for error handling.  Utilizing this
in a VM allows it to be OS agnostic and test the OS at it's lowest levels
of hardware interaction.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 block/Makefile.objs  |   2 +-
 block/error_inject.c | 179 +++++++++++++++++++++++++++++++++++++++++++
 block/error_inject.h |  43 +++++++++++
 block/qapi.c         |  18 +++++
 qapi/block.json      |  36 +++++++++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 block/error_inject.c
 create mode 100644 block/error_inject.h

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 35f3bca4d9..c8fcbc276b 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,4 +1,4 @@
-block-obj-y +=3D raw-format.o vmdk.o vpc.o
+block-obj-y +=3D raw-format.o vmdk.o vpc.o error_inject.o
 block-obj-$(CONFIG_QCOW1) +=3D qcow.o
 block-obj-$(CONFIG_VDI) +=3D vdi.o
 block-obj-$(CONFIG_CLOOP) +=3D cloop.o
diff --git a/block/error_inject.c b/block/error_inject.c
new file mode 100644
index 0000000000..26a47dfb8c
--- /dev/null
+++ b/block/error_inject.c
@@ -0,0 +1,179 @@
+/*
+ * Error injection code for block devices
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "error_inject.h"
+
+#include <gmodule.h>
+
+#include "qemu/thread.h"
+
+static QemuMutex error_inject_lock;
+static GHashTable *error_inject_data;
+
+
+static void delete_lba_entries(void *entry)
+{
+    GSequence *e =3D (GSequence *) entry;
+    g_sequence_free(e);
+}
+
+struct value {
+    uint64_t error_lba;
+
+    /*
+     * TODO Actually do something with behavior
+     */
+    MediaErrorBehavior behavior;
+    /*
+     * TODO Add data for generating bitrot, when we do change free funct=
ion
+     */
+};
+
+static int key_compare(gconstpointer a, gconstpointer b, gpointer data)
+{
+    uint64_t left =3D ((struct value *)a)->error_lba;
+    uint64_t right =3D ((struct value *)b)->error_lba;
+
+    if (left < right) {
+        return -1;
+    } else if (left > right) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static uint64_t error_lba_get(GSequenceIter *iter)
+{
+    gpointer tmp =3D g_sequence_get(iter);
+    return ((struct value *)tmp)->error_lba;
+}
+
+void media_error_create(const char *device_id, uint64_t lba,
+                        MediaErrorBehavior behavior)
+{
+    qemu_mutex_lock(&error_inject_lock);
+
+    GSequence *block_device =3D g_hash_table_lookup(error_inject_data, d=
evice_id);
+    if (!block_device) {
+        block_device =3D g_sequence_new(g_free);
+        char *key =3D strdup(device_id);
+        g_hash_table_insert(error_inject_data, key, block_device);
+    }
+
+    struct value lookup =3D {lba, MEDIA_ERROR_BEHAVIOR__MAX};
+    if (!g_sequence_lookup(block_device, &lookup, key_compare, NULL)) {
+        struct value *val =3D g_new(struct value, 1);
+        val->error_lba =3D lba;
+        val->behavior =3D behavior;
+
+        g_sequence_insert_sorted(block_device, val, key_compare, NULL);
+    }
+
+    qemu_mutex_unlock(&error_inject_lock);
+}
+
+void media_error_delete(const char *device_id, uint64_t lba)
+{
+    qemu_mutex_lock(&error_inject_lock);
+
+    GSequence *block_device =3D g_hash_table_lookup(error_inject_data, d=
evice_id);
+    if (block_device) {
+        struct value find =3D { lba, MEDIA_ERROR_BEHAVIOR__MAX};
+        GSequenceIter *found =3D g_sequence_lookup(block_device, &find,
+                                                 key_compare, NULL);
+        if (found) {
+            g_sequence_remove(found);
+        }
+    }
+
+    qemu_mutex_unlock(&error_inject_lock);
+}
+
+int error_in_read(const char *device_id, uint64_t lba, uint64_t len,
+                  uint64_t *error_lba)
+{
+    uint64_t error_sector =3D 0;
+    const uint64_t transfer_end =3D lba + len;
+    int ec =3D 0;
+    *error_lba =3D 0xFFFFFFFFFFFFFFFF;
+
+    qemu_mutex_lock(&error_inject_lock);
+
+    GSequence *block_device =3D g_hash_table_lookup(error_inject_data, d=
evice_id);
+    if (block_device && g_sequence_get_length(block_device) !=3D 0) {
+        struct value find =3D {lba, MEDIA_ERROR_BEHAVIOR__MAX};
+        GSequenceIter *iter =3D g_sequence_search(block_device, &find,
+                                                key_compare, NULL);
+
+        /*
+         * g_sequence_seach returns where the item would be inserted.
+         * In the case of a direct match, it's spot is inserted after th=
e
+         * existing, thus we need to check the one immediately before
+         * the insertion point to see if it is the one we are looking fo=
r.
+         */
+        GSequenceIter *prev =3D g_sequence_iter_prev(iter);
+        error_sector =3D error_lba_get(prev);
+
+        if (error_sector >=3D lba && error_sector < transfer_end) {
+            *error_lba =3D error_sector;
+            ec =3D 1;
+        } else {
+            /*
+             * Lets look at next until we find one in our transfer or ba=
il
+             * if the error(s) logical block address are greater than th=
e
+             * end of our transfer.
+             */
+            while (!g_sequence_iter_is_end(iter)) {
+                error_sector =3D error_lba_get(iter);
+
+                if (error_sector >=3D transfer_end) {
+                    break;
+                }
+                if (error_sector >=3D lba && error_sector < transfer_end=
) {
+                    *error_lba =3D error_sector;
+                    ec =3D 1;
+                    break;
+                } else {
+                    iter =3D g_sequence_iter_next(iter);
+                }
+            }
+        }
+    }
+
+    qemu_mutex_unlock(&error_inject_lock);
+
+    return ec;
+}
+
+
+static void __attribute__((__constructor__)) error_inject_init(void)
+{
+    qemu_mutex_init(&error_inject_lock);
+
+    error_inject_data =3D g_hash_table_new_full(g_str_hash,
+                                              g_str_equal,
+                                              g_free,
+                                              delete_lba_entries);
+}
diff --git a/block/error_inject.h b/block/error_inject.h
new file mode 100644
index 0000000000..5f2d143c90
--- /dev/null
+++ b/block/error_inject.h
@@ -0,0 +1,43 @@
+/*
+ * Error injection code for block devices
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#ifndef ERROR_INJECT
+#define ERROR_INJECT
+#include "qemu/osdep.h"
+
+#include <stdint.h>
+
+#include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-types-block.h"
+
+
+void media_error_create(const char *device_id, uint64_t lba,
+                        MediaErrorBehavior behavior);
+void media_error_delete(const char *device_id, uint64_t lba);
+
+
+int error_in_read(const char *device_id, uint64_t lba, uint64_t len,
+                  uint64_t *error_lba);
+
+#endif
diff --git a/block/qapi.c b/block/qapi.c
index 15f1030264..d66201a831 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -26,11 +26,14 @@
 #include "qemu-common.h"
 #include "block/qapi.h"
 #include "block/block_int.h"
+#include "block/error_inject.h"
 #include "block/throttle-groups.h"
 #include "block/write-threshold.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qobject-output-visitor.h"
+#include "qapi/qapi-types-block.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
@@ -841,3 +844,18 @@ void bdrv_image_info_dump(ImageInfo *info)
         bdrv_image_info_specific_dump(info->format_specific);
     }
 }
+
+void qmp_media_error_create(const char *device_id, uint64_t lba,
+        MediaErrorBehavior behavior, Error **errp)
+{
+    /*
+     * We could validate the device_id and lba for existence and range, =
but we
+     * want to be able to add entries before a device is hot plugged too=
.
+     */
+    media_error_create(device_id, lba, behavior);
+}
+
+void qmp_media_error_delete(const char *device_id, uint64_t lba, Error *=
*errp)
+{
+    media_error_delete(device_id, lba);
+}
diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb6..2b11954b44 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -453,3 +453,39 @@
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
             'sector-num': 'int', 'sectors-count': 'int' } }
+
+##
+# @MediaErrorBehavior:
+#
+# Enumerated type for classifying type of read error behavior.
+#
+##
+{ 'enum': 'MediaErrorBehavior', 'data': ['hard', 'fixed_on_write', 'flak=
ey'] }
+
+##
+# @media-error-create:
+#
+# Example:
+# -> {"execute": "media-error-create",
+#     "arguments": {"device_id": "12345678, "lba" : 10000, "behavior" : =
"hard"}}
+# <- { "return": {} }
+#
+# Create a synthetic media error for the specified logical block address=
 when
+# it is read by the guest OS.
+#
+##
+{ 'command':'media-error-create',
+  'data': {'device_id': 'str', 'lba': 'uint64', 'behavior': 'MediaErrorB=
ehavior'}}
+
+##
+# @media-error-delete:
+#
+# Delete a synthetic media error for the specified logical block address=
.
+#
+# # Example:
+# -> {"execute": "media-error-delete",
+#     "arguments": {"device_id": "01020304", "lba" : 10000}
+# <- { "return": {} }
+##
+{ 'command':'media-error-delete',
+  'data': {'device_id': 'str', 'lba': 'uint64'}}
--=20
2.21.0


