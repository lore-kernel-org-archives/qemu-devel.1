Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dgvQG-0007jP-RT
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 12:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dgvQF-0001vQ-NP
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 12:07:28 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dgvQF-0001uv-F0
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 12:07:27 -0400
Received: by mail-pg0-x241.google.com with SMTP id l64so6850138pge.2
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 09:07:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502639388-12580-1-git-send-email-zuban32s@gmail.com>
References: <1502639388-12580-1-git-send-email-zuban32s@gmail.com>
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 13 Aug 2017 19:07:26 +0300
Message-ID: <CAKSfGUAE6B=Swjjx6E+N92f0qJXJGBPAO8h8+3eocpqzzTXLhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Generic PCIE-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

2017-08-13 18:49 GMT+03:00 Aleksandr Bezzubikov <zuban32s@gmail.com>:
> This series introduces a new device - Generic PCI Express to PCI bridge,
> and also makes all necessary changes to enable hotplug of the bridge itse=
lf
> and any device into the bridge.
>
> Changes v5->v6:
> 1. Fix indentation in the cap creation function (addresses Marcel's comme=
nt)
> 2. Simplify capability pref_mem_* fields assignment (addresses Marcel's c=
omment)
> 3. Documentation fixes:
>         - fix mutually exclusive fields definition (addresses Laszlo's co=
mment)
>         - fix pcie-pci-bridge usage example (addresses Marcel's comment)
>
> Changes v4->v5:
> 1. Change PCIE-PCI Bridge license (addresses Marcel's comment)
> 2. The capability layout changes (adress Laszlo' comments):
>     - separate pref_mem into pref_mem_32 and pref_mem_64 fields (SeaBIOS =
side has the same changes)
>     - accordingly change the Generic Root Port's properties
> 3. Do not add the capability to the root port if no valid values are prov=
ided (adresses Michael's comment)
> 4. Rename the capability type to 'RESOURCE_RESERVE' (addresses Marcel's c=
omment)
> 5. Remove shpc_present check function (addresses Marcel's comment)
> 6. Fix the 4th patch message (adresses Michael's comment)
> 7. Patch for SHPC enabling in _OSC method has been already merged
>
> Changes v3->v4:
> 1. PCIE-PCI Bridge device: "msi_enable"->"msi", "shpc"->"shpc_bar", remov=
e local_err,
>    make "msi" property OnOffAuto, shpc_present() is still here
>    to avoid SHPC_VMSTATE refactoring (address Marcel's comments).
> 2. Change QEMU PCI capability layout (SeaBIOS side has the same changes):
>   - change reservation fields types: bus_res - uint32_t, others - uint64_=
t
>   - rename 'non_pref' and 'pref' fields
>   - interpret -1 value as 'ignore'
> 3. Use parent_realize in Generic PCI Express Root Port properly.
> 4. Fix documentation: fully replace the DMI-PCI bridge references with th=
e new PCIE-PCI bridge,
> "PCIE"->"PCI Express", small mistakes and typos - address Laszlo's and Ma=
rcel's comments.
> 5. Rename QEMU PCI cap creation fucntion - addresses Marcel's comment.
>
> Changes v2->v3:
> (0). 'do_not_use' capability field flag is still _not_ in here since we h=
aven't come to consesus on it yet.
> 1. Merge commits 5 (bus_reserve property creation) and 6 (property usage)=
 together - addresses Michael's comment.
> 2. Add 'bus_reserve' property and QEMU PCI capability only to Generic PCI=
E Root Port - addresses Michael's and Marcel's comments.
> 3. Change 'bus_reserve' property's default value to 0 - addresses Michael=
's comment.
> 4. Rename QEMU bridge-specific PCI capability creation function - address=
es Michael's comment.
> 5. Init the whole QEMU PCI capability with zeroes - addresses Michael's a=
nd Laszlo's comments.
> 6. Change QEMU PCI capability layout (SeaBIOS side has the same changes)
>   - add 'type' field to distinguish multiple
>     RedHat-specific capabilities - addresses Michael's comment
>   - do not mimi=D1=81 PCI Config space register layout, but use mutually =
exclusive differently
>     sized fields for IO and prefetchable memory limits - addresses Laszlo=
's comment
> 7. Correct error handling in PCIE-PCI bridge realize function.
> 8. Replace a '2' constant with PCI_CAP_FLAGS in the capability creation f=
unction - addresses Michael's comment.
> 9. Remove a comment on _OSC which isn't correct anymore - address Marcel'=
s comment.
> 10. Add documentation for the Generic PCIE-PCI Bridge and QEMU PCI capabi=
lity - addresses Michael's comment.
>
> Changes v1->v2:
> 1. Enable SHPC for the bridge.
> 2. Enable SHPC support for the Q35 machine (ACPI stuff).
> 3. Introduce PCI capability to help firmware on the system init.
>    This allows the bridge to be hotpluggable. Now it's supported
>    only for pcie-root-port. Now it's supposed to used with
>    SeaBIOS only, look at the SeaBIOS corresponding series
>    "Allow RedHat PCI bridges reserve more buses than necessary during ini=
t".
>
> Aleksandr Bezzubikov (4):
>   hw/pci: introduce pcie-pci-bridge device
>   hw/pci: introduce bridge-only vendor-specific capability to provide
>     some hints to firmware
>   hw/pci: add QEMU-specific PCI capability to the Generic PCI Express
>     Root Port
>   docs: update documentation considering PCIE-PCI bridge
>
>  docs/pcie.txt                      |  49 +++++-----
>  docs/pcie_pci_bridge.txt           | 114 ++++++++++++++++++++++
>  hw/pci-bridge/Makefile.objs        |   2 +-
>  hw/pci-bridge/gen_pcie_root_port.c |  36 +++++++
>  hw/pci-bridge/pcie_pci_bridge.c    | 192 +++++++++++++++++++++++++++++++=
++++++
>  hw/pci/pci_bridge.c                |  46 +++++++++
>  include/hw/pci/pci.h               |   1 +
>  include/hw/pci/pci_bridge.h        |  25 +++++
>  include/hw/pci/pcie_port.h         |   1 +
>  9 files changed, 442 insertions(+), 24 deletions(-)
>  create mode 100644 docs/pcie_pci_bridge.txt
>  create mode 100644 hw/pci-bridge/pcie_pci_bridge.c
>
> --
> 2.7.4
>

Michael, do we need anything else here to get this merged?


Thanks,
Aleksandr Bezzubikov
