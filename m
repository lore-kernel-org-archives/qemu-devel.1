Received: from eggs.gnu.org ([2001:4830:134:3::10]:56378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic3-000267-1O
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008KD-Ah
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ibz-0008Ie-VV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F050961E53
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA8AB77559
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:52 +0200
Message-Id: <1493911445-19568-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/28] qapi: New QAPI_CLONE_MEMBERS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QAPI_CLONE() returns a newly allocated QAPI object.  Inconvenient when
we want to clone into an existing object.  QAPI_CLONE_MEMBERS() does
exactly that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-4-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/clone-visitor.h | 14 ++++++++++++++
 qapi/qapi-clone-visitor.c    | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index b16177e..a4915c7 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -24,6 +24,9 @@ typedef struct QapiCloneVisitor QapiCloneVisitor;
 
 void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
                                                      void **, Error **));
+void qapi_clone_members(void *dst, const void *src, size_t sz,
+                        void (*visit_type_members)(Visitor *, void *,
+                                                   Error **));
 
 /*
  * Deep-clone QAPI object @src of the given @type, and return the result.
@@ -36,4 +39,15 @@ void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
                         (void (*)(Visitor *, const char *, void**,      \
                                   Error **))visit_type_ ## type))
 
+/*
+ * Copy deep clones of @type members from @src to @dst.
+ *
+ * Not usable on QAPI scalars (integers, strings, enums), nor on a
+ * QAPI object that references the 'any' type.
+ */
+#define QAPI_CLONE_MEMBERS(type, dst, src)                              \
+    qapi_clone_members(dst, src, sizeof(type),                          \
+                       (void (*)(Visitor *, void *,                     \
+                                 Error **))visit_type_ ## type ## _members)
+
 #endif
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 34086cb..de756bf 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -180,3 +180,16 @@ void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
     visit_free(v);
     return dst;
 }
+
+void qapi_clone_members(void *dst, const void *src, size_t sz,
+                        void (*visit_type_members)(Visitor *, void *,
+                                                   Error **))
+{
+    Visitor *v;
+
+    v = qapi_clone_visitor_new();
+    memcpy(dst, src, sz);
+    to_qcv(v)->depth++;
+    visit_type_members(v, dst, &error_abort);
+    visit_free(v);
+}
-- 
2.7.4
