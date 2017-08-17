Received: from eggs.gnu.org ([2001:4830:134:3::10]:47756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1diPiy-0008LO-HZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1diPix-0003TW-P5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:40:56 -0400
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-9-ehabkost@redhat.com>
	<7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com>
	<87mv6yssjx.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <3c4127c8-ae3f-b5d2-cd31-1f4b9d525c09@redhat.com>
Date: Thu, 17 Aug 2017 14:40:41 -0400
MIME-Version: 1.0
In-Reply-To: <87mv6yssjx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 08/13] ide: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, qemu-block@nongnu.org



On 08/17/2017 12:54 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 08/14/2017 05:57 PM, Eduardo Habkost wrote:
>>> Example output when using "-machine q35":
>>>
>>>   {
>>>     "available": true,
>>>     "count": 1,
>>>     "device-types": [
>>>       "ide-device"
>>>     ],
>>>     "hotpluggable": false,
>>>     "opts": [
>>>       { "option": "unit", "values": 0 },
>>>       { "option": "bus", "values": "ide.2" }
>>>     ],
>>>     "opts-complete": true
>>>   }
>>>   {
>>>     "available": false,
>>>     "count": 1,
>>>     "device": "/machine/unattached/device[19]",
>>>     "device-types": [
>>>       "ide-device"
>>>     ],
>>>     "hotpluggable": false,
>>>     "opts": [
>>>       { "option": "unit", "values": 1 },
>>>       { "option": "bus", "values": "ide.2" } ],
>>>     "opts-complete": true
>>>   }
>>>   {
>>>     "available": true,
>>>     "count": 10,
>>>     "device-types": [
>>>       "ide-device"
>>>     ],
>>>     "hotpluggable": false,
>>>     "opts": [
>>>       { "option": "unit", "values": [ [ 0, 1 ] ] },
>>
>> Hm, these unit values aren't really correct -- we do not support
>> primary/secondary semantics for IDE buses on the AHCI device. I guess
>> they technically exist, but you cannot use them for anything.
>>
>> Should I do something to "disable" or otherwise hide the unusable
>> secondary unit slots for AHCI devices?
> 
> I think that would make this introspection more useful.
> 

OK, let me look into how to meaningfully disable them. I didn't think
they were addressable in any tangible way currently, you certainly can't
put devices on them. I'm not sure where these values are coming from --
I'll play with the patches.

The only reason they even technically exist is because IDEBus comes
indelibly with two IDEStates baked in -- it can't be changed currently,
because everything's all wonky in IDE land.

I really ought to just rip off the bandaid and do an aggressive
refactoring ...... :|
