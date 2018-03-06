Received: from eggs.gnu.org ([2001:4830:134:3::10]:48218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVd-0005Hc-4t
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVb-0006Sy-Vu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:01 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVb-0006Ry-OC
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:59 -0500
Received: by mail-wm0-x242.google.com with SMTP id 188so22105574wme.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:59 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:17 +0100
Message-Id: <1520342370-123606-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/34] address_space_rw:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

address_space_rw is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, transform flatview_rw
into address_space_rw, since flatview_rw is otherwise unused.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/exec.c b/exec.c
index bffb959..604f03c 100644
--- a/exec.c
+++ b/exec.c
@@ -3181,24 +3181,6 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                   addr1, l, mr);
 }
 
-static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                               uint8_t *buf, int len, bool is_write)
-{
-    if (is_write) {
-        return flatview_write(fv, addr, attrs, (uint8_t *)buf, len);
-    } else {
-        return flatview_read(fv, addr, attrs, (uint8_t *)buf, len);
-    }
-}
-
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs, uint8_t *buf,
-                             int len, bool is_write)
-{
-    return flatview_rw(address_space_to_flatview(as),
-                       addr, attrs, buf, len, is_write);
-}
-
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len)
 {
@@ -3232,6 +3214,16 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
+MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+                             uint8_t *buf, int len, bool is_write)
+{
+    if (is_write) {
+        return address_space_write(as, addr, attrs, buf, len);
+    } else {
+        return address_space_read_full(as, addr, attrs, buf, len);
+    }
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
-- 
1.8.3.1
