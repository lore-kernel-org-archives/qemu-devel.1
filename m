Received: from eggs.gnu.org ([209.51.188.92]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAv-000694-Sv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAr-00070C-Pv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:57 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34508)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAr-0006yy-7Z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:53 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 12 Apr 2019 15:20:25 +0300
Message-Id: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru

Hi,

I've added 'inline-fd:' proto to simplify migration to/from fd.
I thought about modifying the existing 'fd:' proto but I'm not sure it's =
a
good idea to change it's contract.

Existing 'fd:' proto works with previously added fd by getfd or add-fd co=
mmands.
If client doesn't want to work with this fd before or after migration the=
n it's
easier to send an fd with the migrate-* command. Also, client shouldn't m=
aintain
this fd.

Usage:
{ 'execute': 'migrate', 'arguments': { 'uri': 'inline-fd:' } }
{ 'execute': 'migrate-incoming', 'arguments': { 'uri': 'inline-fd:' } }

Regards,
Yury

Yury Kotov (3):
  monitor: Add monitor_recv_fd function to work with sent fds
  migration: Add inline-fd protocol
  migration-test: Add a test for inline_fd protocol

 include/monitor/monitor.h          |   1 +
 migration/Makefile.objs            |   2 +-
 migration/inline-fd.c              |  89 ++++++++++++++++++++++
 migration/inline-fd.h              |  22 ++++++
 migration/migration.c              |  15 ++++
 migration/trace-events             |   4 +
 monitor.c                          |  15 +++-
 tests/libqtest.c                   |  83 +++++++++++++++++++-
 tests/libqtest.h                   |  51 ++++++++++++-
 tests/migration-test.c             | 117 ++++++++++++++++++++++++++---
 tests/qemu-seccomp                 | Bin 0 -> 1266168 bytes
 tests/test-query-device-blockstats | Bin 0 -> 1272608 bytes
 12 files changed, 379 insertions(+), 20 deletions(-)
 create mode 100644 migration/inline-fd.c
 create mode 100644 migration/inline-fd.h
 create mode 100755 tests/qemu-seccomp
 create mode 100755 tests/test-query-device-blockstats

--=20
2.21.0
