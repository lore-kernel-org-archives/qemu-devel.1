Received: from eggs.gnu.org ([2001:4830:134:3::10]:55964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fpZMj-0000Qq-Ih
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fpZMg-0001xn-8w
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:28:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fpZMg-0001xO-4B
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:28:02 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<43bf022f-6059-8e93-f8c3-61a7ecb72178@linux.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6c406b79-ff47-fbbd-a700-df38f06960db@redhat.com>
Date: Tue, 14 Aug 2018 15:27:58 +0200
MIME-Version: 1.0
In-Reply-To: <43bf022f-6059-8e93-f8c3-61a7ecb72178@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com

On 08/14/18 10:39, Liu, Jing2 wrote:
> Hi Laszlo,
> Sorry for late reply. I missed these mails because of wrong filter.
> And thanks very much for comments. My reply as belows.
>=20
> On 8/7/2018 8:19 PM, Laszlo Ersek wrote:
>> On 08/07/18 09:04, Jing Liu wrote:
> [...]
>>> @@ -46,6 +46,12 @@ struct PCIBridgeDev {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OnOffAuto msi;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* additional resources to reserve on firmware in=
it */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t io_reserve;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t mem_reserve;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t pref32_reserve;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t pref64_reserve;
>>> =C2=A0 };
>>> =C2=A0 typedef struct PCIBridgeDev PCIBridgeDev;
>>
>> (1) Please evaluate the following idea:
>>
> This is really good and I'm only not sure if DEFINE_PROP_ like,
> DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
> res_reserve.bus_reserve, -1), is a right/good way?
> I mean the third parameter "_f".

Yes, I think you can refer to members within structure fields like that.

>=20
> [...]
>>
>> - gen_rp_props should be updated accordingly. The property names shoul=
d
>> stay the same, but they should reference fields of the "res_reserve"
>> field.
>>
>> (2) Then, in a separate patch, you can add another "res_reserve" field
>> to "PCIBridgeDev". (As a consequence, "bus_reserve" will also be added=
,
>> which I think is the right thing to do.)
>>
> I consider whether we need limit the bus_reserve of pci-pci bridge. For
> old codes, we could add "unlimited" numbers of devices (but less than
> than max) onto pci-pci bridge.

In theory the bus_reserve hint makes sense too. There likely isn't a
great use case for it in practice, but that's not reason enough IMO to
diverge in the implementation (the factored-out structure and the
properties). It's certainly not wrong to offer the property, IMO.


>=20
>> (3) There is a class that is derived from TYPE_PCI_BRIDGE_DEV:
>> TYPE_PCI_BRIDGE_SEAT_DEV. Is it correct to add the new properties /
>> fields to the latter as well?
>>
> Umm, I looked into the codes that doesn't have hotplug property?
> So do we need add resource reserve for it?

No clue. I don't know anything about TYPE_PCI_BRIDGE_SEAT_DEV; I'll have
to defer to Marcel and others on that.

>=20
>>> =C2=A0 @@ -95,6 +101,13 @@ static void pci_bridge_dev_realize(PCIDevi=
ce
>>> *dev, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(loc=
al_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 err =3D pci_bridge_qemu_reserve_cap_init(d=
ev, 0, 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge_dev->i=
o_reserve, bridge_dev->mem_reserve,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge_dev->p=
ref32_reserve, bridge_dev->pref64_reserve,
>>> errp);
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cap_error;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (shpc_present(dev)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* TODO: spec =
recommends using 64 bit prefetcheable BAR.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Check =
whether that works well. */
>>> @@ -103,6 +116,8 @@ static void pci_bridge_dev_realize(PCIDevice
>>> *dev, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0 +cap_error:
>>> +=C2=A0=C2=A0=C2=A0 msi_uninit(dev);
>>
>> (4) This error handler doesn't look entirely correct; we can reach it
>> without having initialized MSI. (MSI setup is conditional; and even if
>> we attempt it, it is permitted to fail with "msi=3Dauto".) Therefore,
>> msi_uninit() should be wrapped into "if (msi_present())", same as you
>> see in pci_bridge_dev_exitfn().
>=20
> sure, can add a pre-check. But I don't understand why we need that,
> msi_uninit() will check msi_present()?

Thanks for pointing that out.

So, I grepped the source code for msi_uninit(). It seems that only one
location gates it with msi_present() -- in pci_bridge_dev_exitfn() --,
while 13 other locations just call it unconditionally.

I don't know what the consistent approach is here. I'll have to defer to
the PCI maintainers; their taste will decide. Technically your code
looks correct, then.

Thanks
Laszlo
