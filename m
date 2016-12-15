Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBt-0002wq-G1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBp-0001IW-TQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59257
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBp-0001Ht-M8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jfit079896
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:29 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm790ay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:27 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:23 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-30-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 29/67] qht: simplify qht_reset_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>

From: "Emilio G. Cota" <cota@braap.org>

Sometimes gcc doesn't pick up the fact that 'new' is properly
set if 'resize == true', which may generate an unnecessary
build warning.

Fix it by removing 'resize' and directly checking that 'new'
is non-NULL.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1475706880-10667-2-git-send-email-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f555a9d0b3c785b698f32e6879e97d0a4b387314)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/qht.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/util/qht.c b/util/qht.c
index 16a8d79..af8da3c 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -410,10 +410,9 @@ void qht_reset(struct qht *ht)
 
 bool qht_reset_size(struct qht *ht, size_t n_elems)
 {
-    struct qht_map *new;
+    struct qht_map *new = NULL;
     struct qht_map *map;
     size_t n_buckets;
-    bool resize = false;
 
     n_buckets = qht_elems_to_buckets(n_elems);
 
@@ -421,18 +420,17 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
     map = ht->map;
     if (n_buckets != map->n_buckets) {
         new = qht_map_create(n_buckets);
-        resize = true;
     }
 
     qht_map_lock_buckets(map);
     qht_map_reset__all_locked(map);
-    if (resize) {
+    if (new) {
         qht_do_resize(ht, new);
     }
     qht_map_unlock_buckets(map);
     qemu_mutex_unlock(&ht->lock);
 
-    return resize;
+    return !!new;
 }
 
 static inline
-- 
1.9.1
