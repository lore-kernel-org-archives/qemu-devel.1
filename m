Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhw-0001Z4-9y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXht-0001Z5-LN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:34 +0200
Message-Id: <20180614191443.14361-10-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/18] block: Make remaining uses of qobject
 input visitor more robust
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Remaining uses of qobject_input_visitor_new_keyval() in the block
subsystem:

* block_crypto_create_opts_init()
  Currently doesn't visit any non-string scalars, thus safe.  It's
  called from
  - block_crypto_open_luks()
    Creates the QDict with qemu_opts_to_qdict_filtered(), which
    creates only string scalars, but has a TODO asking for other types.
  - qcow_open()
  - qcow2_open(), qcow2_co_invalidate_cache(), qcow2_reopen_prepare()

* block_crypto_create_opts_init(), called from
  - block_crypto_co_create_opts_luks()
    Also creates the QDict with qemu_opts_to_qdict_filtered().

* vdi_co_create_opts()
  Also creates the QDict with qemu_opts_to_qdict_filtered().

Replace these uses by qobject_input_visitor_new_flat_confused() for
robustness.  This adds crumpling.  Right now, that's a no-op, but if
we ever extend these things in non-flat ways, crumpling will be
needed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/crypto.c | 12 +++++++++---
 block/vdi.c    |  8 ++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index bc322b50f5..82091c5f70 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -21,11 +21,11 @@
 #include "qemu/osdep.h"
 
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-crypto.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
 #include "qemu/option.h"
@@ -159,7 +159,10 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
     ret = g_new0(QCryptoBlockOpenOptions, 1);
     ret->format = format;
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
+    v = qobject_input_visitor_new_flat_confused(opts, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
@@ -210,7 +213,10 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
     ret = g_new0(QCryptoBlockCreateOptions, 1);
     ret->format = format;
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
+    v = qobject_input_visitor_new_flat_confused(opts, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
diff --git a/block/vdi.c b/block/vdi.c
index 668af0a828..1d8ed67dbf 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -51,10 +51,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -934,7 +934,11 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     }
 
     /* Get the QAPI object */
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
+        ret = -EINVAL;
+        goto done;
+    }
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
-- 
2.17.1
