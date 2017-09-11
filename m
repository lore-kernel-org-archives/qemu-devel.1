Received: from eggs.gnu.org ([2001:4830:134:3::10]:38085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNs-0006pt-Nb
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNo-0000vs-AR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSNo-0000vP-1F
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1722A36C1F6
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:20:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:44 -0500
Message-Id: <20170911172022.4738-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 00/38] Preliminary libqtest cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

I'm trying to get rid of some of the duplication in libqtest.h
before tackling the project of making qmp() easier to use. v6
got some positive review on the direction of making dependence
on global_qtest explicit (compared to v5 where I went the
opposite direction and tried to use global_qtest even more than
it was already being abused for), so most of the changes in
this posting are related to additional cleanups or addressing
good review comments.

Still to come: I still have work pending on overhauling the
qmp() and qtest_qmp() code, using naming that makes more
sense, as well as getting us to the point that we can reliably
use -Wformat checking on qmp().

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git qapi-qmp-cleanup-v7

Since v6 (https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00308.=
html):
- Add review tags where appropriate
- merge a couple of patches [Thomas]
- split ahci into multiple patches [Thomas]
- add qtest_[v]startf rather than overloading (and churn) on
qtest_start [Thomas]
- catch more depedencies on global_qtest under tests/libqos/
- lots more patches added to make use of global_qtest obvious
- drop .gitignore changes for a later series

001/38:[----] [--] 'test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTIN=
G code'
002/38:[----] [--] 'qtest: Don't perform side effects inside assertion'
003/38:[----] [--] 'numa-test: Use hmp()'
004/38:[----] [--] 'tests: Clean up wait for event'
005/38:[----] [--] 'libqtest: Remove dead qtest_instances variable'
006/38:[----] [--] 'libqtest: Use qemu_strtoul()'
007/38:[0020] [FC] 'libqtest: Inline qtest_query_target_endianness()'
008/38:[0019] [FC] 'libqos: Track QTestState with QPCIBus'
009/38:[down] 'libqos: Track QTestState with QVirtioBus'
010/38:[down] 'libqos: Move/rename qpci_unplug_acpi_device_test() to pci.=
c'
011/38:[0045] [FC] 'libqos: Use explicit QTestState for pci operations'
012/38:[0179] [FC] 'libqos: Use explicit QTestState for virtio operations=
'
013/38:[0011] [FC] 'libqos: Use explicit QTestState for fw_cfg operations=
'
014/38:[0015] [FC] 'libqos: Use explicit QTestState for rtas operations'
015/38:[down] 'libqos: Use explicit QTestState for i2c operations'
016/38:[down] 'libqos: Use explicit QTestState for ahci operations'
017/38:[down] 'libqos: Use explicit QTestState for remaining libqos opera=
tions'
018/38:[0079] [FC] 'ahci-test: Drop dependence on global_qtest'
019/38:[0012] [FC] 'ivshmem-test: Drop dependence on global_qtest'
020/38:[----] [--] 'postcopy-test: Drop dependence on global_qtest'
021/38:[----] [--] 'vhost-user-test: Drop dependence on global_qtest'
022/38:[----] [-C] 'qmp-test: Drop dependence on global_qtest'
023/38:[----] [--] 'tests/boot-sector: Drop dependence on global_qtest'
024/38:[0079] [FC] 'tests/acpi-utils: Drop dependence on global_qtest'
025/38:[----] [--] 'wdt_ib700-test: Drop dependence on global_qtest'
026/38:[down] 'libqtest: Merge qtest_end() into qtest_quit()'
027/38:[down] 'libqtest: Swap order of qtest_init() and qtest_start()'
028/38:[down] 'libqtest: Add qtest_[v]startf()'
029/38:[down] 'libqtest: Merge qtest_init() into qtest_start()'
030/38:[0008] [FC] 'qtest: Avoid passing raw strings through hmp()'
031/38:[down] 'libqtest: Merge qtest_clock_*() with clock_*()'
032/38:[down] 'libqtest: Merge qtest_irq*() with irq*()'
033/38:[down] 'libqtest: Merge qtest_{in,out}[bwl]() with {in,out}[bwl]()=
'
034/38:[down] 'libqtest: Merge qtest_{read,write}[bwlq]() with {read,writ=
e}[bwlq]()'
035/38:[down] 'libqtest: Merge qtest_{mem,buf}{read,write}() with {mem,bu=
f}{read,write}()'
036/38:[down] 'libqtest: Merge qtest_memset() with qmemset()'
037/38:[0088] [FC] 'libqtest: Separate qmp_discard_response() from comman=
d'
038/38:[down] 'libqtest: Merge qtest_hmp() with hmp()'

