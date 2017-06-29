Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQJ-0005ka-JV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQE-0000Pr-Nj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:27 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dQhQE-0000Of-Fg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:22 -0400
Received: by mail-lf0-x242.google.com with SMTP id f28so8682491lfi.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:56:20 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 30 Jun 2017 00:55:56 +0300
Message-Id: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

The series adds hotplug support to legacy PCI buses for Q35 machines.
The ACPI hotplug code is emitted if at least one legacy pci-bridge is present.

This series is mostly based on past Marcel's series 
https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05681.html,
but rebased on current master with some minor changes according to current codebase.

ACPI code emission approach used in this series can be called "static", 
because it checkswhether a bridge exists only at initial DSDT generation moment. 
The main goal is to enable AML PCI hotplug-related code to be generated dynamically. 
In other words, the bridge plugged in - a new acpi definition block is
loaded (using LoadTable method). 
This is necessary for PCIE-PCI bridge hotplugging feature. 

Aleksandr Bezzubikov (6):
  hw/acpi: remove dead acpi code
  hw/acpi: simplify dsdt building code
  hw/acpi: fix pcihp io initialization
  hw/acpi: prepare pci hotplug IO for ich9
  hw/acpi: extend acpi pci hotplug support for pci express
  hw/ich9: enable acpi pci hotplug

 hw/acpi/ich9.c         |  31 +++++++++++++
 hw/i386/acpi-build.c   | 116 ++++++++++++++++++++++++-------------------------
 hw/isa/lpc_ich9.c      |  12 +++++
 include/hw/acpi/ich9.h |   4 ++
 include/hw/i386/pc.h   |   7 ++-
 5 files changed, 111 insertions(+), 59 deletions(-)

-- 
2.7.4
