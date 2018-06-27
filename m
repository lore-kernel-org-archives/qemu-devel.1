Received: from eggs.gnu.org ([2001:4830:134:3::10]:38238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYDbw-0004vf-S4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYDbs-0007sj-SM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:48:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fYDbs-0007o9-KB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:48:00 -0400
Date: Wed, 27 Jun 2018 12:47:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180627164757.GA17117@flamenco>
References: <1529944302-14186-1-git-send-email-cota@braap.org>
	<168807dc-6c5b-fc1f-6a70-72e0a518b178@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168807dc-6c5b-fc1f-6a70-72e0a518b178@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] translate-all: fix locking of TBs whose
 two pages share the same physical page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On Tue, Jun 26, 2018 at 19:28:19 -0700, Richard Henderson wrote:
> On 06/25/2018 09:31 AM, Emilio G. Cota wrote:
> > +    } else if (page1 == page2) {
> > +        page_lock(p1);
> > +        if (ret_p2) {
> > +            *ret_p2 = p1;
> 
> I think you should set NULL here...
> 
> > @@ -1623,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
> >          tb = existing_tb;
> >      }
> >  
> > -    if (p2) {
> > +    if (p2 && p2 != p) {
> >          page_unlock(p2);
> 
> ... so that you need no change here.
> Otherwise it looks good.

I did that initially. However, note that if we do that then
the second page is not added to the list of pages for this
TB (via tb_page_add), which breaks the provided test case.

    page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
    tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
    if (p2) {
        tb_page_add(p2, tb, 1, phys_page2);
    } else {
        tb->page_addr[1] = -1;
    }

Regardless of whether p1 and p2 point to the same physical page,
the fact that the TB goes across two virtual pages should be
preserved, and in this case tb_page_add must be called twice.

Thanks,

		Emilio
