Received: from eggs.gnu.org ([2001:4830:134:3::10]:40757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djuXF-0000fl-EP
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djuXE-0000C1-7z
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:47:01 -0400
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-9-ehabkost@redhat.com>
	<7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com>
	<20170818165716.GB3108@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <53a1c9d4-e61e-6bd8-1b00-f1f45dd02ebd@redhat.com>
Date: Mon, 21 Aug 2017 17:46:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170818165716.GB3108@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 08/18/2017 12:57 PM, Eduardo Habkost wrote:
> On Wed, Aug 16, 2017 at 05:46:18PM -0400, John Snow wrote:
>>
>>
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
> If the device is already rejecting -device ...,unit=1, then the
> bug is in my implementation of enumerate_devices.  Maybe it
> should just look at IDEBus::max_units to find that out?
> 

jhuston@probe (master) ~/s/q/b/git>
./x86_64-softmmu/qemu-system-x86_64 \
-M q35 \
-nodefaults \
-device ich9-ahci,id=ahci0 \
-drive id=bar,file=/media/ext/img/f25.qcow2,if=none \
-device ide-hd,id=foo,bus=ahci0.0,drive=bar,unit=1 \
-vga std

qemu-system-x86_64: -device ide-hd,id=foo,bus=ahci0.0,drive=bar,unit=1:
Can't create IDE unit 1, bus supports only 1 units
qemu-system-x86_64: -device ide-hd,id=foo,bus=ahci0.0,drive=bar,unit=1:
Device initialization failed.

based on;

IDEBus.max_units

as seen in:

hw/ide/qdev.c line 93.


Seems a bit like a hack on IDE's end -- but if your enumerate devices
code has a call-in inside of the IDE layer, please do check the
IDEBus::max_units property.

--js
