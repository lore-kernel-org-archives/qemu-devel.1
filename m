Received: from eggs.gnu.org ([2001:4830:134:3::10]:54341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fXcmh-0007c2-HE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fXcme-0007ds-B5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:28:43 -0400
Date: Tue, 26 Jun 2018 07:00:52 +0530
From: Amol Surati <suratiamol@gmail.com>
Message-ID: <20180626013050.GA13519@arch>
References: <20180620042930.24208-1-suratiamol@gmail.com>
	<20180620042930.24208-2-suratiamol@gmail.com>
	<4049a376-e991-91ab-a1ea-037ee7c0a5b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4049a376-e991-91ab-a1ea-037ee7c0a5b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ide/hw/core: fix crash on processing a
 partial-sector-size DMA xfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Amol Surati <suratiamol@gmail.com>, qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>

On Mon, Jun 25, 2018 at 05:10:23PM -0400, John Snow wrote:
> 
> 
> On 06/20/2018 12:29 AM, Amol Surati wrote:
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1777315
> > 
> > QEMU's short PRD policy applies to a DMA transfer of size < 512 bytes.
> > But it fails to consider transfers which are >= 512 bytes, but are
> > not a multiple of 512 bytes.
> > 
> > Such transfers are not subject to the short PRD policy. They end up
> > violating the assumptions about the granularity of the IO sizes,
> > upon which depend the verification of the completion of the previous
> > transfer, and the advancement of the offset in preparation of the next.
> > 
> > Those violations result in the crash.
> > 
> > By forcing each transfer to be a multiple of sector size, such
> > transfers are subjected to the policy, and therefore culled before they
> > cause the crash.
> > 
> 
> So now even if the PRDT we get is greater than a sector is not an even
> multiple of 512, we reject it as too short.

Yes. 

When PRDT is greater than a sector but non an even multiple of 512,
we used to crash. Now we do not.

The reason for this patch is to maintain backward compatibility with the
current split-completion design that QEMU adopts, while still avoiding the
crash. The cover letter has the reasons for this patch.


> 
> That doesn't seem correct to me.

https://github.com/asurati/1777315/blob/master/v2.diff has a different
patch, which aligns with what Kevin had suggested. It allows the
IO which you described above, but then it completes the command
as soon as it detects a partial transfer which is larger than 512.

The patch where s->sg.size is used as the offset to start the next
IO would require the dma IOs to be misaligned and of non-512 sizes.
Will that be okay? 

Else, one needs to change each implementation
of prepare_buf to ensure that it always ALIGNS_UP to the sector
size any partial read/write/trim, in anticipation of the next PRDT
which can cover the difference.


> 
> > Signed-off-by: Amol Surati <suratiamol@gmail.com>
> > ---
> >  hw/ide/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index 2c62efc536..14d135224b 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -836,6 +836,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >  {
> >      IDEState *s = opaque;
> >      int n;
> > +    int32_t size_prepared;
> >      int64_t sector_num;
> >      uint64_t offset;
> >      bool stay_active = false;
> > @@ -886,7 +887,9 @@ static void ide_dma_cb(void *opaque, int ret)
> >      n = s->nsector;
> >      s->io_buffer_index = 0;
> >      s->io_buffer_size = n * 512;
> > -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
> > +    size_prepared = s->bus->dma->ops->prepare_buf(s->bus->dma,
> > +                                                  s->io_buffer_size);
> > +    if (size_prepared <= 0 || size_prepared % 512) {
> >          /* The PRDs were too short. Reset the Active bit, but don't raise an
> >           * interrupt. */
> >          s->status = READY_STAT | SEEK_STAT;
> > 
> 
> -- 
> —js
