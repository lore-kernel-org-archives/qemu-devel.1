Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7B7-00020s-NT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7B3-000400-Fp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7B3-0003zK-8z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FE73D9960
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:15:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:11 -0500
Message-Id: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/12] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com

I've merged the best aspects of Markus' and my previous posts on
the topic.  While it mostly touches test code (and thus could
be considered 2.10 material at a stretch), it's a big enough
series that it's probably safer to leave for 2.11.

If you like the idea of qmp_cmd() taking a command name and a
QObject (easier than QDict) for arguments, there may be more
places to clean up to use that paradigm (for this round of
posting, I focused more on cleaning up the areas touched in
earlier patches, rather than a global search).

Eric Blake (5):
  qobject: Accept "%"PRId64 in qobject_from_jsonf()
  qtest: Avoid passing raw strings through hmp()
  qtest: Document calling conventions
  qtest: Add a new helper qmp_cmd() and friends
  qtests: convert tests to use qmp_cmd

Markus Armbruster (7):
  tests: Pass literal format strings directly to qmp_FOO()
  tests: Clean up string interpolation into QMP input (simple cases)
  tests/libqos/usb: Clean up string interpolation into QMP input
  tests/libqos/pci: Clean up string interpolation into QMP input
  tests: Clean up wait for event
  tests/libqtest: Clean up how we read the QMP greeting
  tests/libqtest: Enable compile-time format string checking

 configure                      |  24 +++++++
 tests/libqos/pci.h             |   2 +-
 tests/libqtest.h               | 103 ++++++++++++++++++--------
 qobject/json-lexer.c           |  21 +++---
 qobject/json-parser.c          |  10 +--
 tests/ahci-test.c              |   4 +-
 tests/boot-order-test.c        |   2 +-
 tests/check-qjson.c            |   7 ++
 tests/device-introspect-test.c |   3 +-
 tests/ide-test.c               |   4 +-
 tests/ivshmem-test.c           |  10 +--
 tests/libqos/libqos.c          |  17 +----
 tests/libqos/pci-pc.c          |  15 +---
 tests/libqos/pci.c             |  32 +++++----
 tests/libqos/usb.c             |  30 ++++----
 tests/libqtest.c               |  29 +++++++-
 tests/pc-cpu-test.c            |  10 +--
 tests/postcopy-test.c          |  15 ++--
 tests/tco-test.c               |   3 +-
 tests/test-hmp.c               |   4 +-
 tests/test-qga.c               | 160 ++++++++++++++++++-----------------------
 tests/usb-hcd-uhci-test.c      |   6 +-
 tests/usb-hcd-xhci-test.c      |  12 +---
 tests/vhost-user-test.c        |  16 ++---
 tests/virtio-blk-test.c        |   5 +-
 tests/wdt_ib700-test.c         |  35 +++------
 26 files changed, 303 insertions(+), 276 deletions(-)

-- 
2.13.3
