Received: from eggs.gnu.org ([2001:4830:134:3::10]:33242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dc-0002TL-T8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dY-0007ll-UL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8dY-0007kh-O6
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:28 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so59112040wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:15 +0100
Message-Id: <1485531620-121182-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] exec: make address_space_cache_destroy
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
Cc: mst@redhat.com

Clear cache->mr so that address_space_cache_destroy does nothing
the second time it is called.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
1.8.3.1
