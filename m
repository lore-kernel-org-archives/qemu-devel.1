Received: from eggs.gnu.org ([2001:4830:134:3::10]:50141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fv0iV-0007tR-VQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fv0iR-0000E1-RI
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:03 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quan.xu0@gmail.com>) id 1fv0iR-0000BD-3q
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:59 -0400
Received: by mail-oi0-x242.google.com with SMTP id c190-v6so9158511oig.6
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 06:40:57 -0700 (PDT)
From: Quan Xu <quan.xu0@gmail.com>
Message-ID: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
Date: Wed, 29 Aug 2018 21:40:50 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC] migration: make sure to run iterate
 precopy during the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, kvm <kvm@vger.kernel.org>

 From 8dbf7370e7ea1caab0b769d0d4dcdd072d14d421 Mon Sep 17 00:00:00 2001
From: Quan Xu <quan.xu0@gmail.com>
Date: Wed, 29 Aug 2018 21:33:14 +0800
Subject: [PATCH RFC] migration: make sure to run iterate precopy during the
  bulk stage

Since the bulk stage assumes in (migration_bitmap_find_dirty) that every
page is dirty, return a rough total ram as pending size to make sure that
migration thread continues to run iterate precopy during the bulk stage.

Otherwise the downtime grows unpredictably, as migration thread needs to
send both the rest of pages and dirty pages during complete precopy.

Signed-off-by: Quan Xu <quan.xu0@gmail.com>
---
  migration/ram.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 79c8942..cfa304c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3308,7 +3308,8 @@ static void ram_save_pending(QEMUFile *f, void 
*opaque, uint64_t max_size,
          /* We can do postcopy, and all the data is postcopiable */
          *res_compatible += remaining_size;
      } else {
-        *res_precopy_only += remaining_size;
+        *res_precopy_only += (rs->ram_bulk_stage ?
+                              ram_bytes_total() : remaining_size);
      }
  }

--
1.8.3.1
