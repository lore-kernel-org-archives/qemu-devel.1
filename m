Received: from eggs.gnu.org ([2001:4830:134:3::10]:53675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eeZdY-00034e-2e
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eeZdX-0001zs-3j
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:59:44 -0500
From: Liang Li <liliang.opensource@gmail.com>
Date: Thu, 25 Jan 2018 12:59:29 +0800
Message-ID: <20180125045926.GA4720@localhost>
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM
 has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Wed, Jan 24, 2018 at 01:16:39PM -0600, Eric Blake wrote:
> On 01/24/2018 12:17 AM, Liang Li wrote:
> > We found that when doing drive mirror to a low speed shared storage,
> > if there was heavy BLK IO write workload in VM after the 'ready' event,
> > drive mirror block job can't be canceled immediately, it would keep
> > running until the heavy BLK IO workload stopped in the VM. This patch
> > fixed this issue.
> 
> I think you are breaking semantics here.  Libvirt relies on
> 'block-job-cancel' after the 'ready' event to be a clean point-in-time
> snapshot, but that is only possible if there is no out-of-order pending
> I/O at the time the action takes place.  Breaking in the middle of the
> loop, without using bdrv_drain(), risks leaving an inconsistent copy of
> data in the mirror not corresponding to any point-in-time on the source.
> 
> There's ongoing work on adding async mirroring; this may be a better
> solution to the issue you are seeing.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05419.html
> 
Hi Eric,

Thinks for your information, I didn't know libvirt depends on 'block-job-cancel'
for some of the block related operations.

It's seems a new interface should provided by qemu for use case that just
for aborting block job and don't care abort the mirror data integrality, and
libvirt can make use of this new interface.

Do you think this is the right direction?

Liang
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
