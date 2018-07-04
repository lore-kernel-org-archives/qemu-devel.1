Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPc-0001CR-VX
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPb-0005kT-W0
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadPb-0005kN-RH
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FF5281A4EAD
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 08:45:19 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 16:45:00 +0800
Message-Id: <20180704084507.14560-3-peterx@redhat.com>
In-Reply-To: <20180704084507.14560-1-peterx@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/9] qapi: allow build_params to return "void"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

When there is no parameter at all for a function prototype, return
"void" for the parameter list.  This will happen after the next patch
where we removed the Error* for some of the emit functions.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8b6708dbf1..105c82742f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1963,7 +1963,7 @@ extern const QEnumLookup %(c_name)s_lookup;
 def build_params(arg_type, boxed, extra):
     if not arg_type:
         assert not boxed
-        return extra
+        return extra if extra else "void"
     ret = ''
     sep = ''
     if boxed:
@@ -1980,7 +1980,7 @@ def build_params(arg_type, boxed, extra):
                               c_name(memb.name))
     if extra:
         ret += sep + extra
-    return ret
+    return ret if ret else "void"
 
 
 #
-- 
2.17.1
