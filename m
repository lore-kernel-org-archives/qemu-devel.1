Received: from eggs.gnu.org ([2001:4830:134:3::10]:38406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDz-0005R8-MF
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDu-0007Fs-NG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:51 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fcSDu-0007F4-Fi
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:46 -0400
Received: by mail-ed1-x543.google.com with SMTP id v22-v6so13352992edq.4
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:12:46 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  9 Jul 2018 11:11:29 +0200
Message-Id: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

qgraph API for the qtest driver framework

This series of patches introduce a different qtest driver 
organization, viewing machines, drivers and tests as node in a 
graph, each having one or multiple edges relations.

The idea is to have a framework where each test asks for a specific
driver, and the framework takes care of allocating the proper devices
required and passing the correct command line arguments to QEMU.

A node can be of four types:
- MACHINE:   for example "arm/raspi2"
- DRIVER:    for example "generic-sdhci"
- INTERFACE: for example "sdhci" (interface for all "-sdhci" drivers)
- TEST:      for example "sdhci-test", consumes an interface and tests
             the functions provided

An edge relation between two nodes (drivers or machines) X and Y can be:
- X CONSUMES Y: Y can be plugged into X
- X PRODUCES Y: X provides the interface Y
- X CONTAINS Y: Y is part of X component

Basic framework steps are the following:
- All nodes and edges are created in their respective machine/driver/test files
- The framework starts QEMU and asks for a list of available drivers
  and machines
- The framework walks the graph starting from the available machines and
  performs a Depth First Search for tests
- Once a test is found, the path is walked again and all drivers are
  allocated accordingly and the final interface is passed to the test
- The test is executed
- Unused objects are cleaned and the path discovery is continued

Depending on the QEMU binary used, only some drivers/machines will be available
and only test that are reached by them will be executed.

This work is being done as Google Summer of Code 2018 project for QEMU,
my mentors are Paolo Bonzini and Laurent Vivier.
Additional infos on the project can be found at:
https://wiki.qemu.org/Features/qtest_driver_framework

Emanuele Giuseppe Esposito (7):
  tests: qgraph API for the qtest driver framework
  tests/qgraph: pci-pc driver and interface nodes
  tests/qgraph: sdhci driver and interface nodes
  tests/qgraph: arm/raspi2 machine node
  tests/qgraph: x86_64/pc machine node
  tests/qgraph: gtest integration
  tests/qgraph: sdhci test node

 configure                        |   2 +-
 include/qemu/module.h            |   2 +
 tests/Makefile.include           |  16 +-
 tests/libqos/pci-pc.c            |  53 ++-
 tests/libqos/pci-pc.h            |   8 +
 tests/libqos/pci.c               |   8 +
 tests/libqos/qgraph.c            | 676 +++++++++++++++++++++++++++++++
 tests/libqos/qgraph.h            | 259 ++++++++++++
 tests/libqos/qgraph_extra.h      | 155 +++++++
 tests/libqos/raspi2-machine.c    |  68 ++++
 tests/libqos/sdhci.c             | 142 +++++++
 tests/libqos/sdhci.h             |  68 ++++
 tests/libqos/x86_64_pc-machine.c |  93 +++++
 tests/qos-test.c                 | 310 ++++++++++++++
 tests/sdhci-test.c               | 222 +++-------
 tests/test-qgraph.c              | 446 ++++++++++++++++++++
 16 files changed, 2357 insertions(+), 171 deletions(-)
 create mode 100644 tests/libqos/qgraph.c
 create mode 100644 tests/libqos/qgraph.h
 create mode 100644 tests/libqos/qgraph_extra.h
 create mode 100644 tests/libqos/raspi2-machine.c
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h
 create mode 100644 tests/libqos/x86_64_pc-machine.c
 create mode 100644 tests/qos-test.c
 create mode 100644 tests/test-qgraph.c

-- 
2.17.1
