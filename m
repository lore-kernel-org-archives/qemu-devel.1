Received: from eggs.gnu.org ([2001:4830:134:3::10]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFnwx-0002JS-UP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFnwu-0001aO-Ny
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFnwu-0001Zr-Fm
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:17:52 -0400
Date: Thu, 25 Oct 2018 18:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025181643-mutt-send-email-mst@kernel.org>
References: <20181025140631.634922-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025140631.634922-1-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC 0/2] Attempt to implement the standby feature
 for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Oct 25, 2018 at 05:06:29PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Hi all,
> 
> Background:
> 
> There has been a few attempts to implement the standby feature for vfio
> assigned devices which aims to enable the migration of such devices. This
> is another attempt.
> 
> The series implements an infrastructure for hiding devices from the bus
> upon boot. What it does is the following:
> 
> * In the first patch the infrastructure for hiding the device is added
>   for the qbus and qdev APIs. A "hidden" boolean is added to the device
>   state and it is set based on a callback to the standby device which
>   registers itself for handling the assessment: "should the primary device
>   be hidden?" by cross validating the ids of the devices.
> 
> * In the second patch the virtio-net uses the API to hide the vfio
>   device and unhides it when the feature is acked.
> 
> Disclaimers:
> 
> * I have only scratch tested this and from qemu side, it seems to be
>   working.
> * This is an RFC so it lacks some proper error handling in few cases
>   and proper resource freeing. I wanted to get some feedback first
>   before it is finalized.
> 
> Command line example:
> 
> /home/sameeh/Builds/failover/qemu/x86_64-softmmu/qemu-system-x86_64 \
> -netdev tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_71 \
> -netdev tap,vhost=on,id=hostnet1,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_72,queues=4 \
> -device virtio-net,host_mtu=1500,netdev=hostnet1,id=cc1_72,vectors=10,mq=on,primary=cc1_71 \
> -device e1000,netdev=hostnet0,id=cc1_71,standby=cc1_72 \
> 
> Migration support:
> 
> Pre migration or during setup phase of the migration we should send an
> unplug request to the guest to unplug the primary device. I haven't had
> the chance to implement that part yet but should do soon. Do you know
> what's the best approach to do so? I wanted to have a callback to the
> virtio-net device which tries to send an unplug request to the guest and
> if succeeds then the migration continues. It needs to handle the case where
> the migration fails and then it has to replug the primary device back.
> 
> The following terms are used as interchangeable:
> standby - virtio-net
> primary - vfio-device - physical device - assigned device
> 
> Please share your thoughts and suggestions,
> Thanks!

Didn't have time to look at code yet. Could you test with a VF please?
That's the real test, isn't it?

> Sameeh Jubran (2):
>   qdev/qbus: Add hidden device support
>   virtio-net: Implement VIRTIO_NET_F_STANDBY feature
> 
>  hw/core/qdev.c                 | 48 +++++++++++++++++++++++++---
>  hw/net/virtio-net.c            | 25 +++++++++++++++
>  hw/pci/pci.c                   |  1 +
>  include/hw/pci/pci.h           |  2 ++
>  include/hw/qdev-core.h         | 11 ++++++-
>  include/hw/virtio/virtio-net.h |  5 +++
>  qdev-monitor.c                 | 58 ++++++++++++++++++++++++++++++++--
>  7 files changed, 142 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.0
