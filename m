Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3h4-0006oP-Gq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3h3-0003px-9R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:10:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 13 Sep 2017 11:10:35 +0200
Message-Id: <20170913091038.2900-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] iotests: cure s390x failures by
 switching to ccw/aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Recent changes in s390x made pci support dependant on the zpci cpu
feature, which is not provided on all models (and not on by default).
This means we cannot instatiate pci devices on a standard qemu
invocation for s390x. Moreover, the zpci instructions are not even
wired up for tcg yet, so actually doing anything with those pci devices
is bound to fail on tcg.

For 040, 051, 139, and 182, this can be fixed by switching to virtio-ccw
from virtio-pci on s390x. 051 also needs a bit of post-processing on
the output.

For 067, it is easier to switch to virtio aliases, which will pick
virtio-ccw on s390x and virtio-pci elsewhere. It also exercises the
aliasing path.

v1->v2:
- avoid adding new reference output by adding post-processing to 051
  and switching to aliases for 067

Cornelia Huck (3):
  iotests: use -ccw on s390x for 040, 139, and 182
  iotests: use -ccw on s390x for 051
  iotests: use virtio aliases for 067

 tests/qemu-iotests/040        |  6 +++++-
 tests/qemu-iotests/051        | 12 +++++++++++-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 tests/qemu-iotests/067        |  3 ++-
 tests/qemu-iotests/067.out    |  2 +-
 tests/qemu-iotests/139        | 12 ++++++++++--
 tests/qemu-iotests/182        | 13 +++++++++++--
 8 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.13.5
