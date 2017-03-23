Received: from eggs.gnu.org ([2001:4830:134:3::10]:49775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr0PL-0006rp-5e
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr0PH-0005ik-Sf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr0PH-0005iO-ME
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9226AC04B93D
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:55:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Mar 2017 11:55:47 +0100
Message-Id: <1490266548-22500-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-1-git-send-email-armbru@redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

BlockdevOptionsRbd member auth-supported is a list of struct
RbdAuthMethod, whose only member is enum RbdAuthSupport.  There is no
reason for wrapping the enum in a struct.  Delete the wrapper, and
rename the enum.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c          |  2 +-
 qapi/block-core.json | 15 ++-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 8ba0f79..f460d71 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -566,7 +566,7 @@ static char *rbd_auth(QDict *options)
     int i;
 
     for (i = 0;; i++) {
-        sprintf(keybuf, "auth-supported.%d.auth", i);
+        sprintf(keybuf, "auth-supported.%d", i);
         val = qdict_get(options, keybuf);
         if (!val) {
             break;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f132fc..fe1e40f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2601,25 +2601,14 @@
 
 
 ##
-# @RbdAuthSupport:
-#
-# An enumeration of RBD auth support
-#
-# Since: 2.9
-##
-{ 'enum': 'RbdAuthSupport',
-  'data': [ 'cephx', 'none' ] }
-
-
-##
 # @RbdAuthMethod:
 #
 # An enumeration of rados auth_supported types
 #
 # Since: 2.9
 ##
-{ 'struct': 'RbdAuthMethod',
-  'data': { 'auth': 'RbdAuthSupport' } }
+{ 'enum': 'RbdAuthMethod',
+  'data': [ 'cephx', 'none' ] }
 
 ##
 # @BlockdevOptionsRbd:
-- 
2.7.4
