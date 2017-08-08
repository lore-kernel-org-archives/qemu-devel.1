Received: from eggs.gnu.org ([2001:4830:134:3::10]:53585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1des0T-0007rx-Pv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1des0O-0002qx-Pq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:04:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1des0O-0002qU-La
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:04:16 -0400
Date: Mon, 7 Aug 2017 20:04:14 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170808000414.GA20585@flamenco>
References: <20170729003327.GA16954@flamenco>
	<CAFEAcA9M88wdV+pR5pSCRbt=NT=OKL+Z88hOjsb_v3q-AcL4fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M88wdV+pR5pSCRbt=NT=OKL+Z88hOjsb_v3q-AcL4fA@mail.gmail.com>
Subject: Re: [Qemu-devel] tb_invalidate_phys_range and
 tb_invalidate_phys_page_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Sat, Jul 29, 2017 at 10:23:42 +0100, Peter Maydell wrote:
> On 29 July 2017 at 01:33, Emilio G. Cota <cota@braap.org> wrote:
(snip)
> > +void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end,
> > +                              int is_cpu_write_access)
> > +{
> > +    while (start < end) {
> > +        tb_invalidate_phys_page_range(start, end, is_cpu_write_access);
> > +        start &= TARGET_PAGE_MASK;
> > +        start += TARGET_PAGE_SIZE;
> > +    }
> > +}
> >
> > What I find puzzling is that here we pass 'end' unmodified, instead of
> > making sure the range passed is within a page.
> >
> > Is this a bug, or am I missing something?
> 
> It's a bit odd, but looking at the code I think it doesn't matter.
> The only thing that tb_invalidate_phys_page_range() uses 'end'
> for is when it does the "does this TB I've found overlap the
> range we're flushing" check with
>  if (!(tb_end <= start || tb_start >= end))
> 
> If we pass an 'end' value that's larger than it would be if
> we confined it to the page, this is safe because at worst
> we'll invalidate more TBs than we needed to (and in practice
> if the TB we've found is within the full range that
> tb_invalidate_phys_range() is checking we need to invalidate
> it anyway). I haven't quite worked it through but I rather
> suspect that you can't have a TB that's in the list for
> the PageDesc for 'start' and which overlaps in the
> "full" [start-end) range but which wouldn't overlap
> in a truncated [start-(end rounded down to end of page))
> range.
> 
> Basically the reason for the "same page" restriction
> is that tb_invalidate_phys_page_range() only does
> a single page_find() for the 'start' address. So
> as long as we call it once per page in the range
> it doesn't matter that we pass an overly pessimistic
> end. This is kind of bordering on "happens to work"
> territory though, so maybe we could improve it...

Thanks Peter.

I just sent a patch to improve this as part of the "tb lock removal"
series. The patch is here:
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01270.html

Cheers,

		Emilio
