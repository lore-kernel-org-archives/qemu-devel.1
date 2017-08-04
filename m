Received: from eggs.gnu.org ([2001:4830:134:3::10]:59484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNH-0008E8-K7
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNE-0003hB-7G
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRND-0003g2-VA
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F97580460
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:25:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:29 -0500
Message-Id: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Definitely 2.11 material now.  v4 is a rather big overhaul
of what has been previously posted, rebasing things to make
it easier to pass the command name separately from the args
when calling qmp() derivatives in the testsuite, and adding
support for %% handling to make -Wformat checking more robust.

Also available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git qapi-qmp-cleanup-v4

Diffstat since v3:

001/22:[0011] [FC] 'qobject: Accept "%"PRId64 in qobject_from_jsonf()'
002/22:[----] [--] 'tests: Clean up wait for event'
003/22:[----] [--] 'tests/libqtest: Clean up how we read the QMP greeting'
004/22:[down] 'tests: Add assertion for no qmp("")'
005/22:[down] 'qobject: Simplify qobject_from_jsonv()'
006/22:[down] 'qobject: Perform %% interpolation in qobject_from_jsonf()'
007/22:[down] 'numa-test: Use hmp()'
008/22:[----] [--] 'qtest: Avoid passing raw strings through hmp()'
009/22:[0022] [FC] 'qtest: Document calling conventions'
010/22:[down] 'libqtest: Skip round-trip through QObject'
011/22:[down] 'test-qga: Simplify command construction'
012/22:[down] 'libqtest: Change qmp_fd_send() to drop varargs'
013/22:[down] 'libqtest: Add qmp_raw()'
014/22:[down] 'libqtest: Separate qmp_discard_response() from command'
015/22:[down] 'libqtest: Delete qtest_qmp() wrappers'
016/22:[down] 'libqtest: Add qmp_cmd() helper'
017/22:[down] 'libqtest: Add qmp_args() helper'
018/22:[0014] [FC] 'tests/libqos/usb: Clean up string interpolation into QMP input'
019/22:[down] 'libqtest: Add qmp_args_dict() helper'
020/22:[0004] [FC] 'tests/libqos/pci: Clean up string interpolation into QMP input'
021/22:[down] 'libqtest: Drop now-unused qmp()'
022/22:[down] 'libqtest: Rename qmp_cmd() to qmp()'

Eric Blake (18):
  qobject: Accept "%"PRId64 in qobject_from_jsonf()
  tests: Add assertion for no qmp("")
  qobject: Simplify qobject_from_jsonv()
  qobject: Perform %% interpolation in qobject_from_jsonf()
  numa-test: Use hmp()
  qtest: Avoid passing raw strings through hmp()
  qtest: Document calling conventions
  libqtest: Skip round-trip through QObject
  test-qga: Simplify command construction
  libqtest: Change qmp_fd_send() to drop varargs
  libqtest: Add qmp_raw()
  libqtest: Separate qmp_discard_response() from command
  libqtest: Delete qtest_qmp() wrappers
  libqtest: Add qmp_cmd() helper
  libqtest: Add qmp_args() helper
  libqtest: Add qmp_args_dict() helper
  libqtest: Drop now-unused qmp()
  libqtest: Rename qmp_cmd() to qmp()

Markus Armbruster (4):
  tests: Clean up wait for event
  tests/libqtest: Clean up how we read the QMP greeting
  tests/libqos/usb: Clean up string interpolation into QMP input
  tests/libqos/pci: Clean up string interpolation into QMP input

 configure                          |  24 ++++
 include/qapi/qmp/qjson.h           |   2 +-
 tests/libqos/pci.h                 |   2 +-
 tests/libqtest.h                   | 163 +++++++++++---------------
 tests/libqtest.c                   | 234 ++++++++++++++-----------------------
 qobject/json-lexer.c               |  24 ++--
 qobject/json-parser.c              |  59 +++++-----
 qobject/qjson.c                    |  49 +++++++-
 tests/ahci-test.c                  |  29 ++---
 tests/boot-order-test.c            |   4 +-
 tests/check-qjson.c                |  57 +++++++++
 tests/device-introspect-test.c     |   7 +-
 tests/drive_del-test.c             |  11 +-
 tests/fdc-test.c                   |  11 +-
 tests/ide-test.c                   |   5 +-
 tests/ivshmem-test.c               |  10 +-
 tests/libqos/ahci.c                |   4 +-
 tests/libqos/libqos.c              |  23 +---
 tests/libqos/pci-pc.c              |  14 +--
 tests/libqos/pci.c                 |  32 ++---
 tests/libqos/usb.c                 |  26 ++---
 tests/numa-test.c                  |  23 +---
 tests/pc-cpu-test.c                |   8 +-
 tests/postcopy-test.c              |  41 +++----
 tests/q35-test.c                   |   2 +-
 tests/qmp-test.c                   |  27 +++--
 tests/qom-test.c                   |  11 +-
 tests/tco-test.c                   |   3 +-
 tests/test-filter-mirror.c         |   3 +-
 tests/test-filter-redirector.c     |   6 +-
 tests/test-hmp.c                   |   4 +-
 tests/test-netfilter.c             | 139 +++++++++-------------
 tests/test-qga.c                   | 220 +++++++++++++++++-----------------
 tests/test-qobject-input-visitor.c |  18 +--
 tests/test-x86-cpuid-compat.c      |   8 +-
 tests/tmp105-test.c                |   9 +-
 tests/usb-hcd-uhci-test.c          |  20 +---
 tests/usb-hcd-xhci-test.c          |  37 ++----
 tests/vhost-user-test.c            |  12 +-
 tests/virtio-blk-test.c            |  20 ++--
 tests/virtio-net-test.c            |  13 +--
 tests/virtio-scsi-test.c           |  13 +--
 tests/virtio-serial-test.c         |  12 +-
 tests/vmgenid-test.c               |   2 +-
 tests/wdt_ib700-test.c             |  37 ++----
 45 files changed, 678 insertions(+), 800 deletions(-)

-- 
2.13.3
