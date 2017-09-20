Received: from eggs.gnu.org ([2001:4830:134:3::10]:47307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufKH-0002MN-ST
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufKB-0001Ro-3J
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dufKA-0001RM-R1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:45:59 -0400
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
	<4ca77991-ad6a-a138-622b-b42f410fa1eb@redhat.com>
	<a8d8ec43-bc27-b28a-dd7d-163a715acb5e@redhat.com>
	<24ca79b9-9350-4339-960b-0dbdf9cd4c5b@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <77945ee2-ccfa-becc-eee1-c4b1066303c7@redhat.com>
Date: Wed, 20 Sep 2017 14:16:42 +0300
MIME-Version: 1.0
In-Reply-To: <24ca79b9-9350-4339-960b-0dbdf9cd4c5b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by
 default for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 20/09/2017 14:01, Laszlo Ersek wrote:
> On 09/20/17 09:42, Marcel Apfelbaum wrote:
>> On 20/09/2017 1:15, Laszlo Ersek wrote:
>=20
>>> It seems that we now have "grp->io_reserve" (a numeric quantity, not =
a
>>> boolean), from property "io-reserve". The default value is -1.
>>>
>>> According to the documentation added in c1800a162765 ("docs: update
>>> documentation considering PCIE-PCI bridge", 2017-08-18), the value -1
>>> seems to imply, "If any reservation field is -1 then this kind of
>>> reservation is not needed and must be ignored by firmware".
>>>
>>
>> This was decided after long long upstream discussions with
>> different maintainers.
>=20
> I know :) I participated in the review, and the documentation patch
> noted above carries my R-b.
>=20
> I didn't mean that the -1 default was wrong, only that we might have to
> polish the definition / semantics a bit.
>=20
>>> I think we'll need to refine the definition. Once OVMF starts process=
ing
>>> this capability, the behavior should be compatible with earlier
>>> behavior. Assume that a user sets only "mem-reserve" to something
>>> different from -1, and thus the capability appears. When OVMF sees th=
e
>>> capability, it should be able to tell apart:
>>>
>>> - no particular hint about IO space, so continue doing whatever has b=
een
>>> done all this time (default IO space reservation),
>>> - do not request IO space reservation at all, > - a given (positive)
>>> size of IO space should be reserved.
>>>
>>> So I think:
>>>
>>> (a) the above read-only mask setting should be done based on
>>>
>>>  =C2=A0=C2=A0 (grp->io_reserve =3D=3D 0)
>>>
>>> and the "enable-io-fwd" property should be unnecessary,
>>>
>>
>> I really want this to be the case,=C2=A0 but I need to check the
>> implementation first. The only concern is the semantics.
>>
>> (grp->io_reserve =3D=3D 0) hints the firmware to take
>> max(hint, <default-value>), since we don't want to reserve less
>> than the IO range needed by existing devices behind the bridge.
>=20
> I agree.
>=20
> In OVMF, I would translate (io_reserve =3D=3D 0) into *not* returning a=
ny
> particular IO reservation hint to the generic PciBusDxe driver, for the
> PCI-E port in question. In turn PciBusDxe follows the above "max"
> semantics, as far as I remember; in other words, setting io_reserve to
> zero wouldn't break existing IO requirements.
>=20
> Here's a table:
>=20
> - io_reserve =3D=3D (-1) --> OVMF returns an IO reservation of 512 byte=
s
>    (which in practice gets rounded up to 4KB). If more IO is needed by
>    devices behind the bridge, then that larger value is used. This is t=
he
>    current behavior and we should keep it.
>=20
> - io_reserve =3D=3D 0 --> OVMF returns no IO reservation at all. If any=
 IO
>    is needed by devices behind the bridge, then that value is used.
>    Otherwise, no IO is allocated.
>=20
> - io_reserve > 0 --> OVMF returns this value to PciBusDxe. PciBusDxe
>    might round it up. If more IO is needed by devices behind the bridge=
,
>    then that larger value is used.
>=20
>> The implementation issue might be that Guest Firmware would
>> take the alignment as default value for an empty root port.
>> (maybe take it as a bug and "solve" it?)
>=20
> Hm, I don't get this. What do you mean?
>=20

Empty PCI Express Root Port with io_reserve =3D 0 should end with
no IO ports range, right?

But there is some code in SeaBIOS that "aligns" the IO range to 4K,
so we may end up with a 4K range even if io_reserve=3D0.


>>
>>> (b) the "io-reserve" property should be set to 0 for 2.11 machine typ=
es
>>> and onward, and to -1 for 2.10 and earlier (for compatibility),
>>>
>>
>> Michael asked us to wait a little before changing the default,
>> you can ask him for more info :)
>=20
> Sure, I'm totally fine with delaying the change to the default value.
>=20
>>
>>> (c) the documentation in "docs/pcie_pci_bridge.txt" should be updated=
 to
