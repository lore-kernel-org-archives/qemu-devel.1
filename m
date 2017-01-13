Received: from eggs.gnu.org ([2001:4830:134:3::10]:59772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33H-0003Qz-La
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33E-0006Wp-M1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33E-0006VA-Ab
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 736347F6A4
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:25 +0100
Message-Id: <20170113144135.5150-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 11/21] qapi: rework qapi Exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use a base class QAPIError, and QAPIParseError for parser errors and
QAPISemError for semantic errors, suggested by Markus Armbruster.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 334 ++++++++++++++++++++++++++------------------------=
------
 1 file changed, 156 insertions(+), 178 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 21bc32fda3..1483ec09f5 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -91,35 +91,38 @@ def error_path(parent):
     return res
=20
=20
-class QAPISchemaError(Exception):
-    def __init__(self, schema, msg):
+class QAPIError(Exception):
+    def __init__(self, fname, line, col, incl_info, msg):
         Exception.__init__(self)
-        self.fname =3D schema.fname
+        self.fname =3D fname
+        self.line =3D line
+        self.col =3D col
+        self.info =3D incl_info
         self.msg =3D msg
-        self.col =3D 1
-        self.line =3D schema.line
-        for ch in schema.src[schema.line_pos:schema.pos]:
-            if ch =3D=3D '\t':
-                self.col =3D (self.col + 7) % 8 + 1
-            else:
-                self.col +=3D 1
-        self.info =3D schema.incl_info
=20
     def __str__(self):
-        return error_path(self.info) + \
-            "%s:%d:%d: %s" % (self.fname, self.line, self.col, self.msg)
+        loc =3D "%s:%d" % (self.fname, self.line)
+        if self.col is not None:
+            loc +=3D ":%s" % self.col
+        return error_path(self.info) + "%s: %s" % (loc, self.msg)
=20
=20
-class QAPIExprError(Exception):
-    def __init__(self, expr_info, msg):
-        Exception.__init__(self)
-        assert expr_info
-        self.info =3D expr_info
-        self.msg =3D msg
+class QAPIParseError(QAPIError):
+    def __init__(self, parser, msg):
+        col =3D 1
+        for ch in parser.src[parser.line_pos:parser.pos]:
+            if ch =3D=3D '\t':
+                col =3D (col + 7) % 8 + 1
+            else:
+                col +=3D 1
+        QAPIError.__init__(self, parser.fname, parser.line, col,
+                           parser.incl_info, msg)
=20
-    def __str__(self):
-        return error_path(self.info['parent']) + \
-            "%s:%d: %s" % (self.info['file'], self.info['line'], self.ms=
g)
+
+class QAPISemError(QAPIError):
+    def __init__(self, info, msg):
+        QAPIError.__init__(self, info['file'], info['line'], None,
+                           info['parent'], msg)
=20
=20
 class QAPISchemaParser(object):
@@ -140,25 +143,24 @@ class QAPISchemaParser(object):
         self.accept()
=20
         while self.tok is not None:
-            expr_info =3D {'file': fname, 'line': self.line,
-                         'parent': self.incl_info}
+            info =3D {'file': fname, 'line': self.line,
+                    'parent': self.incl_info}
             expr =3D self.get_expr(False)
             if isinstance(expr, dict) and "include" in expr:
                 if len(expr) !=3D 1:
