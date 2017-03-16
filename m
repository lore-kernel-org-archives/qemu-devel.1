Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00066w-Nx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00073d-5D
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtP-00071u-W1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1244515561
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1FC1176A4
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:31 +0100
Message-Id: <1489645685-4750-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 15/49] qapi: Fix
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

Missed in commit 7264f5c.  Harmless, because nothing checks whether an
enumeration type is implicit so far.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-14-git-send-email-armbru@redhat.com>
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