Eric Blake (37):
  test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING code
  qtest: Don't perform side effects inside assertion
  numa-test: Use hmp()
  libqtest: Remove dead qtest_instances variable
  libqtest: Use qemu_strtoul()
  libqtest: Inline qtest_query_target_endianness()
  libqos: Track QTestState with QPCIBus
  libqos: Track QTestState with QVirtioBus
  libqos: Move/rename qpci_unplug_acpi_device_test() to pci.c
  libqos: Use explicit QTestState for pci operations
  libqos: Use explicit QTestState for virtio operations
  libqos: Use explicit QTestState for fw_cfg operations
  libqos: Use explicit QTestState for rtas operations
  libqos: Use explicit QTestState for i2c operations
  libqos: Use explicit QTestState for ahci operations
  libqos: Use explicit QTestState for remaining libqos operations
  ahci-test: Drop dependence on global_qtest
  ivshmem-test: Drop dependence on global_qtest
  postcopy-test: Drop dependence on global_qtest
  vhost-user-test: Drop dependence on global_qtest
  qmp-test: Drop dependence on global_qtest
  tests/boot-sector: Drop dependence on global_qtest
  tests/acpi-utils: Drop dependence on global_qtest
  wdt_ib700-test: Drop dependence on global_qtest
  libqtest: Merge qtest_end() into qtest_quit()
  libqtest: Swap order of qtest_init() and qtest_start()
  libqtest: Add qtest_[v]startf()
  libqtest: Merge qtest_init() into qtest_start()
  qtest: Avoid passing raw strings through hmp()
  libqtest: Merge qtest_clock_*() with clock_*()
  libqtest: Merge qtest_irq*() with irq*()
  libqtest: Merge qtest_{in,out}[bwl]() with {in,out}[bwl]()
  libqtest: Merge qtest_{read,write}[bwlq]() with {read,write}[bwlq]()
  libqtest: Merge qtest_{mem,buf}{read,write}() with
    {mem,buf}{read,write}()
  libqtest: Merge qtest_memset() with qmemset()
  libqtest: Separate qmp_discard_response() from command
  libqtest: Merge qtest_hmp() with hmp()

Markus Armbruster (1):
  tests: Clean up wait for event

 tests/libqtest.h               | 522 +++++++----------------------------=
