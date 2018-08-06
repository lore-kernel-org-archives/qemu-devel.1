Received: from eggs.gnu.org ([2001:4830:134:3::10]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOp-0001XI-44
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOl-000870-TF
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fmZOl-000867-NB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:47 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Aug 2018 08:53:21 +0200
Message-Id: <20180806065344.7103-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/23] tests: Compile-time format string
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
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

This is a reboot of "[PATCH 0/9] tests: Clean up around qmp() and
hmp()" I sent about a year ago.  Back then, Eric folded it into his
"Clean up around qmp() and hmp()" series, which stalled after v4.

My reboot tries to avoid that fate by reducing mission creep.  There
are plenty of good ideas in Eric's series we should mine some day, but
today is not that day.

v3:
* Reordered to reduce churn: PATCH 04 was 21, 05 was 01
* PATCH 04: Instead of open coding the *_discard_response() in tests,
  add macros with a TODO [Thomas]
* PATCH 05: Comments tweaked again, ripple effect on PATCH 06+14
* PATCH 14: Quoting bug and commit message typo fixed [Eric]
* PATCH 19: Missing attribute supplied [Eric]
* PATCH 20: Whitespace cleanup [Eric]
* PATCH 22: Commit message typo fixed [Eric]
* PATCH 23: Commit message improved [Eric]
v2:
* PATCH 01: Comments tweaked, ripple effect on PATCH 05+13
* PATCH 05: Commit message improved [Thomas]
* PATCH 06: Style fix [Philippe]
* PATCH 16+17: Silence a warning
* PATCH 21-23: New

Eric Blake (1):
  libqtest: Document calling conventions

Markus Armbruster (22):
  libqtest: Rename functions to send QMP messages
  libqtest: Clean up how we read device_del messages
  libqtest: Clean up how we read the QMP greeting
  libqtest: Remove qtest_qmp_discard_response() & friends
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
  libqtest: Replace qtest_startf() by qtest_initf()
  libqtest: Rename qtest_FOOv() to qtest_vFOO() for consistency

 include/qapi/qmp/qjson.h           |  12 +-
 qobject/qjson.c                    |  89 ++++++++++----
 tests/ahci-test.c                  |  15 +--
 tests/boot-order-test.c            |  13 +-
 tests/boot-serial-test.c           |  10 +-
 tests/cdrom-test.c                 |   6 +-
 tests/check-qjson.c                |  15 +--
 tests/cpu-plug-test.c              |   7 +-
 tests/drive_del-test.c             |   3 +
 tests/e1000e-test.c                |   6 +-
 tests/endianness-test.c            |  24 ++--
 tests/fdc-test.c                   |   4 +
 tests/ide-test.c                   |   9 +-
 tests/ipmi-bt-test.c               |   2 +-
 tests/ivshmem-test.c               |   8 +-
 tests/libqos/ahci.c                |   4 +-
 tests/libqos/pci-pc.c              |   9 +-
 tests/libqos/pci.c                 |   7 --
 tests/libqos/pci.h                 |   2 -
 tests/libqos/usb.c                 |  10 +-
 tests/libqos/usb.h                 |   2 +-
 tests/libqtest.c                   | 189 ++++++++++++++---------------
 tests/libqtest.h                   | 124 ++++++++++---------
 tests/m25p80-test.c                |   6 +-
 tests/m48t59-test.c                |   2 +-
 tests/machine-none-test.c          |   2 +-
 tests/migration-test.c             | 187 +++++++++++++---------------
 tests/numa-test.c                  |   4 +-
 tests/pnv-xscom-test.c             |   8 +-
 tests/prom-env-test.c              |  10 +-
 tests/qmp-test.c                   |  20 +--
 tests/sdhci-test.c                 |   6 +-
 tests/tco-test.c                   |   6 +-
 tests/test-filter-mirror.c         |   6 +-
 tests/test-filter-redirector.c     |   8 +-
 tests/test-qga.c                   | 150 ++++++++++-------------
 tests/test-qobject-input-visitor.c |  19 +--
 tests/tpm-util.c                   |  41 ++-----
 tests/usb-hcd-ehci-test.c          |   2 +-
 tests/usb-hcd-ohci-test.c          |   2 +-
 tests/usb-hcd-uhci-test.c          |   4 +-
 tests/usb-hcd-xhci-test.c          |  10 +-
 tests/vhost-user-test.c            |   6 +-
 tests/virtio-balloon-test.c        |   4 +-
 tests/virtio-blk-test.c            |  17 ++-
 tests/virtio-console-test.c        |  12 +-
 tests/virtio-net-test.c            |   3 +-
 tests/virtio-rng-test.c            |   3 +-
 tests/virtio-scsi-test.c           |   2 +-
 tests/virtio-serial-test.c         |   6 +-
 tests/vmgenid-test.c               |   6 +-
 51 files changed, 561 insertions(+), 561 deletions(-)

--=20
2.17.1
