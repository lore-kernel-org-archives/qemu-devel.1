Received: from eggs.gnu.org ([208.118.235.92]:52014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjh-0007Jg-Hm
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjg-0001PV-Nb
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjg-0001Jv-Hn
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so18059286wmh.0
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:32 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:37 +0100
Message-Id: <5ffd8b7b6fefbc3c2c4fb074f3083ffbdc946d20.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/52] qapi: support alternates in
 OptsVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

They are required for flat unions (you still have to allocate the
structs).

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 include/qapi/opts-visitor.h |  7 +++----
 qapi/opts-visitor.c         | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qapi/opts-visitor.h b/include/qapi/opts-visitor.h
index 9b989e7e08..ca044e3b33 100644
--- a/include/qapi/opts-visitor.h
+++ b/include/qapi/opts-visitor.h
@@ -29,10 +29,9 @@ typedef struct OptsVisitor OptsVisitor;
  * - values below INT64_MIN or LLONG_MIN are rejected,
  * - values above INT64_MAX or LLONG_MAX are rejected.
  *
- * The Opts input visitor does not implement support for visiting QAPI
- * alternates, numbers (other than integers), null, or arbitrary
- * QTypes.  It also requires a non-null list argument to
- * visit_start_list().
+ * The Opts input visitor does not implement support for visiting numbers
+ * (other than integers), null, or arbitrary QTypes. It also requires a
+ * non-null list argument to visit_start_list().
  */
 Visitor *opts_visitor_new(const QemuOpts *opts);
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197495..4af6043b75 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -156,6 +156,13 @@ opts_start_struct(Visitor *v, const char *name, void **obj,
     }
 }
 
+static void
+opts_start_alternate(Visitor *v, const char *name, GenericAlternate **obj,
+                     size_t size, Error **errp)
+{
+    opts_start_struct(v, name, (void **)obj, size, errp);
+}
+
 
 static void
 opts_check_struct(Visitor *v, Error **errp)
@@ -198,6 +205,12 @@ opts_end_struct(Visitor *v, void **obj)
     ov->fake_id_opt = NULL;
 }
 
+static void
+opts_end_alternate(Visitor *v, void **obj)
+{
+    opts_end_struct(v, obj);
+}
+
 
 static GQueue *
 lookup_distinct(const OptsVisitor *ov, const char *name, Error **errp)
@@ -547,6 +560,9 @@ opts_visitor_new(const QemuOpts *opts)
     ov->visitor.check_struct = &opts_check_struct;
     ov->visitor.end_struct   = &opts_end_struct;
 
+    ov->visitor.start_alternate = &opts_start_alternate;
+    ov->visitor.end_alternate = &opts_end_alternate;
+
     ov->visitor.start_list = &opts_start_list;
     ov->visitor.next_list  = &opts_next_list;
     ov->visitor.check_list = &opts_check_list;
-- 
2.20.1
