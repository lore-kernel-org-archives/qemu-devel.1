Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMW2E-0006mc-OH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMW2A-0000dL-D2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:30:34 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-4-vsementsov@virtuozzo.com>
	<59dccfee-7c47-61d0-40a0-b67f0b7fd8cf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f0b9ce3e-0912-d6ee-ff7c-c5254a3f8103@virtuozzo.com>
Date: Wed, 6 Dec 2017 12:30:09 +0300
MIME-Version: 1.0
In-Reply-To: <59dccfee-7c47-61d0-40a0-b67f0b7fd8cf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/4] scripts/qemu.py: tiny
 enhancement for event_wiat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org

06.12.2017 01:59, John Snow wrote:
>
> On 11/28/2017 02:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> - add comment
>> - allow int timeout and disallow bool (which has special
>>    meaning for pull_event())
>> - remove unreachable 'return None'
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/qemu.py | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 9bfdf6d37d..8763335254 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -291,7 +291,13 @@ class QEMUMachine(object):
>>           branch processing on match's value None
>>              {"foo": {"bar": 1}} matches {"foo": None}
>>              {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
>> +
>> +        @raise QMPTimeoutError: If timeout period elapses.
>> +        @raise QMPConnectError: If some other error occurred.
>>           '''
>> +
>> +        assert isinstance(timeout, float) or isinstance(timeout, int)
>> +
>>           def event_match(event, match=None):
>>               if match is None:
>>                   return True
>> @@ -316,13 +322,11 @@ class QEMUMachine(object):
>>   
>>           # Poll for new events
>>           while True:
>> -            event = self._qmp.pull_event(wait=timeout)
>> +            event = self._qmp.pull_event(wait=float(timeout))
> Before this patch you *could* ask for no timeout, and this would block
> waiting for an event. After, you can't.
>
> Are you making the argument that it is *never* correct to ask for no
> timeout?

hm, you are right, I'll fix.

>
>>               if (event['event'] == name) and event_match(event, match):
>>                   return event
>>               self._events.append(event)
>>   
>> -        return None
>> -
>>       def get_log(self):
>>           '''
>>           After self.shutdown or failed qemu execution, this returns the output
>>


-- 
Best regards,
Vladimir
