Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyht-0006fy-Lb
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyWm-0001Pd-Al
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gEyWm-0001Mw-0H
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:23:28 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 23 Oct 2018 17:23:01 +0200
Message-Id: <20181023152306.3123-3-david@redhat.com>
In-Reply-To: <20181023152306.3123-1-david@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/7] qapi: correctly parse uint64_t values
 from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Right now, we parse uint64_t values just like int64_t values, resulting
in negative values getting accepted and certain valid large numbers only
being representable as negative numbers. Also, reported errors indicate
that an int64_t is expected.

Parse uin64_t separately. We don't have to worry about ranges.

E.g. we can now also specify
    -device nvdimm,memdev=mem1,id=nv1,addr=0xFFFFFFFFC0000000
Instead of only going via negative values
    -device nvdimm,memdev=mem1,id=nv1,addr=-0x40000000

Resulting in the same values

(qemu) info memory-devices
Memory device [nvdimm]: "nv1"
  addr: 0xffffffffc0000000
  slot: 0
  node: 0

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/string-input-visitor.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index c1454f999f..f2df027325 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -247,15 +247,16 @@ error:
 static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                               Error **errp)
 {
-    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
-    int64_t i;
-    Error *err = NULL;
-    parse_type_int64(v, name, &i, &err);
-    if (err) {
-        error_propagate(errp, err);
-    } else {
-        *obj = i;
+    StringInputVisitor *siv = to_siv(v);
+    uint64_t val;
+
+    if (qemu_strtou64(siv->string, NULL, 0, &val)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
+                   "an uint64 value");
+        return;
     }
+
+    *obj = val;
 }
 
 static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
-- 
2.17.1
