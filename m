Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIf-0008FB-Aq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIe-0000iw-IW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:49 -0400
Message-Id: <1493106839-10438-4-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 03/13] tcg: enforce 64-byte alignment of
 TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This will allow us to prevent cache line false sharing in TCGContext.

Before:
$ objdump -t  build/x86_64-linux-user/qemu-x86_64 | grep tcg_ctx
00000000003ea820 g     O .bss   00000000000152d8              tcg_ctx

After:
$ objdump -t  build/x86_64-linux-user/qemu-x86_64 | grep tcg_ctx
00000000003ea880 g     O .bss   0000000000015300              tcg_ctx

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6c216bb..5fdbfe3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -727,7 +727,7 @@ struct TCGContext {
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
-};
+} QEMU_ALIGNED(64);
 
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
-- 
2.7.4
