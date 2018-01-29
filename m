Received: from eggs.gnu.org ([2001:4830:134:3::10]:51530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eg6zz-0005PC-N2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eg6zw-0001TC-Jk
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:49:15 -0500
References: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
	<20180127091552.GC12900@umbus>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <12b543eb-419e-5279-4f13-e5ee466c4d17@redhat.com>
Date: Mon, 29 Jan 2018 11:49:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180127091552.GC12900@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix MSI/MSIX selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 27/01/2018 10:15, David Gibson wrote:
> On Fri, Jan 26, 2018 at 11:25:24PM +0100, Greg Kurz wrote:
>> In various place we don't correctly check if the device supports MSI o=
r
>> MSI-X. This can cause devices to be advertised with MSI support, even
>> if they only support MSI-X (like virtio-pci-* devices for example):
>>
>>                 ethernet@0 {
>>                         ibm,req#msi =3D <0x1>; <--- wrong!
>> 			.
>> 			ibm,loc-code =3D "qemu_virtio-net-pci:0000:00:00.0";
>> 			.
>> 			ibm,req#msi-x =3D <0x3>;
>>                 };
>>
>> Worse, this can also cause the "ibm,change-msi" RTAS call to corrupt t=
he
>> PCI status and cause migration to fail:
>>
>>   qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x6
>>     read: 0 device: 10 cmask: 10 wmask: 0 w1cmask:0
>>                               ^^
>>            PCI_STATUS_CAP_LIST bit which is assumed to be constant
>>
>> This patch changes spapr_populate_pci_child_dt() to properly check for
>> MSI support using msi_present(): this ensures that PCIDevice::msi_cap
>> was set by msi_init() and that msi_nr_vectors_allocated() will look at
>> the right place in the config space.
>>
>> Checking PCIDevice::msix_entries_nr is enough for MSI-X but let's add
>> a call to msix_present() there as well for consistency.
>>
>> It also changes rtas_ibm_change_msi() to select the appropriate MSI
>> type in Function 1 instead of always selecting plain MSI. This new
>> behaviour is compliant with LoPAPR 1.1, as described in "Table 71.
>> ibm,change-msi Argument Call Buffer":
>>
>>   Function 1: If Number Outputs is equal to 3, request to set to a new
>>            number of MSIs (including set to 0).
>>            If the =E2=80=9Cibm,change-msix-capable=E2=80=9D property e=
xists and Number
>>            Outputs is equal to 4, request is to set to a new number of
>>            MSI or MSI-X (platform choice) interrupts (including set to
>>            0).
>>
>> Since MSI is the the platform default (LoPAPR 6.2.3 MSI Option), let's
>> check for MSI support first.
>>
>> And finally, it checks the input parameters are valid, as described in
>> LoPAPR 1.1 "R1=E2=80=937.3.10.5.1=E2=80=933":
>>
>>   For the MSI option: The platform must return a Status of -3 (Paramet=
er
>>   error) from ibm,change-msi, with no change in interrupt assignments =
if
>>   the PCI configuration address does not support MSI and Function 3 wa=
s
>>   requested (that is, the =E2=80=9Cibm,req#msi=E2=80=9D property must =
exist for the PCI
>>   configuration address in order to use Function 3), or does not suppo=
rt
>>   MSI-X and Function 4 is requested (that is, the =E2=80=9Cibm,req#msi=
-x=E2=80=9D property
>>   must exist for the PCI configuration address in order to use Functio=
n 4),
>>   or if neither MSIs nor MSI-Xs are supported and Function 1 is reques=
ted.
>>
>> This ensures that the ret_intr_type variable contains a valid MSI type
>> for this device, and that spapr_msi_setmsg() won't corrupt the PCI sta=
tus.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Applied, thanks.
>=20
> Alexey, is this the migration bug you were mentioning to me?
>=20
> +lvivier
>=20
> Laurent, could this cover any of the migration bugs you're looking at?
> If not we should probably file a new downstream BZ for it.

It doesn't fix my problem:. I have always this kind of error after a
migration on P9:

[   39.305470] Unable to handle kernel paging request for d6
[   39.305534] Faulting instruction address: 0xc000000000694ac0

[   39.305578] Oops: Kernel access of bad area, sig: 11 [#1]
...
[   39.306625] NIP [c000000000694ac0] ioread16+0x30/0x1a0

[   39.306655] LR [c008000000bb074c] vp_get+0x15c/0x190 [virtio_pci]

[   39.306690] Call Trace:

[   39.306707] [c00000000315fb50] [c00000000001c9c0]
__switch_to+0x330/0x660 (u)
[   39.306761] [c00000000315fbc0] [c008000000bb074c] vp_get+0x15c/0x190
[virtio]
[   39.306812] [c00000000315fc00] [c008000000d41328]
virtnet_config_changed_wor]

Greg, do you have a test case for the bug your patch fixes?

Thanks,
Laurent
