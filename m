Received: from eggs.gnu.org ([2001:4830:134:3::10]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUp-00059P-GK
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUm-000775-OI
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fwsUm-00075g-Hi
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  3 Sep 2018 13:18:26 -0400
Message-Id: <20180903171831.15446-2-cota@braap.org>
In-Reply-To: <20180903171831.15446-1-cota@braap.org>
References: <20180903171831.15446-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/6] qsp: drop atomics when using the seqlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Using atomics here is a mistake since they're not guaranteed
to compile.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 util/qsp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index b0c2575d10..a1ee03b84b 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -351,6 +351,7 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
 static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
 {
 #ifdef CONFIG_ATOMIC64
+    /* use __nocheck because sizeof(void *) might be < sizeof(u64) */
     to->ns += atomic_read__nocheck(&from->ns);
     to->n_acqs += atomic_read__nocheck(&from->n_acqs);
 #else
@@ -359,8 +360,8 @@ static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
 
     do {
         version = seqlock_read_begin(&from->sequence);
-        ns = atomic_read__nocheck(&from->ns);
-        n_acqs = atomic_read__nocheck(&from->n_acqs);
+        ns = from->ns;
+        n_acqs = from->n_acqs;
     } while (seqlock_read_retry(&from->sequence, version));
 
     to->ns += ns;
@@ -375,14 +376,17 @@ static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
  */
 static inline void do_qsp_entry_record(QSPEntry *e, int64_t delta, bool acq)
 {
-#ifndef CONFIG_ATOMIC64
-    seqlock_write_begin(&e->sequence);
-#endif
+#ifdef CONFIG_ATOMIC64
     atomic_set__nocheck(&e->ns, e->ns + delta);
     if (acq) {
         atomic_set__nocheck(&e->n_acqs, e->n_acqs + 1);
     }
-#ifndef CONFIG_ATOMIC64
+#else
+    seqlock_write_begin(&e->sequence);
+    e->ns += delta;
+    if (acq) {
+        e->n_acqs++;
+    }
     seqlock_write_end(&e->sequence);
 #endif
 }
-- 
2.17.1
