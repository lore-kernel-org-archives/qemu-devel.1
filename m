Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgX6-0006B4-57
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgX4-0000Cy-68
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgX4-0000CV-1K
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D97B2634A
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:09 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:43 +0800
Message-Id: <20180903043149.4076-2-peterx@redhat.com>
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 1/7] qapi: Fix build_params() for empty
 parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

From: Markus Armbruster <armbru@redhat.com>

build_params() returns '' instead of 'void' when there are no
parameters.  Can't happen now, but the next commit will change that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
[peterx: compose the patch from email replies]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qapi/common.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 02c5c6767a..3b0d4bf9c0 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2070,16 +2070,14 @@ extern const QEnumLookup %(c_name)s_lookup;
     return ret
 
 
-def build_params(arg_type, boxed, extra):
-    if not arg_type:
-        assert not boxed
-        return extra
+def build_params(arg_type, boxed, extra=None):
     ret = ''
     sep = ''
     if boxed:
+        assert arg_type
         ret += '%s arg' % arg_type.c_param_type()
         sep = ', '
-    else:
+    elif arg_type:
         assert not arg_type.variants
         for memb in arg_type.members:
             ret += sep
@@ -2090,7 +2088,7 @@ def build_params(arg_type, boxed, extra):
                               c_name(memb.name))
     if extra:
         ret += sep + extra
-    return ret
+    return ret if ret else 'void'
 
 
 #
-- 
2.17.1
