Received: from eggs.gnu.org ([209.51.188.92]:43208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1hBbSL-0002mC-Jq
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1hBbSK-0008Bs-Jj
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:41:13 -0400
Received: from forwardcorp1p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b6:217]:34314)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1hBbSK-00089L-5V
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:41:12 -0400
Date: Wed, 3 Apr 2019 11:41:05 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20190403084104.GA12185@dimastep-nix>
References: <20190322130158.GA29843@dimastep-nix>
	<CAFEAcA8ikgEaTiFc4QrctM7ZcBS_GpgGYRoJDK9vax0E-9hbYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ikgEaTiFc4QrctM7ZcBS_GpgGYRoJDK9vax0E-9hbYA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1] exec: check the range in the
 address_space_unmap routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Yakovlev, Evgeny" <wrfsh@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 22, 2019 at 01:35:57PM +0000, Peter Maydell wrote:
> On Fri, 22 Mar 2019 at 13:19, Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > In case of the virtio-blk communication, can get the following assertion
> > for the specifically crafted virtio packet:
> >   qemu-system-x86_64: exec.c:3725: address_space_unmap: Assertion `mr !=
> >   NULL' failed.
> > This assertion is triggered if the length of the first descriptor in the
> > block request chain (block command descriptor) is more than block command
> > size. In this case the hw/block/virtio-blk.c:virtio_blk_handle_request()
> > routine calls the iov_discard_front() function and the iov base and size
> > are changed. As a result the address can not be found during the
> > address_space_unmap() call.
> >
> > The fix is to check the whole address range in the address_space_unmap
> > function.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  exec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/exec.c b/exec.c
> > index 86a38d3..0eeb018 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3717,7 +3717,7 @@ void *address_space_map(AddressSpace *as,
> >  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
> >                           int is_write, hwaddr access_len)
> >  {
> > -    if (buffer != bounce.buffer) {
> > +    if ((buffer < bounce.buffer) || (buffer + access_len > bounce.buffer + bounce.len)) {
> >          MemoryRegion *mr;
> >          ram_addr_t addr1;
> 
> A quick look at the xen_invalidate_map_cache_entry() implementation
> suggests that it also assumes that the address passed to
> address_space_unmap() must be the same address that was
> originally handed out via address_space_map().
Hard to say for me, if it is needed or not, since we have no xen
reproducer for this issue. Right now we are making some fuzzing for the
virtio-blk devices and hit these asserts which are good to fix.

> 
> So I think we either need to also change the Xen code, or
> we need to fix this at the virtio level by having it keep
> track of the buffer it was handed so it can unmap it.
Maybe a fix at virtio level will be better in general, what do you
think?

Thanks, Dima.

> 
> thanks
> -- PMM
