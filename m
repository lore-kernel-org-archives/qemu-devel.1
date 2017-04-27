Received: from eggs.gnu.org ([2001:4830:134:3::10]:38504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3r61-0004lv-30
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3r5w-00072D-5b
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:37:05 -0400
Message-Id: <59026477020000480014395C@prv-mh.provo.novell.com>
Date: Thu, 27 Apr 2017 15:36:55 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <1493323148-32461-1-git-send-email-brogers@suse.com>
	<alpine.DEB.2.10.1704271403550.2895@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1704271403550.2895@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] ACPI: don't call acpi_pcihp_device_plug_cb
 on xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, imammedo@redhat.com, mst@redhat.com



>>> On 4/27/2017 at 03:09 PM, Stefano Stabellini <sstabellini@kernel.org> =
wrote:=20
> On Thu, 27 Apr 2017, Bruce Rogers wrote:
>> Commit f0c9d64a exposed the issue that with a xenfv machine using
>> pci passthrough, acpi cpi hotplug code was being executed by mistake.
>> Guard calls to acpi_pcihp_device_plug_cb (and corresponding
>> acpi_pcihp_device_unplug_cb) with a check for xen_enabled(). Without
>> this check I am seeing an error that the bus doesn't have the
>> acpi-pcihp-bsel property set.
>>=20
>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>> ---
>>  hw/acpi/piix4.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index a553a7e..c409374 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -385,7 +385,10 @@ static void piix4_device_plug_cb(HotplugHandler=20
> *hotplug_dev,
>>                                  dev, errp);
>>          }
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, =
dev,=20
> errp);
>> +        if (!xen_enabled()) {
>> +            acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug=
, dev,
>> +                                      errp);
>> +        }
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          if (s->cpu_hotplug_legacy) {
>>              legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, =
errp);
>> @@ -408,8 +411,10 @@ static void=20
> piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>          acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotp=
lug,
>>                                        dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, =
dev,
>> -                                    errp);
>> +        if (!xen_enabled()) {
>> +            acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotpl=
ug,=20
> dev,
>> +                                        errp);
>> +        }
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>>                 !s->cpu_hotplug_legacy) {
>>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, =
errp);
>=20
> Wouldn't it be better to simply turn the error_setg("Unsupported bus...)
> in acpi_pcihp_device_plug_cb and acpi_pcihp_device_unplug_cb into debug
> printfs? After all, from this description it is clear that they are not
> an error conditions. PCI Passthough works correctly, right?
>=20
> I realize that I should have suggested this earlier, sorry about that.

I don't think we want to be running through qemu acpi code any more than =
is
necessary when using xen hvm.
