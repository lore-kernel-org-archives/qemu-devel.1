Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqq-0002oH-TZ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqn-0002XK-QG
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:24 -0400
Received: from relay.sw.ru ([195.214.232.25]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fRfqn-0002WG-G7
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:21 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat,  9 Jun 2018 18:32:06 +0300
Message-Id: <20180609153217.19683-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 00/11] NBD reconnect
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

Here is NBD reconnect.
The feature realized inside nbd-client driver and works as follows:

There are two parameters: reconnect-attempts and reconnect-timeout.
So, we will try to reconnect in case of initial connection failed or
in case of connection lost. All current and new io operations will wait
until we make reconnect-attempts tries to reconnect. After this, all
requests will fail with EIO, but we will continue trying to reconnect.

v3:
06: fix build error in function 'nbd_co_send_request':
     error: 'i' may be used uninitialized in this function

v2 notes:
Here is v2 of NBD reconnect, but it is very very different from v1, so,
forget about v1.
The series includes my "NBD reconnect: preliminary refactoring", with
changes in 05: leave asserts (Eric).

Vladimir Sementsov-Ogievskiy (11):
  block/nbd-client: split channel errors from export errors
  block/nbd: move connection code from block/nbd to block/nbd-client
  block/nbd-client: split connection from initialization
  block/nbd-client: fix nbd_reply_chunk_iter_receive
  block/nbd-client: don't check ioc
  block/nbd-client: move from quit to state
  block/nbd-client: rename read_reply_co to connection_co
  block/nbd-client: move connecting to connection_co
  block/nbd: add cmdline and qapi parameters for nbd reconnect
  block/nbd-client: nbd reconnect
  iotests: test nbd reconnect

 qapi/block-core.json          |  12 +-
 block/nbd-client.h            |  23 ++-
 block/nbd-client.c            | 429 ++++++++++++++++++++++++++++++------------
 block/nbd.c                   |  61 +++---
 tests/qemu-iotests/220        |  68 +++++++
 tests/qemu-iotests/220.out    |   7 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +
 8 files changed, 445 insertions(+), 160 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

-- 
2.11.1
