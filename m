Received: from eggs.gnu.org ([209.51.188.92]:36383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gd-0002bB-4H
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gc-00047g-6j
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:19 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gb-00041x-Kn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:17 -0500
Received: by mail-wm1-x342.google.com with SMTP id z5so4669304wmf.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:50 +0100
Message-Id: <1549390526-24246-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/76] i386: hvf: Don't miss 16-bit displacement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>

From: Roman Bolshakov <r.bolshakov@yadro.com>

In 16-bit addressing mode, when Mod = 0 and R/M = 6, decoded displacement
doesn't reach decode_linear_addr and gets lost. Instructions that
involve the combination of ModRM always get a pointer with zero offset
from the beginning of DS segment.

The change fixes drawing in F-BIRD from day 1 of '18 advent calendar.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20190125154743.14498-1-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 5f513c5..9ef7d75 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -1642,7 +1642,7 @@ void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
     X86Seg seg = R_DS;
 
     if (!decode->modrm.mod && 6 == decode->modrm.rm) {
-        op->ptr = (uint16_t)decode->displacement;
+        ptr = decode->displacement;
         goto calc_addr;
     }
 
-- 
1.8.3.1
