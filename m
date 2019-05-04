Received: from eggs.gnu.org ([209.51.188.92]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQN-0007Ki-EH
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0001IO-Gc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:51 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:27 -0600
Message-Id: <20190504120528.6389-10-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 9/9] linux-user: add IBT support to x86
 safe-syscall.S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org

Because safe-syscall.S does not go through the C compiler, the
.note.gnu.property note has to be added manually.  Safe syscalls do not
involve any indirect branch or stack unwinding, so they are trivially
safe for IBT or shadow stacks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/host/i386/safe-syscall.inc.S   | 19 +++++++++++++++++++
 linux-user/host/x86_64/safe-syscall.inc.S | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/linux-user/host/i386/safe-syscall.inc.S b/linux-user/host/i386/safe-syscall.inc.S
index 9e58fc6504..6c6d568d62 100644
--- a/linux-user/host/i386/safe-syscall.inc.S
+++ b/linux-user/host/i386/safe-syscall.inc.S
@@ -98,3 +98,22 @@ safe_syscall_end:
 	.cfi_endproc
 
 	.size	safe_syscall_base, .-safe_syscall_base
+
+	.pushsection ".note.gnu.property", "a"
+	.p2align 2
+	.long 1f - 0f          /* name length.  */
+	.long 4f - 1f          /* data length.  */
+	.long 5                /* NT_GNU_PROPERTY_TYPE_0.  */
+0:
+	.asciz "GNU"           /* vendor name.  */
+	.p2align 2
+1:
+        /* GNU_PROPERTY_X86_FEATURE_1_AND.  */
+	.long 0xc0000002       /* pr_type.  */
+	.long 3f - 2f          /* pr_datasz.  */
+2:
+	.long 0x3              /* IBT, SHSTK */
+3:
+	.p2align 2
+4:
+	.popsection
diff --git a/linux-user/host/x86_64/safe-syscall.inc.S b/linux-user/host/x86_64/safe-syscall.inc.S
index f36992daa3..e1a57db338 100644
--- a/linux-user/host/x86_64/safe-syscall.inc.S
+++ b/linux-user/host/x86_64/safe-syscall.inc.S
@@ -89,3 +89,22 @@ safe_syscall_end:
         .cfi_endproc
 
         .size   safe_syscall_base, .-safe_syscall_base
+
+	.pushsection ".note.gnu.property", "a"
+	.p2align 3
+	.long 1f - 0f          /* name length.  */
+	.long 4f - 1f          /* data length.  */
+	.long 5                /* NT_GNU_PROPERTY_TYPE_0.  */
+0:
+	.asciz "GNU"           /* vendor name.  */
+	.p2align 3
+1:
+        /* GNU_PROPERTY_X86_FEATURE_1_AND.  */
+	.long 0xc0000002       /* pr_type.  */
+	.long 3f - 2f          /* pr_datasz.  */
+2:
+	.long 0x3              /* IBT, SHSTK */
+3:
+	.p2align 3
+4:
+	.popsection
-- 
2.21.0
