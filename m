Received: from eggs.gnu.org ([2001:4830:134:3::10]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpM-0005yP-Ga
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpH-0005iZ-2G
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpG-0005hx-U4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:25 -0400
Message-Id: <1502149958-23381-10-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 09/22] translate-all: introduce iterator macros
 for tagged TB lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

These will soon gain a couple of users.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8f6f8f1..396c10c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -115,6 +115,25 @@ typedef struct PageDesc {
 #endif
 } PageDesc;
 
+/* list iterators for lists of tagged pointers in TranslationBlock */
+#define tb_for_each_tagged(head, tb, n, field)                  \
+    for (n = (head) & 1,                                        \
+             tb = (TranslationBlock *)((head) & ~1);            \
+         tb;                                                    \
+         tb = (TranslationBlock *)tb->field[n],                 \
+             n = (uintptr_t)tb & 1,                             \
+             tb = (TranslationBlock *)((uintptr_t)tb & ~1))
+
+/* prev is a *uintptr_t. It allows us to safely remove tb */
+#define tb_for_each_tagged_safe(head, tb, n, field, prev)       \
+    for (prev = &(head),                                        \
+             n = *prev & 1,                                     \
+             tb = (TranslationBlock *)(*prev & ~1);             \
+         tb;                                                    \
+         prev = &tb->field[n],                                  \
+             n = (uintptr_t)*prev & 1,                          \
+             tb = (TranslationBlock *)(*prev & ~1))
+
 /* In system mode we want L1_MAP to be based on ram offsets,
    while in user mode we want it to be based on virtual addresses.  */
 #if !defined(CONFIG_USER_ONLY)
-- 
2.7.4
