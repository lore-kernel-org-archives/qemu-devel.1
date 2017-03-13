Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnO2q-0006JE-7j
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnO2n-0003iL-3V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cnO2m-0003i9-UB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:21:41 -0400
Date: Mon, 13 Mar 2017 12:21:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170313112132.GB5545@noname.redhat.com>
References: <2e5a75c0-b142-5e23-4314-445385b2cdb6@imatronix.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5a75c0-b142-5e23-4314-445385b2cdb6@imatronix.cl>
Subject: Re: [Qemu-devel] Swap disks virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>
Cc: qemu-devel@nongnu.org

Am 13.03.2017 um 04:42 hat Christopher Pereira geschrieben:
> We are currently providing Linux swap disks with QEMU driver, virtio
> bus and qcow2 type.
> 
> Do you know any alternatives that provide better performance?
> 
> Considering that swap disks contain less critical data, QEMU could
> avoid disk IOs by using unassigned memory whenever possible. This
> could also be handled by the underlying linux filesystem of course.
> Can we tell QEMU to use the linux swap disk for creating a guest
> swap disk? What's the state of the art regarding swap disks
> virtualization?

I think the state of the art is to give the VMs enough memory rather
than making them use a swap disk. If the amount of memory required by
each VM changes dynamically, you can use memory ballooning or hotplug to
increase or decrease the memory size while the VM is running. If you
overcommit the memory, the VMs will automatically be part of the host's
swapping (with all performance implications of swapping, so I think
you'll still want to avoid it on the host, too).

But if you really, really want to use a swap disk in the VM for some
reason, there are three things that I would do:

1. Most importantly, set a good cache mode, cache=unsafe sounds
   perfectly fine here because you're not interested in the state of the
   image after a crash.

2. Consider putting the image on a tmpfs on the host. cache=unsafe will
   already make sure that qemu never forces Linux to write out the data
   in its cache with an fsync() call, but Linux will still do background
   writeouts. With tmpfs, that won't happen. Of course, the downside is
   that you're using actual host memory for it and rely on the host
   kernel to swap out the tmpfs rather than data of host processes,
   which may or may not work out. But I understand that this is more or
   less what you're asking for.

3. You're unlikely to use any interesting features with this image, so
   using raw instead of qcow2 could be possible. Don't expect too much
   here, especially if your qcow2 image is preallocated, but if you can
   use raw, it's always the best performing option.

Even with this, you still have the virtual disk I/O overhead for
accessing the VM's swap space, so it will never be as fast as just
giving the VM more memory.

Kevin
