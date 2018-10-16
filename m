Received: from eggs.gnu.org ([2001:4830:134:3::10]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCDjx-0007JQ-P1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 21:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCDjw-0003QP-0V
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 21:01:41 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-8-mreitz@redhat.com>
	<14120cdc-1517-f9af-9f35-3c78b4f634a9@redhat.com>
	<20181015235752.GK31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
Date: Mon, 15 Oct 2018 21:01:22 -0400
MIME-Version: 1.0
In-Reply-To: <20181015235752.GK31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in
 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 10/15/18 7:57 PM, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 07:38:45PM -0400, Cleber Rosa wrote:
>>
>>
>> On 10/15/18 10:14 AM, Max Reitz wrote:
>>> iotest 169 uses the 'new' module to add methods to a class.  This module
>>> no longer exists in Python 3.  Instead, we can use a lambda.  Best of
>>> all, this works in 2.7 just as well.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  tests/qemu-iotests/169 | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>>> index f243db9955..e5614b159d 100755
>>> --- a/tests/qemu-iotests/169
>>> +++ b/tests/qemu-iotests/169
>>> @@ -23,7 +23,6 @@ import iotests
>>>  import time
>>>  import itertools
>>>  import operator
>>> -import new
>>>  from iotests import qemu_img
>>>  
>>>  
>>> @@ -144,7 +143,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>>>  
>>>  def inject_test_case(klass, name, method, *args, **kwargs):
>>>      mc = operator.methodcaller(method, *args, **kwargs)
>>> -    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
>>> +    setattr(klass, 'test_' + name, lambda self: mc(self))
>>>  
>>>  for cmb in list(itertools.product((True, False), repeat=4)):
>>>      name = ('_' if cmb[0] else '_not_') + 'persistent_'
>>>
>>
>> This can be simplified with:
>>
>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>> index e5614b159d..2199f14ae7 100755
>> --- a/tests/qemu-iotests/169
>> +++ b/tests/qemu-iotests/169
>> @@ -22,7 +22,6 @@ import os
>>  import iotests
>>  import time
>>  import itertools
>> -import operator
>>  from iotests import qemu_img
>>
>>
>> @@ -141,18 +140,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>>              self.check_bitmap(self.vm_b, sha256 if persistent else False)
>>
>>
>> -def inject_test_case(klass, name, method, *args, **kwargs):
>> -    mc = operator.methodcaller(method, *args, **kwargs)
>> -    setattr(klass, 'test_' + name, lambda self: mc(self))
>> -
>>  for cmb in list(itertools.product((True, False), repeat=4)):
>>      name = ('_' if cmb[0] else '_not_') + 'persistent_'
>>      name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
>>      name += '_online' if cmb[2] else '_offline'
>>      name += '_shared' if cmb[3] else '_nonshared'
>>
>> -    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
>> -                     *list(cmb))
>> +    setattr(TestDirtyBitmapMigration, 'test_' + name,
>> +            lambda self: TestDirtyBitmapMigration.do_test_migration(
>> +                self, *list(cmb)))
> 
> I'm not fond of the long multi-line lambda expression, but I love
> that you got rid of operator.methodcaller().  :)
> 
> However, this doesn't seem to work: `*list(cmb)` will be
> evaluated only when the lambda is called, and `cmb` will be
> always `(False, False, False, False)`.
> 
> I was going to suggest defining a nested function inside
> inject_test_case() to replace operator.methodcaller(), but then I
> thought it was not worth it.
> 

You're right! I missed that.  Anyway, another possibility:

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index e5614b159d..cd0d9c289c 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -22,7 +22,7 @@ import os
 import iotests
 import time
 import itertools
-import operator
+import functools
 from iotests import qemu_img


@@ -140,20 +140,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_b.launch()
             self.check_bitmap(self.vm_b, sha256 if persistent else False)

-
-def inject_test_case(klass, name, method, *args, **kwargs):
-    mc = operator.methodcaller(method, *args, **kwargs)
-    setattr(klass, 'test_' + name, lambda self: mc(self))
-
-for cmb in list(itertools.product((True, False), repeat=4)):
+for cmb in itertools.product((True, False), repeat=4):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
     name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
     name += '_online' if cmb[2] else '_offline'
     name += '_shared' if cmb[3] else '_nonshared'

-    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
-                     *list(cmb))
-
+    test =
functools.partialmethod(TestDirtyBitmapMigration.do_test_migration,
+                                   *cmb)
+    setattr(TestDirtyBitmapMigration, 'test_' + name, test)

 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
