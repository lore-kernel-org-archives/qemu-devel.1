Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX4-0004yR-Sx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX4-0007r3-0e
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:30 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeX3-0007qa-QM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:29 -0400
Received: by mail-wr0-x241.google.com with SMTP id x23so49173673wrb.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:29 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:36 +0200
Message-Id: <1499238885-26161-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/42] tcg: move tb_lock out of translate-all.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/main.c         | 1 -
 include/exec/exec-all.h | 4 ++++
 tcg/tcg.h               | 4 ----
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 04f95dd..fa9c012 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -25,7 +25,6 @@
 #include "qemu/config-file.h"
 #include "qemu/path.h"
 #include "qemu/help_option.h"
-/* For tb_lock */
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73..0b56432 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -467,6 +467,10 @@ extern uintptr_t tci_tb_ptr;
    smaller than 4 bytes, so we don't worry about special-casing this.  */
 #define GETPC_ADJ   2
 
+void tb_lock(void);
+void tb_unlock(void);
+void tb_lock_reset(void);
+
 #if !defined(CONFIG_USER_ONLY)
 
 struct MemoryRegion *iotlb_to_region(CPUState *cpu,
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9e37722..da78721 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -757,10 +757,6 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
-void tb_lock(void);
-void tb_unlock(void);
-void tb_lock_reset(void);
-
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
-- 
1.8.3.1
