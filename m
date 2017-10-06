Received: from eggs.gnu.org ([2001:4830:134:3::10]:58365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LJb-0004pY-2M
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LJZ-0003M0-PL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:36:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
	<7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
Date: Fri, 06 Oct 2017 07:36:37 +0200
In-Reply-To: <7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com> (Jan
	Dakinevich's message of "Tue, 3 Oct 2017 17:32:49 +0300")
Message-ID: <87wp4896sa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:

> On 10/03/2017 05:02 PM, Eric Blake wrote:
>> On 10/03/2017 07:47 AM, Jan Dakinevich wrote:
>>> The command is intended for gathering virtio information such as status,
>>> feature bits, negotiation status. It is convenient and useful for debug
>>> purpose.
>>>
>>> The commands returns generic virtio information for virtio such as
>>> common feature names and status bits names and information for all
>>> attached to current machine devices.
>>>
>>> To retrieve names of device-specific features `get_feature_name'
>>> callback in VirtioDeviceClass also was introduced.
>>>
>>> Cc: Denis V. Lunev <den@virtuozzo.com>
>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
>>> ---
>>>  hw/block/virtio-blk.c       |  21 +++++++++
>>>  hw/char/virtio-serial-bus.c |  15 +++++++
>>>  hw/display/virtio-gpu.c     |  13 ++++++
>>>  hw/net/virtio-net.c         |  35 +++++++++++++++
>>>  hw/scsi/virtio-scsi.c       |  16 +++++++
>>>  hw/virtio/Makefile.objs     |   2 +
>>>  hw/virtio/virtio-balloon.c  |  15 +++++++
>>>  hw/virtio/virtio-stub.c     |   9 ++++
>>>  hw/virtio/virtio.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/virtio/virtio.h  |   2 +
>>>  qapi-schema.json            |   1 +
>>>  qapi/virtio.json            |  94 +++++++++++++++++++++++++++++++++++++++++
>>>  12 files changed, 324 insertions(+)
>>>  create mode 100644 hw/virtio/virtio-stub.c
>>>  create mode 100644 qapi/virtio.json
>> 
>> This creates a new .json file, but does not touch MAINTAINERS.  Our idea
>> in splitting the .json files was to make it easier for each sub-file
>> that needs a specific maintainer in addition to the overall *.json line
>> for QAPI maintainers, so this may deserve a MAINTAINERS entry.
>> 
>
> Ok.
>
>>> +++ b/qapi/virtio.json
>>> @@ -0,0 +1,94 @@
>>> +# -*- Mode: Python -*-
>>> +#
>>> +
>>> +##
>>> +# = Virtio devices
>>> +##
>>> +
>>> +{ 'include': 'common.json' }
>>> +
>>> +##
>>> +# @VirtioInfoBit:
>>> +#
>>> +# Named virtio bit
>>> +#
>>> +# @bit: bit number
>>> +#
>>> +# @name: bit name
>>> +#
>>> +# Since: 2.11.0
>>> +#
>>> +##
>>> +{
>>> +    'struct': 'VirtioInfoBit',
>>> +    'data': {
>>> +        'bit': 'uint64',
>> 
>> Why is this a 64-bit value? Are the values 0-63, or are they 1, 2, 4, 8,
>> ...?  The documentation on 'bit number' is rather sparse.
>
> I would prefer `uint' here, but I don't see generic unsigned type (may
> be, I am mistaken). I could use uint8 here, though.
>
>> 
>>> +        'name': 'str'
>> 
>> Wouldn't an enum type be better than an open-ended string?
>> 
>
> Bit names are not known here, they are obtained from virtio device
> implementations.

What exactly uses these bits?

Why do these uses justify pass-through?  By pass-through, I mean the
messenger (QEMU) merely passes them along, without understanding them.
Defeats introspection.

>>> +    }
>>> +}
>>> +
>>> +##
>>> +# @VirtioInfoDevice:
>>> +#
>>> +# Information about specific virtio device
>>> +#
>>> +# @qom_path: QOM path of the device
>> 
>> Please make this 'qom-path' - new interfaces should prefer '-' over '_'.
>
> Ok.
>
>>> +#
>>> +# @feature-names: names of device-specific features
>>> +#
>>> +# @host-features: bitmask of features, provided by devices
>>> +#
>>> +# @guest-features: bitmask of features, acknowledged by guest
>>> +#
>>> +# @status: virtio device status bitmask
>>> +#
>>> +# Since: 2.11.0
>>> +#
>>> +##
>>> +{
>>> +    'struct': 'VirtioInfoDevice',
>>> +    'data': {
>>> +        'qom_path': 'str',
>>> +        'feature-names': ['VirtioInfoBit'],
>>> +        'host-features': 'uint64',
>>> +        'guest-features': 'uint64',
>>> +        'status': 'uint64'
>> 
>> I'm wondering if this is the best representation (where the caller has
>> to parse the integer and then lookup in feature-names what each bit of
>> the integer represents).  But I'm not sure I have anything better off
>> the top of my head.
>> 
>
> Consider it as way to tell caller about names of supported features.

"Unsigned integer interpreted as combination of well-known bit-valued
symbols" is a fine C interface, but a pretty horrid QMP interface.
What's wrong with doing a set the straightforward way as "array of
enum"?

>>> +    }
>>> +}
>>> +
>>> +##
>>> +# @VirtioInfo:
>>> +#
>>> +# Information about virtio devices
>>> +#
>>> +# @feature-names: names of common virtio features
>>> +#
>>> +# @status-names: names of bits which represents virtio device status
>>> +#
>>> +# @devices: list of per-device virtio information
>>> +#
>>> +# Since: 2.11.0
>>> +#
>>> +##
>>> +{
>>> +    'struct': 'VirtioInfo',
>>> +    'data': {
>>> +        'feature-names': ['VirtioInfoBit'],
>> 
>> Why is feature-names listed at two different nestings of the return value?
>> 
>
> These are different feature names. First names are common and predefined
> for all devices. Second names are device-specific.
>
>>> +        'status-names': ['VirtioInfoBit'],
>>> +        'devices': ['VirtioInfoDevice']
>>> +    }
>>> +}
>>> +
>>> +
>>> +##
>>> +# @query-virtio:
>>> +#
>>> +# Returns generic and per-device virtio information
>>> +#
>>> +# Since: 2.11.0
>>> +#
>>> +##
>>> +{
>>> +    'command': 'query-virtio',
>>> +    'returns': 'VirtioInfo'
>>> +}
>>>
>> 
