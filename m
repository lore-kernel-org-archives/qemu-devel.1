Received: from eggs.gnu.org ([2001:4830:134:3::10]:52577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007tW-Fy
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN5-0001Ja-7t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN5-0001Ix-2N
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAB3F3D944
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A824D7EFEF
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:15 +0100
Message-Id: <1490204908-26567-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 for-2.9 04/17] keyval: Document issues with
 'any' and alternate types
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
Message-Id: <1490014548-15083-5-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
