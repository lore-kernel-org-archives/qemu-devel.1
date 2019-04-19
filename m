Received: from eggs.gnu.org ([209.51.188.92]:45010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcgL-0000WV-NK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcgK-00015L-Fw
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHcgK-00014k-Ag
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so231465qtb.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:12:30 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:12:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190419191210-mutt-send-email-mst@kernel.org>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416184624.15397-1-dan.streetman@canonical.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost-user race condition on shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Streetman <dan.streetman@canonical.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, maxime.coquelin@redhat.com

On Tue, Apr 16, 2019 at 02:46:22PM -0400, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
> 
> Buglink: https://launchpad.net/bugs/1823458

Cc Maxime.


> This is a race condition between the normal shutdown of a guest
> and the handling of its vhost-user net being externally closed.
> It's explained in more detail at the bug link; the short version
> is that there are 2 problems, fixed by the 2 patches.  The first
> patch fixes the race condition where multiple threads call
> vhost_net_stop(), and the second patch prevents vhost-user from
> calling vhost_net_cleanup() on CHR_EVENT_CLOSED, because it will
> be cleaned up later and its fields will be accessed when
> vhost_net_stop() is called later.
> 
> As explained in the bug report, this requires a rather complicated
> setup to reproduce, and I'm not able to create a setup to reproduce
> it myself.  However this has been reported to me/Canonical, and the
> reporter is able to reproduce it consistently, so I've used them for
> debug and testing.  This reproduction was done with the older 2.5
> qemu, from Ubuntu Xenial; but the problem does still appear to exist
> in upstream qemu, based on review of the code, which is why I'm sending
> these patches.
> 
> Dan Streetman (2):
>   add VirtIONet vhost_stopped flag to prevent multiple stops
>   do not call vhost_net_cleanup() on running net from char user event
> 
>  hw/net/virtio-net.c            | 3 ++-
>  include/hw/virtio/virtio-net.h | 1 +
>  net/vhost-user.c               | 1 -
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
