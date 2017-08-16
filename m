Received: from eggs.gnu.org ([2001:4830:134:3::10]:36359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dhvhM-00055b-3H
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dhvhE-00080n-KU
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dhvhE-0007zQ-BH
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:37:08 -0400
References: <1502640203-15577-1-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <53132fbe-ab14-6708-a682-bb5bf2244db0@redhat.com>
Date: Wed, 16 Aug 2017 13:36:56 +0300
MIME-Version: 1.0
In-Reply-To: <1502640203-15577-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] Red Hat PCI bridge resource reserve
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: mst@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

On 13/08/2017 19:03, Aleksandr Bezzubikov wrote:
> Now PCI bridges get a bus range number on a system init,
> basing on currently plugged devices. That's why when one wants to hotpl=
ug another bridge,
> it needs his child bus, which the parent is unable to provide (speaking=
 about virtual device).
> The suggested workaround is to have vendor-specific capability in Red H=
at PCI bridges
> that contains number of additional bus to reserve (as well as IO/MEM/PR=
EF space limit hints)
> on BIOS PCI init.
> So this capability is intended only for pure QEMU->SeaBIOS usage.
>=20
> Considering all aforesaid, this series is directly connected with
> QEMU series "Generic PCIE-PCI Bridge".
>=20
> Although the new PCI capability is supposed to contain various limits a=
long with
> bus number to reserve, now only its full layout is proposed. And
> only bus_reserve field is used in QEMU and BIOS. Limits usage
> is still a subject for implementation as now
> the main goal of this series to provide necessary support from the
> firmware side to PCIE-PCI bridge hotplug.
>=20
> Changes v5->v6:
> 1. Remove unnecessary indents and line breaks (addresses Marcel's comme=
nts)
> 2. Count IO/MEM/PREF region size as a maximum of necessary size and one=
 provide in
> 	RESOURCE_RESERVE capability (addresses Marcel's comment).
> 3. Make the cap debug message more detailed (addresses Marcel's comment=
).
> 4. Change pref_32 and pref_64 cap fields comment.
>=20
> Changes v4->v5:
> 1. Rename capability-related #defines
> 2. Move capability IO/MEM/PREF fields values usage to the regions creat=
ion stage (addresses Marcel's comment)
> 3. The capability layout change: separate pref_mem into pref_mem_32 and=
 pref_mem_64 fields (QEMU side has the same changes) (addresses Laszlo's =
comment)
> 4. Extract the capability lookup and check to the separate function (ad=
dresses Marcel's comment)
> 	- despite of Marcel's comment do not extract field check for -1 since =
it increases code length
> 	  and doesn't look nice because of different field types
> 5. Fix the capability's comment (addresses Marcel's comment)
> 6. Fix the 3rd patch message
>=20
> Changes v3->v4:
> 1. Use all QEMU PCI capability fields - addresses Michael's comment
> 2. Changes of the capability layout (QEMU side has the same changes):
> 	- change reservation fields types: bus_res - uint32_t, others - uint64=
_t
> 	- interpret -1 value as 'ignore'
>=20
> Changes v2->v3:
> 1. Merge commit 2 (Red Hat vendor ID) into commit 4 - addresses Marcel'=
s comment,
> 	and add Generic PCIE Root Port device ID - addresses Michael's comment=
.
> 2. Changes of the capability layout  (QEMU side has the same changes):
> 	- add 'type' field to distinguish multiple
> 		RedHat-specific capabilities - addresses Michael's comment
> 	- do not mimi=D1=81 PCI Config space register layout, but use mutually=
 exclusive differently
> 		sized fields for IO and prefetchable memory limits - addresses Laszlo=
's comment
> 	- use defines instead of structure and offsetof - addresses Michael's =
comment
> 3. Interpret 'bus_reserve' field as a minimum necessary
> 	 range to reserve - addresses Gerd's comment
> 4. pci_find_capability moved to pci.c - addresses Kevin's comment
> 5. Move capability layout header to src/fw/dev-pci.h - addresses Kevin'=
s comment
> 6. Add the capability documentation - addresses Michael's comment
> 7. Add capability length and bus_reserve field sanity checks - addresse=
s Michael's comment
>=20
> Changes v1->v2:
> 1. New #define for Red Hat vendor added (addresses Konrad's comment).
> 2. Refactored pci_find_capability function (addresses Marcel's comment)=
.
> 3. Capability reworked:
> 	- data type added;
> 	- reserve space in a structure for IO, memory and
> 	  prefetchable memory limits.
>=20
> Aleksandr Bezzubikov (3):
>    pci: refactor pci_find_capapibilty to get bdf as the first argument
>      instead of the whole pci_device
>    pci: add QEMU-specific PCI capability structure
>    pci: enable RedHat PCI bridges to reserve additional resource on PCI
>      init
>=20
>   src/fw/dev-pci.h    |  53 +++++++++++++++++++++++++++
>   src/fw/pciinit.c    | 101 +++++++++++++++++++++++++++++++++++++++++++=
++++++---
>   src/hw/pci.c        |  25 +++++++++++++
>   src/hw/pci.h        |   1 +
>   src/hw/pci_ids.h    |   3 ++
>   src/hw/pcidevice.c  |  24 -------------
>   src/hw/pcidevice.h  |   1 -
>   src/hw/virtio-pci.c |   6 ++--
>   8 files changed, 181 insertions(+), 33 deletions(-)
>   create mode 100644 src/fw/dev-pci.h
>=20

Hi,

Series
    Tested-by: Marcel Apfelbaum <marcel@redhat.com>

Tested with Win10 and Fedora guests, verified the bus/io/mem hints
are working correctly.

Thanks,
Marcel
