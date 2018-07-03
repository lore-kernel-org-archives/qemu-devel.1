Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPS9-00055x-62
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPS8-00034h-EV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:51:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Jul 2018 19:50:47 +0200
Message-Id: <20180703175049.27669-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix attaching drained child node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

This fixes the following case that was reported by Max and was caused by
not correctly waiting for activity to cease on the parent node before
attaching a drained child node:

$ ./qemu-img create -f qed foo.qed 64M
Formatting 'foo.qed', fmt=qed size=67108864 cluster_size=65536
$ echo "{'execute':'qmp_capabilities'}
        {'execute':'blockdev-snapshot',
         'arguments':{'node':'backing','overlay':'overlay'}}
        {'execute':'quit'}" | \
    x86_64-softmmu/qemu-system-x86_64 -qmp stdio -nodefaults \
        -blockdev "{'node-name':'backing','driver':'null-co'}" \
        -blockdev "{'node-name':'overlay','driver':'qed',
                    'file':{'driver':'file','filename':'foo.qed'}}"
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
"package": "v2.12.0-1422-g0109e7e6f8"}, "capabilities": []}}
{"return": {}}
qemu-system-x86_64: block.c:3434: bdrv_replace_node: Assertion
`!atomic_read(&to->in_flight)' failed.
[1]    5252 done                 echo  |
       5253 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
stdio -nodefaults -blockdev  -blockdev

Kevin Wolf (2):
  block: Poll after drain on attaching a node
  test-bdrv-drain: Test bdrv_append() to drained node

 include/block/block.h     |  8 ++++++++
 include/block/block_int.h |  3 +++
 block.c                   |  2 +-
 block/io.c                | 26 ++++++++++++++++++++------
 tests/test-bdrv-drain.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 7 deletions(-)

-- 
2.13.6
