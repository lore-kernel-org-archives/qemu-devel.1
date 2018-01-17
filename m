Received: from eggs.gnu.org ([2001:4830:134:3::10]:45577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eboed-0000wM-By
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eboeZ-0006ge-3j
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:25:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eboeY-0006bm-Th
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:25:23 -0500
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
	<b706db4f-b103-9433-9973-762c7c594005@amsat.org>
	<3012b56d-9242-47ee-eb58-530080ba8c43@redhat.com>
	<f59cf77f-e796-19a7-148f-d91fbd09b9b8@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <d9ab0369-774b-4e2b-ba6d-18685ca4e00a@redhat.com>
Date: Wed, 17 Jan 2018 16:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <f59cf77f-e796-19a7-148f-d91fbd09b9b8@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, atar4qemu@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/01/2018 22:05, Mark Cave-Ayland wrote:
> On 16/01/18 14:23, Marcel Apfelbaum wrote:
>=20
>> Hi Philippe,
>>
>> On 16/01/2018 2:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>> CC'ing PCI maintainers.
>>>
>>> Hi Mark,
>>>
>>> On 01/15/2018 05:58 PM, Mark Cave-Ayland wrote:
>>>> This inbuilt device contains a single 4-byte register, of which bit =
24 is used
>>>> to power down the machine on a real Ultra 5.
>>>>
>>>> The power device exists at offset 0x724000 on a real machine, but du=
e to the
>>>> current configuration of the BARs in QEMU it must be located lower i=
n PCI IO
>>>> space.
>>> Is is some issue in pci_bar_address()?
>>>
>>
>> The QEMU IO layout:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * QEMU I/O address space usage:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 0000 - 0fff=C2=A0=C2=A0=C2=
=A0 legacy isa, pci config, pci root bus, ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 1000 - 9fff=C2=A0=C2=A0=C2=
=A0 free
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 a000 - afff=C2=A0=C2=A0=C2=
=A0 hotplug (cpu, pci via acpi, i440fx/piix only)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 b000 - bfff=C2=A0=C2=A0=C2=
=A0 power management (PORT_ACPI_PM_BASE)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ qemu 1.=
4+ implements pci config registers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 properly so guests can place the registers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 where they want, on older versions its fixed ]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 c000 - ffff=C2=A0=C2=A0=C2=
=A0 free, traditionally used for pci io
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> As you can see we don't have IO address space over ffff.
>=20
> Well that's not actually quite true - we use a separate ebus address sp=
ace for the onboard devices (and that does have=20
> 32-bit PCI IO accesses enabled), but the issue here is one of the sun4u=
 PCI host/onboard device configuration rather=20
> than anything to do with QEMU.
>=20

Got it, thanks (the above is probably true only for x86 machines)
Marcel

>=20
> ATB,
>=20
> Mark.
