Received: from eggs.gnu.org ([2001:4830:134:3::10]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fExiz-00014W-FD
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fExiw-0005Qz-EZ
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:59:45 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:46707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fExiw-0005Q8-4T
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:59:42 -0400
Received: by mail-lf0-x244.google.com with SMTP id v85-v6so34694602lfa.13
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 06:59:41 -0700 (PDT)
Date: Sat, 5 May 2018 15:59:39 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180505135939.jemvjg7xkuldebyn@toto>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-27-edgar.iglesias@gmail.com>
	<CAKmqyKPJh=AtnAfAavfgzTJKxk5TRLwuT1LQpCuWRFxwaUTyuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPJh=AtnAfAavfgzTJKxk5TRLwuT1LQpCuWRFxwaUTyuA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 26/29] target-microblaze: mmu: Prepare
 for 64-bit addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 03, 2018 at 09:54:01PM +0000, Alistair Francis wrote:
> On Thu, May 3, 2018 at 2:44 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
> wrote:
> 
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> > Prepare for 64-bit addresses.
> > This makes no functional difference as the upper parts of
> > the 64-bit addresses are not yet reachable.
> 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >   target/microblaze/mmu.c | 14 +++++++-------
> >   target/microblaze/mmu.h |  6 +++---
> >   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> > diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> > index 231803ceea..a379968618 100644
> > --- a/target/microblaze/mmu.c
> > +++ b/target/microblaze/mmu.c
> > @@ -81,16 +81,16 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
> >   {
> >       unsigned int i, hit = 0;
> >       unsigned int tlb_ex = 0, tlb_wr = 0, tlb_zsel;
> > -    unsigned int tlb_size;
> > -    uint32_t tlb_tag, tlb_rpn, mask, t0;
> > +    uint64_t tlb_tag, tlb_rpn, mask;
> > +    uint32_t tlb_size, t0;
> 
> >       lu->err = ERR_MISS;
> >       for (i = 0; i < ARRAY_SIZE(mmu->rams[RAM_TAG]); i++) {
> > -        uint32_t t, d;
> > +        uint64_t t, d;
> 
> >           /* Lookup and decode.  */
> >           t = mmu->rams[RAM_TAG][i];
> > -        D(qemu_log("TLB %d valid=%d\n", i, t & TLB_VALID));
> > +        D(qemu_log("TLB %d valid=%" PRId64 "\n", i, t & TLB_VALID));
> 
> While touching this it's probably worth updating to use qemu_log_mask with
> the MMU mask instead of the D() macro.


Yeah, I added a follow-up patch to the series that cleans up the
debug/logs in this file. I kept this particular patch as is to
avoid unrelated changes to get mixed into the 64bit conversion.

Cheers,
Edgar
