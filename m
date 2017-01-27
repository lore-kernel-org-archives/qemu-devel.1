Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rR-0005bM-51
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rQ-0004Mq-33
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:41 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rP-0004MU-T6
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:40 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so58373512wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:49 +0100
Message-Id: <1485524749-118532-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/41] memory: don't sign-extend 32-bit writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

ldl_p has a signed return type so assigning it to uint64_t implicitly
sign-extends the value. This results in devices with min_access_size = 8
seeing unexpected values passed to their write handlers.

Example: guest performs a 32-bit write of 0x80000000 to an mmio region
and the handler receives 0xFFFFFFFF80000000 in its value argument.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-Id: <1485440557-10384-1-git-send-email-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index f2bed92..b05c5d2 100644
--- a/exec.c
+++ b/exec.c
@@ -2630,7 +2630,7 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
                 break;
             case 4:
                 /* 32 bit write access */
-                val = ldl_p(buf);
+                val = (uint32_t)ldl_p(buf);
                 result |= memory_region_dispatch_write(mr, addr1, val, 4,
                                                        attrs);
                 break;
-- 
1.8.3.1
