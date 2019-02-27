Received: from eggs.gnu.org ([209.51.188.92]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzCB-0000qd-6X
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzC5-0000U8-Rx
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyzC5-0000TW-Fu
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83DDC3B73D
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:24:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Feb 2019 13:24:04 +0000
Message-Id: <20190227132413.13213-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com
Cc: quintela@redhat.com, armbru@redhat.com, thuth@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a reworking of a few sets of patches from 2017
that were put together by myself, Germano and Vlad that make
the network announce system more flexible.

  Firstly, it's parameterised, so that you can change the number
of packets and the gap between them; the number can be set to 0
to disable announce completely.

  Secondly, you can force an announce by a qmp or hmp command at
any time.  This is useful if you need the guest to do an announce
for a different reason; for example if the management layer
has just juggled some bonding configuration around.

  The packet creation and timing also moves to net/ from migration/

  The previous set was:
     https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05594.html

Dave

v6
  qmp format change (from Markus's review)
  removed gcov line from test (from Thomas's review)
  slightly expanded HMP help text (from Thomas's review)


Dr. David Alan Gilbert (9):
  net: Introduce announce timer
  migration: Add announce parameters
  virtio-net: Switch to using announce timer
  migration: Switch to using announce timer
  net: Add a network device specific self-announcement ability
  virtio-net: Allow qemu_announce_self to trigger virtio announcements
  qmp: Add announce-self command
  hmp: Add hmp_announce_self
  tests: Add a test for qemu self announcements

 hmp-commands.hx                |  16 ++++
 hmp.c                          |  33 ++++++++
 hmp.h                          |   1 +
 hw/net/trace-events            |   6 ++
 hw/net/virtio-net.c            |  69 ++++++++++++----
 include/hw/virtio/virtio-net.h |   4 +-
 include/migration/misc.h       |  12 +--
 include/net/announce.h         |  41 ++++++++++
 include/net/net.h              |   2 +
 include/qemu/typedefs.h        |   1 +
 include/sysemu/sysemu.h        |   2 -
 migration/migration.c          | 103 +++++++++++++++++++++++-
 migration/migration.h          |   4 +
 migration/savevm.c             |  72 +----------------
 migration/trace-events         |   1 -
 net/Makefile.objs              |   1 +
 net/announce.c                 | 140 +++++++++++++++++++++++++++++++++
 net/trace-events               |   3 +
 qapi/migration.json            |  53 ++++++++++++-
 qapi/net.json                  |  43 ++++++++++
 tests/Makefile.include         |   3 +
 tests/test-announce-self.c     |  82 +++++++++++++++++++
 tests/test-hmp.c               |   1 +
 23 files changed, 590 insertions(+), 103 deletions(-)
 create mode 100644 include/net/announce.h
 create mode 100644 net/announce.c
 create mode 100644 tests/test-announce-self.c

--=20
2.20.1
