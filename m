Received: from eggs.gnu.org ([2001:4830:134:3::10]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdDUu-0003Xv-Un
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdDUt-0006Tl-9i
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:04:40 -0500
Date: Mon, 13 Feb 2017 11:04:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170213100430.GA4011@noname.redhat.com>
References: <CAMr-obvQ82w5+fuF1Q1pnbWvvp0mFguG8R1uaBV+RDBkKdEwGg@mail.gmail.com>
	<CAMr-obv38E7jmVN4r-UQLoBgk5bBj9ZWWrYts6=12Pkiz62KvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obv38E7jmVN4r-UQLoBgk5bBj9ZWWrYts6=12Pkiz62KvA@mail.gmail.com>
Subject: Re: [Qemu-devel] Converting qcow2 image to raw thin lv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-discuss@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 12.02.2017 um 01:58 hat Nir Soffer geschrieben:
> On Sat, Feb 11, 2017 at 12:23 AM, Nir Soffer <nirsof@gmail.com> wrote:
> > Hi all,
> >
> > I'm trying to convert images (mostly qcow2) to raw format on thin lv,
> > hoping to write only the allocated blocks on the thin lv, but
> > it seems that qemu-img cannot write sparse image on a block
> > device.
> >
> > Here is an example:
> >
> > Create a new thin lv:
> >
> > # lvcreate --name raw-test --virtualsize 20g --thinpool pool0 ovirt-local
> >   Using default stripesize 64.00 KiB.
> >   Logical volume "raw-test" created.
> >
> > [root@voodoo6 ~]# lvs ovirt-local
> >   LV                                   VG          Attr       LSize
> > Pool  Origin Data%  Meta%  Move Log Cpy%Sync Convert
> >   029060ab-41ef-4dfd-9a3e-4c716c01db06 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.74
> >   4f207ee8-bb47-465a-9b68-cb778e070861 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        0.00
> >   7aed605e-c74c-40d8-b449-8a1bf7228b8b ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.98
> >   ce6d08d3-350f-4afa-a0e7-7b492a1a7744 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.87
> >   pool0                                ovirt-local twi-aotz-- 40.00g
> >            10.30  5.49
> >   raw-test                             ovirt-local Vwi-a-tz-- 20.00g
> > pool0        0.00
> >
> > I want to convert this image (fresh fedora 25 installation):
> >
> > # qemu-img info fedora.qcow2
> > image: fedora.qcow2
> > file format: qcow2
> > virtual size: 20G (21474836480 bytes)
> > disk size: 1.3G
> > cluster_size: 65536
> > Format specific information:
> >     compat: 1.1
> >     lazy refcounts: false
> >     refcount bits: 16
> >     corrupt: false
> >
> > Convert the image to raw, into the new thin lv:
> >
> > # qemu-img convert -p -f qcow2 -O raw -t none -T none fedora.qcow2
> > /dev/ovirt-local/raw-test
> >     (100.00/100%)
> >
> > The image size was 1.3G, but now the thin lv is fully allocated:
> >
> > # lvs ovirt-local
> >   LV                                   VG          Attr       LSize
> > Pool  Origin Data%  Meta%  Move Log Cpy%Sync Convert
> >   029060ab-41ef-4dfd-9a3e-4c716c01db06 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.74
> >   4f207ee8-bb47-465a-9b68-cb778e070861 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        0.00
> >   7aed605e-c74c-40d8-b449-8a1bf7228b8b ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.98
> >   ce6d08d3-350f-4afa-a0e7-7b492a1a7744 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.87
> >   pool0                                ovirt-local twi-aotz-- 40.00g
> >            60.30  29.72
> >   raw-test                             ovirt-local Vwi-a-tz-- 20.00g
> > pool0        100.00
> >
> > Recreate the lv:
> >
> > # lvremove -f ovirt-local/raw-test
> >   Logical volume "raw-test" successfully removed
> >
> > # lvcreate --name raw-test --virtualsize 20g --thinpool pool0 ovirt-local
> >   Using default stripesize 64.00 KiB.
> >   Logical volume "raw-test" created.
> >
> > Covert the qcow image to raw sparse file:
> >
> > # qemu-img convert -p -f qcow2 -O raw -t none -T none fedora.qcow2 fedora.raw
> >     (100.00/100%)
> >
> > # qemu-img info fedora.raw
> > image: fedora.raw
> > file format: raw
> > virtual size: 20G (21474836480 bytes)
> > disk size: 1.3G
> >
> > Write the sparse file to the thin lv:
> >
> > # dd if=fedora.raw of=/dev/ovirt-local/raw-test bs=8M conv=sparse
> > 2560+0 records in
> > 2560+0 records out
> > 21474836480 bytes (21 GB) copied, 39.0065 s, 551 MB/s
> >
> > Now we are using only 7.19% of the lv:
> >
> > # lvs ovirt-local
> >   LV                                   VG          Attr       LSize
> > Pool  Origin Data%  Meta%  Move Log Cpy%Sync Convert
> >   029060ab-41ef-4dfd-9a3e-4c716c01db06 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.74
> >   4f207ee8-bb47-465a-9b68-cb778e070861 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        0.00
> >   7aed605e-c74c-40d8-b449-8a1bf7228b8b ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.98
> >   ce6d08d3-350f-4afa-a0e7-7b492a1a7744 ovirt-local Vwi-a-tz-- 20.00g
> > pool0        6.87
> >   pool0                                ovirt-local twi-aotz-- 40.00g
> >            13.89  7.17
> >   raw-test                             ovirt-local Vwi-a-tz-- 20.00g
> > pool0        7.19
> >
> > This works, but it would be nicer to have a way to convert
> > to raw sparse to a block device in one pass.
> 
> So it seems that qemu-img is trying to write a sparse image.
> 
> I tested again with empty file:
> 
>     truncate -s 20m empty
> 
> Using strace, qemu-img checks the device discard_zeroes_data:
> 
>     ioctl(11, BLKDISCARDZEROES, 0)          = 0
> 
> Then it find that the source is empty:
> 
>     lseek(10, 0, SEEK_DATA)                 = -1 ENXIO (No such device
> or address)
> 
> Then it issues one call
> 
>     [pid 10041] ioctl(11, BLKZEROOUT, 0x7f6049c82ba0) = 0
> 
> And fsync and close the destination.
> 
> # grep -s "" /sys/block/dm-57/queue/discard_*
> /sys/block/dm-57/queue/discard_granularity:65536
> /sys/block/dm-57/queue/discard_max_bytes:17179869184
> /sys/block/dm-57/queue/discard_zeroes_data:0
> 
> I wonder why discard_zeroes_data is 0, while discarding
> blocks seems to zero them.
> 
> Seems that this this bug:
> https://bugzilla.redhat.com/835622
> 
> thin lv does promise (by default) to zero new allocated blocks,
> and it does returns zeros when reading unallocated data, like
> a sparse file.
> 
> Since qemu does not know that the thin lv is not allocated, it cannot
> skip empty blocks safely.
> 
> It would be useful if it had a flag to force sparsness when the
> user knows that this operation is safe, or maybe we need a thin lvm
> driver?

Yes, I think your analysis is correct, I seem to remember that I've seen
this happen before.

The Right Thing (TM) to do, however, seems to be fixing the kernel so
that BLKDISCARDZEROES correctly returns that discard does in fact zero
out blocks on this device. As soon as this ioctl works correctly,
qemu-img should just automatically do what you want.

Now if it turns out it is important to support older kernels without the
fix, we can think about a driver-specific option for the 'file' driver
that overrides the kernel's value. But I really want to make sure that
we use such workarounds only in addition, not instead of doing the
proper root cause fix in the kernel.

So can you please bring it up with the LVM people?

Kevin
