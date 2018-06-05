Received: from eggs.gnu.org ([2001:4830:134:3::10]:46368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQD7e-0004LM-N7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQD7b-0005F3-GP
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:39:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQD7b-0005Dz-B5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:39:39 -0400
Date: Tue, 5 Jun 2018 17:39:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605173342-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<20180601045824.GH14867@xz-mi> <5B10F412.8050900@intel.com>
	<20180601104005.GL14867@xz-mi> <20180601153328.GC2531@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601153328.GC2531@work-vm>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Fri, Jun 01, 2018 at 04:33:29PM +0100, Dr. David Alan Gilbert wrote:
> I think the answer is no - it doesn't matter; by telling the hypervisor
> the page is 'free' the kernel gives freedom to the hypervisor to
> discard the page contents.

I'd like to call attention to this since it's easy to get confused.

That's not exactly true in the current interface.

It's a *hint* not a guarantee.

Let me explain.

It all starts with a request from hypervisor and each free page report
is matched to a request.  What the report says is that the page was free
*sometime after the request was sent to guest*.  If hypervisor was
tracking changes to page all the time since before sending the request,
it can conclude that page was free and can discard the contents.  If it
wasn't then it can't be sure and can not discard the page, it can maybe
use the hint for other decisions (e.g. unused => should be sent before
other pages).

-- 
MST
