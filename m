Received: from eggs.gnu.org ([2001:4830:134:3::10]:37093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilo-0006Wj-4h
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilj-0001iL-TF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqilj-0001hO-LA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07A207F748
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C534F800C8
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:33 +0100
Message-Id: <1490198748-4753-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 02/17] keyval: Improve some comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490014548-15083-3-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/keyval.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/util/keyval.c b/util/keyval.c
index f646b36..46cd540 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -21,22 +21,36 @@
  *
  * Semantics defined by reduction to JSON:
  *
- *   key-vals is a tree of objects and arrays rooted at object R
- *   where for each key-val = key-fragment . ... = val in key-vals
- *       R op key-fragment op ... = val'
- *       where (left-associative) op is
- *                 array subscript L[key-fragment] for numeric key-fragment
- *                 member reference L.key-fragment otherwise
- *             val' is val with ',,' replaced by ','
- *   and only R may be empty.
+ *   key-vals specifies a JSON object, i.e. a tree whose root is an
+ *   object, inner nodes other than the root are objects or arrays,
+ *   and leaves are strings.
  *
- *   Duplicate keys are permitted; all but the last one are ignored.
+ *   Each key-val = key-fragment '.' ... '=' val specifies a path from
+ *   root to a leaf (left of '='), and the leaf's value (right of
+ *   '=').
  *
- *   The equations must have a solution.  Counter-example: a.b=1,a=2
- *   doesn't have one, because R.a must be an object to satisfy a.b=1
- *   and a string to satisfy a=2.
+ *   A path from the root is defined recursively:
+ *       L '.' key-fragment is a child of the node denoted by path L
+ *       key-fragment is a child of the tree root
+ *   If key-fragment is numeric, the parent is an array and the child
+ *   is its key-fragment-th member, counting from zero.
+ *   Else, the parent is an object, and the child is its member named
+ *   key-fragment.
  *
- * Key-fragments must be valid QAPI names or consist only of digits.
+ *   This constrains inner nodes to be either array or object.  The
+ *   constraints must be satisfiable.  Counter-example: a.b=1,a=2 is
+ *   not, because root.a must be an object to satisfy a.b=1 and a
+ *   string to satisfy a=2.
+ *
+ *   Array subscripts can occur in any order, but the set of
+ *   subscripts must not have gaps.  For instance, a.1=v is not okay,
+ *   because root.a[0] is missing.
+ *
+ *   If multiple key-val denote the same leaf, the last one determines
+ *   the value.
+ *
+ * Key-fragments must be valid QAPI names or consist only of decimal
+ * digits.
  *
  * The length of any key-fragment must be between 1 and 127.
  *
@@ -64,8 +78,8 @@
 
 /*
  * Convert @key to a list index.
- * Convert all leading digits to a (non-negative) number, capped at
- * INT_MAX.
+ * Convert all leading decimal digits to a (non-negative) number,
+ * capped at INT_MAX.
  * If @end is non-null, assign a pointer to the first character after
  * the number to *@end.
  * Else, fail if any characters follow.
@@ -337,7 +351,8 @@ static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
     }
 
     /*
-     * Make a list from @elt[], reporting any missing elements.
+     * Make a list from @elt[], reporting the first missing element,
+     * if any.
      * If we dropped an index >= nelt in the previous loop, this loop
      * will run into the sentinel and report index @nelt missing.
      */
-- 
2.7.4
