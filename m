Received: from eggs.gnu.org ([2001:4830:134:3::10]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWw3-0004pq-5M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWw2-00071b-Dj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:47:11 -0400
Date: Wed, 23 Aug 2017 15:46:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170823144659.GF16760@stefanha-x1.localdomain>
References: <20170821161539.11066-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821161539.11066-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix hang after server closes
 connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Aug 21, 2017 at 05:15:39PM +0100, Stefan Hajnoczi wrote:
> Commit 72b6ffc76653214b69a94a7b1643ff80df134486 ("nbd-client: Fix
> regression when server sends garbage") improved NBD client behavior when
> the connection enters a broken state.
> 
> The following still does not behave as expected:
> 
>   $ qemu-nbd -p 1234 -x drive0 -f qcow2 test.qcow2
>   $ qemu-system-x86_64 -M accel=kvm -m 1G \
>         -drive if=virtio,id=drive0,file=nbd://localhost:1234/drive0,format=raw
>   $ pkill qemu-nbd
>   (qemu) quit
>   ...hang...
> 
> QEMU should be able to quit even when the connection was previously
> closed by the NBD server.  Currently the nbd_read_reply_entry()
> coroutine terminates without letting in-flight requests know that the
> connection is dead.
> 
> This patch flags the connection as dead so in-flight requests can
> complete.
> 
> Reported-by: Longxiang Lyu <lolyu@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This patch is superceded by "[PATCH] nbd-client: avoid spurious
qio_channel_yield() re-entry".

Stefan