------
 tests/acpi-utils.h             |  67 +++---
 tests/boot-sector.h            |   6 +-
 tests/libqos/ahci.h            |   2 +-
 tests/libqos/fw_cfg.h          |  10 +-
 tests/libqos/i2c.h             |   7 +-
 tests/libqos/libqos.h          |   5 +-
 tests/libqos/malloc-pc.h       |   4 +-
 tests/libqos/malloc-spapr.h    |   2 +-
 tests/libqos/malloc.h          |   1 +
 tests/libqos/pci-pc.h          |   2 +-
 tests/libqos/pci-spapr.h       |   2 +-
 tests/libqos/pci.h             |   5 +-
 tests/libqos/rtas.h            |   9 +-
 tests/libqos/virtio-mmio.h     |   6 +-
 tests/libqos/virtio-pci.h      |   2 -
 tests/libqos/virtio.h          |  13 +-
 tests/multiboot/libc.h         |   2 +-
 tests/libqtest.c               | 192 ++++++++-------
 qtest.c                        |  80 +++++--
 tests/ac97-test.c              |   4 +-
 tests/acpi-utils.c             |  19 +-
 tests/ahci-test.c              |  92 ++++----
 tests/bios-tables-test.c       | 199 ++++++++--------
 tests/boot-order-test.c        |  31 ++-
 tests/boot-sector.c            |   8 +-
 tests/boot-serial-test.c       |  12 +-
 tests/device-introspect-test.c |  30 +--
 tests/display-vga-test.c       |  18 +-
 tests/drive_del-test.c         |  26 +-
 tests/ds1338-test.c            |   6 +-
 tests/e1000-test.c             |  10 +-
 tests/e1000e-test.c            |  46 ++--
 tests/eepro100-test.c          |  11 +-
 tests/endianness-test.c        |  57 ++---
 tests/es1370-test.c            |   4 +-
 tests/fdc-test.c               | 144 ++++++------
 tests/fw_cfg-test.c            |  13 +-
 tests/hd-geo-test.c            |  20 +-
 tests/i440fx-test.c            |  24 +-
 tests/i82801b11-test.c         |   5 +-
 tests/ide-test.c               |  58 +++--
 tests/intel-hda-test.c         |   9 +-
 tests/ioh3420-test.c           |   7 +-
 tests/ipmi-bt-test.c           |  29 +--
 tests/ipmi-kcs-test.c          |  23 +-
 tests/ipoctal232-test.c        |   5 +-
 tests/ivshmem-test.c           |  27 +--
 tests/libqos/ahci.c            |  47 ++--
 tests/libqos/fw_cfg.c          |  14 +-
 tests/libqos/i2c-imx.c         |  67 +++---
 tests/libqos/i2c-omap.c        |  45 ++--
 tests/libqos/libqos-pc.c       |   2 +-
 tests/libqos/libqos.c          |  52 +---
 tests/libqos/malloc-pc.c       |   8 +-
 tests/libqos/malloc-spapr.c    |   4 +-
 tests/libqos/pci-pc.c          |  81 +++----
 tests/libqos/pci-spapr.c       |  45 ++--
 tests/libqos/pci.c             |  22 +-
 tests/libqos/rtas.c            |  36 +--
 tests/libqos/virtio-mmio.c     |  61 +++--
 tests/libqos/virtio-pci.c      |  14 +-
 tests/libqos/virtio.c          |  87 ++++---
 tests/m25p80-test.c            |  89 ++++---
 tests/m48t59-test.c            |  14 +-
 tests/megasas-test.c           |   7 +-
 tests/multiboot/libc.c         |   2 +-
 tests/ne2000-test.c            |   4 +-
 tests/numa-test.c              | 102 +++-----
 tests/nvme-test.c              |   7 +-
 tests/pc-cpu-test.c            |  24 +-
 tests/pcnet-test.c             |   4 +-
 tests/pnv-xscom-test.c         |  18 +-
 tests/postcopy-test.c          |  93 ++++----
 tests/prom-env-test.c          |  15 +-
 tests/pvpanic-test.c           |   8 +-
 tests/pxe-test.c               |  16 +-
 tests/q35-test.c               |  24 +-
 tests/qmp-test.c               |  43 ++--
 tests/qom-test.c               |   7 +-
 tests/rtas-test.c              |   3 +-
 tests/rtc-test.c               |  94 ++++----
 tests/rtl8139-test.c           |  17 +-
 tests/spapr-phb-test.c         |   5 +-
 tests/tco-test.c               |  45 ++--
 tests/test-arm-mptimer.c       |  43 ++--
 tests/test-filter-mirror.c     |  19 +-
 tests/test-filter-redirector.c |  66 +++---
 tests/test-hmp.c               |  13 +-
 tests/test-netfilter.c         |   9 +-
 tests/test-qga.c               |  90 -------
 tests/test-x86-cpuid-compat.c  |  13 +-
 tests/tmp105-test.c            |   7 +-
 tests/tpci200-test.c           |   4 +-
 tests/usb-hcd-ehci-test.c      |  27 ++-
 tests/usb-hcd-ohci-test.c      |   4 +-
 tests/usb-hcd-uhci-test.c      |   7 +-
 tests/usb-hcd-xhci-test.c      |  19 +-
 tests/vhost-user-test.c        | 105 +++------
 tests/virtio-9p-test.c         |   5 +-
 tests/virtio-balloon-test.c    |   4 +-
 tests/virtio-blk-test.c        |  83 ++++---
 tests/virtio-console-test.c    |  10 +-
 tests/virtio-net-test.c        |  30 ++-
 tests/virtio-rng-test.c        |   9 +-
 tests/virtio-scsi-test.c       |  22 +-
 tests/virtio-serial-test.c     |   4 +-
 tests/vmgenid-test.c           |  51 ++--
 tests/vmxnet3-test.c           |   4 +-
 tests/wdt_ib700-test.c         |  92 ++++----
 110 files changed, 1632 insertions(+), 2210 deletions(-)

--=20
2.13.5
