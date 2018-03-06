Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVe-0005JC-Oc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVa-0006RX-RM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:02 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVa-0006Q7-Kw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:58 -0500
Received: by mail-wr0-x241.google.com with SMTP id v111so20894746wrb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:58 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:16 +0100
Message-Id: <1520342370-123606-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/34] address_space_map:
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

address_space_map is calling address_space_to_flatview but it can
be called outside the RCU lock.  The function itself is calling
rcu_read_lock/rcu_read_unlock, just in the wrong place, so the
fix is easy.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 62ed49d..bffb959 100644
--- a/exec.c
+++ b/exec.c
@@ -3468,7 +3468,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr l, xlat;
     MemoryRegion *mr;
     void *ptr;
-    FlatView *fv = address_space_to_flatview(as);
+    FlatView *fv;
 
     if (len == 0) {
         return NULL;
@@ -3476,6 +3476,7 @@ void *address_space_map(AddressSpace *as,
 
     l = len;
     rcu_read_lock();
+    fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write);
 
     if (!memory_access_is_direct(mr, is_write)) {
-- 
1.8.3.1
