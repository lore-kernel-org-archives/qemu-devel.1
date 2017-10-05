Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e09RN-0004TX-MA
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e09RM-0007SM-U0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:56:05 -0400
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
	<7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
	<20171003162921.GB2335@work-vm>
	<418e65f7-faae-2e78-2170-2721bd6b2305@virtuozzo.com>
	<2a1df411-c809-cc3e-6471-fd6cc1653bd0@redhat.com>
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Message-ID: <5c2960d9-5e24-5784-e089-fa515c9d1abf@virtuozzo.com>
Date: Thu, 5 Oct 2017 19:55:44 +0300
MIME-Version: 1.0
In-Reply-To: <2a1df411-c809-cc3e-6471-fd6cc1653bd0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio'
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org



On 10/04/2017 07:00 PM, Eric Blake wrote:
> On 10/04/2017 09:26 AM, Jan Dakinevich wrote:
> 
>>>>>> +{
>>>>>> +    'struct': 'VirtioInfo',
>>>>>> +    'data': {
>>>>>> +        'feature-names': ['VirtioInfoBit'],
>>>>>
>>>>> Why is feature-names listed at two different nestings of the return value?
>>>>>
>>>>
>>>> These are different feature names. First names are common and predefined
>>>> for all devices. Second names are device-specific.
>>>
>>> If you can turn these into enums (union'd enums?) then you might
>>> be able to get rid of a lot of your array filling/naming conversion
>>> boilerplate. (Not sure if it's worth it, but it's worth looking).
>>>
>>
>> I would be happy to drop this boilerplate, but how enum could help here?
>> To respond my requirement it should be something like set, not enum.
>> Even so, having set, I would have been needed to declare mapping between
>> names in set type and bit numbers within feature bitmask.
> 
> Instead of returning a bitmask ("mask":123) as well as an array naming
> those bits
> ([{"bit":1,"name":"bit1"},{"bit":2","name":"bit2"},{"bit":4,"name":"bit4},...]),
> you could omit the bit numbers and just return an array of named bits
> (["bit1", "bit2", "bit4"]).  An enum lets you declare up front what
> named bits are supported (and code can introspect when new named bits
> are supported in newer qemu).
>
But how can I declare in this notation that name "bit1" is owned by bit
#1, name "bit2" is owned by bit #2, name "bit4" is owned by bit #4, and
all other bits has no names.

> Perhaps it's easier to first take a step back, and show what the desired
> output might be like, and then we can figure out how to represent that
> output in QAPI.
> 

Yeah... I expect the following HMP output:

(qmue) info virtio
virtio-blk-device at 0000:00:07.0
  status:           0x07 acknowledge,driver,driver_ok
  host features:    0x0000000179000e54
  guest features:   0x0000000030000e54
  common features:
                   notify_on_empty
                        any_layout
                     indirect_desc                           acked
                         event_idx                           acked
                         version_1
  specific features:
                           seg_max                           acked
                          blk_size                           acked
                             flush                           acked
                          topology                           acked
virtio-serial-device at 0000:00:08.0
  status:           0x07 acknowledge,driver,driver_ok
  host features:    0x0000000179000006
  guest features:   0x0000000030000002
  common features:
                   notify_on_empty
                        any_layout
                     indirect_desc                           acked
                         event_idx                           acked
                         version_1
  specific features:
                         multiport                           acked
                       emerg_write

-- 
Best regards
Jan Dakinevich
