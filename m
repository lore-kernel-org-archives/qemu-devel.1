Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1WR-0005Q6-2q
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1WN-0005Pn-Qn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV1WN-0005Pe-H6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:17:07 -0400
Date: Mon, 18 Jun 2018 18:17:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180618211704.GM7451@localhost.localdomain>
References: <20180615220205.6929-1-tamiko@43-1.org>
	<20180615220205.6929-2-tamiko@43-1.org>
	<87muvssm2t.fsf@dusky.pond.sub.org>
	<20180618160430.GG7451@localhost.localdomain>
	<87y3fc6kvh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3fc6kvh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: open files in binary mode and
 use explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Matthias Maier <tamiko@43-1.org>, qemu-devel@nongnu.org, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

On Mon, Jun 18, 2018 at 07:54:26PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Mon, Jun 18, 2018 at 07:25:14AM +0200, Markus Armbruster wrote:
> >> Matthias Maier <tamiko@43-1.org> writes:
> >> 
> >> > This is a different approach to fix the locale dependent encode/decode
> >> > problem in common.py utilizing the binary read/write mode [1,2], and (if
> >> > a python 3 interpreter is used) with explicit decode/encode arguments
> >> > [3].
> >> 
> >> Why can't we simply pass encoding='utf-8' to open()?
> >
> > This wouldn't work in Python 2.7 (where the `open()` builtin
> > doesn't support the `encoding` parameter).
> >
> > io.open(..., encoding='utf-8') should work, though.
> 
> This falls apart because then f.read() returns objects of type 'unicode'
> in Python 2, breaking isinstance(..., str) predicates in several places.

If the existing code already works with Python 3, we can import
Python 3 string semantics in Python 2.7 so we have just one
string API to care about.

This should do it:

  from __future__ import unicode_literals
  from builtins import str
  from builtins import open

We also need a small fixup to the argparse parameters to ensure
they are of the Python3-like str type instead of the Python 2.7
str type.

Full patch below.

After this patch, we should be able to unconditionally call
open(..., encoding='utf-8') or .read().decode('utf-8'), without
any Python version checks.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 3d98ca2e0c..a0dbc4c913 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -5,6 +5,8 @@
 # See the COPYING file in the top-level directory.
 
 from __future__ import print_function
+from __future__ import unicode_literals
+from builtins import str
 import argparse
 import re
 import sys
@@ -23,13 +25,13 @@ def main(argv):
     parser.add_argument('-b', '--builtins', action='store_true',
                         help="generate code for built-in types")
     parser.add_argument('-o', '--output-dir', action='store', default='',
-                        help="write output to directory OUTPUT_DIR")
+                        type=str, help="write output to directory OUTPUT_DIR")
     parser.add_argument('-p', '--prefix', action='store', default='',
-                        help="prefix for symbols")
+                        type=str, help="prefix for symbols")
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
-    parser.add_argument('schema', action='store')
+    parser.add_argument('schema', action='store', type=str)
     args = parser.parse_args()
 
     match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3b0867c14f..df69481a4b 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,6 +13,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+from __future__ import unicode_literals
 from qapi.common import *
 
 
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2462fc0291..7ff5d1bbdd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,6 +12,9 @@
 # See the COPYING file in the top-level directory.
 
 from __future__ import print_function
+from __future__ import unicode_literals
+from builtins import str
+from builtins import open
 import errno
 import os
 import re
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index b5630844f9..d223d5cf46 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -6,6 +6,7 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 from __future__ import print_function
+from __future__ import unicode_literals
 import re
 import qapi.common
 
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 4426861ff1..a58d557ccd 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,6 +12,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+from __future__ import unicode_literals
 from qapi.common import *
 
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 5b6c72c7b2..4a582d3a5d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,6 +10,8 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+from __future__ import unicode_literals
+from builtins import str
 from qapi.common import *
 
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0fb37..a530838f97 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,6 +13,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 """
 
+from __future__ import unicode_literals
 from qapi.common import *
 
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d8936c..a6479fa4fa 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,6 +13,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+from __future__ import unicode_literals
 from qapi.common import *
 
 
-- 
Eduardo
