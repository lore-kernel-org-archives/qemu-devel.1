Received: from eggs.gnu.org ([2001:4830:134:3::10]:40518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7Vv-0002MS-SG
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7Vs-0002WP-QH
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:47:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dR7Vs-0002W1-9b
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:47:56 -0400
Date: Fri, 30 Jun 2017 21:47:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170701014754.GA32043@flamenco>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-7-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498768109-4092-7-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] fixup: missed some TLS variables
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

On Thu, Jun 29, 2017 at 16:28:28 -0400, Emilio G. Cota wrote:
> XXX: After allowing tb_gen_code to run in parallel (see next patch),
>      crashes due to races in TCG code are found very quickly with -smp > 1
>      (e.g. "tcg/tcg.c:233: tcg_out_label: Assertion `!l->has_value' failed.")
>      Note that with -smp 1 it works fine; with smp > 1 I can make it
>      fail later with "taskset -c 0", so clearly there is a race going on.

Fixed! I missed a few __thread's -- see below.

I found the missing ones by moving tb_lock around and using
'valgrind --tool=drd' (it's not ThreadSanitizer, but it doesn't
choke on our coroutines and it's reasonably fast).

Preliminary tests show even with patch 6 we don't gain almost anything
when booting 64 cores (on a 64-core host), which is what I expected
(we still have to acquire tb_lock on each translation, even if only
for a few instructions, which is a scalability killer). But I'd
worry about optimisations later; for now I'll focus on cleaning up
the patchset, so my next steps are:

- Apply Richard's feedback so far
- Consolidate TLS variables into TCGContext, so that we'll have
  as little TLS variables as possible.

Cheers,

		E.

--- 8< ----

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 2 +-
 tcg/optimize.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e..2e2bc7b 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -6,7 +6,7 @@
 /* Helpers for instruction counting code generation.  */
 
 static int icount_start_insn_idx;
-static TCGLabel *exitreq_label;
+static TCG_THREAD TCGLabel *exitreq_label;
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index adfc56c..71af19b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -40,8 +40,8 @@ struct tcg_temp_info {
     tcg_target_ulong mask;
 };
 
-static struct tcg_temp_info temps[TCG_MAX_TEMPS];
-static TCGTempSet temps_used;
+static TCG_THREAD struct tcg_temp_info temps[TCG_MAX_TEMPS];
+static TCG_THREAD TCGTempSet temps_used;
 
 static inline bool temp_is_const(TCGArg arg)
 {
-- 
2.7.4
