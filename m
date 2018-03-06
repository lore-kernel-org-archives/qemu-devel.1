Received: from eggs.gnu.org ([2001:4830:134:3::10]:48191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVb-0005EH-FG
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVX-0006Nx-Fa
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:59 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVX-0006NX-8Y
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:55 -0500
Received: by mail-wr0-x243.google.com with SMTP id k9so20878356wre.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:55 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:13 +0100
Message-Id: <1520342370-123606-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/34] address_space_write:
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

address_space_write is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_write to address_space_write.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 4d8addb..ec91162 100644
--- a/exec.c
+++ b/exec.c
@@ -3078,6 +3078,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     return result;
 }
 
+/* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const uint8_t *buf, int len)
 {
@@ -3086,25 +3087,14 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
     MemoryRegion *mr;
     MemTxResult result = MEMTX_OK;
 
-    if (len > 0) {
-        rcu_read_lock();
-        l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true);
-        result = flatview_write_continue(fv, addr, attrs, buf, len,
-                                         addr1, l, mr);
-        rcu_read_unlock();
-    }
+    l = len;
+    mr = flatview_translate(fv, addr, &addr1, &l, true);
+    result = flatview_write_continue(fv, addr, attrs, buf, len,
+                                     addr1, l, mr);
 
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
-                                              MemTxAttrs attrs,
-                                              const uint8_t *buf, int len)
-{
-    return flatview_write(address_space_to_flatview(as), addr, attrs, buf, len);
-}
-
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
@@ -3213,6 +3203,23 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                        addr, attrs, buf, len, is_write);
 }
 
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const uint8_t *buf, int len)
+{
+    MemTxResult result = MEMTX_OK;
+    FlatView *fv;
+
+    if (len > 0) {
+        rcu_read_lock();
+        fv = address_space_to_flatview(as);
+        result = flatview_write(fv, addr, attrs, buf, len);
+        rcu_read_unlock();
+    }
+
+    return result;
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
-- 
1.8.3.1
