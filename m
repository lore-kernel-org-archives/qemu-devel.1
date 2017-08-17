Received: from eggs.gnu.org ([2001:4830:134:3::10]:49983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diUI6-0006ow-TT
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diUI3-0008Pj-P6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:33:30 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:37175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1diUI3-0008PH-Cj
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:33:27 -0400
Received: by mail-lf0-x241.google.com with SMTP id x16so5258191lfb.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:33:27 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 18 Aug 2017 02:33:18 +0300
Message-Id: <1503012801-10855-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND v7 0/3] Red Hat PCI bridge resource
 reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, mst@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Now PCI bridges get a bus range number on a system init,
basing on currently plugged devices. That's why when one wants to hotplug another bridge,
it needs his child bus, which the parent is unable to provide (speaking about virtual device).
The suggested workaround is to have vendor-specific capability in Red Hat PCI bridges
that contains number of additional bus to reserve (as well as IO/MEM/PREF space limit hints) 
on BIOS PCI init.
So this capability is intended only for pure QEMU->SeaBIOS usage.

Considering all aforesaid, this series is directly connected with
QEMU series "Generic PCIE-PCI Bridge".

Although the new PCI capability is supposed to contain various limits along with
bus number to reserve, now only its full layout is proposed. And
only bus_reserve field is used in QEMU and BIOS. Limits usage
is still a subject for implementation as now
the main goal of this series to provide necessary support from the 
firmware side to PCIE-PCI bridge hotplug. 

Changes v6->v7:
0. Resend - fix a bug with incorrect subordinate bus default value.
1. Do not use alignment in case of IO reservation cap usage.
2. Log additional buses reservation events.

Changes v5->v6:
1. Remove unnecessary indents and line breaks (addresses Marcel's comments)
2. Count IO/MEM/PREF region size as a maximum of necessary size and one provide in
	RESOURCE_RESERVE capability (addresses Marcel's comment).
3. Make the cap debug message more detailed (addresses Marcel's comment).
4. Change pref_32 and pref_64 cap fields comment.

Changes v4->v5:
1. Rename capability-related #defines
2. Move capability IO/MEM/PREF fields values usage to the regions creation stage (addresses Marcel's comment)
3. The capability layout change: separate pref_mem into pref_mem_32 and pref_mem_64 fields (QEMU side has the same changes) (addresses Laszlo's comment)
4. Extract the capability lookup and check to the separate function (addresses Marcel's comment)
	- despite of Marcel's comment do not extract field check for -1 since it increases code length
	  and doesn't look nice because of different field types 
5. Fix the capability's comment (addresses Marcel's comment)
6. Fix the 3rd patch message

Changes v3->v4:
1. Use all QEMU PCI capability fields - addresses Michael's comment
2. Changes of the capability layout (QEMU side has the same changes):
	- change reservation fields types: bus_res - uint32_t, others - uint64_t
	- interpret -1 value as 'ignore'

Changes v2->v3:
1. Merge commit 2 (Red Hat vendor ID) into commit 4 - addresses Marcel's comment,
	and add Generic PCIE Root Port device ID - addresses Michael's comment.
2. Changes of the capability layout  (QEMU side has the same changes):
	- add 'type' field to distinguish multiple 
		RedHat-specific capabilities - addresses Michael's comment
	- do not mimiс PCI Config space register layout, but use mutually exclusive differently
		sized fields for IO and prefetchable memory limits - addresses Laszlo's comment
	- use defines instead of structure and offsetof - addresses Michael's comment
3. Interpret 'bus_reserve' field as a minimum necessary
	 range to reserve - addresses Gerd's comment
4. pci_find_capability moved to pci.c - addresses Kevin's comment
5. Move capability layout header to src/fw/dev-pci.h - addresses Kevin's comment
6. Add the capability documentation - addresses Michael's comment
7. Add capability length and bus_reserve field sanity checks - addresses Michael's comment

Changes v1->v2:
1. New #define for Red Hat vendor added (addresses Konrad's comment).
2. Refactored pci_find_capability function (addresses Marcel's comment).
3. Capability reworked:
	- data type added;
	- reserve space in a structure for IO, memory and 
	  prefetchable memory limits.


Aleksandr Bezzubikov (3):
  pci: refactor pci_find_capapibilty to get bdf as the first argument
    instead of the whole pci_device
  pci: add QEMU-specific PCI capability structure
  pci: enable RedHat PCI bridges to reserve additional resources on PCI
    init

 src/fw/dev-pci.h    |  53 ++++++++++++++++++++++++++
 src/fw/pciinit.c    | 108 +++++++++++++++++++++++++++++++++++++++++++++++++---
 src/hw/pci.c        |  25 ++++++++++++
 src/hw/pci.h        |   1 +
 src/hw/pci_ids.h    |   3 ++
 src/hw/pcidevice.c  |  24 ------------
 src/hw/pcidevice.h  |   1 -
 src/hw/virtio-pci.c |   6 +--
 8 files changed, 188 insertions(+), 33 deletions(-)
 create mode 100644 src/fw/dev-pci.h

-- 
2.7.4
