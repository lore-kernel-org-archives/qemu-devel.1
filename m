Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejivX-0001PD-Gd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejivS-0001zL-Lr
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejivS-0001zC-FJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:55:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
	<CAMxuvawWTd+HWx3seEstJA1YQp3EypH1a7UQ_h-XPR73hXHwTQ@mail.gmail.com>
	<871shzjvnv.fsf@dusky.pond.sub.org>
Date: Thu, 08 Feb 2018 10:55:28 +0100
In-Reply-To: <871shzjvnv.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 05 Feb 2018 16:36:20 +0100")
Message-ID: <876077st4f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 06/21] qapi-gen: New common driver for
 code and doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andre Lureau <mlureau@redhat.com> writes:
>
>> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote:
[...]
>>> diff --git a/scripts/qapi2texi.py b/scripts/qapi/doc.py
>>> old mode 100755
>>> new mode 100644
>>> similarity index 92%
>>> rename from scripts/qapi2texi.py
>>> rename to scripts/qapi/doc.py
>>> index 924b374cd3..1f57f6e1c2
>>> --- a/scripts/qapi2texi.py
>>> +++ b/scripts/qapi/doc.py
>>> @@ -4,10 +4,9 @@
>>>  # This work is licensed under the terms of the GNU LGPL, version 2+.
>>>  # See the COPYING file in the top-level directory.
>>>  """This script produces the documentation of a qapi schema in texinfo format"""
>>> +
>>>  import re
>>> -import sys
>>> -
>>> -import qapi
>>> +import qapi.common
>>>
>>>  MSG_FMT = """
>>>  @deftypefn {type} {{}} {name}
>>> @@ -196,7 +195,7 @@ def texi_entity(doc, what, base=None, variants=None,
>>>              + texi_sections(doc))
>>>
>>>
>>> -class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>>> +class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
>>
>> Would be a bit easier to read and more consitent with a top-level
>> "from qapi.common import QAPISchemaVisitor"
>
> Can do.

The obvious patch (appended) doesn't work, because doc_required is
always False in gen_doc().  WTF?!?

[...]


diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 4027722032..919e77b79e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -7,7 +7,7 @@
 
 from __future__ import print_function
 import re
-import qapi.common
+from qapi.common import doc_required, QAPIGenDoc, QAPISchemaVisitor
 
 MSG_FMT = """
 @deftypefn {type} {{}} {name}
@@ -196,7 +196,7 @@ def texi_entity(doc, what, base=None, variants=None,
             + texi_sections(doc))
 
 
-class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
+class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
     def __init__(self):
         self.out = None
         self.cur_doc = None
@@ -272,7 +272,7 @@ def texi_schema(schema):
 
 
 def gen_doc(schema, output_dir, prefix):
-    if qapi.common.doc_required:
-        gen = qapi.common.QAPIGenDoc()
+    if doc_required:
+        gen = QAPIGenDoc()
         gen.add(texi_schema(schema))
         gen.write(output_dir, prefix + 'qapi.texi')
