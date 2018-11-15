Received: from eggs.gnu.org ([2001:4830:134:3::10]:53760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70u-0002QA-Ni
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70r-0005kj-HL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:32 -0600
Message-Id: <20181115020334.1189829-12-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/13] qcow2: Audit for read/write 64-bit
 cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

The qcow2 read/write functions do their own fragmentation (because
of cluster remapping); while we could advertise s->cluster_size
and let the block layer do fragmentation for us, that would NOT
solve the issue of the block layer handing us a length less than
a cluster but at an offset which overlaps a cluster boundary. Thus,
we still have to fragment ourselves, at which point it is easiest
to just document that this driver is 64-bit clean.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0b5ad130060..1dd3491f77f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1687,6 +1687,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->cluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.max_transfer = INT64_MAX;
 }

 static int qcow2_reopen_prepare(BDRVReopenState *state,
-- 
2.17.2
