Received: from eggs.gnu.org ([2001:4830:134:3::10]:35933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gH7wc-0006wu-Nd
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gH7wY-000709-I2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gH7wY-0006zE-C3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9915E308A95E
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 13:50:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Oct 2018 14:50:49 +0100
Message-Id: <20181029135049.12552-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/dump-guest-memory: Synchronize with
 guest_phys_blocks_region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Recent patches have removed ram_device and nonvolatile RAM
from dump-guest-memory's output.  Do the same for dumps
that are extracted from a QEMU core file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/dump-guest-memory.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 5a857cebcf..f04697b1dd 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -417,7 +417,9 @@ def get_guest_phys_blocks():
         memory_region = flat_range["mr"].dereference()
 
         # we only care about RAM
-        if not memory_region["ram"]:
+        if not memory_region["ram"] \
+           or memory_region["ram_device"] \
+           or memory_region["nonvolatile"]:
             continue
 
         section_size = int128_get64(flat_range["addr"]["size"])
-- 
2.17.1
