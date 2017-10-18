Received: from eggs.gnu.org ([2001:4830:134:3::10]:36050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyF-0003fv-8r
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyE-0002Je-DI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:49832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyE-0002Iy-7B
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id g90so5590900wrd.6
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:14 +0200
Message-Id: <1508343141-31835-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/29] memory: reuse section_from_flat_range()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can use section_from_flat_range() instead of manually initializing.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-8-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 3e1558a..e26e5a3 100644
--- a/memory.c
+++ b/memory.c
@@ -2599,14 +2599,8 @@ static void listener_add_address_space(MemoryListener *listener,
 
     view = address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
-        MemoryRegionSection section = {
-            .mr = fr->mr,
-            .fv = view,
-            .offset_within_region = fr->offset_in_region,
-            .size = fr->addr.size,
-            .offset_within_address_space = int128_get64(fr->addr.start),
-            .readonly = fr->readonly,
-        };
+        MemoryRegionSection section = section_from_flat_range(fr, view);
+
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
-- 
1.8.3.1
