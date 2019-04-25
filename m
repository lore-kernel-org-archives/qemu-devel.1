Received: from eggs.gnu.org ([209.51.188.92]:60937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJeQc-0000hO-Le
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJeQY-0002MS-0m
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJeQX-0002Im-8N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:37 -0400
Date: Thu, 25 Apr 2019 15:28:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425152824.228a9c8a@redhat.com>
In-Reply-To: <b0d3f541-ead5-830a-2536-4af67f5845da@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-10-git-send-email-imammedo@redhat.com>
	<b0d3f541-ead5-830a-2536-4af67f5845da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/13] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>

On Thu, 25 Apr 2019 14:37:35 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 4/25/19 7:34 AM, Igor Mammedov wrote:
> > once FW provides a pointer to SMBIOS entry point like it does for
> > RSDP it should be possible to enable this one the same way.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> > v3:
> >   - add ref to a uefi-test-tools feature req into comment (Laszlo)
> > ---
> >  tests/bios-tables-test.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 0f24540..1be55a1 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -573,8 +573,15 @@ static void test_acpi_one(const char *params, test=
_data *data)
> >          }
> >      }
> > =20
> > -    test_smbios_entry_point(data);
> > -    test_smbios_structs(data);
> > +    /*
> > +     * TODO: make SMBIOS tests work with UEFI firmware,
> > +     * Bug on uefi-test-tools to provide entry point:
> > +     * https://bugs.launchpad.net/qemu/+bug/1821884
> > +     */
> > +    if (!use_uefi) {
> > +        test_smbios_entry_point(data);
> > +        test_smbios_structs(data);
> > +    } =20
>=20
> Now that Laszlo resolved this bug, you can update the SMBIOS tests :)

It's not on top of priority list, I'll do it later on as time would allow.

For me it's important to get virt-arm ACPI tested so that NEMU folks
could generalize code ACPI between x86- and arm- virt machines without
testing it manually for regressions each time.


> Without this patch I get:
>=20
> ERROR:/home/phil/source/qemu/tests/bios-tables-test.c:460:test_smbios_ent=
ry_point:
> assertion failed (off < 0x100000): (0x00100000 < 0x00100000)
>=20
> And the UEFI console shows:
>=20
> BdsDxe: failed to load Boot0001 "UEFI Misc Device" from
> VenHw(93E34C7E-B50E-11DF-9223-2443DFD72085,00): Not Found
> FatDiskIo: Cache Page OutBound occurred!
> add-symbol-file
> /home/lacos/src/upstream/qemu/tests/uefi-test-tools/Build/UefiTestTools/D=
EBUG_GCC5/AARCH64/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest/DEBUG/Bios=
TablesTest.dll
> 0x442C3000
> Loading driver at 0x000442C2000 EntryPoint=3D0x000442C47AC BiosTablesTest=
.efi
> InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 4654EE18
> ProtectUefiImageCommon - 0x451AA140
>   - 0x00000000442C2000 - 0x0000000000006000
> SetUefiImageMemoryAttributes - 0x00000000442C2000 - 0x0000000000001000
> (0x0000000000004008)
> SetUefiImageMemoryAttributes - 0x00000000442C3000 - 0x0000000000003000
> (0x0000000000020008)
> SetUefiImageMemoryAttributes - 0x00000000442C6000 - 0x0000000000002000
> (0x0000000000004008)
> BdsDxe: starting Boot0002 "UEFI Misc Device 2" from
> PciRoot(0x0)/Pci(0x2,0x0)
> BiosTablesTest: BiosTablesTest=3D45100000 Rsdp10=3D0 Rsdp20=3D44020000
> BiosTablesTest: Smbios21=3D0 Smbios30=3D47640000
> BiosTablesTest: press any key to exit
>=20
> > =20
> >      assert(!global_qtest);
> >      qtest_quit(data->qts);
> >  =20
>=20
