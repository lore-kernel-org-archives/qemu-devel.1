Received: from eggs.gnu.org ([2001:4830:134:3::10]:36946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Um-C5
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004FJ-6Y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:23 +0300
Message-Id: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 00/10] NBD reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

Here is NBD reconnect. Previously, if connection failed all current
and future requests will fail. After the series, nbd-client driver
will try to reconnect unlimited times. During first @reconnect-delay
seconds of reconnecting all requests will wait for the connection,
and if it is established requests will be resent. After
@reconnect-delay period all requests will be failed (until successful
reconnect).

v4: - add Eric's r-b to 01.
    - drop CONNECTING_INIT mode, don't reconnect on _open.
    - new api: only one parameter @reconnect-delay
    - new interval scheme between reconnect attempts
        (1 - 2 - 4 - 8 - 16 - 16 ... seconds)
    - fixes and refactorings in main patch (09), including merge with
      old 08 patch
    

v3:
06: fix build error in function 'nbd_co_send_request':
     error: 'i' may be used uninitialized in this function

v2 notes:
Here is v2 of NBD reconnect, but it is very very different from v1, so,
forget about v1.
The series includes my "NBD reconnect: preliminary refactoring", with
changes in 05: leave asserts (Eric).

Vladimir Sementsov-Ogievskiy (10):
  block/nbd-client: split channel errors from export errors
  block/nbd: move connection code from block/nbd to block/nbd-client
  block/nbd-client: split connection from initialization
  block/nbd-client: fix nbd_reply_chunk_iter_receive
  block/nbd-client: don't check ioc
  block/nbd-client: move from quit to state
  block/nbd-client: rename read_reply_co to connection_co
  block/nbd: add cmdline and qapi parameter reconnect-delay
  block/nbd-client: nbd reconnect
  iotests: test nbd reconnect

 qapi/block-core.json          |  12 +-
 block/nbd-client.h            |  20 +-
 block/nbd-client.c            | 515 +++++++++++++++++++++++++++++++-----------
 block/nbd.c                   |  56 ++---
 tests/qemu-iotests/220        |  67 ++++++
 tests/qemu-iotests/220.out    |   7 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +
 8 files changed, 512 insertions(+), 170 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

-- 
2.11.1
