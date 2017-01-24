Received: from eggs.gnu.org ([2001:4830:134:3::10]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SF-0006D9-PU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SE-00009b-MZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:27 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5SE-00009W-HE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:26 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so36413323wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jan 2017 19:04:16 +0100
Message-Id: <20170124180420.12430-5-pbonzini@redhat.com>
In-Reply-To: <20170124180420.12430-1-pbonzini@redhat.com>
References: <20170124180420.12430-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] exec: make address_space_cache_destroy
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

Clear cache->mr so that address_space_cache_destroy does nothing
the second time it is called.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index f2bed92..5de15cf 100644
--- a/exec.c
+++ b/exec.c
@@ -3165,6 +3165,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
         xen_invalidate_map_cache_entry(cache->ptr);
     }
     memory_region_unref(cache->mr);
+    cache->mr = NULL;
 }
 
 /* Called from RCU critical section.  This function has the same
-- 
2.9.3
