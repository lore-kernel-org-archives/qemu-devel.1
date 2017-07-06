Received: from eggs.gnu.org ([2001:4830:134:3::10]:56101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSuLa-0003RJ-H6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSuLX-0005O9-Ri
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dSuLX-0005Nc-LU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:08:39 -0400
Date: Thu, 6 Jul 2017 03:08:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170706030726-mutt-send-email-mst@kernel.org>
References: <1498617479-5809-1-git-send-email-wei.w.wang@intel.com>
	<20170703220017-mutt-send-email-mst@kernel.org>
	<595B7617.4060203@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595B7617.4060203@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v4] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: jasowang@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com

On Tue, Jul 04, 2017 at 07:03:51PM +0800, Wei Wang wrote:
> On 07/04/2017 03:18 AM, Michael S. Tsirkin wrote:
> > On Wed, Jun 28, 2017 at 10:37:59AM +0800, Wei Wang wrote:
> > > This patch enables the virtio-net tx queue size to be configurable
> > > between 256 (the default queue size) and 1024 by the user when the
> > > vhost-user backend is used.
> > > 
> > > Currently, the maximum tx queue size for other backends is 512 due
> > > to the following limitations:
> > > - QEMU backend: the QEMU backend implementation in some cases may
> > > send 1024+1 iovs to writev.
> > > - Vhost_net backend: there are possibilities that the guest sends
> > > a vring_desc of memory which crosses a MemoryRegion thereby
> > > generating more than 1024 iovs after translation from guest-physical
> > > address in the backend.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > I was going to apply this, but run into a host of issues:
> > 
> > This segfaults:
> > $ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-net,tx_queue_size=1024
> > Segmentation fault (core dumped)
> > 
> > I tried to tweak this code a bit to avoid the crash, and I run into a further issue:
> > $ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-net,tx_queue_size=1024
> > Bad ram offset aa49002
> > Aborted (core dumped)
> > 
> > the second issue is especially concerning.
> > 
> 
> AFAIK, all the virtio-net backends require "-netdev". I'm wondering if there
> is any case that virtio-net can work without a "-netdev" created in QEMU?

Of course. Old style -net with vlans still work.

> If not, would it be better if we just stop the device creation at the
> beginning of
> virtio_net_device_realize() if "-netdev" is not given (i.e.
> !n->nic_conf.peers.ncs[0])?
> 
> Best,
> Wei

That will break a ton of scripts without any real benefit
to users.


-- 
MST
