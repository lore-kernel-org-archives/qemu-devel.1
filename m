Received: from eggs.gnu.org ([209.51.188.92]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5Gd-00069l-Ni
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gh5Gc-0005ZI-II
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:14:59 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  8 Jan 2019 22:14:47 -0600
Message-Id: <20190109041452.31240-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Promote x-nbd-server-add-bitmap to stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

Or rather, move its functionality into nbd-server-add.  And as
a side effect, teach qemu-nbd how to export a persistent bitmap
without having to go through a qemu process and several QMP
commands.

Based-on: <20181221093529.23855-1-jsnow@redhat.com>
[0/11 bitmaps: remove x- prefix from QMP api]

Patch 5 was very lightly tested; I hope to have more time to play
with that patch alongside Andrey's pending [qemu-img info lists
bitmap directory entries], with an update to iotests to
demonstrate how it is possible to inspect dirty bitmaps by using
qemu-img to learn what is available then qemu-nbd to expose them.
It's still painful that there are no qemu-img commands for
creating a new persistent bitmap; that still has to be done via
QMP on a live guest.

Eric Blake (5):
  nbd: Merge nbd_export_set_name into nbd_export_new
  nbd: Allow bitmap export during QMP nbd-server-add
  nbd: Remove x-nbd-server-add-bitmap
  nbd: Merge nbd_export_bitmap into nbd_export_new
  qemu-nbd: Add --bitmap=3DNAME option

 qemu-nbd.texi              |   5 ++
 qapi/block.json            |  35 ++++-------
 include/block/nbd.h        |   7 +--
 blockdev-nbd.c             |  44 ++++++--------
 hmp.c                      |   6 +-
 nbd/server.c               | 121 ++++++++++++++++---------------------
 qemu-nbd.c                 |  19 ++++--
 tests/qemu-iotests/223     |  11 ++--
 tests/qemu-iotests/223.out |   2 -
 9 files changed, 109 insertions(+), 141 deletions(-)

--=20
2.20.1
