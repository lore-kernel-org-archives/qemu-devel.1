Received: from eggs.gnu.org ([2001:4830:134:3::10]:41231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjLaQ-0000L2-W4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjLaN-00077z-Pr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:55:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjLaN-00077n-Gx
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:55:39 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEAD3C05681D
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 07:55:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
	<20170301144809.GE10160@redhat.com>
Date: Thu, 02 Mar 2017 08:55:35 +0100
In-Reply-To: <20170301144809.GE10160@redhat.com> (Daniel P. Berrange's message
	of "Wed, 1 Mar 2017 14:48:09 +0000")
Message-ID: <8760jsp0y0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Wed, Mar 01, 2017 at 08:36:03AM -0600, Eric Blake wrote:
>> On 03/01/2017 06:32 AM, Daniel P. Berrange wrote:
>> > Some of the migration parameters are strings, which default to NULL,
>> > eg tls_hostname and tls_creds.
>> > 
>> > The mgmt app will set the tls_creds parameter on both source and target
>> > QEMU instances, in order to trigger use of TLS for migration.
>> > 
>> > After performing a TLS encrypted migration though, migration might be
>> > used for other reasons - for example, to save the QEMU state to a file.
>> > We need TLS turned off when doing this, but the migrate-set-parameters
>> > QAPI command does not provide any facility to clear/reset parameters
>> > to their default state.
>> > 
>> > If you simply ommit the tls_creds parameter in migrate-set-parameters,
>> 
>> s/ommit/omit/
>> 
>> > then 'has_tls_creds' will be false and so no action will be taken. The
>> > only option that works with migrate-set-parameters is to treat "" on
>> > the wire as equivalent to requesting NULL. Failing that we would have
>> > to create a new 'migrate-reset-parameters' method to explicitly put
>> > a parameter back to its default value.
>> 
>> That happens to work in this case, because an empty string as the TLS
>> parameter makes no sense.

Yes.

>> A nicer solution would be to support JSON null on the wire, so the user
>> can pass "tls-creds":null to explicitly request wiping out the
>> credentials rather than making the empty string magic.  But that's more
>> invasive (the QAPI parser would have to be enhanced to allow an
>> alternate that visits either a string or null).

We already support JSON null on the wire, we just lack a built-in null
type in the schema language.  It's not hard; sketch appended.  I expect
to have missed a few more checks for the null type.

>>                                                  Ultimately, I think
>> we'll have to do that when we come up with some string property where ""
>> should not be given magic treatment.
>> 
>> So now we have a dilemma: do we special case "" here, to be stuck with
>> it even if we later add nullable-string support later, or do we go all
>> the way to nullable-string support now?  We've missed soft freeze for
>> 2.9, so my vote is that it is okay to special case "" in  this instance,
>> even though we'll have to continue to support it indefinitely even if we
>> gain nullable-string QMP.
>
> FYI, if QEMU ever sends a QMP reply whose value comes from a NULL string,
> it turns that into "". IOW, on output "" and NULL are indistinguishable

C "" != C NULL != JSON null

Let me elaborate.

We use QObject * to represent a JSON expression.

The JSON expression that consists of the literal name null is
represented as a non-null QObject *, created with qnull().

A null QObject * could mean something like "I have no JSON expression
for you", which is not the same as "I'm handing you the JSON expression
consisting of the literal null".

When a QObject * represents a JSON expression, none of its QObject *
children may be null.  Absent JSON object members are simply absent in
the QDict.  There is no such thing as an absent list member.

A QString wraps a char * that cannot be null.  A QString * still can,
like any other QObject *.

The QObject input visitor converts a QObject representing a JSON
expression to QAPI object.  It assumes the QObject * are all non-null,
as are the QString's char *.  It guards its assumptions with assertions.

The QObject output visitor converts a QAPI object to a QObject
representing a JSON expression.  Corresponding assumptions about the
pointers within the QAPI object:

* A pointer to a QAPI object can only be null when it represents an
  optional member that is absent.

* A char * can't be null.

However, we relax the second assumption to map NULL to "" silently.  Bad
idea going back to the early days of QAPI.  We intend to get rid of it,
see TODO comment in visit_type_str().

> So from that POV, treating JSON nil and "" as indistiguishable on input
> would be consistent with what we do on output.

Consistent with a bad idea we want to get rid of, plus external
exposure, so we can't :)

> I'd only suggest allowing JSON nil on input, if we're willing change the
> output code to map NULL -> nil, instead of NULL -> "".

No, the mapping is between JSON null and QNull *.  C null pointers are
something else entirely.

Back when I fitted support for JSON null into this code, I considered
representing it as NULL, but quickly gave up due to the existing usage
of NULL for something else entirely.




diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index dabc42e..939d1e7 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -41,6 +41,8 @@ struct %(c_name)s {
 def gen_struct_members(members):
     ret = ''
     for memb in members:
+        if memb.type.c_type() is None:
+            continue
         if memb.optional:
             ret += mcgen('''
     bool has_%(c_name)s;
@@ -123,6 +125,8 @@ def gen_variants(variants):
                 c_name=c_name(variants.tag_member.name))
 
     for var in variants.variants:
+        if var.type.c_unboxed_type() is None:
+            continue
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
@@ -208,6 +212,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 
     def visit_array_type(self, name, info, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
+            if element_type.c_type() is None:
+                return
             self._btin += gen_fwd_object_or_array(name)
             self._btin += gen_array(name, element_type)
             self._btin += gen_type_cleanup_decl(name)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 330b9f3..58a633f 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -187,6 +187,8 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
                  c_name=c_name(name), promote_int=promote_int)
 
     for var in variants.variants:
+        if var.type.c_type() is None:
+            continue
         ret += mcgen('''
     case %(case)s:
 ''',
@@ -301,6 +303,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.defn += gen_visit_enum(name)
 
     def visit_array_type(self, name, info, element_type):
+        if element_type.c_type() is None:
+            return
         decl = gen_visit_decl(name)
         defn = gen_visit_list(name, element_type)
         if isinstance(element_type, QAPISchemaBuiltinType):
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 53a4477..b2ad698 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -34,6 +34,7 @@ builtin_types = {
     'uint64':   'QTYPE_QINT',
     'size':     'QTYPE_QINT',
     'any':      None,           # any QType possible, actually
+    'null':     'QTYPE_QNULL',
     'QType':    'QTYPE_QSTRING',
 }
 
@@ -1094,7 +1095,8 @@ class QAPISchemaType(QAPISchemaEntity):
             'number':  'QTYPE_QFLOAT',
             'int':     'QTYPE_QINT',
             'boolean': 'QTYPE_QBOOL',
-            'object':  'QTYPE_QDICT'
+            'object':  'QTYPE_QDICT',
+            'null':    'QTYPE_QNULL'
         }
         return json2qtype.get(self.json_type())
 
@@ -1525,7 +1527,8 @@ class QAPISchema(object):
                   ('uint64', 'int',     'uint64_t'),
                   ('size',   'int',     'uint64_t'),
                   ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + pointer_suffix)]:
+                  ('any',    'value',   'QObject' + pointer_suffix),
+                  ('null',   'null',    None)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType('q_empty', None,
                                                           None, [], None)
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index f4d8cc4..2629c51 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -392,3 +392,9 @@
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
   'returns': '__org.qemu_x-Union1' }
+
+##
+# @str-or-null:
+##
+{ 'alternate': 'str-or-null',
+  'data': { 's': 'str', 'n': 'null' } }
