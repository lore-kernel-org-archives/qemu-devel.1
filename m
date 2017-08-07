Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIw-0007Bh-3S
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIg-0003o5-PB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:50 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:23 +0200
Message-Id: <1502117160-24655-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 19/56] block: Make snapshot VM state size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  SnapshotInfo member
@vm-state-size is 'int' (int64_t).  QEMUSnapshotInfo member
@vm_state_size is uint64_t.  bdrv_query_snapshot_info_list(),
bdrv_image_info_dump(), qmp_blockdev_snapshot_delete_internal_sync()
convert implicitly between the two.

Change the SnapshotInfo member to 'size'.

query-named-block-nodes, query-block and
blockdev-snapshot-delete-internal-sync now report VM state sizes above
2^63-1 correctly instead of their (negative) two's complement.

HMP's "info snapshots" and "info block" still report negative values,
because bdrv_snapshot_dump() passes the size to
get_human_readable_size(), which is still signed.  To be fixed soon.

Same for "qemu-img snapshot -l" and "qemu-img info".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 27790f3..ecfeecd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -28,7 +28,7 @@
 #
 ##
 { 'struct': 'SnapshotInfo',
-  'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
+  'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'size',
             'date-sec': 'int', 'date-nsec': 'int',
             'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
 
-- 
2.7.5
