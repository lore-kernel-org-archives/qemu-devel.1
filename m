Received: from eggs.gnu.org ([2001:4830:134:3::10]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWN-000779-Kg
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWK-0006nJ-8M
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWK-0006mJ-29
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5957F4022909
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:01 +0200
Message-Id: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/20] tests: Compile-time format string
 checking for libqtest.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a reboot of "[PATCH 0/9] tests: Clean up around qmp() and
hmp()" I sent about a year ago.  Back then, Eric folded it into his
"Clean up around qmp() and hmp()" series, which stalled after v4.

My reboot tries to avoid that fate by reducing mission creep.  There
are plenty of good ideas in Eric's series we should mine some day, but
today is not that day.

Since the changes outside tests are limited to renames and a few new
helpers, all in qobject/qjson.c, I guess we could merge this for 3.0.
But it can just as well wait for the next development cycle.

Eric Blake (1):
  libqtest: Document calling conventions

Markus Armbruster (19):
  libqtest: Rename functions to send QMP messages
  libqtest: Clean up how we read device_del messages
  libqtest: Clean up how we read the QMP greeting
  qobject: Replace qobject_from_jsonf() by qobject_from_jsonf_nofail()
  qobject: New qobject_from_vjsonf_nofail(), qdict_from_vjsonf_nofail()
  libqtest: Simplify qmp_fd_vsend() a bit
  test-qobject-input-visitor: Avoid format string ambiguity
  qobject: qobject_from_jsonv() is dangerous, hide it away
  tests: Pass literal format strings directly to qmp_FOO()
  tests: Clean up string interpolation into QMP input (simple cases)
  cpu-plug-test: Don't pass integers as strings to device_add
  tests: Clean up string interpolation around qtest_qmp_device_add()
  migration-test: Make wait_command() return the "return" member
  tests: New helper qtest_qmp_receive_success()
  migration-test: Make wait_command() cope with '%'
  migration-test: Clean up string interpolation into QMP, part 1
  migration-test: Clean up string interpolation into QMP, part 2
  migration-test: Clean up string interpolation into QMP, part 3
  libqtest: Enable compile-time format string checking

 include/qapi/qmp/qjson.h           |  12 +-
 qobject/qjson.c                    |  89 +++++++++++----
 tests/ahci-test.c                  |  12 +-
 tests/check-qjson.c                |  15 +--
 tests/cpu-plug-test.c              |   7 +-
 tests/e1000e-test.c                |   6 +-
 tests/ide-test.c                   |   4 +-
 tests/ivshmem-test.c               |   8 +-
 tests/libqos/ahci.c                |   4 +-
 tests/libqos/pci-pc.c              |   9 +-
 tests/libqos/pci.c                 |   7 --
 tests/libqos/pci.h                 |   2 -
 tests/libqos/usb.c                 |  10 +-
 tests/libqos/usb.h                 |   2 +-
 tests/libqtest.c                   | 141 +++++++++++++----------
 tests/libqtest.h                   |  90 ++++++++++-----
 tests/migration-test.c             | 178 ++++++++++++-----------------
 tests/qmp-test.c                   |  18 +--
 tests/test-qga.c                   | 150 +++++++++++-------------
 tests/test-qobject-input-visitor.c |  19 +--
 tests/tpm-util.c                   |  41 ++-----
 tests/usb-hcd-ehci-test.c          |   2 +-
 tests/usb-hcd-ohci-test.c          |   2 +-
 tests/usb-hcd-uhci-test.c          |   4 +-
 tests/usb-hcd-xhci-test.c          |  10 +-
 tests/vhost-user-test.c            |   6 +-
 tests/virtio-blk-test.c            |   5 +-
 tests/virtio-net-test.c            |   3 +-
 tests/virtio-rng-test.c            |   3 +-
 tests/virtio-scsi-test.c           |   2 +-
 tests/virtio-serial-test.c         |   2 +-
 31 files changed, 439 insertions(+), 424 deletions(-)

-- 
2.17.1
