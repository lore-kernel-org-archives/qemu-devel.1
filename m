Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dS6Ck-0007p2-PB
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dS6Cg-0007RX-N5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dS6Cg-0007R6-EV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:36:10 -0400
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-2-marcandre.lureau@redhat.com>
	<56d715b2-4d6b-44ab-0fc6-9e8c0b451623@redhat.com>
	<20170703182710.GS12152@localhost.localdomain>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c461d127-e7c7-3d82-7788-cf31bdafdf86@redhat.com>
Date: Mon, 3 Jul 2017 20:35:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170703182710.GS12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] vmgenid: replace
 x-write-pointer-available hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, imammedo@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 07/03/17 20:27, Eduardo Habkost wrote:
> On Mon, Jul 03, 2017 at 08:06:33PM +0200, Laszlo Ersek wrote:
>> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
>>> This compat property sole function is to prevent the device from bein=
g
>>> instantiated. Instead of requiring an extra compat property, check if
>>> fw_cfg has DMA enabled.
>>>
>>> This has the additional benefit of handling other cases properly, lik=
e:
>>>
>>>   $ qemu-system-x86_64 -device vmgenid -machine none
>>>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write sup=
port in fw_cfg, which this machine type does not provide
>>>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global=
 fw_cfg.dma_enabled=3Doff
>>>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write sup=
port in fw_cfg, which this machine type does not provide
>>>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global=
 fw_cfg.dma_enabled=3Don
>>>   [boots normally]
>>>
>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  include/hw/acpi/bios-linker-loader.h | 2 ++
>>>  include/hw/compat.h                  | 4 ----
>>>  hw/acpi/bios-linker-loader.c         | 6 ++++++
>>>  hw/acpi/vmgenid.c                    | 9 +--------
>>>  4 files changed, 9 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/b=
ios-linker-loader.h
>>> index efe17b0b9c..a711dbced8 100644
>>> --- a/include/hw/acpi/bios-linker-loader.h
>>> +++ b/include/hw/acpi/bios-linker-loader.h
>>> @@ -7,6 +7,8 @@ typedef struct BIOSLinker {
>>>      GArray *file_list;
>>>  } BIOSLinker;
>>> =20
>>> +bool bios_linker_loader_can_write_pointer(void);
>>> +
>>>  BIOSLinker *bios_linker_loader_init(void);
>>> =20
>>>  void bios_linker_loader_alloc(BIOSLinker *linker,
>>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>>> index 26cd5851a5..36f02179ac 100644
>>> --- a/include/hw/compat.h
>>> +++ b/include/hw/compat.h
>>> @@ -150,10 +150,6 @@
>>>          .driver   =3D "fw_cfg_io",\
>>>          .property =3D "dma_enabled",\
>>>          .value    =3D "off",\
>>> -    },{\
>>> -        .driver   =3D "vmgenid",\
>>> -        .property =3D "x-write-pointer-available",\
>>> -        .value    =3D "off",\
>>>      },
>>> =20
>>>  #define HW_COMPAT_2_3 \
>>> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loade=
r.c
>>> index 046183a0f1..587d62cb93 100644
>>> --- a/hw/acpi/bios-linker-loader.c
>>> +++ b/hw/acpi/bios-linker-loader.c
>>> @@ -168,6 +168,12 @@ bios_linker_find_file(const BIOSLinker *linker, =
const char *name)
>>>      return NULL;
>>>  }
>>> =20
>>> +bool bios_linker_loader_can_write_pointer(void)
>>> +{
>>> +    FWCfgState *fw_cfg =3D fw_cfg_find();
>>> +    return fw_cfg && fw_cfg_dma_enabled(fw_cfg);
>>> +}
>>> +
>>>  /*
>>>   * bios_linker_loader_alloc: ask guest to load file into guest memor=
y.
>>>   *
>>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>>> index a32b847fe0..ab5da293fd 100644
>>> --- a/hw/acpi/vmgenid.c
>>> +++ b/hw/acpi/vmgenid.c
>>> @@ -205,17 +205,11 @@ static void vmgenid_handle_reset(void *opaque)
>>>      memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le)=
);
>>>  }
>>> =20
>>> -static Property vmgenid_properties[] =3D {
>>> -    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
>>> -                     write_pointer_available, true),
>>> -    DEFINE_PROP_END_OF_LIST(),
>>> -};
>>> -
>>>  static void vmgenid_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      VmGenIdState *vms =3D VMGENID(dev);
>>> =20
>>> -    if (!vms->write_pointer_available) {
>>> +    if (!bios_linker_loader_can_write_pointer()) {
>>>          error_setg(errp, "%s requires DMA write support in fw_cfg, "
>>>                     "which this machine type does not provide", VMGEN=
ID_DEVICE);
>>>          return;
>>> @@ -239,7 +233,6 @@ static void vmgenid_device_class_init(ObjectClass=
 *klass, void *data)
>>>      dc->vmsd =3D &vmstate_vmgenid;
>>>      dc->realize =3D vmgenid_realize;
>>>      dc->hotpluggable =3D false;
>>> -    dc->props =3D vmgenid_properties;
>>> =20
>>>      object_class_property_add_str(klass, VMGENID_GUID, NULL,
>>>                                    vmgenid_set_guid, NULL);
>>>
>>
>> I believe we discussed this approach back then (but I can't find the
>> relevant messages, of course).
>>
>> What guarantees that, by the time you call fw_cfg_find() from
>> vmgenid_realize() -- that is, from the realize function of an
>> independent device --, the fw_cfg device will have been realized (with
>> its properties having taken their final values)? I don't see how the
>> ordering is guaranteed here; please explain (preferably in the commit
>> message).
>=20
> Good point.  What makes this work is the fact that fw_cfg is a built-in
> device that is initialized very early by the machine init code.  We
> could remove that requirement, but it would require reporting errors
> from the machine_done notifier (in acpi_setup(), probably).  I'm not
> sure it would be worth the extra complexity.

Thank you for the explanation -- I agree we shouldn't up-end the code
now, but I think two sets of documentation should be added:

- the commit message should capture your explanation

- the bios_linker_loader_can_write_pointer() function should have a
reminder that board code must realize fw_cfg first, as a fixed (sysbus?)
device, before another device realize function reaches
bios_linker_loader_can_write_pointer().

(CC'ing Mark Cave-Ayland for any necessary co-ordination.)

> We have at least one other device that also assumes fw_cfg_find() can b=
e
> safely used on realize: pvpanic.

Good point.

Thanks
Laszlo
