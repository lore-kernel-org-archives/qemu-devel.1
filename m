Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0F-0002PK-Df
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw05-0002be-Tb
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpvzz-0002YI-DA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BC704219DCB
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:38:06 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:36 +0800
Message-Id: <20180815133747.25032-3-peterx@redhat.com>
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 02/13] qapi: Fix build_params() for empty
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
index 9230a2a3e8..6471c45233 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2067,16 +2067,14 @@ extern const QEnumLookup %(c_name)s_lookup;
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
@@ -2087,7 +2085,7 @@ def build_params(arg_type, boxed, extra):
                               c_name(memb.name))
     if extra:
         ret += sep + extra
-    return ret
+    return ret if ret else 'void'
 
 
 #
-- 
2.17.1
