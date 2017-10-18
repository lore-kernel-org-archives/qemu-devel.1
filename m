Received: from eggs.gnu.org ([2001:4830:134:3::10]:43360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4swd-0006Wn-A0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 14:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4swZ-0007fF-8n
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 14:19:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4swZ-0007ek-3c
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 14:19:51 -0400
Date: Wed, 18 Oct 2017 14:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018181949.GA32663@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-39-richard.henderson@linaro.org>
	<b420cf7c-a15f-6edc-74a8-4e41738bad28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b420cf7c-a15f-6edc-74a8-4e41738bad28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 38/50] translate-all: use a binary
 search tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Wed, Oct 18, 2017 at 09:41:43 +0200, Paolo Bonzini wrote:
> On 16/10/2017 19:25, Richard Henderson wrote:
> >   * Translation Cache-related fields of a TB.
> > + * This struct exists just for convenience; we keep track of TB's in a binary
> > + * search tree, and the only fields needed to compare TB's in the tree are
> > + * @ptr and @size. @search is brought here for consistency, since it is also
> > + * a TC-related field.
> >   */
> >  struct tb_tc {
> >      void *ptr;    /* pointer to the translated code */
> >      uint8_t *search;  /* pointer to search data */
> > +    size_t size;
> >  };
> 
> Isn't search equal to ptr + size, or something like that?

It is indeed! Fixup below.

The change shrinks TranslationBlock, but it leaves performance unchanged
(recall that we add padding after TranslationBlock to avoid cache line
overlap between the struct and translated code).

Thanks,

		Emilio

-- >8 --
Subject: [PATCH] fixup

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 4 +---
 include/exec/exec-all.h   | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ac8dfe6..f9881d8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -272,8 +272,6 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     uint8_t *p = block;
     int i, j, n;
 
-    tb->tc.search = block;
-
     for (i = 0, n = tb->icount; i < n; ++i) {
         target_ulong prev;
 
@@ -309,7 +307,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     target_ulong data[TARGET_INSN_START_WORDS] = { tb->pc };
     uintptr_t host_pc = (uintptr_t)tb->tc.ptr;
     CPUArchState *env = cpu->env_ptr;
-    uint8_t *p = tb->tc.search;
+    uint8_t *p = tb->tc.ptr + tb->tc.size;
     int i, j, num_insns = tb->icount;
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &tcg_ctx->prof;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 746f4be..923ece3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -308,12 +308,11 @@ static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
  * Translation Cache-related fields of a TB.
  * This struct exists just for convenience; we keep track of TB's in a binary
  * search tree, and the only fields needed to compare TB's in the tree are
- * @ptr and @size. @search is brought here for consistency, since it is also
- * a TC-related field.
+ * @ptr and @size.
+ * Note: the address of search data can be obtained by adding @size to @ptr.
  */
 struct tb_tc {
     void *ptr;    /* pointer to the translated code */
-    uint8_t *search;  /* pointer to search data */
     size_t size;
 };
 
-- 
2.7.4
