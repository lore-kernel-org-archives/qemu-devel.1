Received: from eggs.gnu.org ([2001:4830:134:3::10]:42676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAbXp-0003pk-U8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAbXm-0003Em-QR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:25:41 -0400
Date: Tue, 16 May 2017 20:25:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170516122528.GC27669@lemon.lan>
References: <20170516072414.19025-1-famz@redhat.com>
	<20170516080737.GB27669@lemon.lan>
	<e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio: Move memory_listener_unregister
 to .unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 05/16 11:23, Paolo Bonzini wrote:
> 
> 
> On 16/05/2017 10:07, Fam Zheng wrote:
> > On Tue, 05/16 15:24, Fam Zheng wrote:
> >> The root cause of the crash is not obvious here, but the change
> >> regardlessly makes sense so it's proposed here: the listener was
> >> registered in .realize(), so do the cleanup in the matching .unrealize()
> >> rather than the .finalize() callback.
> 
> This is not entirely true.
> 
> Unrealize is the point where the device doesn't get any more requests.
> Instance finalize is the point where there are no references anymore.
> If a pending request has a reference to X, instance finalize is the
> right place to free X.
> 
> However, in this case using .unrealize() should be fine.
> 
> > Actually it seem calling memory_listener_unregister in .instance_finalize is not
> > safe because it can be in the RCU thread.  This race is what caused the
> > corruption of the listener lists.
> 
> RCU callbacks are called with BQL held, so that shouldn't be it.  But
> the patch should be okay anyway.

You are right. Having had another look, I think it's because of this:
VirtIODevice is an embeded member of VirtIOSCSIPCI therefore it is never
"finalized" through QOM reference directly.  Am I right?

Fam
