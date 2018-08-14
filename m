Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHm-0006H3-Pi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHj-0002GW-KZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpOHj-0002Fv-E0
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 21:37:58 -0400
Message-Id: <20180814013801.26036-2-cota@braap.org>
In-Reply-To: <20180814013801.26036-1-cota@braap.org>
References: <20180814013801.26036-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/4] hw/i386/pc: hold the BQL when calling
 cpu_get_ticks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/i386/pc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 83a444472b..7371cd9960 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -158,7 +158,18 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
 /* TSC handling */
 uint64_t cpu_get_tsc(CPUX86State *env)
 {
-    return cpu_get_ticks();
+    uint64_t ret;
+    bool locked;
+
+    locked = qemu_mutex_iothread_locked();
+    if (!locked) {
+        qemu_mutex_lock_iothread();
+    }
+    ret = cpu_get_ticks();
+    if (!locked) {
+        qemu_mutex_unlock_iothread();
+    }
+    return ret;
 }
 
 /* IRQ handling */
-- 
2.17.1
