Received: from eggs.gnu.org ([209.51.188.92]:56548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM7nI-0004WO-Az
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM7my-0007hO-LH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:14:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM7me-0006tM-TI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:13:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so2201415wrr.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:11:59 -0700 (PDT)
Date: Thu, 2 May 2019 11:11:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190502091154.y34h7qvm6ubta632@steredhat>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
	<20190430110918.GF5607@linux.fritz.box>
	<2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

On Tue, Apr 30, 2019 at 10:41:02AM -0500, Eric Blake wrote:
> On 4/30/19 6:09 AM, Kevin Wolf wrote:
> > Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 30.04.2019 12:24, Stefano Garzarella wrote:
> >>> On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >>>> This fixes at least one overflow in qcow2_process_discards, which
> >>>> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> >>>> the past) parameter is int since its introduction in 0b919fae.
> >>>>
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> >>>> -    if (!bs || !bs->drv) {
> >>>> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
> >>>
> >>> Should we describe this change in the commit message?
> >>
> >> Honestly, don't want to resend the series for this.
> > 
> > I haven't reviewed the patches yet, but if this remains the only thing
> > to change, it can be updated while applying the series if we have a
> > specific proposal for a new commit message.
> 
> How about:
> 
> This fixes at least one overflow in qcow2_process_discards, which was
> inadvertently truncating a 64-bit region length to the bdrv_pdiscard
> 'int bytes' parameter (previously bdrv_discard's 'int sectors') since
> its introduction in 0b919fae.
> 
> By inlining the remaining portions of bdrv_check_byte_request() that are
> still independent from the code previously validating a 32-bit request,
> we can drop the call to that function. A request larger than 31 bits (or
> the driver's max discard limit, if specified) is still split into
> smaller chunks by the block layer before reaching the driver.
> 

That sounds good to me!

Thanks,
Stefano
