Received: from eggs.gnu.org ([2001:4830:134:3::10]:42078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ebWYD-0007Ho-8I
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ebWY9-000507-AR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:05:37 -0500
References: <20180110190909.20652-1-marcel@redhat.com>
	<5ea6ecb8-8866-b396-2c45-bac340a400e7@redhat.com>
	<3a752931-71f0-4708-c57b-6bab609e3a60@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <523385d1-3632-13b1-a26b-aa5d2ca5556c@redhat.com>
Date: Tue, 16 Jan 2018 20:05:22 +0100
MIME-Version: 1.0
In-Reply-To: <3a752931-71f0-4708-c57b-6bab609e3a60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-bridge: fix QEMU crash because of
 pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: qemu-stable@nongnu.org, zuban32s@gmail.com

On 01/15/18 17:31, Marcel Apfelbaum wrote:
> On 15/01/2018 17:54, Laszlo Ersek wrote:
>> On 01/10/18 20:09, Marcel Apfelbaum wrote:
>>> If we try to use more pcie_root_ports then available slots
>>> and an IO hint is passed to the port, QEMU crashes because
>>> we try to init the "IO hint" capability even if the device
>>> is not created.
>>> Fix it by checking for error before adding the capability,
>>> so QEMU can fail gracefully.
>>>
>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>> ---
>>> =C2=A0 hw/pci-bridge/gen_pcie_root_port.c | 7 ++++++-
>>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> In your opinion, can we add:
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 226263fb5cdaa4a4a95f1680fabbc9dd2123fd67
>>
>> ?
>>
>> (Not sure if a stable branch is already open for 2.11. Commit
>> 226263fb5cdaa appeared in 2.11.)
>>
>> Ah, I'm silly. You CC'd stable up-front. :)
>>
>> So, what about the Fixes tag?
>>
>=20
> For sure, I wasn't aware of the "Fixes" tag. I'll be sure to use it
> in the future.
>=20
> Do I need to resend, or Michael can pick the tag?

I think Michael can add the tag the same as my R-b.

Thanks,
Laszlo

>=20
>>>
>>> diff --git a/hw/pci-bridge/gen_pcie_root_port.c
>>> b/hw/pci-bridge/gen_pcie_root_port.c
>>> index ad4e6aa7ff..0e2f2e8bf1 100644
>>> --- a/hw/pci-bridge/gen_pcie_root_port.c
>>> +++ b/hw/pci-bridge/gen_pcie_root_port.c
>>> @@ -74,8 +74,13 @@ static void gen_rp_realize(DeviceState *dev, Error
>>> **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *d =3D PCI_DEVICE(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GenPCIERootPort *grp =3D GEN_PCIE_ROOT=
_PORT(d);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIERootPortClass *rpc =3D PCIE_ROOT_P=
ORT_GET_CLASS(d);
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rpc->parent_realize(dev, errp);
>>> +=C2=A0=C2=A0=C2=A0 rpc->parent_realize(dev, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc =3D pci_bridge_qemu_rese=
rve_cap_init(d, 0,
>>> grp->bus_reserve,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 grp->io_reserve, grp->mem_reserve, grp->pref32_reserve,
>>>
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>
>=20
> Appreciated!
>=20
> Thanks,
> Marcel
>=20
>> Thanks
>> Laszlo
>>
>=20
