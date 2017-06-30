Received: from eggs.gnu.org ([2001:4830:134:3::10]:38377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR31X-0007Hz-PQ
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR31U-0005ua-I2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:00:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dR31U-0005t8-6n
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:00:16 -0400
Date: Fri, 30 Jun 2017 10:55:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630145557.GA19722@flamenco>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-4-git-send-email-cota@braap.org>
	<c0d720c9-e63e-1d5d-8b78-a1b66e179a20@twiddle.net>
	<dfb7a099-6cd7-1f0d-9fad-047f670a32dc@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb7a099-6cd7-1f0d-9fad-047f670a32dc@twiddle.net>
Subject: Re: [Qemu-devel] [RFC 3/7] translate-all: use a binary search tree
 to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Fri, Jun 30, 2017 at 00:49:37 -0700, Richard Henderson wrote:
> On 06/30/2017 12:41 AM, Richard Henderson wrote:
> >On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> >>+/* @key is already in the tree so it's safe to use container_of on it */
> >>+static gint tc_ptr_cmp(gconstpointer candidate, gconstpointer key)
> >>+{
> >>+    uintptr_t a = *(uintptr_t *)candidate;
> >>+    const TranslationBlock *tb = container_of(key, TranslationBlock, tc_ptr);
> >
> >This I'm not keen on.  It'd be one thing if it was our own datastructure,
> >but I see nothing in the GTree documentation that says that the comparison
> >must always be done this way.

I also checked for this. Couldn't find anything in the docs -- the
only guarantee I could find is the implicit one that since the g_tree
module was created, the 2nd pointer ("b" above) has consistenly been
the in-node one. I don't think they'd ever change this, but yes
relying on this assumption is a bit risky.

If we prefer using our own we could bring the AVL tree from CCAN:
  http://git.ozlabs.org/?p=ccan;a=tree;f=ccan/avl

> What if we bundle tc_ptr + tc_size into a struct and only reference that?
> We'd embed that struct into the TB.  In tb_find_pc, create that struct on
> the stack, setting tc_size = 0.

This is clean and safe, but we'd add a 4-byte hole for 64-on-64bit.
However, we could bring other fields into the embedded struct to plug
the hole. Also, using an anonymous struct would hide this from the
calling code:

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4b4c143..07f1f50 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -319,16 +319,18 @@ struct TranslationBlock {
     uint16_t size;      /* size of target code for this block (1 <=
                            size <= TARGET_PAGE_SIZE) */
     uint16_t icount;
-    uint32_t cflags;    /* compile flags */
+
+    struct {
+        void *tc_ptr;    /* pointer to the translated code */
+        int32_t out_size; /* size of host code for this block */
+        uint32_t cflags;    /* compile flags */
 #define CF_COUNT_MASK  0x7fff
 #define CF_LAST_IO     0x8000 /* Last insn may be an IO access.  */
 #define CF_NOCACHE     0x10000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
+    };
 
-    uint16_t invalid;
-
-    void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
     /* original tb when cflags has CF_NOCACHE */
     struct TranslationBlock *orig_tb;
@@ -365,7 +367,7 @@ struct TranslationBlock {
      */
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_list_first;
-    int32_t out_size; /* size of host code for this block */
+    uint16_t invalid;
 };

That is 122 bytes, with all 6 bytes of padding at the end.
We also move invalid to the 2nd cache line, which I'm not sure
it would matter much (I liked having out_size there because
it's fairly slow path).

Also I'd rename out_size to tc_size.

		E.
