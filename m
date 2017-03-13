Received: from eggs.gnu.org ([2001:4830:134:3::10]:52216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0007Xn-Tf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJk-0003ZQ-CA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJk-0003Y2-52
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:13 +0100
Message-Id: <1489385927-6735-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 13/47] qapi: Fix
 QAPISchemaEnumType.is_implicit() for 'QType'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Missed in commit 7264f5c.  Harmless, because nothing checks whether an
enumeration type is implicit so far.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e6d023f..7a2b6ab 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1148,8 +1148,8 @@ class QAPISchemaEnumType(QAPISchemaType):
             v.check_clash(self.info, seen)
 
     def is_implicit(self):
-        # See QAPISchema._make_implicit_enum_type()
-        return self.name.endswith('Kind')
+        # See QAPISchema._make_implicit_enum_type() and ._def_predefineds()
+        return self.name.endswith('Kind') or self.name == 'QType'
 
     def c_type(self):
         return c_name(self.name)
-- 
2.7.4
