Received: from eggs.gnu.org ([2001:4830:134:3::10]:49333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMyXe-0000qC-7o
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMyXb-0004HX-5C
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:56:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMyXa-0004HG-U5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:56:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0123F5FD63
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 15:56:50 +0000 (UTC)
Date: Thu, 7 Dec 2017 17:56:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207175544-mutt-send-email-mst@kernel.org>
References: <20171205174100.GD2405@work-vm>
	<90cb3043-cf68-2635-2dd9-f47cf5e8c10e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90cb3043-cf68-2635-2dd9-f47cf5e8c10e@redhat.com>
Subject: Re: [Qemu-devel] Hotplug ram and vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 07, 2017 at 04:52:18PM +0100, Maxime Coquelin wrote:
> Hi David,
> 
> On 12/05/2017 06:41 PM, Dr. David Alan Gilbert wrote:
> > Hi,
> >    Since I'm reworking the memory map update code I've been
> > trying to test it with hot adding RAM; but even on upstream
> > I'm finding that hot adding RAM causes the guest to stop passing
> > packets with vhost-user-bridge;  have either of you seen the same
> > thing?
> 
> No, I have never tried this.
> 
> > I'm doing:
> > ./tests/vhost-user-bridge -u /tmp/vubrsrc.sock
> > $QEMU -enable-kvm -m 1G,maxmem=2G,slots=4 -smp 2 -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -trace events=vhost-trace-file -chardev socket,id=char0,path=/tmp/vubrsrc.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 $IMAGE -net none
> > 
> > (with a f27 guest) and then doing:
> > (qemu) object_add memory-backend-file,id=mem1,size=256M,mem-path=/dev/shm
> > (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
> > 
> > but then not getting any responses inside the guest.
> > 
> > I can see the code sending another set-mem-table with the
> > extra chunk of RAM and fd, and I think I can see the bridge
> > mapping it.
> 
> I think there are at least two problems.
> The first one is that vhost-user-bridge does not support vhost-user
> protocol's reply-ack feature. So when QEMU sends the requests, it cannot
> know whether/when it has been handled by the backend.
> 
> It had been fixed by sending a GET_FEATURE requests to be sure the
> SET_MEM_TABLE was handled, as messages are processed in order. The problem
> is that it caused some test failures when using TCG, so it got
> reverted.
> 
> The initial fix:
> 
> commit 28ed5ef16384f12500abd3647973ee21b03cbe23
> Author: Prerna Saxena <prerna.saxena@nutanix.com>
> Date:   Fri Aug 5 03:53:51 2016 -0700
> 
>     vhost-user: Attempt to fix a race with set_mem_table.
> 
> The revert:
> 
> commit 94c9cb31c04737f86be29afefbff401cd23bc24d
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Aug 15 16:35:24 2016 +0300
> 
>     Revert "vhost-user: Attempt to fix a race with set_mem_table."

It's a question of stress-testing it and finding out why did
it cause tests fail esp when run within a container.

> 
> Another problem is that memory mmapped with previous call does not seems
> to be unmapped, but that should not cause other problems than leaking
> virtual memory.
> 
> Maxime
> > Dave
> > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
