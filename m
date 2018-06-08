Received: from eggs.gnu.org ([2001:4830:134:3::10]:45295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLJE-0005d9-Iy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLJD-0004i8-BC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRLJD-0004hm-3t
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:36:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 14:35:58 -0300
Message-Id: <20180608173558.8122-3-ehabkost@redhat.com>
In-Reply-To: <20180608173558.8122-1-ehabkost@redhat.com>
References: <20180608173558.8122-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] python: Remove scripts/ordereddict.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Python 2.7 (the minimum Python version we require) provides
collections.OrderedDict on the standard library, so we don't need
to carry our own implementation.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/ordereddict.py | 128 -----------------------------------------
 scripts/qapi/common.py |   5 +-
 2 files changed, 1 insertion(+), 132 deletions(-)
 delete mode 100644 scripts/ordereddict.py

diff --git a/scripts/ordereddict.py b/scripts/ordereddict.py
deleted file mode 100644
index 68ed340b33..0000000000
--- a/scripts/ordereddict.py
+++ /dev/null
@@ -1,128 +0,0 @@
-# Copyright (c) 2009 Raymond Hettinger
-#
-# Permission is hereby granted, free of charge, to any person
-# obtaining a copy of this software and associated documentation files
-# (the "Software"), to deal in the Software without restriction,
-# including without limitation the rights to use, copy, modify, merge,
-# publish, distribute, sublicense, and/or sell copies of the Software,
-# and to permit persons to whom the Software is furnished to do so,
-# subject to the following conditions:
-#
-#     The above copyright notice and this permission notice shall be
-#     included in all copies or substantial portions of the Software.
-#
-#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-#     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-#     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-#     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-#     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-#     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-#     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-#     OTHER DEALINGS IN THE SOFTWARE.
-
-from UserDict import DictMixin
-
-
-class OrderedDict(dict, DictMixin):
-
-    def __init__(self, *args, **kwds):
-        if len(args) > 1:
-            raise TypeError('expected at most 1 arguments, got %d' % len(args))
-        try:
-            self.__end
-        except AttributeError:
-            self.clear()
-        self.update(*args, **kwds)
-
-    def clear(self):
-        self.__end = end = []
-        end += [None, end, end]         # sentinel node for doubly linked list
-        self.__map = {}                 # key --> [key, prev, next]
-        dict.clear(self)
-
-    def __setitem__(self, key, value):
-        if key not in self:
-            end = self.__end
-            curr = end[1]
-            curr[2] = end[1] = self.__map[key] = [key, curr, end]
-        dict.__setitem__(self, key, value)
-
-    def __delitem__(self, key):
-        dict.__delitem__(self, key)
-        key, prev, next = self.__map.pop(key)
-        prev[2] = next
-        next[1] = prev
-
-    def __iter__(self):
-        end = self.__end
-        curr = end[2]
-        while curr is not end:
-            yield curr[0]
-            curr = curr[2]
-
-    def __reversed__(self):
-        end = self.__end
-        curr = end[1]
-        while curr is not end:
-            yield curr[0]
-            curr = curr[1]
-
-    def popitem(self, last=True):
-        if not self:
-            raise KeyError('dictionary is empty')
-        if last:
-            key = next(reversed(self))
-        else:
-            key = next(iter(self))
-        value = self.pop(key)
-        return key, value
-
-    def __reduce__(self):
-        items = [[k, self[k]] for k in self]
-        tmp = self.__map, self.__end
-        del self.__map, self.__end
-        inst_dict = vars(self).copy()
-        self.__map, self.__end = tmp
-        if inst_dict:
-            return (self.__class__, (items,), inst_dict)
-        return self.__class__, (items,)
-
-    def keys(self):
-        return list(self)
-
-    setdefault = DictMixin.setdefault
-    update = DictMixin.update
-    pop = DictMixin.pop
-    values = DictMixin.values
-    items = DictMixin.items
-    iterkeys = DictMixin.iterkeys
-    itervalues = DictMixin.itervalues
-    iteritems = DictMixin.iteritems
-
-    def __repr__(self):
-        if not self:
-            return '%s()' % (self.__class__.__name__,)
-        return '%s(%r)' % (self.__class__.__name__, self.items())
-
-    def copy(self):
-        return self.__class__(self)
-
-    @classmethod
-    def fromkeys(cls, iterable, value=None):
-        d = cls()
-        for key in iterable:
-            d[key] = value
-        return d
-
-    def __eq__(self, other):
-        if isinstance(other, OrderedDict):
-            if len(self) != len(other):
-                return False
-            for p, q in zip(self.items(), other.items()):
-                if p != q:
-                    return False
-            return True
-        return dict.__eq__(self, other)
-
-    def __ne__(self, other):
-        return not self == other
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index e82990f0f2..2462fc0291 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -16,10 +16,7 @@ import errno
 import os
 import re
 import string
-try:
-    from collections import OrderedDict
-except:
-    from ordereddict import OrderedDict
+from collections import OrderedDict
 
 builtin_types = {
     'null':     'QTYPE_QNULL',
-- 
2.18.0.rc1.1.g3f1ff2140