-                    raise QAPIExprError(expr_info,
-                                        "Invalid 'include' directive")
+                    raise QAPISemError(info, "Invalid 'include' directiv=
e")
                 include =3D expr["include"]
                 if not isinstance(include, str):
-                    raise QAPIExprError(expr_info,
-                                        "Value of 'include' must be a st=
ring")
+                    raise QAPISemError(info,
+                                       "Value of 'include' must be a str=
ing")
                 incl_abs_fname =3D os.path.join(os.path.dirname(abs_fnam=
e),
                                               include)
                 # catch inclusion cycle
-                inf =3D expr_info
+                inf =3D info
                 while inf:
                     if incl_abs_fname =3D=3D os.path.abspath(inf['file']=
):
-                        raise QAPIExprError(expr_info, "Inclusion loop f=
or %s"
-                                            % include)
+                        raise QAPISemError(info, "Inclusion loop for %s"
+                                           % include)
                     inf =3D inf['parent']
                 # skip multiple include of the same file
                 if incl_abs_fname in previously_included:
@@ -166,14 +168,13 @@ class QAPISchemaParser(object):
                 try:
                     fobj =3D open(incl_abs_fname, 'r')
                 except IOError as e:
-                    raise QAPIExprError(expr_info,
-                                        '%s: %s' % (e.strerror, include)=
)
+                    raise QAPISemError(info, '%s: %s' % (e.strerror, inc=
lude))
                 exprs_include =3D QAPISchemaParser(fobj, previously_incl=
uded,
-                                                 expr_info)
+                                                 info)
                 self.exprs.extend(exprs_include.exprs)
             else:
                 expr_elem =3D {'expr': expr,
-                             'info': expr_info}
+                             'info': info}
                 self.exprs.append(expr_elem)
=20
     def accept(self):
@@ -194,8 +195,7 @@ class QAPISchemaParser(object):
                     ch =3D self.src[self.cursor]
                     self.cursor +=3D 1
                     if ch =3D=3D '\n':
-                        raise QAPISchemaError(self,
-                                              'Missing terminating "\'"'=
)
+                        raise QAPIParseError(self, 'Missing terminating =
"\'"')
                     if esc:
                         if ch =3D=3D 'b':
                             string +=3D '\b'
@@ -213,25 +213,25 @@ class QAPISchemaParser(object):
                                 ch =3D self.src[self.cursor]
                                 self.cursor +=3D 1
                                 if ch not in "0123456789abcdefABCDEF":
-                                    raise QAPISchemaError(self,
-                                                          '\\u escape ne=
eds 4 '
-                                                          'hex digits')
+                                    raise QAPIParseError(self,
+                                                         '\\u escape nee=
ds 4 '
+                                                         'hex digits')
                                 value =3D (value << 4) + int(ch, 16)
                             # If Python 2 and 3 didn't disagree so much =
on
                             # how to handle Unicode, then we could allow
                             # Unicode string defaults.  But most of QAPI=
 is
                             # ASCII-only, so we aren't losing much for n=
ow.
                             if not value or value > 0x7f:
-                                raise QAPISchemaError(self,
-                                                      'For now, \\u esca=
pe '
-                                                      'only supports non=
-zero '
-                                                      'values up to \\u0=
07f')
+                                raise QAPIParseError(self,
+                                                     'For now, \\u escap=
e '
+                                                     'only supports non-=
zero '
+                                                     'values up to \\u00=
7f')
                             string +=3D chr(value)
                         elif ch in "\\/'\"":
                             string +=3D ch
                         else:
-                            raise QAPISchemaError(self,
-                                                  "Unknown escape \\%s" =
% ch)
+                            raise QAPIParseError(self,
+                                                 "Unknown escape \\%s" %=
 ch)
                         esc =3D False
                     elif ch =3D=3D "\\":
                         esc =3D True
@@ -259,7 +259,7 @@ class QAPISchemaParser(object):
                 self.line +=3D 1
                 self.line_pos =3D self.cursor
             elif not self.tok.isspace():
-                raise QAPISchemaError(self, 'Stray "%s"' % self.tok)
+                raise QAPIParseError(self, 'Stray "%s"' % self.tok)
=20
     def get_members(self):
         expr =3D OrderedDict()
@@ -267,24 +267,24 @@ class QAPISchemaParser(object):
             self.accept()
             return expr
         if self.tok !=3D "'":
-            raise QAPISchemaError(self, 'Expected string or "}"')
+            raise QAPIParseError(self, 'Expected string or "}"')
         while True:
             key =3D self.val
             self.accept()
             if self.tok !=3D ':':
-                raise QAPISchemaError(self, 'Expected ":"')
+                raise QAPIParseError(self, 'Expected ":"')
             self.accept()
             if key in expr:
-                raise QAPISchemaError(self, 'Duplicate key "%s"' % key)
+                raise QAPIParseError(self, 'Duplicate key "%s"' % key)
             expr[key] =3D self.get_expr(True)
             if self.tok =3D=3D '}':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPISchemaError(self, 'Expected "," or "}"')
+                raise QAPIParseError(self, 'Expected "," or "}"')
             self.accept()
             if self.tok !=3D "'":
-                raise QAPISchemaError(self, 'Expected string')
+                raise QAPIParseError(self, 'Expected string')
=20
     def get_values(self):
         expr =3D []
@@ -292,20 +292,20 @@ class QAPISchemaParser(object):
             self.accept()
             return expr
         if self.tok not in "{['tfn":
-            raise QAPISchemaError(self, 'Expected "{", "[", "]", string,=
 '
-                                  'boolean or "null"')
+            raise QAPIParseError(self, 'Expected "{", "[", "]", string, =
'
+                                 'boolean or "null"')
         while True:
             expr.append(self.get_expr(True))
             if self.tok =3D=3D ']':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPISchemaError(self, 'Expected "," or "]"')
+                raise QAPIParseError(self, 'Expected "," or "]"')
             self.accept()
=20
     def get_expr(self, nested):
         if self.tok !=3D '{' and not nested:
-            raise QAPISchemaError(self, 'Expected "{"')
+            raise QAPIParseError(self, 'Expected "{"')
         if self.tok =3D=3D '{':
             self.accept()
             expr =3D self.get_members()
@@ -316,7 +316,7 @@ class QAPISchemaParser(object):
             expr =3D self.val
             self.accept()
         else:
-            raise QAPISchemaError(self, 'Expected "{", "[" or string')
+            raise QAPIParseError(self, 'Expected "{", "[" or string')
         return expr
=20
 #
@@ -375,20 +375,18 @@ valid_name =3D re.compile('^(__[a-zA-Z0-9.-]+_)?'
                         '[a-zA-Z][a-zA-Z0-9_-]*$')
=20
=20
-def check_name(expr_info, source, name, allow_optional=3DFalse,
+def check_name(info, source, name, allow_optional=3DFalse,
                enum_member=3DFalse):
     global valid_name
     membername =3D name
=20
     if not isinstance(name, str):
-        raise QAPIExprError(expr_info,
-                            "%s requires a string name" % source)
+        raise QAPISemError(info, "%s requires a string name" % source)
     if name.startswith('*'):
         membername =3D name[1:]
         if not allow_optional:
-            raise QAPIExprError(expr_info,
-                                "%s does not allow optional name '%s'"
-                                % (source, name))
+            raise QAPISemError(info, "%s does not allow optional name '%=
s'"
+                               % (source, name))
     # Enum members can start with a digit, because the generated C
     # code always prefixes it with the enum name
     if enum_member and membername[0].isdigit():
@@ -397,8 +395,7 @@ def check_name(expr_info, source, name, allow_optiona=
l=3DFalse,
     # and 'q_obj_*' implicit type names.
     if not valid_name.match(membername) or \
        c_name(membername, False).startswith('q_'):
-        raise QAPIExprError(expr_info,
-                            "%s uses invalid name '%s'" % (source, name)=
)
+        raise QAPISemError(info, "%s uses invalid name '%s'" % (source, =
name))
=20
=20
 def add_name(name, info, meta, implicit=3DFalse):
@@ -407,13 +404,11 @@ def add_name(name, info, meta, implicit=3DFalse):
     # FIXME should reject names that differ only in '_' vs. '.'
     # vs. '-', because they're liable to clash in generated C.
     if name in all_names:
-        raise QAPIExprError(info,
-                            "%s '%s' is already defined"
-                            % (all_names[name], name))
+        raise QAPISemError(info, "%s '%s' is already defined"
+                           % (all_names[name], name))
     if not implicit and (name.endswith('Kind') or name.endswith('List'))=
:
-        raise QAPIExprError(info,
-                            "%s '%s' should not end in '%s'"
-                            % (meta, name, name[-4:]))
+        raise QAPISemError(info, "%s '%s' should not end in '%s'"
+                           % (meta, name, name[-4:]))
     all_names[name] =3D meta
=20
=20
@@ -465,7 +460,7 @@ def is_enum(name):
     return find_enum(name) is not None
=20
=20
-def check_type(expr_info, source, value, allow_array=3DFalse,
+def check_type(info, source, value, allow_array=3DFalse,
                allow_dict=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
     global all_names
@@ -476,69 +471,64 @@ def check_type(expr_info, source, value, allow_arra=
y=3DFalse,
     # Check if array type for value is okay
     if isinstance(value, list):
         if not allow_array:
-            raise QAPIExprError(expr_info,
-                                "%s cannot be an array" % source)
+            raise QAPISemError(info, "%s cannot be an array" % source)
         if len(value) !=3D 1 or not isinstance(value[0], str):
-            raise QAPIExprError(expr_info,
-                                "%s: array type must contain single type=
 name"
-                                % source)
+            raise QAPISemError(info,
+                               "%s: array type must contain single type =
name" %
+                               source)
         value =3D value[0]
=20
     # Check if type name for value is okay
     if isinstance(value, str):
         if value not in all_names:
-            raise QAPIExprError(expr_info,
-                                "%s uses unknown type '%s'"
-                                % (source, value))
+            raise QAPISemError(info, "%s uses unknown type '%s'"
+                               % (source, value))
         if not all_names[value] in allow_metas:
-            raise QAPIExprError(expr_info,
-                                "%s cannot use %s type '%s'"
-                                % (source, all_names[value], value))
+            raise QAPISemError(info, "%s cannot use %s type '%s'" %
+                               (source, all_names[value], value))
         return
=20
     if not allow_dict:
-        raise QAPIExprError(expr_info,
-                            "%s should be a type name" % source)
+        raise QAPISemError(info, "%s should be a type name" % source)
=20
     if not isinstance(value, OrderedDict):
-        raise QAPIExprError(expr_info,
-                            "%s should be a dictionary or type name" % s=
ource)
+        raise QAPISemError(info,
+                           "%s should be a dictionary or type name" % so=
urce)
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name(expr_info, "Member of %s" % source, key,
+        check_name(info, "Member of %s" % source, key,
                    allow_optional=3Dallow_optional)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
-            raise QAPIExprError(expr_info,
-                                "Member of %s uses reserved name '%s'"
-                                % (source, key))
+            raise QAPISemError(info, "Member of %s uses reserved name '%=
s'"
+                               % (source, key))
         # Todo: allow dictionaries to represent default values of
         # an optional argument.
-        check_type(expr_info, "Member '%s' of %s" % (key, source), arg,
+        check_type(info, "Member '%s' of %s" % (key, source), arg,
                    allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
                                 'enum'])
=20
=20
-def check_command(expr, expr_info):
+def check_command(expr, info):
     name =3D expr['command']
     boxed =3D expr.get('boxed', False)
=20
     args_meta =3D ['struct']
     if boxed:
         args_meta +=3D ['union', 'alternate']
-    check_type(expr_info, "'data' for command '%s'" % name,
+    check_type(info, "'data' for command '%s'" % name,
                expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
                allow_metas=3Dargs_meta)
     returns_meta =3D ['union', 'struct']
     if name in returns_whitelist:
         returns_meta +=3D ['built-in', 'alternate', 'enum']
-    check_type(expr_info, "'returns' for command '%s'" % name,
+    check_type(info, "'returns' for command '%s'" % name,
                expr.get('returns'), allow_array=3DTrue,
                allow_optional=3DTrue, allow_metas=3Dreturns_meta)
=20
=20
-def check_event(expr, expr_info):
+def check_event(expr, info):
     global events
     name =3D expr['event']
     boxed =3D expr.get('boxed', False)
@@ -547,12 +537,12 @@ def check_event(expr, expr_info):
     if boxed:
         meta +=3D ['union', 'alternate']
     events.append(name)
-    check_type(expr_info, "'data' for event '%s'" % name,
+    check_type(info, "'data' for event '%s'" % name,
                expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
                allow_metas=3Dmeta)
=20
=20
-def check_union(expr, expr_info):
+def check_union(expr, info):
     name =3D expr['union']
     base =3D expr.get('base')
     discriminator =3D expr.get('discriminator')
@@ -565,123 +555,117 @@ def check_union(expr, expr_info):
         enum_define =3D None
         allow_metas =3D ['built-in', 'union', 'alternate', 'struct', 'en=
um']
         if base is not None:
-            raise QAPIExprError(expr_info,
-                                "Simple union '%s' must not have a base"
-                                % name)
+            raise QAPISemError(info, "Simple union '%s' must not have a =
base" %
+                               name)
=20
     # Else, it's a flat union.
     else:
         # The object must have a string or dictionary 'base'.
-        check_type(expr_info, "'base' for union '%s'" % name,
+        check_type(info, "'base' for union '%s'" % name,
                    base, allow_dict=3DTrue, allow_optional=3DTrue,
                    allow_metas=3D['struct'])
         if not base:
-            raise QAPIExprError(expr_info,
-                                "Flat union '%s' must have a base"
-                                % name)
+            raise QAPISemError(info, "Flat union '%s' must have a base"
+                               % name)
         base_members =3D find_base_members(base)
         assert base_members
=20
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
-        check_name(expr_info, "Discriminator of flat union '%s'" % name,
+        check_name(info, "Discriminator of flat union '%s'" % name,
                    discriminator)
         discriminator_type =3D base_members.get(discriminator)
         if not discriminator_type:
-            raise QAPIExprError(expr_info,
-                                "Discriminator '%s' is not a member of b=
ase "
-                                "struct '%s'"
-                                % (discriminator, base))
+            raise QAPISemError(info,
+                               "Discriminator '%s' is not a member of ba=
se "
+                               "struct '%s'"
+                               % (discriminator, base))
         enum_define =3D find_enum(discriminator_type)
         allow_metas =3D ['struct']
         # Do not allow string discriminator
         if not enum_define:
-            raise QAPIExprError(expr_info,
-                                "Discriminator '%s' must be of enumerati=
on "
-                                "type" % discriminator)
+            raise QAPISemError(info,
+                               "Discriminator '%s' must be of enumeratio=
n "
+                               "type" % discriminator)
=20
     # Check every branch; don't allow an empty union
     if len(members) =3D=3D 0:
-        raise QAPIExprError(expr_info,
-                            "Union '%s' cannot have empty 'data'" % name=
)
+        raise QAPISemError(info, "Union '%s' cannot have empty 'data'" %=
 name)
     for (key, value) in members.items():
-        check_name(expr_info, "Member of union '%s'" % name, key)
+        check_name(info, "Member of union '%s'" % name, key)
=20
         # Each value must name a known type
-        check_type(expr_info, "Member '%s' of union '%s'" % (key, name),
+        check_type(info, "Member '%s' of union '%s'" % (key, name),
                    value, allow_array=3Dnot base, allow_metas=3Dallow_me=
tas)
=20
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
         if enum_define:
             if key not in enum_define['enum_values']:
-                raise QAPIExprError(expr_info,
-                                    "Discriminator value '%s' is not fou=
nd in "
-                                    "enum '%s'" %
-                                    (key, enum_define["enum_name"]))
+                raise QAPISemError(info,
+                                   "Discriminator value '%s' is not foun=
d in "
+                                   "enum '%s'"
+                                   % (key, enum_define["enum_name"]))
=20
     # If discriminator is user-defined, ensure all values are covered
     if enum_define:
         for value in enum_define['enum_values']:
             if value not in members.keys():
-                raise QAPIExprError(expr_info,
-                                    "Union '%s' data missing '%s' branch=
"
-                                    % (name, value))
+                raise QAPISemError(info, "Union '%s' data missing '%s' b=
ranch"
+                                   % (name, value))
=20
=20
-def check_alternate(expr, expr_info):
+def check_alternate(expr, info):
     name =3D expr['alternate']
     members =3D expr['data']
     types_seen =3D {}
=20
     # Check every branch; require at least two branches
     if len(members) < 2:
-        raise QAPIExprError(expr_info,
-                            "Alternate '%s' should have at least two bra=
nches "
-                            "in 'data'" % name)
+        raise QAPISemError(info,
+                           "Alternate '%s' should have at least two bran=
ches "
+                           "in 'data'" % name)
     for (key, value) in members.items():
-        check_name(expr_info, "Member of alternate '%s'" % name, key)
+        check_name(info, "Member of alternate '%s'" % name, key)
=20
         # Ensure alternates have no type conflicts.
-        check_type(expr_info, "Member '%s' of alternate '%s'" % (key, na=
me),
+        check_type(info, "Member '%s' of alternate '%s'" % (key, name),
                    value,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
         qtype =3D find_alternate_member_qtype(value)
         if not qtype:
-            raise QAPIExprError(expr_info,
-                                "Alternate '%s' member '%s' cannot use "
-                                "type '%s'" % (name, key, value))
+            raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
+                               "type '%s'" % (name, key, value))
         if qtype in types_seen:
-            raise QAPIExprError(expr_info,
-                                "Alternate '%s' member '%s' can't "
-                                "be distinguished from member '%s'"
-                                % (name, key, types_seen[qtype]))
+            raise QAPISemError(info, "Alternate '%s' member '%s' can't "
+                               "be distinguished from member '%s'"
+                               % (name, key, types_seen[qtype]))
         types_seen[qtype] =3D key
=20
=20
-def check_enum(expr, expr_info):
+def check_enum(expr, info):
     name =3D expr['enum']
     members =3D expr.get('data')
     prefix =3D expr.get('prefix')
=20
     if not isinstance(members, list):
-        raise QAPIExprError(expr_info,
-                            "Enum '%s' requires an array for 'data'" % n=
ame)
+        raise QAPISemError(info,
+                           "Enum '%s' requires an array for 'data'" % na=
me)
     if prefix is not None and not isinstance(prefix, str):
-        raise QAPIExprError(expr_info,
-                            "Enum '%s' requires a string for 'prefix'" %=
 name)
+        raise QAPISemError(info,
+                           "Enum '%s' requires a string for 'prefix'" % =
name)
     for member in members:
-        check_name(expr_info, "Member of enum '%s'" % name, member,
+        check_name(info, "Member of enum '%s'" % name, member,
                    enum_member=3DTrue)
=20
=20
-def check_struct(expr, expr_info):
+def check_struct(expr, info):
     name =3D expr['struct']
     members =3D expr['data']
=20
-    check_type(expr_info, "'data' for struct '%s'" % name, members,
+    check_type(info, "'data' for struct '%s'" % name, members,
                allow_dict=3DTrue, allow_optional=3DTrue)
-    check_type(expr_info, "'base' for struct '%s'" % name, expr.get('bas=
e'),
+    check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=3D['struct'])
=20
=20
@@ -690,27 +674,24 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
     info =3D expr_elem['info']
     name =3D expr[meta]
     if not isinstance(name, str):
-        raise QAPIExprError(info,
-                            "'%s' key must have a string value" % meta)
+        raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
     for (key, value) in expr.items():
         if key not in required and key not in optional:
-            raise QAPIExprError(info,
-                                "Unknown key '%s' in %s '%s'"
-                                % (key, meta, name))
+            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
+                               % (key, meta, name))
         if (key =3D=3D 'gen' or key =3D=3D 'success-response') and value=
 is not False:
-            raise QAPIExprError(info,
-                                "'%s' of %s '%s' should only use false v=
alue"
-                                % (key, meta, name))
+            raise QAPISemError(info,
+                               "'%s' of %s '%s' should only use false va=
lue"
+                               % (key, meta, name))
         if key =3D=3D 'boxed' and value is not True:
-            raise QAPIExprError(info,
-                                "'%s' of %s '%s' should only use true va=
lue"
-                                % (key, meta, name))
+            raise QAPISemError(info,
+                               "'%s' of %s '%s' should only use true val=
ue"
+                               % (key, meta, name))
     for key in required:
         if key not in expr:
-            raise QAPIExprError(info,
-                                "Key '%s' is missing from %s '%s'"
-                                % (key, meta, name))
+            raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
+                               % (key, meta, name))
=20
=20
 def check_exprs(exprs):
@@ -743,8 +724,8 @@ def check_exprs(exprs):
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
             add_name(expr['event'], info, 'event')
         else:
-            raise QAPIExprError(expr_elem['info'],
-                                "Expression is missing metatype")
+            raise QAPISemError(expr_elem['info'],
+                               "Expression is missing metatype")
=20
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
@@ -978,8 +959,8 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
     def check(self, schema):
         if self.members is False:               # check for cycles
-            raise QAPIExprError(self.info,
-                                "Object %s contains itself" % self.name)
+            raise QAPISemError(self.info,
+                               "Object %s contains itself" % self.name)
         if self.members:
             return
         self.members =3D False                    # mark as being checke=
d
@@ -1051,12 +1032,11 @@ class QAPISchemaMember(object):
     def check_clash(self, info, seen):
         cname =3D c_name(self.name)
         if cname.lower() !=3D cname and self.owner not in case_whitelist=
:
-            raise QAPIExprError(info,
-                                "%s should not use uppercase" % self.des=
cribe())
+            raise QAPISemError(info,
+                               "%s should not use uppercase" % self.desc=
ribe())
         if cname in seen:
-            raise QAPIExprError(info,
-                                "%s collides with %s"
-                                % (self.describe(), seen[cname].describe=
()))
+            raise QAPISemError(info, "%s collides with %s" %
+                               (self.describe(), seen[cname].describe())=
)
         seen[cname] =3D self
=20
     def _pretty_owner(self):
@@ -1201,14 +1181,13 @@ class QAPISchemaCommand(QAPISchemaEntity):
             self.arg_type.check(schema)
             if self.boxed:
                 if self.arg_type.is_empty():
-                    raise QAPIExprError(self.info,
-                                        "Cannot use 'boxed' with empty t=
ype")
+                    raise QAPISemError(self.info,
+                                       "Cannot use 'boxed' with empty ty=
pe")
             else:
                 assert not isinstance(self.arg_type, QAPISchemaAlternate=
Type)
                 assert not self.arg_type.variants
         elif self.boxed:
-            raise QAPIExprError(self.info,
-                                "Use of 'boxed' requires 'data'")
+            raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
         if self._ret_type_name:
             self.ret_type =3D schema.lookup_type(self._ret_type_name)
             assert isinstance(self.ret_type, QAPISchemaType)
@@ -1235,14 +1214,13 @@ class QAPISchemaEvent(QAPISchemaEntity):
             self.arg_type.check(schema)
             if self.boxed:
                 if self.arg_type.is_empty():
-                    raise QAPIExprError(self.info,
-                                        "Cannot use 'boxed' with empty t=
ype")
+                    raise QAPISemError(self.info,
+                                       "Cannot use 'boxed' with empty ty=
pe")
             else:
                 assert not isinstance(self.arg_type, QAPISchemaAlternate=
Type)
                 assert not self.arg_type.variants
         elif self.boxed:
-            raise QAPIExprError(self.info,
-                                "Use of 'boxed' requires 'data'")
+            raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
         visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed)
@@ -1258,7 +1236,7 @@ class QAPISchema(object):
             self._predefining =3D False
             self._def_exprs()
             self.check()
-        except (QAPISchemaError, QAPIExprError) as err:
+        except QAPIError as err:
             print >>sys.stderr, err
             exit(1)
=20
--=20
2.11.0
