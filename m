Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4Ts-0003lT-CV
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4To-0006rM-EF
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:08:44 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36389
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dK4To-0006qh-6s
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:08:40 -0400
Received: from host109-146-132-203.range109-146.btcentralplus.com
	([109.146.132.203] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4Tj-0005T5-6j
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 16:08:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ccd731e5-f128-0493-d12f-72193a39d0f9@ilande.co.uk>
Date: Sun, 11 Jun 2017 16:08:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] pci_nic_init_nofail() only works on root PCI buses?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi all,

Playing around with trying to set up PCI bridges for sun4u, I noticed
that I get an assert with the following diff which simply moves the
default NIC behind a PCI bridge rather than being directly on the root
PCI bus:

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 69f565d..0b17f2e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -465,7 +465,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);

     for(i = 0; i < nb_nics; i++)
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus3, "ne2k_pci", NULL);

     ide_drive_get(hd, ARRAY_SIZE(hd));


$ ./qemu-system-sparc64 -nographic
qemu-system-sparc64: hw/pci/pci.c:682: pci_get_bus_devfn: Assertion
`!root->parent_dev' failed.
Aborted

Is there any particular reason why the assert() is set to fail if the
NIC isn't being instantiated on the root PCI bus?


ATB,

Mark.
