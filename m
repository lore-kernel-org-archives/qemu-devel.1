Received: from eggs.gnu.org ([2001:4830:134:3::10]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZg4U-000523-Oc
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZg4T-0002cQ-Bj
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:55:50 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
	<fe80addc-0e37-a453-b9e1-5e78b559a093@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a1b2fca0-2bd1-01f6-6ff0-dfde78d4dfec@redhat.com>
Date: Wed, 19 Dec 2018 12:55:38 -0500
MIME-Version: 1.0
In-Reply-To: <fe80addc-0e37-a453-b9e1-5e78b559a093@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/5] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2018 4:52, John Snow wrote:
>> Python before 3.6 does not sort kwargs by default.
>> If we want to print out pretty-printed QMP objects while
>> preserving the "exec" > "arguments" ordering, we need a custom sort.
>>
>> We can accomplish this by sorting **kwargs into an OrderedDict,
>> which does preserve addition order.
>> ---
>>   tests/qemu-iotests/iotests.py | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>

Hm, my patch sending script broke and it's not adding my S-o-B lines.
I'll fix that.

>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 9595429fea..9aec03c7a3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -30,6 +30,7 @@ import signal
>>   import logging
>>   import atexit
>>   import io
>> +from collections import OrderedDict
>>   
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
>>   import qtest
>> @@ -75,6 +76,16 @@ def qemu_img(*args):
>>           sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
>>       return exitcode
>>   
>> +def ordered_kwargs(kwargs):
>> +    # kwargs prior to 3.6 are not ordered, so:
>> +    od = OrderedDict()
>> +    for k in sorted(kwargs.keys()):
> 
> you can use for k, v in sorted(kwargs.items()):
> and use then v instead of kwargs[k]
> 

I don't need to sort the tuples, though, Only the keys -- which are not
duplicated. Is it really worth changing? ...

>> +        if isinstance(kwargs[k], dict):
>> +            od[k] = ordered_kwargs(kwargs[k])
>> +        else:
>> +            od[k] = kwargs[k]
>> +    return od
>> +
>>   def qemu_img_create(*args):
>>       args = list(args)
>>   
>> @@ -257,8 +268,9 @@ def filter_img_info(output, filename):
>>   def log(msg, filters=[]):
>>       for flt in filters:
>>           msg = flt(msg)
> 
> I think that trying to apply text filters to object should be fixed first.
> 

Text filters *aren't* applied to objects before this patch.

I think log should apply the filters you give it to the object you give
it, whether or not that's text or QMP objects. If you give it the wrong
filters that's your fault.

That's the way it works now, and I don't think it's broken.

>> -    if type(msg) is dict or type(msg) is list:
>> -        print(json.dumps(msg, sort_keys=True))
>> +    if isinstance(msg, dict) or isinstance(msg, list):
>> +        sort_keys = not isinstance(msg, OrderedDict)
>> +        print(json.dumps(msg, sort_keys=sort_keys))
>>       else:
>>           print(msg)
>>   
>> @@ -448,8 +460,9 @@ class VM(qtest.QEMUQtestMachine):
>>           return result
>>   
>>       def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
>> -        logmsg = '{"execute": "%s", "arguments": %s}' % \
>> -            (cmd, json.dumps(kwargs, sort_keys=True))
>> +        full_cmd = OrderedDict({"execute": cmd,
>> +                                "arguments": ordered_kwargs(kwargs)})
> 
> no, you can't use dict as a parameter to constructor, as dict is not ordered,
> use tuple of tuples, like OrderedDict((('execute': cmd), ('execute': ...)))
> 

Ah, I see the problem...

> 
> 
>> +        logmsg = json.dumps(full_cmd)
>>           log(logmsg, filters)
> 
> and I prefere fixing the thing, that we do json.dumps both in log() and qmp_log() before
> this patch.
> 
> Also: so, we move all qmp_log callers to new logic (through sorting by hand with ordered_kwargs),
> and it works? Then, maybe, move all log callers to new logic, and get rid of json.dumps at all,
> to have one path instead of two?

(There's only one call to dumps by the end of this series, so we're
heading in that direction. I don't want to make callers need to learn
that they need to call ordered_kwargs or build an OrderedDict, I'd
rather let qmp_log handle that.)

> 

The motivation is that log() will log whatever you give it and apply
filters that work on that kind of object. Some callers need to filter
rich QMP objects and some callers need to filter text -- this is the way
log() behaves right now and I simply didn't change it.

What qmp_log currently does is convert both the outgoing and incoming
QMP objects to text, and then filters them as text. However, only
precisely one test (206) uses this functionality.

So... I need some way for test 206 to do what it does. One way is to
make a rich QMP filter, which is what I do later in this series under
the pretense that other tests will likely want to filter QMP output, too.

The other approach involves teaching qmp_log to accept two kinds of
filters (qmp and text) and then passing both along to log(), which will
then filter the object before pretty-printing and then apply the text
filters after pretty-printing, and then logging the result.

As it stands now, though, log() just applies all filters to the first
argument without the caller needing to disambiguate. If I teach log() to
use two types of filters, I need to go back through all of the iotests
and teach all callers to specify e.g. qfilters= or tfilters=.

I opted for an approach that let me just edit test 206 instead -- and
one that added a recursive QMP filter that might be useful in the future
for other purposes.

>>           result = self.qmp(cmd, **kwargs)
>>           log(json.dumps(result, sort_keys=True), filters)
>>
> 
> 
