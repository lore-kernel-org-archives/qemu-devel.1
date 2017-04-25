Received: from eggs.gnu.org ([2001:4830:134:3::10]:38373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2yik-0003ug-EE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2yij-0005rS-6U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d2yij-0005r4-0A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:33:25 -0400
Date: Tue, 25 Apr 2017 13:33:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170425113322.GB4615@noname.redhat.com>
References: <58F92229.1080402@windriver.com>
	<a09762ce-092f-6fb1-6cc3-08a94a3c3dd1@redhat.com>
	<58FA32CC.2060104@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58FA32CC.2060104@windriver.com>
Subject: Re: [Qemu-devel] question about block size and virtual disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Am 21.04.2017 um 18:26 hat Chris Friesen geschrieben:
> On 04/20/2017 03:21 PM, Eric Blake wrote:
> >On 04/20/2017 04:03 PM, Chris Friesen wrote:
> 
> >>Also, does the 4KB block size get "passed-through" to the guest somehow
> >>so that the guest knows it needs to use 4KB blocks, or does that need to
> >>be explicitly specified via virtio-blk-pci.logical_block_size and/or
> >>virtio-blk-pci.physical_block_size parameters?  (Assuming I'm using
> >>virtio-blk-pci.)
> >
> >Again, qemu should be passing the advertisement of host properties down
> >to the guest insofar as possible (so a good guest will see that the
> >hardware is 4k only and will not try to make 512-byte requests), but at
> >the same time, qemu should handle guests that are so old that they are
> >blissfully unaware of the hardware advertisements and send 512-byte
> >requests anyway.  Of course, such guests are penalized with
> >read-modify-write delays when submitting 512-byte IO.  But explicitly
> >stating available parameters is always the wisest course of action, if
> >you don't want to rely on defaults changing underneath you.
> 
> I did an experiment with qemu-kvm-ev-2.6.0-28.el7_3.6.1, using
> -drive cache=none,aio=native and an LVM volume as the storage.
> 
> The guest saw the logical/physical block size as 512B, even though
> on the host both were 4KB.
> 
> Unless something is being lost in the LVM layer (which is possible)
> it appears that qemu defaults to 512B block size unless explicitly
> told otherwise.

Yes, this is the default as it is the most compatible setting (qemu
didn't support 4k sectors initially).

If you know that your guest can handle 4k sectors just fine, it is
recommended to explicitly set both options to 4k to avoid expensive
512 byte sector emulation. If you need to boot from the disk with BIOS,
you won't be able to change the logical block size, but you can still
try setting the physical block size to 4k.

In practice, it shouldn't make too much of a difference because the
OS will work only in complete file system blocks and/or pages, which are
already 4k, so even on a disk with 512 byte sectors, you should mostly
see 4k aligned requests that don't need emulation in qemu.

Kevin
