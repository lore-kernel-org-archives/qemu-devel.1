Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIZbA-0002DG-Om
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIZb7-00033O-4Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:34:52 -0400
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-3-david@redhat.com>
	<20181101151034.4eb1618c@redhat.com>
	<85802555-0f27-847d-22a9-e87ce2e5df55@redhat.com>
	<20181102140032.43f6c93c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84cb2e23-7004-fec5-e4de-8f4c2c9725b3@redhat.com>
Date: Fri, 2 Nov 2018 14:34:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181102140032.43f6c93c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] pcihp: overwrite hotplug handler
 recursively from the start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Libvirt <libvir-list@redhat.com>

On 02.11.18 14:00, Igor Mammedov wrote:
> On Fri, 2 Nov 2018 12:43:10 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 01.11.18 15:10, Igor Mammedov wrote:
>>> On Wed, 24 Oct 2018 12:19:25 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> For now, the hotplug handler is not called for devices that are
>>>> being cold plugged. The hotplug handler is setup when the machine
>>>> initialization is fully done. Only bridges that were cold plugged are
>>>> considered.
>>>>
>>>> Set the hotplug handler for the root piix bus directly when realizing.
>>>> Overwrite the hotplug handler of bridges when hotplugging/coldplugging
>>>> them.
>>>>
>>>> This will now make sure that the ACPI PCI hotplug handler is also called
>>>> for cold-plugged devices (also on bridges) and for bridges that were
>>>> hotplugged.
>>>>
>>>> When trying to hotplug a device to a hotplugged bridge, we now correctly
>>>> get the error message
>>>>  "Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set"
>>>> Insted of going via the standard PCI hotplug handler.  
>>> Erroring out is probably not ok, since it can break existing setups
>>> where SHPC hotplugging to hotplugged bridge was working just fine before.  
>>
>> The question is if it actually was supposed (and eventually did) work.
> I think it works now, it's QEMU 'ACPI hotplug hack' (which exists for
> the sake of Windows) limitation. We weren't able to dynamically add
> ACPI description for hotplugged bridge, so it was using native hotplug.
> Now theoretically we can load tables dynamically but that, would add
> maintenance nightmare (versioned tables) and would be harder to debug.
> I'd rather not go that direction and keep current limited version,
> suggesting users to use native hotplug if guest is capable.

Alright I'll keep current behavior (checking if the bridge is hotplugged
or coldplugged). Thanks!


-- 

Thanks,

David / dhildenb
