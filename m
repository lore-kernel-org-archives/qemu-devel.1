Received: from eggs.gnu.org ([2001:4830:134:3::10]:50249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8d-0006jF-1O
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8b-00076b-Ox
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZY8b-00076C-Ip
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:29 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 15:18:16 +0800
Message-Id: <1486106298-3699-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1486106298-3699-1-git-send-email-peterx@redhat.com>
References: <1486106298-3699-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] kvm/ioapic: dump real object instead of a
 fake one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

When we do "info ioapic" for kvm ioapic, we were building up a temporary
ioapic object. Let's fetch the real one and update correspond to the
real object as well.

This fixes printing uninitialized version field in
ioapic_print_redtbl().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/kvm/ioapic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 8eb2c7a..716d59a 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -114,11 +114,11 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
 
 void kvm_ioapic_dump_state(Monitor *mon, const QDict *qdict)
 {
-    IOAPICCommonState s;
+    IOAPICCommonState *s = IOAPIC_COMMON(object_resolve_path("ioapic", NULL));
 
-    kvm_ioapic_get(&s);
-
-    ioapic_print_redtbl(mon, &s);
+    assert(s);
+    kvm_ioapic_get(s);
+    ioapic_print_redtbl(mon, s);
 }
 
 static void kvm_ioapic_reset(DeviceState *dev)
-- 
2.7.4
