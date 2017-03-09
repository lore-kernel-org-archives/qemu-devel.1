Received: from eggs.gnu.org ([2001:4830:134:3::10]:60925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLu-0005wq-6L
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLs-0004jn-ME
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:26 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <c.pinto@virtualopensystems.com>)
	id 1clwLs-0004jf-Ft
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:24 -0500
Received: by mail-wm0-x241.google.com with SMTP id n11so10461883wma.0
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:35:24 -0800 (PST)
From: Christian Pinto <c.pinto@virtualopensystems.com>
Date: Thu,  9 Mar 2017 12:34:34 +0100
Message-Id: <20170309113437.9667-2-c.pinto@virtualopensystems.com>
In-Reply-To: <20170309113437.9667-1-c.pinto@virtualopensystems.com>
References: <57B7F948.9040701@huawei.com>
	<20170309113437.9667-1-c.pinto@virtualopensystems.com>
Subject: [Qemu-devel] [RFC PATCH 1/4] migration/postcopy-ram: check
 pagefault flags in userfaultfd thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com
Cc: b.reynal@virtualopensystems.com, aarcange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, amit.shah@redhat.com, peter.huangpeng@huawei.com, hanweidong@huawei.com, qemu-devel@nongnu.org, tech@virtualopensystems.com, Christian Pinto <c.pinto@virtualopensystems.com>

The UFFD_PAGEFAULT_FLAG_WP should be set every time the page fault is due to a
write to a write-protected page. Flag should be checked at every time
to be sure the page fault is due to a write into WP area.

Signed-off-by: Christian Pinto <c.pinto@virtualopensystems.com>
Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 migration/postcopy-ram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index ea70bd5d16..9c45f1059f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -534,7 +534,12 @@ static void *postcopy_ram_fault_thread(void *opaque)
                 migrate_send_rp_req_pages(mis, NULL,
                                           rb_offset, hostpagesize);
             }
-        } else { /* UFFDIO_REGISTER_MODE_WP */
+        } else if (msg.arg.pagefault.flags &
+                    UFFD_PAGEFAULT_FLAG_WP) { /* UFFDIO_REGISTER_MODE_WP */
+            /*
+             * msg.arg.pagefault.flags &UFFD_PAGEFAULT_FLAG_WP expected to
+             * be set in case of pagefault due to write protected page
+             * */
             MigrationState *ms = container_of(us, MigrationState,
                                               userfault_state);
             ret = ram_save_queue_pages(ms, qemu_ram_get_idstr(rb), rb_offset,
-- 
2.11.0
