Received: from eggs.gnu.org ([2001:4830:134:3::10]:33417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evlSP-0003Qn-M1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evlSJ-0005uE-Gw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:03:17 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 13 Mar 2018 17:02:10 +0200
Message-Id: <cover.1520952419.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] Give the refcount cache the minimum
 possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

we talked about this the other day, so here are the patches to change
the default cache sizes in qcow2.

Without this patch:

 * refcount-cache-size = l2-cache-size / 4

unless otherwise specified by the user. This is wasteful, the refcount
cache is accessed sequentially during normal I/O, so there's no point
in caching more tables. I measured the effect on the refcount cache
size when populating an empty qcow2 image using random writes, and
there's no difference between having the minimum or the maximum
sizes(*).

With this patch:

 * refcount-cache-size is always 4 clusters by default (the minimum)

 * If "cache-size" is set then l2-cache-size is set to the maximum if
   possible (disk_size * 8 / cluster_size) and the remainder is
   assigned to the refcount cache.

Regards,

Berto

(*) there is, actually: having a very large cache can even make the
    I/O slightly slower, because the larger the cache the longer it
    takes longer to find a cached entry. I only noticed this under
    tmpfs anyway.

Alberto Garcia (2):
  qcow2: Give the refcount cache the minimum possible size by default
  docs: Document the new default sizes of the qcow2 caches

 block/qcow2.c              | 31 +++++++++++++++++++------------
 block/qcow2.h              |  4 ----
 docs/qcow2-cache.txt       | 31 ++++++++++++++-----------------
 tests/qemu-iotests/137.out |  2 +-
 4 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.11.0
