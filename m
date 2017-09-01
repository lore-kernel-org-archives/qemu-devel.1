Received: from eggs.gnu.org ([2001:4830:134:3::10]:55595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqII-0006yd-QH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIF-0001RB-Lv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIF-0001Qb-Ck
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA18FC056784
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:03:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:11 -0500
Message-Id: <20170901180340.30009-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/29] Preliminary libqtest cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

Markus gave some good advice on my 'v4: Clean up around qmp() and hmp()'
series [1], but Paolo made the suggestion on v5 [2] that we are probably
better off avoiding dependence on a magic global variable, rather than
making such dependence even more prominent.  So, this round of patches
starts to head in the direction of more explicit use of a QTestState
object - particularly in all tests that have more than one test state
active at a given time.  There is still more work to do (patch 28 shows
how many tests still depend on global_qtest), and I'd still like to do
even more renaming (for example, rather than having qtest_inb(s, addr)
and inb(addr), I'd rather have a single inb(s, addr) once I get rid of
all dependence on global_qtest, but this series was getting long
enough that I want to get review started on the earlier parts that
might as well go in the tree now rather than waiting for the whole
conversion series to be complete.  (Or, by posting this alternative
that goes the opposite direction from v5, we may decide that depending
on global_qtest is not so bad after all, and just go with v5 instead
of this version.)

There's still more libqtest cleanups in my queue, in particular all
the work around making qmp("...") friendlier to use and compatible
with gcc -Wformat checking, but we'll take it one step at a time.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00595.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03589.html

Since v5:
001/29:[down] 'tests: Improve .gitignore for tests/multiboot'
002/29:[down] 'tests: Sort .gitignore'
003/29:[----] [--] 'test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTIN=
G code'
004/29:[----] [--] 'qtest: Don't perform side effects inside assertion'
005/29:[----] [--] 'numa-test: Use hmp()'
006/29:[----] [-C] 'tests: Clean up wait for event'
007/29:[----] [--] 'libqtest: Remove dead qtest_instances variable'
008/29:[----] [--] 'libqtest: Let socket_send() compute length'
009/29:[----] [--] 'libqtest: Use qemu_strtoul()'
010/29:[----] [--] 'libqtest: Topologically sort functions'
011/29:[----] [--] 'libqtest: Inline qtest_query_target_endianness()'
012/29:[down] 'libqos: Track QTestState with QPCIBus'
013/29:[down] 'libqos: Use explicit QTestState for pci operations'
014/29:[down] 'libqos: Use explicit QTestState for fw_cfg operations'
015/29:[down] 'libqos: Use explicit QTestState for rtas operations'
016/29:[down] 'libqos: Use explicit QTestState for virtio operations'
017/29:[down] 'ahci-test: Drop dependence on global_qtest'
018/29:[down] 'ivshmem-test: Drop dependence on global_qtest'
019/29:[down] 'postcopy-test: Drop dependence on global_qtest'
020/29:[down] 'vhost-user-test: Drop dependence on global_qtest'
021/29:[down] 'qmp-test: Drop dependence on global_qtest'
022/29:[down] 'tests/boot-sector: Drop dependence on global_qtest'
023/29:[down] 'tests/acpi-utils: Drop dependence on global_qtest'
024/29:[down] 'bios-tables-test: Drop dependence on global_qtest'
025/29:[down] 'wdt_ib700-test: Drop dependence on global_qtest'
026/29:[down] 'fw_cfg-test: Drop dependence on global_qtest'
027/29:[down] 'libqtest: Make qtest_init() accept format string'
028/29:[down] 'libqtest: Remove qtest_start() and qtest_end() shortcuts'
029/29:[down] 'libqtest: Rename qtest_init() to qtest_start()'

Eric Blake (28):
  tests: Improve .gitignore for tests/multiboot
  tests: Sort .gitignore
  test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING code
  qtest: Don't perform side effects inside assertion
  numa-test: Use hmp()
  libqtest: Remove dead qtest_instances variable
  libqtest: Let socket_send() compute length
  libqtest: Use qemu_strtoul()
  libqtest: Topologically sort functions
  libqtest: Inline qtest_query_target_endianness()
  libqos: Track QTestState with QPCIBus
  libqos: Use explicit QTestState for pci operations
  libqos: Use explicit QTestState for fw_cfg operations
  libqos: Use explicit QTestState for rtas operations
  libqos: Use explicit QTestState for virtio operations
  ahci-test: Drop dependence on global_qtest
  ivshmem-test: Drop dependence on global_qtest
  postcopy-test: Drop dependence on global_qtest
  vhost-user-test: Drop dependence on global_qtest
  qmp-test: Drop dependence on global_qtest
  tests/boot-sector: Drop dependence on global_qtest
  tests/acpi-utils: Drop dependence on global_qtest
  bios-tables-test: Drop dependence on global_qtest
  wdt_ib700-test: Drop dependence on global_qtest
  fw_cfg-test: Drop dependence on global_qtest
  libqtest: Make qtest_init() accept format string
  libqtest: Remove qtest_start() and qtest_end() shortcuts
  libqtest: Rename qtest_init() to qtest_start()

Markus Armbruster (1):
  tests: Clean up wait for event

 tests/libqtest.h               |  37 +-----
 tests/acpi-utils.h             |  65 ++++-----
 tests/boot-sector.h            |   6 +-
 tests/libqos/ahci.h            |   2 +-
 tests/libqos/fw_cfg.h          |  10 +-
 tests/libqos/libqos.h          |   5 +-
 tests/libqos/malloc-pc.h       |   4 +-
 tests/libqos/malloc-spapr.h    |   2 +-
 tests/libqos/malloc.h          |   1 +
 tests/libqos/pci-pc.h          |   2 +-
 tests/libqos/pci-spapr.h       |   2 +-
 tests/libqos/pci.h             |   1 +
 tests/libqos/rtas.h            |   9 +-
 tests/libqos/virtio-mmio.h     |   3 +-
 tests/libqos/virtio.h          |   5 +-
 tests/libqtest.c               | 293 +++++++++++++++++++++--------------=
------
 qtest.c                        |  80 +++++++----
 tests/ac97-test.c              |   4 +-
 tests/acpi-utils.c             |  19 +--
 tests/ahci-test.c              |  85 ++++++------
 tests/bios-tables-test.c       | 198 ++++++++++++++--------------
 tests/boot-order-test.c        |  19 ++-
 tests/boot-sector.c            |   8 +-
 tests/boot-serial-test.c       |  12 +-
 tests/device-introspect-test.c |  24 ++--
 tests/display-vga-test.c       |  18 +--
 tests/drive_del-test.c         |  17 +--
 tests/ds1338-test.c            |   2 +-
 tests/e1000-test.c             |  10 +-
 tests/e1000e-test.c            |  24 ++--
 tests/eepro100-test.c          |  11 +-
 tests/endianness-test.c        |  33 ++---
 tests/es1370-test.c            |   4 +-
 tests/fdc-test.c               |   4 +-
 tests/fw_cfg-test.c            |  13 +-
 tests/hd-geo-test.c            |  16 +--
 tests/i440fx-test.c            |  16 +--
 tests/i82801b11-test.c         |   5 +-
 tests/ide-test.c               |   8 +-
 tests/intel-hda-test.c         |  11 +-
 tests/ioh3420-test.c           |   7 +-
 tests/ipmi-bt-test.c           |  11 +-
 tests/ipmi-kcs-test.c          |   7 +-
 tests/ipoctal232-test.c        |   5 +-
 tests/ivshmem-test.c           |  22 +---
 tests/libqos/ahci.c            |  49 +++----
 tests/libqos/fw_cfg.c          |  14 +-
 tests/libqos/libqos-pc.c       |   2 +-
 tests/libqos/libqos.c          |  45 ++-----
 tests/libqos/malloc-pc.c       |   8 +-
 tests/libqos/malloc-spapr.c    |   4 +-
 tests/libqos/pci-pc.c          |  58 ++++----
 tests/libqos/pci-spapr.c       |  44 ++++---
 tests/libqos/rtas.c            |  21 +--
 tests/libqos/virtio-mmio.c     |  54 ++++----
 tests/libqos/virtio-pci.c      |   3 +
 tests/libqos/virtio.c          |  77 ++++++-----
 tests/m25p80-test.c            |   9 +-
 tests/m48t59-test.c            |   2 +-
 tests/ne2000-test.c            |   4 +-
 tests/numa-test.c              |  49 +++----
 tests/nvme-test.c              |   7 +-
 tests/pc-cpu-test.c            |  26 ++--
 tests/pcnet-test.c             |   4 +-
 tests/pnv-xscom-test.c         |  14 +-
 tests/postcopy-test.c          |  86 ++++++------
 tests/prom-env-test.c          |  13 +-
 tests/pvpanic-test.c           |   4 +-
 tests/pxe-test.c               |  16 +--
 tests/q35-test.c               |  12 +-
 tests/qmp-test.c               |  35 ++---
 tests/qom-test.c               |   7 +-
 tests/rtas-test.c              |   2 +-
 tests/rtc-test.c               |   2 +-
 tests/rtl8139-test.c           |   7 +-
 tests/spapr-phb-test.c         |   5 +-
 tests/tco-test.c               |  17 +--
 tests/test-arm-mptimer.c       |   4 +-
 tests/test-filter-mirror.c     |  16 +--
 tests/test-filter-redirector.c |  60 ++++-----
 tests/test-hmp.c               |   7 +-
 tests/test-netfilter.c         |   9 +-
 tests/test-qga.c               |  90 -------------
 tests/test-x86-cpuid-compat.c  |  13 +-
 tests/tmp105-test.c            |   7 +-
 tests/tpci200-test.c           |   4 +-
 tests/usb-hcd-ehci-test.c      |  27 ++--
 tests/usb-hcd-ohci-test.c      |   4 +-
 tests/usb-hcd-uhci-test.c      |   6 +-
 tests/usb-hcd-xhci-test.c      |  19 +--
 tests/vhost-user-test.c        | 105 ++++++---------
 tests/virtio-balloon-test.c    |   4 +-
 tests/virtio-blk-test.c        |  16 +--
 tests/virtio-console-test.c    |  12 +-
 tests/virtio-net-test.c        |   4 +-
 tests/virtio-rng-test.c        |   4 +-
 tests/virtio-serial-test.c     |   4 +-
 tests/vmgenid-test.c           |  49 +++----
 tests/vmxnet3-test.c           |   4 +-
 tests/wdt_ib700-test.c         |  84 ++++++------
 tests/.gitignore               |  30 +++--
 101 files changed, 1092 insertions(+), 1330 deletions(-)

--=20
2.13.5
