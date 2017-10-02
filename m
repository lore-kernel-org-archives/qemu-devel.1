Received: from eggs.gnu.org ([2001:4830:134:3::10]:38677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007xm-Ot
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007uP-Ha
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bZ-0007td-C8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:29 +0200
Message-Id: <20171002152552.27999-10-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 09/32] qapi: check_type() parameter
 allow_optional is now unused, drop
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 208010c241..8f9c5666bd 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -629,8 +629,7 @@ def add_name(name, info, meta, implicit=False):
     all_names[name] = meta
 
 
-def check_type(info, source, value, allow_array=False,
-               allow_dict=False, allow_optional=False,
+def check_type(info, source, value, allow_array=False, allow_dict=False,
                allow_metas=[]):
     global all_names
 
@@ -686,7 +685,7 @@ def check_command(expr, info):
     if boxed:
         args_meta += ['union', 'alternate']
     check_type(info, "'data' for command '%s'" % name,
-               expr.get('data'), allow_dict=not boxed, allow_optional=True,
+               expr.get('data'), allow_dict=not boxed,
                allow_metas=args_meta)
     returns_meta = ['union', 'struct']
     if name in returns_whitelist:
@@ -704,8 +703,7 @@ def check_event(expr, info):
     if boxed:
         meta += ['union', 'alternate']
     check_type(info, "'data' for event '%s'" % name,
-               expr.get('data'), allow_dict=not boxed, allow_optional=True,
-               allow_metas=meta)
+               expr.get('data'), allow_dict=not boxed, allow_metas=meta)
 
 
 def check_union(expr, info):
@@ -728,8 +726,7 @@ def check_union(expr, info):
     else:
         # The object must have a string or dictionary 'base'.
         check_type(info, "'base' for union '%s'" % name,
-                   base, allow_dict=True, allow_optional=True,
-                   allow_metas=['struct'])
+                   base, allow_dict=True, allow_metas=['struct'])
         if not base:
             raise QAPISemError(info, "Flat union '%s' must have a base"
                                % name)
@@ -843,7 +840,7 @@ def check_struct(expr, info):
     members = expr['data']
 
     check_type(info, "'data' for struct '%s'" % name, members,
-               allow_dict=True, allow_optional=True)
+               allow_dict=True)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=['struct'])
 
-- 
2.13.6
