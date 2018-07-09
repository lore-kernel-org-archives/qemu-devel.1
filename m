Received: from eggs.gnu.org ([2001:4830:134:3::10]:57838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcZAG-0002bl-8s
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcZAB-0002cx-B2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:37:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Jul 2018 19:37:15 +0300
Message-Id: <20180709163719.87107-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

This fixes image fleecing scheme for 3.0, details are in 04 patch.
01 is a significant fix too.

v5: - keep one _internal recursive function like in original code [Fam]
    - grammar and rewording [Eric] (a bit changed,
                                    be free to fix/reword in flight)

PS: 222 now fails for me, no matter with or without these series...

v4:
01: fix copy_range architecture here too
02: rebase on 01
03: rebase

v3:
02: fix typo in assert, to fix build

v2:
01,02: new patches

03: - improve comment
    - fix assert in bdrv_aligned_pwritev
    - add asserts to not use the flag on read requests
    - support copy_range

04: - expand "detected cases" range 
    - s/fleecing/serialize_target_writes
    - support backup_cow_with_offload
    - drop restriction on compressed writes


v1 cover:

It's a continuation of discussion under
"[PATCH v2 2/3] block/fleecing-filter: new filter driver for fleecing" [1].

Here is my try to implement Kevin's idea, that all backup writes (for
fleecing case) should be serialized. (However, I've skipped for now
fixing related permissions).

Looks like these patches may replace patch [1], to make fleecing scheme
safe. But I'm not sure, a look by Kevin is necessary.

A test is still needed, to prove that this patch is necessary and that it
works..


PS: 222 now fails for me, no matter with or without these series:
    222         [failed, exit status 1] - output mismatch (see 222.out.bad)
    --- /work/src/qemu/up-new-fleecing/tests/qemu-iotests/222.out   2018-07-03 20:18:24.247252451 +0300
    +++ /work/src/qemu/up-new-fleecing/tests/qemu-iotests/222.out.bad       2018-07-09 19:36:39.586747425 +0300
    @@ -40,28 +40,7 @@
     --- Verifying Data ---
     
     read -P0x5d 0 64k
    -read -P0xd5 1M 64k
    -read -P0xdc 32M 64k
    -read -P0xcd 0x3ff0000 64k
    -read -P0 0x00f8000 32k
    -read -P0 0x2010000 32k
    -read -P0 0x3fe0000 64k
    -
    ---- Cleanup ---
    -
    -{u'return': {}}
    -{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 67108864, u'offset': 393216}, u'event': u'BLOCK_JOB_CANCELLED'}
    -{u'return': {}}
    -{u'return': {}}
    -
    ---- Confirming writes ---
    -
    -read -P0xab 0 64k
    -read -P0xad 0x00f8000 64k
    -read -P0x1d 0x2008000 64k
    -read -P0xea 0x3fe0000 64k
    -read -P0xd5 0x108000 32k
    -read -P0xdc 32M 32k
    -read -P0xcd 0x3ff0000 64k
    -
    -Done
    +Traceback (most recent call last):
    +  File "222", line 132, in <module>
    +    assert qemu_io_silent('-r', '-f', 'raw', '-c', cmd, nbd_uri) == 0
    +AssertionError
    Failures: 222
    Failed 1 of 1 tests



Vladimir Sementsov-Ogievskiy (4):
  block/io: fix copy_range
  block: split flags in copy_range
  block: add BDRV_REQ_SERIALISING flag
  block/backup: fix fleecing scheme: use serialized writes

 include/block/block.h          |  27 ++++++++++-
 include/block/block_int.h      |  14 ++++--
 include/sysemu/block-backend.h |   3 +-
 block/backup.c                 |  20 +++++---
 block/block-backend.c          |   5 +-
 block/file-posix.c             |  21 ++++----
 block/io.c                     | 106 ++++++++++++++++++++++++++++-------------
 block/iscsi.c                  |   9 ++--
 block/qcow2.c                  |  20 ++++----
 block/raw-format.c             |  24 ++++++----
 qemu-img.c                     |   2 +-
 11 files changed, 174 insertions(+), 77 deletions(-)

-- 
2.11.1
