Received: from eggs.gnu.org ([2001:4830:134:3::10]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa28-00082S-Vl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa26-0002If-Cz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa26-0002HM-3A
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:34 -0400
Received: by mail-wm1-x329.google.com with SMTP id r63-v6so13004855wma.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:09 +0100
Message-Id: <1540929011-19894-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/10] memory-mapping: skip non-volatile memory
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, lersek@redhat.com

From: Marc-André Lureau <marcandre.lureau@redhat.com>

GuestPhysBlockList is currently used to produce dumps. Given the size
and the typical usage of NVDIMM for storage, they are not a good idea
to have in the dumps. We may want to have an extra dump option to
include them. For now, skip non-volatile regions.

The TCG memory clear function is going to use the GuestPhysBlockList
as well, and will thus skip NVDIMM for similar reasons.

Cc: lersek@redhat.com
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181003114454.5662-4-marcandre.lureau@redhat.com>
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
