Received: from eggs.gnu.org ([209.51.188.92]:45682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxca-0001oI-3L
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcY-0004fl-P7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hAxcY-0004fF-HR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9FAB3004425
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 14:09:05 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-75.phx2.redhat.com [10.3.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83E9119C7C
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 14:09:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:49 -0500
Message-Id: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] NBD patches for 4.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 230ce19814ecc6bff8edac3b5b86e7c82f422c=
6c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190325' into =
staging (2019-03-29 19:29:00 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-04-01

for you to fetch changes up to 75d34eb98ca0bb2f49d607fcaefd9c482e56b15d:

  nbd/client: Trace server noncompliance on structured reads (2019-04-01 =
08:58:04 -0500)

----------------------------------------------------------------
nbd patches for 2019-04-01

- Better behavior of qemu-img map on NBD images
- Fixes for NBD protocol alignment corner cases:
 - the server has fewer places where it sends reads or block status
   not aligned to its advertised block size
 - the client has more cases where it can work around server
   non-compliance present in qemu 3.1
 - the client now avoids non-compliant requests when interoperating
   with nbdkit or other servers not advertising block size

----------------------------------------------------------------
Eric Blake (14):
      qemu-img: Report bdrv_block_status failures
      nbd: Tolerate some server non-compliance in NBD_CMD_BLOCK_STATUS
      nbd: Don't lose server's error to NBD_CMD_BLOCK_STATUS
      nbd: Permit simple error to NBD_CMD_BLOCK_STATUS
      qemu-img: Gracefully shutdown when map can't finish
      nbd-client: Work around server BLOCK_STATUS misalignment at EOF
      iotests: Add 241 to test NBD on unaligned images
      nbd/client: Lower min_block for block-status, unaligned size
      nbd/client: Report offsets in bdrv_block_status
      nbd/client: Reject inaccessible tail of inconsistent server
      nbd/client: Support qemu-img convert from unaligned size
      block: Add bdrv_get_request_alignment()
      nbd/server: Advertise actual minimum block size
      nbd/client: Trace server noncompliance on structured reads

 include/sysemu/block-backend.h |   1 +
 block/block-backend.c          |   7 +++
 block/nbd-client.c             | 124 +++++++++++++++++++++++++++++++++--=
------
 block/nbd.c                    |  19 ++++++-
 nbd/client.c                   |   8 +++
 nbd/server.c                   |  13 +++--
 qemu-img.c                     |  16 ++++--
 block/trace-events             |   2 +
 tests/qemu-iotests/209.out     |   4 +-
 tests/qemu-iotests/223.out     |  22 ++++----
 tests/qemu-iotests/233.out     |   2 +-
 tests/qemu-iotests/241         | 100 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/241.out     |  28 ++++++++++
 tests/qemu-iotests/group       |   1 +
 14 files changed, 299 insertions(+), 48 deletions(-)
 create mode 100755 tests/qemu-iotests/241
 create mode 100644 tests/qemu-iotests/241.out

--=20
2.20.1
