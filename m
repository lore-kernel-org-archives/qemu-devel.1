Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJeZ0-0001II-Lc
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJeYv-00037P-OC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:00:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eJeYv-00036t-HB
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:00:29 -0500
Date: Tue, 28 Nov 2017 13:00:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128130012.1466d231.cohuck@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1711281653440.1581@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
	<20171128101154.64b49cb0.cohuck@redhat.com>
	<20171128103757.GD17146@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711281653440.1581@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 28 Nov 2017 16:57:34 +0530 (IST)
P J P <ppandit@redhat.com> wrote:

> +-- On Tue, 28 Nov 2017, Stefan Hajnoczi wrote --+
> | > This is conflating different things:
> | > - vq does not exist (num == 0)
> | > - vq is not setup by the guest (desc == 0)
> | > - vq has no valid alignment (which is only relevant for legacy)
> | 
> | I agree.
> 
> Either case, vq would be unfit for use, no?

What is "unfit for use"?

I'm not quite sure what you want to achieve with this patch. I assume
you want to fix the issue that a guest may provide invalid values for
align etc. which can cause qemu to crash or behave badly.

If so, you need to do different things for the different points above.
- The guest should not muck around with a non-existing queue (num == 0)
  in any case, so this should be fenced for any manipulation triggered
  by the guest.
- Processing a non-setup queue (desc == 0; also applies to the other
  buffers for virtio-1) should be skipped. However, _setting_ desc etc.
  to 0 from the guest is fine (as long as it follows the other
  constraints of the spec).
- Setting alignment to 0 only applies to legacy + virtio-mmio. I would
  not overengineer fencing this. A simple check in update_rings should
  be enough.
