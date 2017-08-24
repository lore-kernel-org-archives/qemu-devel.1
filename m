Received: from eggs.gnu.org ([2001:4830:134:3::10]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpd-000491-MV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpa-0005uY-JB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxpa-0005ty-AR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:18 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:30 +0100
Message-Id: <20170824192730.8440-33-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 32/32] postcopy shared docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some notes to the migration documentation for shared memory
postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/migration.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
index 1b940a829b..d4c344c671 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.txt
@@ -553,3 +553,42 @@ Postcopy now works with hugetlbfs backed memory:
      hugepages works well, however 1GB hugepages are likely to be problematic
      since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps link,
      and until the full page is transferred the destination thread is blocked.
+
+=== Postcopy with shared memory ===
+
+Postcopy migration with shared memory needs explicit support from the other
+processes that share memory and from QEMU. There are restrictions on the type of
+memory that userfault can support shared.
+
+The Linux kernel userfault support works on /dev/shm memory and on hugetlbfs
+(although the kernel doesn't provide an equivalent to madvise(MADV_DONTNEED)
+for hugetlbfs which may be a problem in some configurations).
+
+The vhost-user code in QEMU supports clients that have Postcopy support,
+and the vhost-user-bridge (in tests/) and the DPDK package have changes
+to support postcopy.
+
+The client needs to open a userfaultfd and register the areas
+of memory that it maps with userfault.  The client must then pass the
+userfaultfd back to QEMU together with a mapping table that allows
+fault addresses in the clients address space to be converted back to
+RAMBlock/offsets.  The client's userfaultfd is added to the postcopy
+fault-thread and page requests are made on behalf of the client by QEMU.
+QEMU performs 'wake' operations on the client's userfaultfd to allow it
+to continue after a page has arrived.
+
+  Note: There are two future improvements that would be nice:
+    a) Some way to make QEMU ignorant of the addresses in the clients
+      address space
+    b) Avoiding the need for QEMU to perform ufd-wake calls after the
+      pages have arrived
+
+Retro-fitting postcopy to existing clients is possible:
+  a) A mechanism is needed for the registration with userfault as above,
+     and the registration needs to be coordinated with the phases of
+     postcopy.  In vhost-user extra messages are added to the existing
+     control channel.
+  b) Any thread that can block due to guest memory accesses must be
+     identified and the implication understood; for example if the
+     guest memory access is made while holding a lock then all other
+     threads waiting for that lock will also be blocked.
-- 
2.13.5
