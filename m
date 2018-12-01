Received: from eggs.gnu.org ([2001:4830:134:3::10]:48036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gTANT-0005Wv-2A
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 13:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gTANO-0007Ur-13
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 13:52:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gTANN-0007Tm-Od
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 13:52:25 -0500
MIME-Version: 1.0
Message-ID: <099db937-3fa3-465e-9a23-a900df9adb7c@default>
Date: Sat, 1 Dec 2018 10:52:21 -0800 (PST)
From: Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel] vfio failure with intel 760p 128GB nvme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: keith.busch@intel.com, alex.williamson@redhat.com

Hi,

I obtained below error when assigning an intel 760p 128GB nvme to guest via
vfio on my desktop:

qemu-system-x86_64: -device vfio-pci,host=3D0000:01:00.0: vfio 0000:01:00.0=
: failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or the=
y don't fit in BARs, or don't align


This is because the msix table is overlapping with pba. According to below
'lspci -vv' from host, the distance between msix table offset and pba offse=
t is
only 0x100, although there are 22 entries supported (22 entries need 0x160)=
.
Looks qemu supports at most 0x800.

# sudo lspci -vv
... ...
01:00.0 Non-Volatile memory controller: Intel Corporation Device f1a6 (rev =
03) (prog-if 02 [NVM Express])
=09Subsystem: Intel Corporation Device 390b
... ...
=09Capabilities: [b0] MSI-X: Enable- Count=3D22 Masked-
=09=09Vector table: BAR=3D0 offset=3D00002000
=09=09PBA: BAR=3D0 offset=3D00002100



A patch below could workaround the issue and passthrough nvme successfully.

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c7bd96..54fc25e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1510,6 +1510,11 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vde=
v, Error **errp)
     msix->pba_offset =3D pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries =3D (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
=20
+    if (msix->table_bar =3D=3D msix->pba_bar &&
+        msix->table_offset + msix->entries * PCI_MSIX_ENTRY_SIZE > msix->p=
ba_offset) {
+        msix->entries =3D (msix->pba_offset - msix->table_offset) / PCI_MS=
IX_ENTRY_SIZE;
+    }
+
     /*
      * Test the size of the pba_offset variable and catch if it extends ou=
tside
      * of the specified BAR. If it is the case, we need to apply a hardwar=
e


Would you please help confirm if this can be regarded as bug in qemu, or is=
sue
with nvme hardware? Should we fix thin in qemu, or we should never use such=
 buggy
hardware with vfio?

Thank you very much!

Dongli Zhang
