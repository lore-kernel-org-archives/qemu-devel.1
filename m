Received: from eggs.gnu.org ([2001:4830:134:3::10]:44517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqt-00007a-VC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqt-0005O4-4b
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 13:55:47 +0100
Message-Id: <1490014548-15083-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-1-git-send-email-armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 4/5] keyval: Document issues with 'any'
 and alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/keyval.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/util/keyval.c b/util/keyval.c
index 46cd540..93d5db6 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -61,6 +61,16 @@
  * "key absent" already means "optional object/array absent", which
  * isn't the same as "empty object/array present".
  *
+ * Design flaw: scalar values can only be strings; there is no way to
+ * denote numbers, true, false or null.  The special QObject input
+ * visitor returned by qobject_input_visitor_new_keyval() mostly hides
+ * this by automatically converting strings to the type the visitor
+ * expects.  Breaks down for alternate types and type 'any', where the
+ * visitor's expectation isn't clear.  Code visiting such types needs
+ * to do the conversion itself, but only when using this keyval
+ * visitor.  Awkward.  Alternate types without a string member don't
+ * work at all.
+ *
  * Additional syntax for use with an implied key:
  *
  *   key-vals-ik  = val-no-key [ ',' key-vals ]
-- 
2.7.4