>>> say:
>>> * (-1) --> default firmware behavior (unspecified)
>>> *=C2=A0=C2=A0 0=C2=A0 --> do not reserve
>>> *=C2=A0 >0=C2=A0 --> specific reservation requested
>>>
>>
>> Agreed, once I re-check SeaBIOS to confirm behavior.
>=20
> BTW, if the OVMF -- more precisely, PciBusDxe -- and SeaBIOS behaviors
> turn out to differ significantly in the handling of the values (althoug=
h
> I don't expect it, see above -- last time I looked, the interpretations
> were similar), I think it's a possibility (although not optimal) to say
> that the interpretation of these values is firmware specific.
>=20
> We won't know for certain until we write the code and test both firmwar=
es.
>=20
>>
>>> (d) pci_bridge_qemu_reserve_cap_init() should be updated accordingly
>>> (i.e., a conflict exists if both mem_pref_32_reserve and
>>> mem_pref_64_reserve are *positive*),
>>>
>>
>> I thought we have this check already.
>=20
> We have a check like this, but it doesn't use the exact condition that
> I'm suggesting above (emphasis on *positive*). We now have
>=20
>      if (mem_pref_32_reserve !=3D (uint32_t)-1 &&
>          mem_pref_64_reserve !=3D (uint64_t)-1) {
>          error_setg(errp,
>=20
> but after introducing the zero value, this is going to be too strict.
> Consider all the possible combinations:
>=20
> * (-1; -1): default fw behavior, check is OK
>=20
> * (-1;  0): fw sticks with the default for the first component, picks
>              "no reservation" for the second component, check is OK
>=20
> * (-1; >0): fw can treat this identically to ( 0; >0) -- see below. Thi=
s
>              is justified because, while the first component says "use
>              the default", the entire situation of having such a
>              capability is new, so the firmware can introduce new ways
>              for handling it. The check passes, which is good.
>=20
> * ( 0;  0): check reports error, but the firmware can handle this case
>              fine (no reservation for either component)
>=20
> * ( 0; >0): check reports error, but the fw can handle this (no
>              reservation for the first component, specific reservation
>              for the second)
>=20
> * (>0; >0): conflict, check is OK
>=20
> (I'm skipping the description of the inverted orderings, such as (0;-1)=
,
> they behave similarly.)
>=20
> So we need to accept 0 as "valid" for either component:
>=20
>      if (mem_pref_32_reserve > 0 &&
>          mem_pref_32_reserve < (uint32_t)-1 &&
>          mem_pref_64_reserve > 0 &&
>          mem_pref_64_reserve < (uint64_t)-1) {
>          error_setg(errp,
>=20

Got it, you are right. How did we end up with something
complicated again :( ?
(complicated =3D needs documentation and not straight forward)

>>
>>>
>>> Second, when determining the reservations in OVMF, I would like to lo=
ok
>>> only at the capability fields, and not do a read-write-read-write
>>> quadruplet to the IO base/limit registers. Do you agree?
>>>
>>
>> Well, as stated before, the semantics for the hint is
>> max(hint, <sum of all IO/MEM ranges for devices behind the bridge>).
>> If you can follow it, that would be OK.
>=20
> In OVMF there are two separate questions:
> - how to report the requested reservations,
> - how to act upon the reported values.
>=20
> The first question pertains to "platform code", i.e., what I'm going to
> implement under OvmfPkg. The second question pertains to "universal
> code" (under "MdeModulePkg/Bus/Pci/PciBusDxe"), which is a lot harder t=
o
> modify, because it is shipped on a wide range of physical platforms too=
.
>=20
> Again, my understanding is that PciBusDxe implements the "max" semantic=
s
> that you describe (pertaining to the 2nd question).
>=20
> My interest is in figuring out the 1st question now, that is, where I
> should take the information from that goes into the "reservation
> description" that PciBusDxe understands. My preference would be to look
> only at the PCIE port in question (i.e. no other PCI devices at all),
> and only at said capability in the config space of the PCIE port.
>=20

Sounds OK.

Thanks,
Marcel

>> Getting back to this patch, setting io-reserve to 0
>> would require also:
>>
>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_word_test_and_clear_=
mask(pci_dev->wmask + PCI_COMMAND,
>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PCI_COMMAND_IO);
>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev->wmask[PCI_IO_BA=
SE] =3D 0;
>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev->wmask[PCI_IO_LI=
MIT] =3D 0;
>>
>> otherwise the Guest OS would not behave, just be aware of it.
>=20
> Absolutely, no doubt about this.
>=20
> Thanks,
> Laszlo
>=20
>=20
>>>>  =C2=A0 static const VMStateDescription vmstate_rp_dev =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "pcie-root-port",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
>>>> @@ -78,6 +111,7 @@ static const VMStateDescription vmstate_rp_dev =3D=
 {
>>>>  =C2=A0 =C2=A0 static Property gen_rp_props[] =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-migrate-msix", G=
enPCIERootPort,
>>>> migrate_msix, true),
>>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("enable-io-fwd", GenPCIERootPor=
t,
>>>> enable_io_fwd, false),
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST()
>>>>  =C2=A0 };
>>>>  =C2=A0 @@ -86,6 +120,7 @@ static void gen_rp_dev_class_init(ObjectC=
lass
>>>> *klass, void *data)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(kla=
ss);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIDeviceClass *k =3D PCI_DEVICE_CLA=
SS(klass);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIERootPortClass *rpc =3D PCIE_ROOT=
_PORT_CLASS(klass);
>>>> +=C2=A0=C2=A0=C2=A0 GenPCIERootPortClass *grpc =3D GEN_PCIE_ROOT_POR=
T_CLASS(klass);
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->vendor_id =3D PCI_VENDOR_I=
D_REDHAT;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->device_id =3D PCI_DEVICE_ID_REDHA=
T_PCIE_RP;
>>>> @@ -96,6 +131,8 @@ static void gen_rp_dev_class_init(ObjectClass
>>>> *klass, void *data)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpc->interrupts_init =3D gen_rp_inte=
rrupts_init;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpc->interrupts_uninit =3D gen_rp_in=
terrupts_uninit;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpc->aer_offset =3D GEN_PCIE_ROOT_PO=
RT_AER_OFFSET;
>>>> +=C2=A0=C2=A0=C2=A0 grpc->parent_realize =3D dc->realize;
>>>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D gen_rp_realize;
>>>>  =C2=A0 }
>>>>  =C2=A0 =C2=A0 static const TypeInfo gen_rp_dev_info =3D {
>>>> @@ -103,6 +140,7 @@ static const TypeInfo gen_rp_dev_info =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D TYPE_PCIE_ROOT_PORT,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(GenPCIERoo=
tPort),
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D ge=
n_rp_dev_class_init,
>>>> +=C2=A0=C2=A0=C2=A0 .class_size=C2=A0=C2=A0=C2=A0 =3D sizeof(GenPCIE=
RootPortClass),
>>>>  =C2=A0 };
>>>>  =C2=A0 =C2=A0=C2=A0 static void gen_rp_register_types(void)
>>>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>>>> index 3e101f8f67..843bf4a3a5 100644
>>>> --- a/include/hw/compat.h
>>>> +++ b/include/hw/compat.h
>>>> @@ -2,7 +2,11 @@
>>>>  =C2=A0 #define HW_COMPAT_H
>>>>  =C2=A0 =C2=A0 #define HW_COMPAT_2_10 \
>>>> -=C2=A0=C2=A0=C2=A0 /* empty */
>>>> +=C2=A0=C2=A0=C2=A0 {\
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver=C2=A0=C2=A0 =3D =
"pcie-root-port",\
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .property =3D "enable-io=
-fwd",\
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .value=C2=A0=C2=A0=C2=A0=
 =3D "true",\
>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>  =C2=A0 =C2=A0 #define HW_COMPAT_2_9 \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {\
>>>>
>>>
>>
>=20
