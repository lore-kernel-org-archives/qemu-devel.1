Received: from eggs.gnu.org ([2001:4830:134:3::10]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0FmV-0000Av-N5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0FmQ-0004zU-Pe
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:42:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e0FmQ-0004yg-Dy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:42:14 -0400
Date: Thu, 5 Oct 2017 19:24:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171005232416.GA23670@flamenco>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
	<CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
	<20170922204018.GA23631@flamenco>
	<00656f91-760f-c46f-86dc-6c0d29192b3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00656f91-760f-c46f-86dc-6c0d29192b3b@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pranith Kumar <bobby.prani+qemu@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Sep 25, 2017 at 10:01:15 -0700, Richard Henderson wrote:
> On 09/22/2017 01:40 PM, Emilio G. Cota wrote:
> > Hi Richard,
> > 
> > Are you planning to get this patchset merged in this window? If so, I can
> > give it a respin on top of the current master.
> 
> Yes, I do.  I've been intending to look at ...
> 
> > Anyway, before doing so we should fix the issue around CF_COUNT_MASK that
> > Pranith reported:
> 
> ... this one and figure out why my intuition is wrong.
> I'm at Linaro Connect this week, so it may have to wait til next.

I just tested this with icount. Turns out two fixups to this patchset are
necessary to not break icount. The first one is (again) to just
include CF_PARALLEL in the hash mask. The second is a fix for the comparison
function of tb_tc, without which removals don't work.

I'm including the fixups below.

Thanks,

		Emilio

commit 7a899a8df2d769dd80ba1a7f559cb4ddbb0c568b
Author: Emilio G. Cota <cota@braap.org>
Date:   Thu Oct 5 18:40:30 2017 -0400

    FIXUP for "tcg: define CF_PARALLEL ..."
    
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 025fae0..8b2f233 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -326,7 +326,7 @@ struct TranslationBlock {
 #define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
 #define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
-#define CF_HASH_MASK (CF_COUNT_MASK | CF_PARALLEL)
+#define CF_HASH_MASK (CF_PARALLEL)
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;

commit c102c2409a5a134fd7f9ba61f69a5ae29df99c89
Author: Emilio G. Cota <cota@braap.org>
Date:   Thu Oct 5 18:51:24 2017 -0400

    FIXUP for "translate-all: use a binary search tree to ..."
    
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9f1faff..fe607ca 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -793,19 +793,19 @@ static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
     const struct tb_tc *b = bp;
 
     /*
-     * When both sizes are set, we know this isn't a lookup and therefore
-     * the two buffers are non-overlapping.
+     * When both sizes are set, we know this isn't a lookup.
      * This is the most likely case: every TB must be inserted; lookups
      * are a lot less frequent.
      */
     if (likely(a->size && b->size)) {
-        /* a->ptr == b->ptr would mean the buffers overlap */
-        g_assert(a->ptr != b->ptr);
-
         if (a->ptr > b->ptr) {
             return 1;
+        } else if (a->ptr < b->ptr) {
+            return -1;
         }
-        return -1;
+        /* a->ptr == b->ptr should happen only on deletions */
+        g_assert(a->size == b->size);
+        return 0;
     }
     /*
      * All lookups have either .size field set to 0.
