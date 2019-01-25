Received: from eggs.gnu.org ([209.51.188.92]:47322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmuYP-0006H1-Pk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmuYN-0005ru-Ui
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:01:25 -0500
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
Date: Fri, 25 Jan 2019 07:01:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190124172323.230296-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-24 18:23, Stefano Garzarella wrote:
> If the WRITE_ZEROES feature is enabled, we check this
> command in the test_basic().
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 04c608764b..8cabbcb85a 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -231,6 +231,69 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
>  
>      guest_free(alloc, req_addr);
>  
> +    if (features & (1u << VIRTIO_BLK_F_WRITE_ZEROES)) {
> +        struct virtio_blk_discard_write_zeroes *dwz_hdr;
> +        void *expected;
> +
> +        /*
> +         * WRITE_ZEROES request on the same sector of previous test where
> +         * we wrote "TEST".
> +         */
> +        req.type = VIRTIO_BLK_T_WRITE_ZEROES;
> +        req.data = g_malloc0(512);

Wouldn't it be more interesting to do a memset(req.data, 0xaa, 512) or
something similar here, to see whether zeroes or 0xaa is written?

> +        dwz_hdr = (struct virtio_blk_discard_write_zeroes *)req.data;
> +        dwz_hdr->sector = 0;
> +        dwz_hdr->num_sectors = 1;
> +        dwz_hdr->flags = 0;
> +
> +        req_addr = virtio_blk_request(alloc, dev, &req, 512);
> +
> +        g_free(req.data);
> +
> +        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
> +        qvirtqueue_add(vq, req_addr + 16, 512, false, true);
> +        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
> +
> +        qvirtqueue_kick(dev, vq, free_head);
> +
> +        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
> +                               QVIRTIO_BLK_TIMEOUT_US);
> +        status = readb(req_addr + 528);
> +        g_assert_cmpint(status, ==, 0);
> +
> +        guest_free(alloc, req_addr);
> +
> +        /* Read request to check if the sector contains all zeroes */
> +        req.type = VIRTIO_BLK_T_IN;
> +        req.ioprio = 1;
> +        req.sector = 0;
> +        req.data = g_malloc0(512);
> +
> +        req_addr = virtio_blk_request(alloc, dev, &req, 512);
> +
> +        g_free(req.data);
> +
> +        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
> +        qvirtqueue_add(vq, req_addr + 16, 512, true, true);
> +        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
> +
> +        qvirtqueue_kick(dev, vq, free_head);
> +
> +        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
> +                               QVIRTIO_BLK_TIMEOUT_US);
> +        status = readb(req_addr + 528);
> +        g_assert_cmpint(status, ==, 0);
> +
> +        data = g_malloc(512);
> +        expected = g_malloc0(512);
> +        memread(req_addr + 16, data, 512);
> +        g_assert_cmpmem(data, 512, expected, 512);
> +        g_free(expected);
> +        g_free(data);
> +
> +        guest_free(alloc, req_addr);
> +    }
> +
>      if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
>          /* Write and read with 2 descriptor layout */
>          /* Write request */
> 
