Received: from eggs.gnu.org ([2001:4830:134:3::10]:54831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtV-000684-FL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00076p-PF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-00073G-J1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8260A8124A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E5E953CC1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:46 +0100
Message-Id: <1489645685-4750-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 30/49] qapi2texi: Generate descriptions
 for simple union tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Simple union tags carry no type information, because their type is
implicit.  Their description should make up for it, but many have
none.  Generate one automatically then.

Example change (qemu-qmp-ref.txt):

  -- Simple Union: ImageInfoSpecific

      A discriminated record of image format specific information
      structures.

      Members:
      'type'
-          Not documented
+          One of "qcow2", "vmdk", "luks"
      'data: ImageInfoSpecificQCow2' when 'type' is "qcow2"
      'data: ImageInfoSpecificVmdk' when 'type' is "vmdk"
      'data: QCryptoBlockInfoLUKS' when 'type' is "luks"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-29-git-send-email-armbru@redhat.com>
---
 scripts/qapi2texi.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index ab6b6cd..282adf4 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -148,11 +148,16 @@ def texi_members(doc, what, base, variants, member_func):
     """Format the table of members"""
     items = ''
     for section in doc.args.itervalues():
+        # TODO Drop fallbacks when undocumented members are outlawed
         if section.content:
-            desc = str(section)
+            desc = texi_format(str(section))
+        elif (variants and variants.tag_member == section.member
+              and not section.member.type.doc_type()):
+            values = section.member.type.member_names()
+            desc = 'One of ' + ', '.join(['@t{"%s"}' % v for v in values])
         else:
             desc = 'Not documented'
-        items += member_func(section.member) + texi_format(desc) + '\n'
+        items += member_func(section.member) + desc + '\n'
     if base:
         items += '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
-- 
2.7.4
