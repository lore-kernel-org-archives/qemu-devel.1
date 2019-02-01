Received: from eggs.gnu.org ([209.51.188.92]:40063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpeDb-0000hm-Hy
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpeDa-0005ln-Hy
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:11:15 -0500
References: <20190131022648.14264-1-jsnow@redhat.com>
	<3844320b-32ba-b025-f68d-4cbfd299c202@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f17afbc8-38ec-48b7-680e-571f67f3c304@redhat.com>
Date: Fri, 1 Feb 2019 14:10:57 -0500
MIME-Version: 1.0
In-Reply-To: <3844320b-32ba-b025-f68d-4cbfd299c202@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests/236: fix transaction kwarg order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 1/31/19 5:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2019 5:26, John Snow wrote:
>> It's not enough to order the kwargs for consistent QMP log output,
>> we must also sort any sub-dictionaries in lists that appear as values.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   tests/qemu-iotests/236.out    | 56 +++++++++++++++++------------------
>>   tests/qemu-iotests/iotests.py | 21 ++++++-------
>>   2 files changed, 39 insertions(+), 38 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
>> index 1dad24db0d..bb2d71ea5e 100644
>> --- a/tests/qemu-iotests/236.out
>> +++ b/tests/qemu-iotests/236.out
>> @@ -45,23 +45,23 @@ write -P0xcd 0x3ff0000 64k
>>       "actions": [
>>         {
>>           "data": {
>> -          "node": "drive0",
>> -          "name": "bitmapB"
> 
> We could notice during review, that things we are trying to order so hard
> are just not ordered in result :)))
> 

I was in a bit of a rush before the holidays :(

>> +          "name": "bitmapB",
>> +          "node": "drive0"
>>           },
> 
> [..]
> 
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index cbedfaf1df..76ad52b358 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -76,15 +76,16 @@ def qemu_img(*args):
>>           sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
>>       return exitcode
>>   
>> -def ordered_kwargs(kwargs):
>> -    # kwargs prior to 3.6 are not ordered, so:
>> -    od = OrderedDict()
>> -    for k, v in sorted(kwargs.items()):
>> -        if isinstance(v, dict):
>> -            od[k] = ordered_kwargs(v)
>> -        else:
>> -            od[k] = v
>> -    return od
>> +def ordered_qmp(qmsg):
>> +    # Dictionaries are not ordered prior to 3.6, therefore:
>> +    if isinstance(qmsg, list):
>> +        return [ordered_qmp(atom) for atom in qmsg]
>> +    if isinstance(qmsg, dict):
>> +        od = OrderedDict()
>> +        for k, v in sorted(qmsg.items()):
>> +            od[k] = ordered_qmp(v)
>> +        return od
> 
> or if you want:
> pairs = ((k, ordered_qmp(v)) for k, v in sorted(qmsg.items()))
> return OrderedDict(pairs)
> 

Ah, well, it already went in -- I don't think I'll send a fixup, but I
do like this way more.

Thanks for the review!

>> +    return qmsg
>>   
>>   def qemu_img_create(*args):
>>       args = list(args)
>> @@ -491,7 +492,7 @@ class VM(qtest.QEMUQtestMachine):
>>       def qmp_log(self, cmd, filters=[], indent=None, **kwargs):
>>           full_cmd = OrderedDict((
>>               ("execute", cmd),
>> -            ("arguments", ordered_kwargs(kwargs))
>> +            ("arguments", ordered_qmp(kwargs))
>>           ))
>>           log(full_cmd, filters, indent=indent)
>>           result = self.qmp(cmd, **kwargs)
>>
> 
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 
