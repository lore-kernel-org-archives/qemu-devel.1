Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkHbo-0006HY-Cx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkHbn-00060c-GQ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:25:16 -0400
References: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
	<5b835c12-04c2-b1f9-4768-0f443742eb07@redhat.com>
	<5a85f2a6-feb7-dd11-53f2-91df6262a827@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <355a2c68-e46b-97f7-12d0-1e72c8f09c13@redhat.com>
Date: Tue, 22 Aug 2017 18:25:04 -0400
MIME-Version: 1.0
In-Reply-To: <5a85f2a6-feb7-dd11-53f2-91df6262a827@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Use after free problem somewhere in ahci.c or
 ich.c code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>



On 08/22/2017 05:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/22/2017 03:39 PM, John Snow wrote:
>> On 08/22/2017 02:15 PM, Thomas Huth wrote:
>>>
>>> Looks like there is a use-after-free problem somewhere in
>>> the ahci.c or ich.c code when trying to add the ich9-ahci
>>> on a old PC machine. Using valgrind, I get:
>>>
>=20
> those old PC don't support AHCI hotplug, so realize() fails then
> unparent() is called.
>=20
>> I'll look; it looks like it works okay for pc-i440fx-2.9 as well as 2.=
0
>> and 1.7.
>>
>> 1.6 appears to be the most modern board that has issues, as well as 1.=
4
>> and the pc-1.2 board you specify.
>=20
> commit 9e047b982452 "piix4: add acpi pci hotplug support"
>=20
> "Add support for acpi pci hotplug using the new infrastructure.
> PIIX4 legacy interface is maintained as is for machine types 1.7 and
> older."
>=20
> I see piix4_pm_init() disabling use_acpi_pci_hotplug if xen_enabled(),
> later when piix4_device_plug_cb() is called for TYPE_PCI_DEVICE it
> checks xen_enabled() instead of checking use_acpi_pci_hotplug.
> Same happens in piix4_device_unplug_request_cb(), not sure it can be
> reached although.
>=20
> My guess is changing !xen_enabled() -> s->use_acpi_pci_hotplug fixes
> this issue, but I'm not sure this is the safest way to fix it.
>=20
> I'll send a patch.
>=20
> Regards,
>=20
> Phil.

Beat me to it! I'll review, thanks.
