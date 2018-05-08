Received: from eggs.gnu.org ([2001:4830:134:3::10]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fG5VO-0001K2-4H
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fG5VL-0002Nk-1g
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:30:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fG5VK-0002N4-Er
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:30:18 -0400
Date: Tue, 8 May 2018 12:30:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180508163015.GA873@flamenco>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-11-git-send-email-cota@braap.org>
	<87be5f7f-e33e-a101-ff01-2a7375ac9934@linaro.org>
	<20180424001831.GA8651@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424001831.GA8651@flamenco>
Subject: Re: [Qemu-devel] [PATCH v2 10/17] translate-all: use per-page
 locking in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Richard,

On Mon, Apr 23, 2018 at 20:18:31 -0400, Emilio G. Cota wrote:
> On Fri, Apr 13, 2018 at 17:29:20 -1000, Richard Henderson wrote:
> > On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> (snip)
> > > +struct page_collection {
> > > +    GTree *tree;
> > > +    struct page_entry *max;
> > > +};
> > 
> > I don't understand the motivation for this data structure.  Substituting one
> > tree for another does not, on the face of it, seem to be a win.
> > 
> > Given that your locking order is based on the physical address, I can
> > understand that the sequential virtual addresses that these routines are given
> > is not appropriate.  But surely you should know how many pages are involved,
> > and therefore be able to allocate a flat array to hold the PageDesc.
> > 
> > > +/*
> > > + * Lock a range of pages ([@start,@end[) as well as the pages of all
> > > + * intersecting TBs.
> > > + * Locking order: acquire locks in ascending order of page index.
> > > + */
> > 
> > I don't think I understand this either.  From whence do you wind up with a
> > range of physical addresses?
> 
> For instance in tb_invalidate_phys_page_range. We need to invalidate
> all TBs associated with a range of phys addresses.
> 
> I am not sure how an array would make things easier, since we need
> to lock the pages in the given range, as well as the pages that
> overlap with the TBs in said range (since we'll invalidate the TBs).
> For example, if we have to invalidate all TBs in the range A-E, it
> is possible that a TB in page C will overlap with page K (not in
> the original range), so we'll have to lock page K as well. All of
> this needs to be done in order, that is, A-E,K.
> 
> If we had an array, we'd have to resize the array anytime we had
> an out-of-range page, and then do a binary search in the array
> to check whether we already locked that page. At this point
> we'd be reinventing a binary tree, so it seems simpler to just
> use a tree.

Do you have any comments wrt the above (and my other replies to
your comments in this series)? I'd like to do a respin this week.

Thanks,

		Emilio
