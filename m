Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7BJ-0006A3-9Q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn6wC-0000WY-No
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:14:49 -0500
Date: Fri, 25 Jan 2019 14:14:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190125135432-mutt-send-email-mst@kernel.org>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
	<5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
	<962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
	<20190125081615.2cevf7cy7bcnxqwh@steredhat>
	<d4aa8b25-f0ad-1444-587c-3d90a8ddc74a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4aa8b25-f0ad-1444-587c-3d90a8ddc74a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 25, 2019 at 09:49:03AM +0100, Thomas Huth wrote:
> On 2019-01-25 09:16, Stefano Garzarella wrote:
> > On Fri, Jan 25, 2019 at 07:07:35AM +0100, Thomas Huth wrote:
> >> On 2019-01-25 07:01, Thomas Huth wrote:
> >>> On 2019-01-24 18:23, Stefano Garzarella wrote:
> >>>> If the WRITE_ZEROES feature is enabled, we check this
> >>>> command in the test_basic().
> >>>>
> >>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>>> ---
> >>>>  tests/virtio-blk-test.c | 63 +++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 63 insertions(+)
> >>>>
> >>>> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> >>>> index 04c608764b..8cabbcb85a 100644
> >>>> --- a/tests/virtio-blk-test.c
> >>>> +++ b/tests/virtio-blk-test.c
> >>>> @@ -231,6 +231,69 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
> >>>>  
> >>>>      guest_free(alloc, req_addr);
> >>>>  
> >>>> +    if (features & (1u << VIRTIO_BLK_F_WRITE_ZEROES)) {
> >>>> +        struct virtio_blk_discard_write_zeroes *dwz_hdr;
> >>>> +        void *expected;
> >>>> +
> >>>> +        /*
> >>>> +         * WRITE_ZEROES request on the same sector of previous test where
> >>>> +         * we wrote "TEST".
> >>>> +         */
> >>>> +        req.type = VIRTIO_BLK_T_WRITE_ZEROES;
> >>>> +        req.data = g_malloc0(512);
> >>>
> >>> Wouldn't it be more interesting to do a memset(req.data, 0xaa, 512) or
> >>> something similar here, to see whether zeroes or 0xaa is written?
> >>
> >> Ah, never mind, I thought req.data would be a sector buffer here, but
> >> looking at the lines below, it apparently is something different.
> >>
> >> Why do you allocate 512 bytes here? I'd rather expect
> >> g_malloc0(sizeof(struct virtio_blk_discard_write_zeroes)) here. ... and
> >> then you could also use a local "struct virtio_blk_discard_write_zeroes
> >> dwz_hdr" variable instead of a pointer, and drop the g_malloc0() completely?
> >>
> > 
> > Hi Thomas,
> > it was my initial implementation, but on the first test I discovered
> > that virtio_blk_request() has an assert on the data_size and it requires
> > a multiple of 512 bytes.
> > Then I looked at the virtio-spec #1, and it seems that data should be
> > multiple of 512 bytes also if it contains the struct
> > virtio_blk_discard_write_zeroes. (I'm not sure)
> > 
> > Anyway I tried to allocate only the space for that struct, commented the
> > assert and the test works well.
> > 
> > How do you suggest to proceed?
> 
> Wow, that's a tough question. Looking at the virtio spec, I agree with
> you, it looks like struct virtio_blk_discard_write_zeroes should be
> padded to 512 bytes here. But when I look at the Linux sources
> (drivers/block/virtio_blk.c), I fail to see that they are doing the
> padding there (but maybe I'm just too blind).
> 
> Looking at the QEMU sources, it seems like it can deal with both and
> always sets the status right behind the last byte:
> 
>     req->in = (void *)in_iov[in_num - 1].iov_base
>               + in_iov[in_num - 1].iov_len
>               - sizeof(struct virtio_blk_inhdr);
> 
> Anyway, I think the virtio spec should be clearer here to avoid bad
> implementations in the future, so maybe Changpeng or Michael could
> update the spec here a little bit?
> 
>  Thomas

I agree the spec makes it look like data is padded to 512 bytes.

I'm happy to write it up but let's decide what it is we want to
support. Arbitrary padding the way qemu does it? Or packed format?

> 
> > [1](https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3944)
> > 
> > 
> > Thanks,
> > Stefano
> > 
