Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KO-0000qz-Cf
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KN-00087f-IK
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:00 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KN-00086o-Bc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:59 -0400
Received: by mail-wm0-x242.google.com with SMTP id u23so21542451wma.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:43 +0200
Message-Id: <1499099693-22903-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 12/22] tcg: move tb_lock out of translate-all.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

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
