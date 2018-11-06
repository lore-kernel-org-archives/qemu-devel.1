Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9DH-0005fz-3U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93S-000193-55
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93R-0000Ij-Ms
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id x12-v6so15202021wrw.8
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:55 +0100
Message-Id: <1541540283-45699-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/17] memory-mapping: skip non-volatile memory
 regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

GuestPhysBlockList is currently used to produce dumps. Given the size
and the typical usage of NVDIMM for storage, they are not a good idea
to have in the dumps. We may want to have an extra dump option to
include them. For now, skip non-volatile regions.

The TCG memory clear function is going to use the GuestPhysBlockList
as well, and will thus skip NVDIMM for similar reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181003114454.5662-4-marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory_mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/memory_mapping.c b/memory_mapping.c
index 775466f..724dd0b 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryListener *listener,
 
     /* we only care about RAM */
     if (!memory_region_is_ram(section->mr) ||
-        memory_region_is_ram_device(section->mr)) {
+        memory_region_is_ram_device(section->mr) ||
+        memory_region_is_nonvolatile(section->mr)) {
         return;
     }
 
-- 
1.8.3.1
