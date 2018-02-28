Received: from eggs.gnu.org ([2001:4830:134:3::10]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erAYM-0006wc-Gn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erAYI-0001MX-TP
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:50:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1erAYI-0001Lb-Kr
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:50:22 -0500
Date: Wed, 28 Feb 2018 17:50:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180228225021.GA11410@flamenco>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-6-git-send-email-cota@braap.org>
	<99cb6bcc-55d2-f07f-fdf4-c55355d2c39f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cb6bcc-55d2-f07f-fdf4-c55355d2c39f@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 05/16] translate-all: iterate over TBs in a
 page with PAGE_FOR_EACH_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Feb 28, 2018 at 13:40:15 -0800, Richard Henderson wrote:
> On 02/26/2018 09:39 PM, Emilio G. Cota wrote:
> > +/* list iterators for lists of tagged pointers in TranslationBlock */
> > +#define TB_FOR_EACH_TAGGED(head, tb, n, field)                  \
> > +    for (n = (head) & 1,                                        \
> > +             tb = (TranslationBlock *)((head) & ~1);            \
> > +         tb;                                                    \
> > +         tb = (TranslationBlock *)tb->field[n],                 \
> > +             n = (uintptr_t)tb & 1,                             \
> > +             tb = (TranslationBlock *)((uintptr_t)tb & ~1))
> > +
> > +#define PAGE_FOR_EACH_TB(pagedesc, tb, n)                       \
> > +    TB_FOR_EACH_TAGGED((pagedesc)->first_tb, tb, n, page_next)
> > +
> 
> I'm not sure I like the generalization of TB_FOR_EACH_TAGGED.  Do you use it
> for anything besides PAGE_FOR_EACH_TB?

Yes, see patch 13. I've added the following comment to the commit log:
 - Introduce the TB_FOR_EACH_TAGGED macro, and use it to define
   PAGE_FOR_EACH_TB, which improves readability. Note that
   TB_FOR_EACH_TAGGED will gain another user in a subsequent patch.

> Weird indentation in the clauses.

Is this any better?

#define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
    for (n = (head) & 1, tb = (TranslationBlock *)((head) & ~1);        \
         tb; tb = (TranslationBlock *)tb->field[n], n = (uintptr_t)tb & 1, \
             tb = (TranslationBlock *)((uintptr_t)tb & ~1))

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks,

		Emilio
