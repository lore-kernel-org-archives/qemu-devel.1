Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQbY-0005OA-Qw
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQbX-0004pA-Mg
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:42:40 -0500
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
	<20171205065304.GK3057@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
Date: Tue, 5 Dec 2017 22:42:25 -0500
MIME-Version: 1.0
In-Reply-To: <20171205065304.GK3057@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DSh1Q1apNLikkIXrFAu1PCivSp0rCLSWk"
Subject: Re: [Qemu-devel] [PATCH 13/17] e500: move PCI host bridge into CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DSh1Q1apNLikkIXrFAu1PCivSp0rCLSWk
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
Subject: Re: [PATCH 13/17] e500: move PCI host bridge into CCSR
References: <cover.1511731946.git.mdavidsaver@gmail.com>
 <15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
 <20171205065304.GK3057@umbus.fritz.box>
In-Reply-To: <20171205065304.GK3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 01:53 AM, David Gibson wrote:
> On Sun, Nov 26, 2017 at 03:59:11PM -0600, Michael Davidsaver wrote:
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> Hmm.  Is there anything you're *not* planning to move under the CCSR.

Well, the decrementer/timebase initialization for one as this has
nothing to do with the CCSR registers.

I haven't added the TSEC/eTSEC instances either.
Partly this is because the existing boards, for reasons I don't understan=
d,
use virtio NICs.

Further, the mpc8540 has TSEC instances 1 and 2, while the mpc8544
has instances 1 and 3.  So I decided to leave NIC setup to the Machine
rather then add the extra code to parameterize this under the CCSR device=
=2E

> If not, I'm really wondering if the CCSR ought to be a device in its
> own right, rather than just a container memory region used within the
> machine.

I don't think I follow what you mean by "device" in this context?
The CCSR object is a SysBusDevice in the qom tree ("/machine/e500-ccsr").=

What device-like characteristics could it have?


