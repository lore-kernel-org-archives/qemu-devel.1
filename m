Received: from eggs.gnu.org ([2001:4830:134:3::10]:48812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4FTV-0003d3-JP
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4FTS-0005nH-Cf
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:43:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4FTS-0005lp-6u
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:43:26 -0400
Date: Thu, 5 Apr 2018 20:43:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180406004324.GA25706@flamenco>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-11-git-send-email-cota@braap.org>
	<87sh8j6iem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh8j6iem.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 10/16] translate-all: use per-page locking
 in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Thu, Mar 29, 2018 at 15:55:13 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > +/* lock the page(s) of a TB in the correct acquisition order */
> > +static inline void page_lock_tb(const TranslationBlock *tb)
> > +{
> > +    if (likely(tb->page_addr[1] == -1)) {
> > +        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
> > +        return;
> > +    }
> > +    if (tb->page_addr[0] < tb->page_addr[1]) {
> > +        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
> > +        page_lock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
> > +    } else {
> > +        page_lock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
> > +        page_lock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
> > +    }
> > +}
(snip)
> > +    /*
> > +     * Add the TB to the page list.
> > +     * To avoid deadlock, acquire first the lock of the lower-addressed page.
> > +     */
> > +    p = page_find_alloc(phys_pc >> TARGET_PAGE_BITS, 1);
> > +    if (likely(phys_page2 == -1)) {
> >          tb->page_addr[1] = -1;
> > +        page_lock(p);
> > +        tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
> > +    } else {
> > +        p2 = page_find_alloc(phys_page2 >> TARGET_PAGE_BITS, 1);
> > +        if (phys_pc < phys_page2) {
> > +            page_lock(p);
> > +            page_lock(p2);
> > +        } else {
> > +            page_lock(p2);
> > +            page_lock(p);
> > +        }
> 
> Give we repeat this check further up perhaps a:
> 
>   page_lock_pair(PageDesc *p1, th_page_addr_t phys1, PageDesc *p2,  tb_page_addr_t phys2)

After trying, I don't think it's worth the trouble.

Note that page_lock_tb expands to nothing in user-mode,
whereas the latter snippet is shared by user-mode and
!user-mode. Dealing with that gets ugly quickly;
besides, we'd have to optionally return *p1 and *p2,
plus choose whether to use page_find or page_find_alloc..

(snip)
> The diff is a little messy around tb_page_add but I think we need an
> assert_page_lock(p) which compiles to check mmap_lock in CONFIG_USER
> instead of the assert_memory_lock().
> 
> Then we can be clear about tb, memory and page locks.

I've added an extra patch to v2 to do this, since this patch is
already huge.

Thanks,

		Emilio
