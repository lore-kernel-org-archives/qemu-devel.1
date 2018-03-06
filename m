Received: from eggs.gnu.org ([2001:4830:134:3::10]:48137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVW-0004vp-0m
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVV-0006M9-3G
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:53 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVU-0006Lg-T3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:53 -0500
Received: by mail-wm0-x244.google.com with SMTP id e194so3744853wmd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:52 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:11 +0100
Message-Id: <1520342370-123606-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/34] openpic_kvm: drop
 address_space_to_flatview call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The MemoryListener is registered on address_space_memory, there is
not much to assert.  This currently works because the callback
is invoked only once when the listener is registered, but section->fv
is the _new_ FlatView, not the old one on later calls and that
would break.

This confines address_space_to_flatview to exec.c and memory.c.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/openpic_kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index f1a59e5..928bc04 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -125,10 +125,6 @@ static void kvm_openpic_region_add(MemoryListener *listener,
     uint64_t reg_base;
     int ret;
 
-    if (section->fv != address_space_to_flatview(&address_space_memory)) {
-        abort();
-    }
-
     /* Ignore events on regions that are not us */
     if (section->mr != &opp->mem) {
         return;
-- 
1.8.3.1
