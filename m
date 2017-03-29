Received: from eggs.gnu.org ([2001:4830:134:3::10]:44771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV6-0001xE-9P
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV4-000089-W1
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJV4-00007m-Oq
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AF27E9EE
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:42 -0300
Message-Id: <20170329194148.19015-4-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/9] qom: QUALIFIED_CAST helper macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The new helper will help us write macros that keep const-ness of
the input arguments, using C11's _Generic keyword.

If _Generic is not supported by the compiler, QUALIFIED_CAST
becomes a regular non-const cast.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index cd0f412ce9..6829735f99 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -474,6 +474,52 @@ struct TypeInfo
     ((Object *)(obj))
 
 /**
+ * REFERENCED_TYPE:
+ * @t: a pointer type
+ *
+ * Returns the referenced type of a pointer type.
+ */
+#define REFERENCED_TYPE(t) \
+    typeof(*((t)0))
+
+/**
+ * QUALIFIED_CAST:
+ * @orig_type: Original type (a pointer type)
+ * @type: A pointer type to which an expression will be cast to.
+ *
+ * Helper to cast an expression to another pointer type while
+ * keeping the 'const' qualifier if it was present in
+ * @orig_type. If the compiler doesn't support _Generic, it
+ * becomes a regular non-const cast.
+ *
+ * Usage examples:
+ *   QUALIFIED_CAST(AType *, BType *)(expr)
+ *     equivalent to (BType *)(expr)
+ *
+ *   QUALIFIED_CAST(const AType *, BType *)(expr)
+ *     If supported, equivalent to: (const BType *)(expr)
+ *     otherwise, equivalent to:          (BType *)(expr)
+ *
+ *   AType *a;
+ *   QUALIFIED_CAST(typeof(a), BType *)(b)
+ *     equivalent to (BType *)(b)
+ *
+ *   const AType *a;
+ *   QUALIFIED_CAST(typeof(a), BType *)(b)
+ *     If supported, equivalent to: (const BType *)(expr)
+ *     otherwise, equivalent to:          (BType *)(expr)
+ */
+#ifdef HAVE_C11_GENERIC
+#define QUALIFIED_CAST(orig_type, type)                     \
+    (typeof(_Generic((const REFERENCED_TYPE(orig_type) *)0, \
+                     orig_type: (const type)(0),            \
+                     default:   (type)(0))))
+#else
+#define QUALIFIED_CAST(orig_type, type) \
+    (type)
+#endif
+
+/**
  * OBJECT_CLASS:
  * @class: A derivative of #ObjectClass.
  *
-- 
2.11.0.259.g40922b1
