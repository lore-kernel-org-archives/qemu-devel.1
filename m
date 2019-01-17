Received: from eggs.gnu.org ([209.51.188.92]:58224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk7mh-0008Vg-Vj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk7eZ-0007Rn-Ar
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:24:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190116135444.GA16898@stefanha-x1.localdomain>
References: <cover.1547475602.git.berto@igalia.com>
	<20190116135444.GA16898@stefanha-x1.localdomain>
Date: Thu, 17 Jan 2019 14:24:10 +0100
Message-ID: <w51d0ov2z9h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed 16 Jan 2019 02:54:44 PM CET, Stefan Hajnoczi wrote:
> The x-blockdev-set-iothread command is for low-level tests so I don't
> expect users to invoke it.

As I said in a different e-mail maybe this is not necessary then.

> This patch series makes virtio-blk and virtio-scsi more robust,
> although I haven't checked what happens if the drive is attached to a
> different IOThread than the device - will the switchover work?

You mean if you use x-blockdev-set-iothread with a drive and then attach
it to a device using a different thread? That seems to work (with my
patch).

> What I'm unclear about is why fdc, ide, usb-msd, and nvme should worry
> about IOThreads/AioContext in .realize() since they don't support it
> in their data path.  What happens when you submit I/O requests to
> devices configured like this?  I guess they would crash or hit
> assertion failures since they invoke blk_aio_*() APIs from outside the
> appropriate AioContext.
>
> Maybe fdc and friends should forbid this scenario:

Yeah, that seems like a simple solution.

Berto
