Received: from eggs.gnu.org ([2001:4830:134:3::10]:49829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cGnrb-0004Mo-Ew
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cGnrW-0001yw-I6
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cGnrW-0001yg-BU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 905E48BD26
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 14:15:21 +0000 (UTC)
References: <20161208200737.GA29563@thinpad.lan.raisama.net>
	<87a8c0qedq.fsf@dusky.pond.sub.org>
	<20161213124239.GO3808@thinpad.lan.raisama.net>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <56cc6442-ba4f-6c5e-9c57-8787acccb6f9@redhat.com>
Date: Tue, 13 Dec 2016 16:15:18 +0200
MIME-Version: 1.0
In-Reply-To: <20161213124239.GO3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12/13/2016 02:42 PM, Eduardo Habkost wrote:
> On Tue, Dec 13, 2016 at 12:04:17PM +0100, Markus Armbruster wrote:
>> Quick interface review only:
>>
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>
>>> This adds a new command to QMP: query-device-slots. It will allow
>>> management software to query possible slots where devices can be
>>> plugged.
>>>
>>> This implementation of the command will return:
>>>
>>> * Multiple PCI slots per bus, in the case of PCI buses;
>>> * One slot per bus in the case of the other buses;
>>
>> Umm, that doesn't seem right.  For instance, a SCSI bus has multiple
>> slots.  The slot address is the SCSI ID.  An IDE bus may have one (SATA)
>> or two (PATA).  For more examples, see qdev-device-use.txt section
>> "Specifying Bus and Address on Bus".
>
> Yes, I should have clarified that: this version changes only PCI
> to expose multiple slots, but other buses also need be changed to
> implement BusClass::enumerate_slots() properly, too.
>
>>
>>> * One slot for each entry from query-hotpluggable-cpus.
>>> In the example below, I am not sure if the PCIe ports are all
>>> supposed to report all slots, but I didn't find any existing
>>> field in PCIBus that would help me figure out the actual number
>>> of slots in a given PCI bus.
>>>
>>> Git tree
>>> --------
>>>
>>> This patch needs the previous query-machines series I am working
>>> on. The full tree can be found on the git tree at:
>>>
>>>   git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info
>>>
>>> Example output
>>> --------------
>>>
>>> The following output was returned by QEMU when running it as:
>>>
>>>  $ qemu-system-x86_64 -machine q35 \
>>>    -readconfig docs/q35-chipset.cfg \
>>>    -smp 4,maxcpus=8,sockets=2,cores=2,threads=2
>>>
>>>  {
>>>     "return": [
>>
>> Are you sure >3000 lines of example output make sense here?
>
> I'm not. :)
>
> That's why I need feedback from the PCI experts. I believe most
> of the PCI ports on q35 accept only one device, but I see no code
> implementing that restriction, and no obvious PCIBus or
> PCIBusClass field indicating that.

Hi,

Sadly there is no such restriction today as far as I know.
We trust the user that he knows what he is doing :)
and we let libvirt implement the restriction.

I do agree we should fix that.

Thanks,
Marcel

>
>>
>> [...]

[...]
