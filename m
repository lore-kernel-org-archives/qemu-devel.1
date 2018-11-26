Received: from eggs.gnu.org ([2001:4830:134:3::10]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gRPbO-00082Z-9g
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gRPbJ-0005v7-A3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gRPbJ-0005tY-56
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:43:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB941C0050CC
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 22:43:31 +0000 (UTC)
Date: Mon, 26 Nov 2018 17:43:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181126173604-mutt-send-email-mst@kernel.org>
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Nov 26, 2018 at 02:20:38PM +0100, Paolo Bonzini wrote:
> vhost does not have to be supported only if KVM is present, in fact
> vhost-user does not even need any kind of kernel support.  This series
> changes this.  The rationale is that, when vhost-user-test.c will be
> converted to qgraph, it will be able to test vhost-user support
> for virtio-mmio backend even on x86.

The reason for limiting it to KVM was very simple:
it has the same set of problems with ordering
as mttcg.

So I guess it's fine but I think we must then limit it
to when tcg emits fence instructions.

Otherwise we'll get subtle race conditions.



> Paolo Bonzini (5):
>   vhost-net: move stubs to a separate file
>   vhost-net-user: add stubs for when no virtio-net device is present
>   vhost: restrict Linux dependency to kernel vhost
>   vhost-net: compile it on all targets that have virtio-net.
>   vhost-net: revamp configure logic
> 
>  backends/Makefile.objs     |   5 +--
>  configure                  | 101 ++++++++++++++++++++++++++++-----------------
>  default-configs/virtio.mak |   4 +-
>  hw/net/Makefile.objs       |   4 +-
>  hw/net/vhost_net-stub.c    |  95 ++++++++++++++++++++++++++++++++++++++++++
>  hw/net/vhost_net.c         |  78 ++--------------------------------
>  hw/virtio/Makefile.objs    |   5 ++-
>  hw/virtio/vhost-backend.c  |  11 ++++-
>  include/exec/poison.h      |   1 -
>  net/Makefile.objs          |   4 +-
>  net/net.c                  |   2 +-
>  net/vhost-user-stub.c      |  23 +++++++++++
>  tests/Makefile.include     |   5 +--
>  13 files changed, 209 insertions(+), 129 deletions(-)
>  create mode 100644 hw/net/vhost_net-stub.c
>  create mode 100644 net/vhost-user-stub.c
> 
> -- 
> 1.8.3.1
