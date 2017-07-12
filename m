Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMWq-0003V6-Px
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMWl-0006GU-LF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:38:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVMWl-0006G1-Ag
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:38:23 -0400
Date: Wed, 12 Jul 2017 14:38:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712183821.GC7547@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-12-git-send-email-cota@braap.org>
	<87h8yh8ze0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8yh8ze0.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 11/22] translate-all: use a binary search
 tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 16:10:15 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> > index fd20bca..673b26d 100644
> > --- a/include/exec/exec-all.h
> > +++ b/include/exec/exec-all.h
> > @@ -320,14 +320,25 @@ struct TranslationBlock {
> >      uint16_t size;      /* size of target code for this block (1 <=
> >                             size <= TARGET_PAGE_SIZE) */
> >      uint16_t icount;
> > -    uint32_t cflags;    /* compile flags */
> > +    /*
> > +     * @tc_size must be kept right after @tc_ptr to facilitate TB lookups in a
> > +     * binary search tree -- see struct ptr_size.
> > +     * We use an anonymous struct here to avoid updating all calling code,
> > +     * which would be quite a lot of churn.
> > +     * The only reason to bring @cflags into the anonymous struct is to
> > +     * avoid inducing a hole in TranslationBlock.
> > +     */
> > +    struct {
> > +        void *tc_ptr;    /* pointer to the translated code */
> > +        uint32_t tc_size; /* size of translated code for this block */
> > +
> > +        uint32_t cflags;    /* compile flags */
> >  #define CF_COUNT_MASK  0x7fff
> >  #define CF_LAST_IO     0x8000 /* Last insn may be an IO access.  */
> >  #define CF_NOCACHE     0x10000 /* To be freed after execution */
> >  #define CF_USE_ICOUNT  0x20000
> >  #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
> > -
> > -    void *tc_ptr;    /* pointer to the translated code */
> > +    };
> 
> Why not just have a named structure for this so there isn't ambiguity
> between struct ptrsize and this thing.

Yeah I did v2 of this patch yesterday. Turns out using an intermediate
struct here (and in the comparison code) doesn't end up in as much churn
as I expected, so I went with that.

(snip)
> > @@ -827,16 +853,7 @@ void tb_free(TranslationBlock *tb)
> >  {
> >      assert_tb_locked();
> >
> > -    /* In practice this is mostly used for single use temporary TB
> > -       Ignore the hard cases and just back up if this TB happens to
> > -       be the last one generated.  */
> > -    if (tcg_ctx.tb_ctx.nb_tbs > 0 &&
> > -            tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
> > -        size_t struct_size = ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> > -
> > -        tcg_ctx.code_gen_ptr = tb->tc_ptr - struct_size;
> > -        tcg_ctx.tb_ctx.nb_tbs--;
> > -    }
> > +    g_tree_remove(tcg_ctx.tb_ctx.tb_tree, &tb->tc_ptr);
> >  }
> 
> This function should be renamed as we never attempt to free (and it was
> pretty half hearted before). Maybe tb_remove or tb_deref?

Good point. I like tb_remove.

		Emilio
