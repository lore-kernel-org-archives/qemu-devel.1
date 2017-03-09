Received: from eggs.gnu.org ([2001:4830:134:3::10]:60982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwM0-0005zm-KI
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLz-0004mn-BH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <c.pinto@virtualopensystems.com>)
	id 1clwLz-0004mb-52
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:31 -0500
Received: by mail-wm0-x241.google.com with SMTP id v190so10451982wme.3
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:35:31 -0800 (PST)
From: Christian Pinto <c.pinto@virtualopensystems.com>
Date: Thu,  9 Mar 2017 12:34:37 +0100
Message-Id: <20170309113437.9667-5-c.pinto@virtualopensystems.com>
In-Reply-To: <20170309113437.9667-1-c.pinto@virtualopensystems.com>
References: <57B7F948.9040701@huawei.com>
	<20170309113437.9667-1-c.pinto@virtualopensystems.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] migration/postcopy-ram:
 ram_set_pages_wp fix
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

setting UFFDIO_WRITEPROTECT_MODE_DONTWAKE when write un-protecting a page
does not wake up the faulting thread.
Set to 0 to force the faulting (VM) thread to wake-up.

Signed-off-by: Christian Pinto <c.pinto@virtualopensystems.com>
Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6252eb379a..684faae614 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -384,7 +384,7 @@ int ram_set_pages_wp(ram_addr_t page_addr,
     wp_struct.range.start = (uint64_t)(uintptr_t)page_addr;
     wp_struct.range.len = size;
     if (remove) {
-        wp_struct.mode = UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
+        wp_struct.mode = 0;
     } else {
         wp_struct.mode = UFFDIO_WRITEPROTECT_MODE_WP;
     }
-- 
2.11.0
