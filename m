Received: from eggs.gnu.org ([2001:4830:134:3::10]:51666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6G-0003T1-Sa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6F-0007yC-Vr
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:00 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6F-0007xZ-QB
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:31:59 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so3426568wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:31:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:25 +0100
Message-Id: <1487255507-106654-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/23] kvm/ioapic: dump real object instead of a
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

When we do "info ioapic" for kvm ioapic, we were building up a temporary
ioapic object. Let's fetch the real one and update correspond to the
real object as well.

This fixes printing uninitialized version field in
ioapic_print_redtbl().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1486106298-3699-2-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
