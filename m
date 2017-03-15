Received: from eggs.gnu.org ([2001:4830:134:3::10]:33356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0001VG-7E
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Up-0000IP-68
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uo-0000HM-U3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:43 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:02 +0100
Message-Id: <1489582656-31133-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 13/47] qapi: Fix
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index fb10d93..dd083b7 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1152,8 +1152,8 @@ class QAPISchemaEnumType(QAPISchemaType):
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