>> ---
>>  hw/ppc/e500.c      | 13 ++++---------
>>  hw/ppc/e500_ccsr.c | 27 +++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index cfd5ed0152..b0c8495aef 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -769,6 +769,8 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>>      qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
>>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
>>      qdev_prop_set_uint32(dev, "ram-size", ram_size);
>> +    qdev_prop_set_uint32(dev, "pci_first_slot", params->pci_first_slo=
t);
>> +    qdev_prop_set_uint32(dev, "pci_first_pin_irq", pci_irq_nrs[0]);
>>      qdev_init_nofail(dev);
>>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0=
);
>> =20
>> @@ -778,20 +780,13 @@ void ppce500_init(MachineState *machine, PPCE500=
Params *params)
>> =20
>> =20
>>      /* PCI */
>> -    dev =3D qdev_create(NULL, "e500-pcihost");
>> -    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(=
dev),
>> -                              &error_abort);
>> -    qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
>> -    qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
>> -    qdev_init_nofail(dev);
>> +    dev =3D DEVICE(object_resolve_path("/machine/pci-host", 0));
>> +    assert(dev);
>>      s =3D SYS_BUS_DEVICE(dev);
>>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
>>          sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nr=
s[i]));
>>      }
>> =20
>> -    memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFF=
SET,
>> -                                sysbus_mmio_get_region(s, 0));
>> -
>>      pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>>      if (!pci_bus)
>>          printf("couldn't create PCI controller!\n");
>> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
>> index cd8216daaf..4ec8f7524d 100644
>> --- a/hw/ppc/e500_ccsr.c
>> +++ b/hw/ppc/e500_ccsr.c
>> @@ -50,6 +50,8 @@
>> =20
>>  #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
>> =20
>> +#define E500_PCI_OFFSET  (0x8000ULL)
>> +
>>  #define E500_PORPLLSR    (0xE0000)
>>  #define E500_PVR         (0xE00A0)
>>  #define E500_SVR         (0xE00A4)
>> @@ -75,6 +77,7 @@ typedef struct {
>> =20
>>      DeviceState *pic;
>>      DeviceState *i2c;
>> +    DeviceState *pcihost;
>>  } CCSRState;
>> =20
>>  #define TYPE_E500_CCSR "e500-ccsr"
>> @@ -201,6 +204,7 @@ static void e500_ccsr_init(Object *obj)
>>      DeviceState *dev =3D DEVICE(obj);
>>      CCSRState *ccsr =3D E500_CCSR(dev);
>> =20
>> +    /* prepare MPIC */
>>      assert(current_machine);
>>      if (kvm_enabled()) {
>> =20
>> @@ -228,6 +232,18 @@ static void e500_ccsr_init(Object *obj)
>>      object_property_add_alias(obj, "mpic-model",
>>                                OBJECT(ccsr->pic), "model",
>>                                &error_fatal);
>> +
>> +    /* prepare PCI host bridge */
>> +    ccsr->pcihost =3D qdev_create(NULL, "e500-pcihost");
>> +    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(=
ccsr->pcihost),
>> +                              &error_abort);
>> +
>> +    object_property_add_alias(obj, "pci_first_slot",
>> +                              OBJECT(ccsr->pcihost), "first_slot",
>> +                              &error_fatal);
>> +    object_property_add_alias(obj, "pci_first_pin_irq",
>> +                              OBJECT(ccsr->pcihost), "first_pin_irq",=

>> +                              &error_fatal);
>>  }
>> =20
>>  static void e500_ccsr_realize(DeviceState *dev, Error **errp)
>> @@ -240,6 +256,7 @@ static void e500_ccsr_realize(DeviceState *dev, Er=
ror **errp)
>>                            ccsr, "e500-ccsr", 1024 * 1024);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &ccsr->iomem);
>> =20
>> +    /* realize MPIC */
>>      qdev_init_nofail(ccsr->pic);
>>      pic =3D SYS_BUS_DEVICE(ccsr->pic);
>> =20
>> @@ -275,6 +292,13 @@ static void e500_ccsr_realize(DeviceState *dev, E=
rror **errp)
>>                                  sysbus_mmio_get_region(pic, 0));
>>      /* Note: MPIC internal interrupts are offset by 16 */
>> =20
>> +    /* realize PCI host bridge*/
>> +    qdev_init_nofail(ccsr->pcihost);
>> +
>> +    memory_region_add_subregion(&ccsr->iomem, E500_PCI_OFFSET,
>> +                                sysbus_mmio_get_region(
>> +                                    SYS_BUS_DEVICE(ccsr->pcihost), 0)=
);
>> +
>>      /* attach I2C controller */
>>      ccsr->i2c =3D qdev_create(NULL, "mpc8540-i2c");
>>      object_property_add_child(qdev_get_machine(), "i2c[*]",
>> @@ -314,6 +338,9 @@ static Property e500_ccsr_props[] =3D {
>>      DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
>>      DEFINE_PROP_UINT32("ccb-freq", CCSRState, ccb_freq, 333333333u),
>>      /* "mpic-model" aliased from MPIC */
>> +    /* "pci_first_slot"
>> +     * "pci_first_pin_irq" aliased from PCI host bridge
>> +     */
>>      DEFINE_PROP_END_OF_LIST()
>>  };
>> =20
>=20



--DSh1Q1apNLikkIXrFAu1PCivSp0rCLSWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAlonZyEACgkQlAHmyz1/
GOqidhAAi3Bc1sZWTYQKuUaAJ9oduGaiHdR39C4CdTYTTZ7rawATFuu2g082zLnM
bMSFD5V2XBRmPvrHlMtzIDlTAA4o23NWLiFVgAHyfHUkUUJcahR/xGGp0RZ9VmYx
N/N6Bbr7wjd3PfOtmPdTOYV931itlvdDughEJEGpVLShswj3hOpZcxkfnLcWYESo
iuhY8RoZ1ZIAousHu2pXpfoObcjo7xpRuXrCJGwgsGy/d4gFOng2aXcTBTDqJrWf
WsHNoP34vscqy322YguwFxQly2FvHSSK2AuCn5zFnMCwskfRDR5IzbY+qBwyrQi1
rBjSvZJNtSUZC5rZdSDxwrsk/xRtF8Zu9IFz+YkoU4oCUfSAvim9a+PO+gDie/5t
kBh/Lbf6gZmBbW/4vnp3UScjCwPxKOHjVKWJYeBFHA2TZ73KkpfuYMETMgoIvRm+
CCo+8H2obzfckey7rCdi2+TVdRISPBW52T2FPvGBucztbgmgddHgj6BF/3mLdzDA
ihp8bdf5o7HuyZmYRsUNjazx758lPs6kWuuHx0AbPoqiFEJDSyYnGwqlNIHlMkwm
JzBTIEBxG9IwbMzOQF6M5lTxCLkB2wFI/rerydZJplrVPQ1qUOqdSg4VlJqkCTCC
fh1cc/d1794/N8v8iv48XuK68cd0BMOaUQ66CjWlRm9WGlWb9Jc=
=5YGD
-----END PGP SIGNATURE-----

--DSh1Q1apNLikkIXrFAu1PCivSp0rCLSWk--
