Received: from eggs.gnu.org ([2001:4830:134:3::10]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1d0CPM-000836-2P
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1d0CPK-0005Zz-QL
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:33:56 -0400
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit@kernel.org>) id 1d0CPK-0005YI-KU
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:33:54 -0400
Date: Mon, 17 Apr 2017 21:33:51 +0200
From: Amit Shah <amit@kernel.org>
Message-ID: <20170417193351.GE32063@grmbl.mre>
References: <20170412135312.1686-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412135312.1686-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] migration: fix virtio-rng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On (Wed) 12 Apr 2017 [15:53:10], Laurent Vivier wrote:
> When post-copy migration is enabled, the destination
> guest can ask for memory from the source when the
> vmstate is restored.
> 
> In the case of virtio, a part of the virtqueue
> is migrated by the vmstate structure (last_avail_idx)
> another part is migrated inside the RAM (used_idx).
> On the source side, the virtqueue can be modified
> whereas the vmstate is already migrated, and the destination
> side can ask for the value in RAM. In this case we have
> an inconsistency that can generate this kind of error:
>     "VQ 0 size 0x8 < last_avail_idx 0xa - used_idx 0"
> in hw/virtio/virtio.c:2180, virtio_load().
> 
> This happens with virtio-rng as the chr_read()
> function which modifies the virqueue is called
> by the rng backend and the rng backend continues to
> run while the migration is running and the CPU is stopped.
> 
> This series fixes this problem by ignoring chr_read()
> calls while the CPU is stopped. The first patch of the
> series fixes another problem triggered by this error
> case: a use-after-free case.
> 
> The probability to have this problem is very low, as
> generally the post-copy phase is very short, so the window
> to modify the virtqueue while the vmstate has been sent
> is very small... except if you are doing trans-continental
> guest migration with high latency and post-copy phase that
> can be run for minutes.
> 
> I've been able to reproduce the problem locally on a host,
> by adding network latency with "tc". Another condition is
> to have an rng daemon running in the guest to generate
> events in the virtio-rng device.

Acked-by: Amit Shah <amit@kernel.org>

		Amit
-- 
http://log.amitshah.net/
