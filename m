Received: from eggs.gnu.org ([2001:4830:134:3::10]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cdFUL-0007er-E2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cdFUH-00034K-CI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:12:13 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:49151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cdFUG-00032h-UK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:12:09 -0500
Date: Mon, 13 Feb 2017 13:11:51 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20170213121151.GA31520@olga.wb>
References: <CAMr-obvQ82w5+fuF1Q1pnbWvvp0mFguG8R1uaBV+RDBkKdEwGg@mail.gmail.com>
	<CAMr-obv38E7jmVN4r-UQLoBgk5bBj9ZWWrYts6=12Pkiz62KvA@mail.gmail.com>
	<20170213100430.GA4011@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213100430.GA4011@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-discuss] Converting qcow2 image to raw thin
 lv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-discuss@nongnu.org

On Mon, Feb 13, 2017 at 11:04:30AM +0100, Kevin Wolf wrote:
> Am 12.02.2017 um 01:58 hat Nir Soffer geschrieben:
> > On Sat, Feb 11, 2017 at 12:23 AM, Nir Soffer <nirsof@gmail.com> wrote:
> > > Hi all,
> > >
> > > I'm trying to convert images (mostly qcow2) to raw format on thin lv,
> > > hoping to write only the allocated blocks on the thin lv, but
> > > it seems that qemu-img cannot write sparse image on a block
> > > device.
> > >
> > > (...)
> > 
> > So it seems that qemu-img is trying to write a sparse image.
> > 
> > I tested again with empty file:
> > 
> >     truncate -s 20m empty
> > 
> > Using strace, qemu-img checks the device discard_zeroes_data:
> > 
> >     ioctl(11, BLKDISCARDZEROES, 0)          = 0
> > 
> > Then it find that the source is empty:
> > 
> >     lseek(10, 0, SEEK_DATA)                 = -1 ENXIO (No such device
> > or address)
> > 
> > Then it issues one call
> > 
> >     [pid 10041] ioctl(11, BLKZEROOUT, 0x7f6049c82ba0) = 0
> > 
> > And fsync and close the destination.
> > 
> > # grep -s "" /sys/block/dm-57/queue/discard_*
> > /sys/block/dm-57/queue/discard_granularity:65536
> > /sys/block/dm-57/queue/discard_max_bytes:17179869184
> > /sys/block/dm-57/queue/discard_zeroes_data:0
> > 
> > I wonder why discard_zeroes_data is 0, while discarding
> > blocks seems to zero them.
> > 
> > Seems that this this bug:
> > https://bugzilla.redhat.com/835622
> > 
> > thin lv does promise (by default) to zero new allocated blocks,
> > and it does returns zeros when reading unallocated data, like
> > a sparse file.
> > 
> > Since qemu does not know that the thin lv is not allocated, it cannot
> > skip empty blocks safely.
> > 
> > It would be useful if it had a flag to force sparsness when the
> > user knows that this operation is safe, or maybe we need a thin lvm
> > driver?
> 
> Yes, I think your analysis is correct, I seem to remember that I've seen
> this happen before.
> 
> The Right Thing (TM) to do, however, seems to be fixing the kernel so
> that BLKDISCARDZEROES correctly returns that discard does in fact zero
> out blocks on this device. As soon as this ioctl works correctly,
> qemu-img should just automatically do what you want.
> 
> Now if it turns out it is important to support older kernels without the
> fix, we can think about a driver-specific option for the 'file' driver
> that overrides the kernel's value. But I really want to make sure that
> we use such workarounds only in addition, not instead of doing the
> proper root cause fix in the kernel.
> 
> So can you please bring it up with the LVM people?

I'm not sure it's that easy. The discard granularity of LVM thin is not
equal to their reported block/sector sizes, but to the size of the
chunks they allocate.

  # blockdev --getss /dev/dm-9
  512
  # blockdev --getbsz /dev/dm-9
  4096
  # blockdev --getpbsz /dev/dm-9
  4096
  # cat /sys/block/dm-9/queue/discard_granularity
  131072
  #

I currently don't see qemu using the discard_granularity property for
this purpose. IIRC the code for write_zeroes() eg. simply checks the
discard_zeroes flag but not what size it is trying to zero-out/discard.

We have an experimental semi-complete "can-do-footshooting" 'zeroinit'
filter for this purpose to basically explicitly set the "has_zero_init"
flag and drop "write_zeroes()" calls to blocks at an address greater
than the highest written one up to that point.
It should use a dirty bitmap instead and is sort of dangerous this way
which is why it's not on the qemu-devel list. But if this approach is at
all acceptable (despite being a hack) I could improve it and send it to
the list?
https://github.com/Blub/qemu/commit/6f6f38d2ef8f22a12f72e4d60f8a1fa978ac569a
(you'd just prefix the destination with `zeroinit:` in the qemu-img
command)

Additionally I'm currently still playing with the details and quirks of
various storages (lvm/dm thin, rbd, zvols) in an attempt to create a
tool to convert between various storages. (I did some successful tests
converting disk images between these storages & qcow2 together with
their snapshots in a COW-aware way...) I'm planning on releasing some
experimental code soon-ish (there's still some polishing to do though to
the documentation, the library's API and the format - and the qcow2
support is a patch for qemu-img to use the library.)

My adventures into dm-thin metadata allows me to answer this one though:

> > or maybe we need a thin lvm driver?

Probably not. It does not support SEEK_DATA/SEEK_HOLE and to my
knowledge also has no other sane metadata querying methods. You'd have
to read the metadata device instead. To do this properly you have to
reserve a metadata snapshot and there can only ever be one of those per
pool, which means you could only have 1 such disk in total running on a
system and no other dm-thin metadata aware tool could be used during
that time (otherwise the reserver operations will fail with an error and
qemu would have to wait&retry a lot...).
