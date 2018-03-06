Received: from eggs.gnu.org ([2001:4830:134:3::10]:48192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVb-0005EP-Fg
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVZ-0006Pn-J4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:59 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVZ-0006P3-BX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:57 -0500
Received: by mail-wr0-x241.google.com with SMTP id l43so20924986wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:57 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:15 +0100
Message-Id: <1520342370-123606-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/34] address_space_access_valid:
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

address_space_access_valid is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_access_valid to address_space_access_valid.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index e4552ee..62ed49d 100644
--- a/exec.c
+++ b/exec.c
@@ -3395,7 +3395,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
     MemoryRegion *mr;
     hwaddr l, xlat;
 
-    rcu_read_lock();
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write);
@@ -3410,15 +3409,20 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         len -= l;
         addr += l;
     }
-    rcu_read_unlock();
     return true;
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
                                 int len, bool is_write)
 {
-    return flatview_access_valid(address_space_to_flatview(as),
-                                 addr, len, is_write);
+    FlatView *fv;
+    bool result;
+
+    rcu_read_lock();
+    fv = address_space_to_flatview(as);
+    result = flatview_access_valid(fv, addr, len, is_write);
+    rcu_read_unlock();
+    return result;
 }
 
 static hwaddr
-- 
1.8.3.1
