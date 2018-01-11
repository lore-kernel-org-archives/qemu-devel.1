Received: from eggs.gnu.org ([2001:4830:134:3::10]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2U-0004pc-D1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2T-0008RR-6a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:43217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eZk2S-0008Qb-Il
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:28 -0500
Received: by mail-lf0-x244.google.com with SMTP id a17so629765lfk.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:05:28 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Jan 2018 13:04:54 -0800
Message-Id: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/9] target/xtensa: add noMMU support to XTFPGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series cleans up XTFPGA xtensa boards: reworks built-in mini
bootloader so that it supports warm reboots and makes function/structure
naming consistent in the hw/xtensa/xtfpga.c.
It extracts common local memory instantiation function into a separate
source file.
It adds noMMU variant for each XTFPGA board. noMMU XTFPGA variants have
different physical memory layout: the RAM size is limited to 256M and
it starts at physical address 0x60000000 and MMIO is visible through two
ranges of physical addresses starting at 0x70000000 and 0x90000000.
The series imports two noMMU cores: de212 (noMMU default core for xtensa
linux) and sample_controller (default core for xtensa Zephyr OS).

Max Filippov (9):
  hw/xtensa/xtfpga: rewrite mini bootloader
  hw/xtensa/xtfpga: clean up function/structure names
  target/xtensa: fix default sysrom/sysram addresses
  hw/xtensa: extract xtensa_create_memory_regions
  hw/xtensa/xtfpga: extract flash configuration
  hw/xtensa/xtfpga: support noMMU cores
  target/xtensa: add de212 core
  target/xtensa: use different default CPU for MMU/noMMU
  target/xtensa: add sample_controller core

 hw/xtensa/Makefile.objs                            |     1 +
 hw/xtensa/sim.c                                    |    38 +-
 hw/xtensa/xtensa_memory.c                          |    55 +
 hw/xtensa/xtensa_memory.h                          |    40 +
 hw/xtensa/xtfpga.c                                 |   414 +-
 target/xtensa/Makefile.objs                        |     2 +
 target/xtensa/core-de212.c                         |    53 +
 target/xtensa/core-de212/core-isa.h                |   622 +
 target/xtensa/core-de212/gdb-config.c              |   198 +
 target/xtensa/core-de212/xtensa-modules.c          | 14566 +++++++++++++++++++
 target/xtensa/core-sample_controller.c             |    53 +
 target/xtensa/core-sample_controller/core-isa.h    |   644 +
 target/xtensa/core-sample_controller/gdb-config.c  |   141 +
 .../xtensa/core-sample_controller/xtensa-modules.c | 11377 +++++++++++++++
 target/xtensa/cpu.h                                |     7 +-
 target/xtensa/overlay_tool.h                       |     8 +-
 16 files changed, 28077 insertions(+), 142 deletions(-)
 create mode 100644 hw/xtensa/xtensa_memory.c
 create mode 100644 hw/xtensa/xtensa_memory.h
 create mode 100644 target/xtensa/core-de212.c
 create mode 100644 target/xtensa/core-de212/core-isa.h
 create mode 100644 target/xtensa/core-de212/gdb-config.c
 create mode 100644 target/xtensa/core-de212/xtensa-modules.c
 create mode 100644 target/xtensa/core-sample_controller.c
 create mode 100644 target/xtensa/core-sample_controller/core-isa.h
 create mode 100644 target/xtensa/core-sample_controller/gdb-config.c
 create mode 100644 target/xtensa/core-sample_controller/xtensa-modules.c

-- 
2.1.4
