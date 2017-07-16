Received: from eggs.gnu.org ([2001:4830:134:3::10]:59436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dWevh-000897-L4
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 04:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dWeve-0008Mj-Fc
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 04:29:29 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dWeve-0008LC-7K
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 04:29:26 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so17828634wma.2
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 01:29:24 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Sun, 16 Jul 2017 11:29:17 +0300
Message-Id: <20170716082917.720-1-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH] pci: honor PCI_COMMAND_MEMORY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Sameeh Jubran <sameeh@daynix.com>

According to PCI spec. bit 1 of command
register (PCI_COMMAND_MEMORY) controls
a device's response to memory space accesses.
A value of 0 disables the device response.
A value of 1 allows the device to respond
to memory space accesses.

Current behavior introduced by commit

  commit 1c380f9460522f32c8dd2577b2a53d518ec91c6d
  Author: Avi Kivity <avi@redhat.com>
  Date:   Wed Oct 3 17:42:58 2012 +0200

      pci: honor PCI_COMMAND_MASTER

is to ignore device memory space accesses unless
bit 2 (PCI_COMMAND_MASTER) is set.

Aforementioned commit introduced regression of
Windows hibernation (S4) functionality support
because on resume Windows kernel sets bits 0 and 1
(PCI_COMMAND_MEMORY | PCI_COMMAND_IO) of boot
device's (piix3-ide in our specific case) command
register and tries to work with the device.

Since PCI_COMMAND_MASTER bit is not set, device
does not answer and Windows fails to resume from
hibernation.

As a result following BSOD happens:

  BugCheck A0, {10e, a, aa00, 418}

  Probably caused by : ntkrnlmp.exe ( nt!PopHiberChecksumHiberFileData+b346 )

  Followup:     MachineOwner
  ---------

  0: kd> !analyze -v
  *******************************************************************************
  *                                                                             *
  *                        Bugcheck Analysis                                    *
  *                                                                             *
  *******************************************************************************

  INTERNAL_POWER_ERROR (a0)
  The power policy manager experienced a fatal error.
  Arguments:
  Arg1: 000000000000010e, The disk subsystem returned corrupt data while reading from the
      hibernation file.
  Arg2: 000000000000000a
  Arg3: 000000000000aa00, Incorrect checksum
  Arg4: 0000000000000418, Previous disk read's checksum

According to our tests this problem happens at least on
Windows 8/8.1/2012/2012R2/10/2016.

This patch solves https://bugzilla.redhat.com/show_bug.cgi?id=988351

Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
---
 hw/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0c6f74a..10af82f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -480,7 +480,7 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
 
     memory_region_set_enabled(&s->bus_master_enable_region,
                               pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+                              & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY));
 
     g_free(config);
     return 0;
@@ -1356,7 +1356,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   pci_get_word(d->config + PCI_COMMAND)
-                                    & PCI_COMMAND_MASTER);
+                                  & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY));
     }
 
     msi_write_config(d, addr, val_in, l);
-- 
2.9.4
