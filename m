Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtV-00067v-7v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00076c-Oe
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-000721-HZ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C810437F44
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA7BE5C541
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:40 +0100
Message-Id: <1489645685-4750-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 24/49] qapi2texi: Explain enum value
 undocumentedness more clearly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of not saying anything when we have no documentation, say "Not
documented".

Example change (qemu-qmp-ref.txt):

  -- Enum: GuestPanicAction

      An enumeration of the actions taken when guest OS panic is detected

      Values:
      'pause'
           system pauses
      'poweroff'
+          Not documented

      Since: 2.1 (poweroff since 2.8)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-23-git-send-email-armbru@redhat.com>
---
 scripts/qapi2texi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 35e182d..1f01817 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -145,7 +145,10 @@ def texi_members(doc, what, member_func, show_undocumented):
     for section in doc.args.itervalues():
         if not section.content and not show_undocumented:
             continue          # Undocumented TODO require doc and drop
-        desc = str(section)
+        if section.content:
+            desc = str(section)
+        else:
+            desc = 'Not documented'
         items += member_func(section.member) + texi_format(desc) + '\n'
     if not items:
         return ''
-- 
2.7.4
