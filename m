Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007z1-9m
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bX-0007t1-TF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bX-0007sJ-Lo
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:28 +0200
Message-Id: <20171002152552.27999-9-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/32] qapi: Simplify check_name()
 parameters
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

Replace flags @enum_member, @allow_optional by string @meta:
'member-enum' implies @enum_member, 'member-struct' implies
@allow_optional.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 248af89b0b..208010c241 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -593,8 +593,7 @@ valid_name = re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
                         '[a-zA-Z][a-zA-Z0-9_-]*$')
 
 
-def check_name(info, source, name, allow_optional=False,
-               enum_member=False):
+def check_name(info, source, name, meta):
     global valid_name
     membername = name
 
@@ -602,12 +601,12 @@ def check_name(info, source, name, allow_optional=False,
         raise QAPISemError(info, "%s requires a string name" % source)
     if name.startswith('*'):
         membername = name[1:]
-        if not allow_optional:
+        if meta != 'member-struct':
             raise QAPISemError(info, "%s does not allow optional name '%s'"
                                % (source, name))
     # Enum members can start with a digit, because the generated C
     # code always prefixes it with the enum name
-    if enum_member and membername[0].isdigit():
+    if meta == 'member-enum' and membername[0].isdigit():
         membername = 'D' + membername
     # Reserve the entire 'q_' namespace for c_name(), and for 'q_empty'
     # and 'q_obj_*' implicit type names.
@@ -618,7 +617,7 @@ def check_name(info, source, name, allow_optional=False,
 
 def add_name(name, info, meta, implicit=False):
     global all_names
-    check_name(info, "'%s'" % meta, name)
+    check_name(info, "'%s'" % meta, name, meta)
     # FIXME should reject names that differ only in '_' vs. '.'
     # vs. '-', because they're liable to clash in generated C.
     if name in all_names:
@@ -667,8 +666,7 @@ def check_type(info, source, value, allow_array=False,
 
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name(info, "Member of %s" % source, key,
-                   allow_optional=allow_optional)
+        check_name(info, "Member of %s" % source, key, 'member-struct')
         if c_name(key, False) == 'u' or c_name(key, False).startswith('has_'):
             raise QAPISemError(info, "Member of %s uses reserved name '%s'"
                                % (source, key))
@@ -741,7 +739,7 @@ def check_union(expr, info):
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
         check_name(info, "Discriminator of flat union '%s'" % name,
-                   discriminator)
+                   discriminator, 'member-union')
         discriminator_type = base_members.get(discriminator)
         if not discriminator_type:
             raise QAPISemError(info,
@@ -760,7 +758,7 @@ def check_union(expr, info):
     if len(members) == 0:
         raise QAPISemError(info, "Union '%s' cannot have empty 'data'" % name)
     for (key, value) in members.items():
-        check_name(info, "Member of union '%s'" % name, key)
+        check_name(info, "Member of union '%s'" % name, key, 'member-union')
 
         # Each value must name a known type
         check_type(info, "Member '%s' of union '%s'" % (key, name),
@@ -794,7 +792,8 @@ def check_alternate(expr, info):
                            "Alternate '%s' should have at least two branches "
                            "in 'data'" % name)
     for (key, value) in members.items():
-        check_name(info, "Member of alternate '%s'" % name, key)
+        check_name(info, "Member of alternate '%s'" % name, key,
+                   'member-alternate')
 
         # Ensure alternates have no type conflicts.
         check_type(info, "Member '%s' of alternate '%s'" % (key, name),
@@ -836,8 +835,7 @@ def check_enum(expr, info):
         raise QAPISemError(info,
                            "Enum '%s' requires a string for 'prefix'" % name)
     for member in members:
-        check_name(info, "Member of enum '%s'" % name, member,
-                   enum_member=True)
+        check_name(info, "Member of enum '%s'" % name, member, 'member-enum')
 
 
 def check_struct(expr, info):
-- 
2.13.6
