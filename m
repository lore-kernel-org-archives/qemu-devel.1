Received: from eggs.gnu.org ([2001:4830:134:3::10]:48967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-0007NE-Gg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIq-0003vN-Gb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:28 +0200
Message-Id: <1502117160-24655-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 24/56] block/qcow2: Change align_offset()
 to operate on uint64_t
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

align_offset() mixes different widths, and its callers pass both
signed and unsigned values.  It's best to stick to unsigned when
twiddling bits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qcow2.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 96a8d43..0d7043e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -468,10 +468,9 @@ static inline int offset_to_l2_index(BDRVQcow2State *s, int64_t offset)
     return (offset >> s->cluster_bits) & (s->l2_size - 1);
 }
 
-static inline int64_t align_offset(int64_t offset, int n)
+static inline uint64_t align_offset(uint64_t offset, uint64_t n)
 {
-    offset = (offset + n - 1) & ~(n - 1);
-    return offset;
+    return (offset + n - 1) & ~(n - 1);
 }
 
 static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
-- 
2.7.5
