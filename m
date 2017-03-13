Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJo-0007Yk-H0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0003bn-Md
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJl-0003Zn-79
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:22 +0100
Message-Id: <1489385927-6735-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 22/47] qapi2texi: Explain enum value
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

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
