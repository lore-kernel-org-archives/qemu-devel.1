Received: from eggs.gnu.org ([2001:4830:134:3::10]:35360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGE-0004iF-4C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAG8-00056E-Ve
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAG8-000564-Qn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F05C74075188
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 01:37:35 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-121.rdu2.redhat.com [10.10.122.121])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B72972026D76
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 01:37:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 20:37:24 -0500
Message-Id: <20180703013730.55375-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] NBD patches for 2018-07-02 (3.0 soft freeze)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-07-02

for you to fetch changes up to a1532a225a183c9fa60b9c1e8ac8a00c7771f64d:

  iotests: New test 223 for exporting dirty bitmap over NBD (2018-07-02 1=
9:50:37 -0500)

Discussed but not included here: we need to ensure that during a
backup sync:none job, writes must NOT be permitted to the fleecing
node's backing file as long as reads are being served from the same
area. Hopefully we can fix this via the existing job, instead of
having to add a new filter node.

----------------------------------------------------------------
nbd patches for 2018-07-02

Bug fixes and iotest exposure of fleecing via NBD (serving a
read-only point-in-time view via blockdev-backup sync:none,
as well as serving dirty bitmaps over NBD), including a new
x-dirty-bitmap parameter when opening NBD clients as the
counterpart to x-nbd-server-add-bitmap. Also a random fix
for iscsi block_status spotted by Coverity that missed other
miscellaneous trees.

- Eric Blake: nbd/server: Fix dirty bitmap logic regression
- Eric Blake: iscsi: Avoid potential for get_status overflow
- John Snow/Vladimir Sementsov-Ogievskiy: 0/2 block: formalize and test f=
leecing
- Eric Blake: 0/2 test NBD bitmap export

----------------------------------------------------------------
Eric Blake (4):
      nbd/server: Fix dirty bitmap logic regression
      iscsi: Avoid potential for get_status overflow
      nbd/client: Add x-dirty-bitmap to query bitmap from server
      iotests: New test 223 for exporting dirty bitmap over NBD

John Snow (1):
      iotests: add 222 to test basic fleecing

Vladimir Sementsov-Ogievskiy (1):
      blockdev: enable non-root nodes for backup source

 qapi/block-core.json       |   7 +-
 block/nbd-client.h         |   1 +
 include/block/nbd.h        |   1 +
 block/iscsi.c              |   2 +-
 block/nbd-client.c         |   3 +
 block/nbd.c                |  10 ++-
 blockdev.c                 |   4 +-
 nbd/client.c               |   4 +-
 nbd/server.c               |   2 +-
 tests/qemu-iotests/222     | 155 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/222.out |  67 ++++++++++++++++++++
 tests/qemu-iotests/223     | 138 +++++++++++++++++++++++++++++++++++++++=
+
 tests/qemu-iotests/223.out |  49 ++++++++++++++
 tests/qemu-iotests/group   |   2 +
 14 files changed, 436 insertions(+), 9 deletions(-)
 create mode 100644 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out
 create mode 100755 tests/qemu-iotests/223
 create mode 100644 tests/qemu-iotests/223.out

--=20
2.14.4
