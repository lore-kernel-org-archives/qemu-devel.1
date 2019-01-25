Received: from eggs.gnu.org ([209.51.188.92]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmwqb-00075s-IQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmwez-0007Pz-Hw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:16:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmwey-0007Pn-Tu
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:16:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so9268655wrt.7
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 00:16:20 -0800 (PST)
Date: Fri, 25 Jan 2019 09:16:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190125081615.2cevf7cy7bcnxqwh@steredhat>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
	<5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
	<962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 25, 2019 at 07:07:35AM +0100, Thomas Huth wrote:
> On 2019-01-25 07:01, Thomas Huth wrote:
> > On 2019-01-24 18:23, Stefano Garzarella wrote:
> >> If the WRITE_ZEROES feature is enabled, we check this
> >> command in the test_basic().
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  tests/virtio-blk-test.c | 63 +++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>
> >> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> >> index 04c608764b..8cabbcb85a 100644
> >> --- a/tests/virtio-blk-test.c
> >> +++ b/tests/virtio-blk-test.c
> >> @@ -231,6 +231,69 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
> >>  
> >>      guest_free(alloc, req_addr);
> >>  
> >> +    if (features & (1u << VIRTIO_BLK_F_WRITE_ZEROES)) {
> >> +        struct virtio_blk_discard_write_zeroes *dwz_hdr;
> >> +        void *expected;
> >> +
> >> +        /*
> >> +         * WRITE_ZEROES request on the same sector of previous test where
> >> +         * we wrote "TEST".
> >> +         */
> >> +        req.type = VIRTIO_BLK_T_WRITE_ZEROES;
> >> +        req.data = g_malloc0(512);
> > 
> > Wouldn't it be more interesting to do a memset(req.data, 0xaa, 512) or
> > something similar here, to see whether zeroes or 0xaa is written?
> 
> Ah, never mind, I thought req.data would be a sector buffer here, but
> looking at the lines below, it apparently is something different.
> 
> Why do you allocate 512 bytes here? I'd rather expect
> g_malloc0(sizeof(struct virtio_blk_discard_write_zeroes)) here. ... and
> then you could also use a local "struct virtio_blk_discard_write_zeroes
> dwz_hdr" variable instead of a pointer, and drop the g_malloc0() completely?
> 

Hi Thomas,
it was my initial implementation, but on the first test I discovered
that virtio_blk_request() has an assert on the data_size and it requires
a multiple of 512 bytes.
Then I looked at the virtio-spec #1, and it seems that data should be
multiple of 512 bytes also if it contains the struct
virtio_blk_discard_write_zeroes. (I'm not sure)

Anyway I tried to allocate only the space for that struct, commented the
assert and the test works well.

How do you suggest to proceed?


[1](https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3944)


Thanks,
Stefano
