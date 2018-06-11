Received: from eggs.gnu.org ([2001:4830:134:3::10]:60718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqY-00025N-EF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqX-0000M6-6H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqW-0000Lv-TY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:43 -0300
Message-Id: <20180611174243.31070-14-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] python: Remove scripts/ordereddict.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Python 2.7 (the minimum Python version we require) provides
collections.OrderedDict on the standard library, so we don't need
to carry our own implementation.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608175252.25110-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile               |   1 -
 scripts/ordereddict.py | 128 -----------------------------------------
 scripts/qapi/common.py |   5 +-
 tests/Makefile.include |   1 -
 4 files changed, 1 insertion(+), 134 deletions(-)
 delete mode 100644 scripts/ordereddict.py

diff --git a/Makefile b/Makefile
index 023b3437ec..6c6664d9a3 100644
--- a/Makefile
+++ b/Makefile
@@ -567,7 +567,6 @@ $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
 $(SRC_PATH)/scripts/qapi/common.py \
 $(SRC_PATH)/scripts/qapi/doc.py \
-$(SRC_PATH)/scripts/ordereddict.py \
 $(SRC_PATH)/scripts/qapi-gen.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 400d8890e7..ccedacebd5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -31,7 +31,6 @@ $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
 $(SRC_PATH)/scripts/qapi/common.py \
 $(SRC_PATH)/scripts/qapi/doc.py \
-$(SRC_PATH)/scripts/ordereddict.py \
 $(SRC_PATH)/scripts/qapi-gen.py
 
 # Get the list of all supported sysemu targets
-- 
2.18.0.rc1.1.g3f1ff2140
