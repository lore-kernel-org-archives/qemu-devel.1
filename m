Received: from eggs.gnu.org ([2001:4830:134:3::10]:41295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fE7dl-0007uA-7s
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fE7dg-0002oh-BA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:53 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:51132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fE7dg-0002oJ-3k
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:48 -0400
Received: by mail-it0-x235.google.com with SMTP id p3-v6so20585190itc.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 23:22:48 -0700 (PDT)
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
	<6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
	<6a553611-7bbb-98dd-6dfb-0ef6f53e4dec@ozlabs.ru>
	<c1d40d88-1c80-2bbd-c28c-613b7fe8d45e@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20c40fb6-b2d1-1b9c-46bf-dce93bfccc56@ozlabs.ru>
Date: Thu, 3 May 2018 16:22:41 +1000
MIME-Version: 1.0
In-Reply-To: <c1d40d88-1c80-2bbd-c28c-613b7fe8d45e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 2/5/18 7:50 pm, Paolo Bonzini wrote:
> On 02/05/2018 11:33, Alexey Kardashevskiy wrote:
>>>>>>> +# Note: the handler creates an object, enumerates properties and destroys
>>>>>>> +# the object so it only lists properties created in TypeInfo::instance_init().
>>>>>>> +# Since the instance_init() callback of the device object adds
>>>>>>> +# DeviceClass::props as object properties, they will be listed as well.
>>
>> There are roughly 400 of realize(), this is will take a bit of time :)
>> imho what it does belongs to .json, why it does exactly that belongs to the
>> git commit log. I'll walk through the realize() hook though, educate
>> myself, at least :)
> 
> Cheer up, there are only 300 callers of object_property_add_* (apart
> from object_property_add_child which is generally not an issue).  You
> could look at those instead. :)

I did not have to go too far for an example:

piix4_pm_realize() calls piix4_pm_add_propeties() and acpi_pcihp_init() and
piix4_acpi_system_hot_add_init() and these guys create
bool/uint8_ptr/uint16_ptr/uint32_ptr properties:



hw/acpi/piix4.c|477| object_property_add_uint8_ptr(OBJECT(s),
ACPI_PM_PROP_ACPI_ENABLE_CMD,
hw/acpi/piix4.c|479| object_property_add_uint8_ptr(OBJECT(s),
ACPI_PM_PROP_ACPI_DISABLE_CMD,
hw/acpi/piix4.c|481| object_property_add_uint32_ptr(OBJECT(s),
ACPI_PM_PROP_GPE0_BLK,
hw/acpi/piix4.c|483| object_property_add_uint32_ptr(OBJECT(s),
ACPI_PM_PROP_GPE0_BLK_LEN,
hw/acpi/piix4.c|485| object_property_add_uint16_ptr(OBJECT(s),
ACPI_PM_PROP_SCI_INT,
hw/acpi/piix4.c|487| object_property_add_uint32_ptr(OBJECT(s),
ACPI_PM_PROP_PM_IO_BASE,
hw/acpi/piix4.c|642| object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",



> Seriously, I think the problem with the comment is only that the reader
> most likely doesn't care about instance_init() or props, as those are
> QEMU implementation details.
So I am putting the chunk below (cut-n-pasted from this thread) for each
command (i.e. twice) instead of my stuff and repost?

===
  Objects can create properties at runtime, for example to describe
  links between different devices and/or objects. These properties
  are not included in the output of this command.
===




--
Alexey
