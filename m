Received: from eggs.gnu.org ([2001:4830:134:3::10]:55014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplyz-0001gV-QB
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplyy-00077k-RH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Aug 2018 21:56:12 -0500
Message-Id: <20180815025614.53588-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Improve qemu-img dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, fullmanet@gmail.com, qemu-block@nongnu.org

I was trying to test NBD fleecing by copying subsets of one
file to another, and had the idea to use:

$ export NBD drive to be fleeced on port 10809
$ qemu-img create -f qcow2 copy $size
$ qemu-nbd -f qcow2 -p 10810 copy
$ qemu-img dd -f raw -O raw if=nbd://localhost:10809 of=nbd://localhost:10810 \
    skip=$offset seek=$offset count=$((len/cluster)) bs=$cluster

except that seek= wasn't implemented. And in implementing that,
I learned that skip= is broken when combined with count=.

[In the meantime, I had to use:

$ export NBD drive to be fleeced on port 10809
$ modprobe nbd
$ qemu-nbd -c /dev/nbd0 -f raw nbd://localhost:10809
$ qemu-nbd -c /dev/nbd1 -f qcow2 copy
$ dd if=/dev/nbd0 of/dev/nbd1 \
    skip=$offset seek=$offset count=$((len/cluster)) bs=$cluster

to get the behavior I needed (basically, create an empty qcow2
destination file, then plug in the guest-visible data based on
the subsets of the disk of my choosing, by reading the block
status/dirty bitmap over NBD).  But bouncing through three
NBD client/server pairs just so I can use plain 'dd' instead
of just two pairs with 'qemu-img dd' feels dirty.
]

Eric Blake (2):
  qemu-img: Fix dd with skip= and count=
  qemu-img: Add dd seek= option

 qemu-img.c                 |  76 ++++++----
 tests/qemu-iotests/160     |  15 +-
 tests/qemu-iotests/160.out | 344 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 397 insertions(+), 38 deletions(-)

-- 
2.14.4
