Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFjb-0002JL-Os
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFjX-0006OQ-Nv
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:29:11 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110151934.16883-1-stefanha@redhat.com>
References: <20171110151934.16883-1-stefanha@redhat.com>
Date: Mon, 13 Nov 2017 15:29:05 +0100
Message-ID: <w51d14m9rri.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] throttle-groups: drain before detaching
 ThrottleState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

On Fri 10 Nov 2017 04:19:34 PM CET, Stefan Hajnoczi wrote:
> I/O requests hang after stop/cont commands at least since QEMU 2.10.0
> with -drive iops=100:
>
>   (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>
> This happens because blk_set_aio_context() detaches the ThrottleState
> while requests may still be in flight:
>
>   if (tgm->throttle_state) {
>       throttle_group_detach_aio_context(tgm);
>       throttle_group_attach_aio_context(tgm, new_context);
>   }
>
> This patch encloses the detach/attach calls in a drained region so no
> I/O request is left hanging.  Also add assertions so we don't make the
> same mistake again in the future.

I'm wondering about the implications of this change... is it possible
now to bypass the I/O limits simply by stopping and quickly resuming the
VM? And is that a problem?

Berto
