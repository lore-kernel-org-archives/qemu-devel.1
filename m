Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3382f85e5=roger.pau@citrix.com>)
	id 1dNdDu-0006Pn-NZ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3382f85e5=roger.pau@citrix.com>)
	id 1dNdDq-0003U6-6R
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:50:58 -0400
Date: Wed, 21 Jun 2017 11:50:47 +0100
From: Roger Pau Monne <roger.pau@citrix.com>
Message-ID: <20170621105047.cbozltc54c5i25hu@dhcp-3-128.uk.xensource.com>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
	<20170620134756.9632-2-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
	<20170621091743.qyhzt52t35y5oxek@dhcp-3-128.uk.xensource.com>
	<29402ff135ee4ce38e97d4f40a63f969@AMSPEX02CL03.citrite.net>
	<1559bb95198848fca36ccc2f911b899c@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1559bb95198848fca36ccc2f911b899c@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize
 feature-persistent if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Wed, Jun 21, 2017 at 11:40:00AM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-
> > bounces+paul.durrant=citrix.com@nongnu.org] On Behalf Of Paul Durrant
> > Sent: 21 June 2017 10:36
> > To: Roger Pau Monne <roger.pau@citrix.com>; Stefano Stabellini
> > <sstabellini@kernel.org>
> > Cc: Kevin Wolf <kwolf@redhat.com>; qemu-block@nongnu.org; qemu-
> > devel@nongnu.org; Max Reitz <mreitz@redhat.com>; Anthony Perard
> > <anthony.perard@citrix.com>; xen-devel@lists.xenproject.org
> > Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize feature-
> > persistent if grant copy is not available
> > 
> > > -----Original Message-----
> > > From: Roger Pau Monne
> > > Sent: 21 June 2017 10:18
> > > To: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Paul Durrant <Paul.Durrant@citrix.com>; xen-
> > devel@lists.xenproject.org;
> > > qemu-devel@nongnu.org; qemu-block@nongnu.org; Anthony Perard
> > > <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>; Max
> > Reitz
> > > <mreitz@redhat.com>
> > > Subject: Re: [PATCH 1/3] xen-disk: only advertize feature-persistent if
> > grant
> > > copy is not available
> > >
> > > On Tue, Jun 20, 2017 at 03:19:33PM -0700, Stefano Stabellini wrote:
> > > > On Tue, 20 Jun 2017, Paul Durrant wrote:
> > > > > If grant copy is available then it will always be used in preference to
> > > > > persistent maps. In this case feature-persistent should not be
> > advertized
> > > > > to the frontend, otherwise it may needlessly copy data into persistently
> > > > > granted buffers.
> > > > >
> > > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > >
> > > > CC'ing Roger.
> > > >
> > > > It is true that using feature-persistent together with grant copies is a
> > > > a very bad idea.
> > > >
> > > > But this change enstablishes an explicit preference of
> > > > feature_grant_copy over feature-persistent in the xen_disk backend. It
> > > > is not obvious to me that it should be the case.
> > > >
> > > > Why is feature_grant_copy (without feature-persistent) better than
> > > > feature-persistent (without feature_grant_copy)? Shouldn't we simply
> > > > avoid grant copies to copy data to persistent grants?
> > >
> > > When using persistent grants the frontend must always copy data from
> > > the buffer to the persistent grant, there's no way to avoid this.
> > >
> > > Using grant_copy we move the copy from the frontend to the backend,
> > > which means the CPU time of the copy is accounted to the backend. This
> > > is not ideal, but IMHO it's better than persistent grants because it
> > > avoids keeping a pool of mapped grants that consume memory and make
> > > the code more complex.
> > >
> > > Do you have some performance data showing the difference between
> > > persistent grants vs grant copy?
> > >
> > 
> > No, but I can get some :-)
> > 
> > For a little background... I've been trying to push throughput of fio running in
> > a debian stretch guest on my skull canyon NUC. When I started out, I was
> > getting ~100MBbs. When I finished, with this patch, the IOThreads one, the
> > multi-page ring one and a bit of hackery to turn off all the aio flushes that
> > seem to occur even if the image is opened with O_DIRECT, I was getting
> > ~960Mbps... which is about line rate for the SSD in the in NUC.
> > 
> > So, I'll force use of persistent grants on and see what sort of throughput I
> > get.
> 
> A quick test with grant copy forced off (causing persistent grants to be used)... My VM is debian stretch using a 16 page shared ring from blkfront. The image backing xvdb is a fully inflated 10G qcow2.
> 
> root@dhcp-237-70:~# fio --randrepeat=1 --ioengine=libaio --direct=0 --gtod_reduce=1 --name=test --filename=/dev/xvdb --bs=512k --iodepth=64 --size=10G --readwrite=randwrite --ramp_time=4
> test: (g=0): rw=randwrite, bs=512K-512K/512K-512K/512K-512K, ioengine=libaio, iodepth=64
> fio-2.16
> Starting 1 process
> Jobs: 1 (f=1): [w(1)] [70.6% done] [0KB/539.4MB/0KB /s] [0/1078/0 iops] [eta 00m:05s]
> test: (groupid=0, jobs=1): err= 0: pid=633: Wed Jun 21 06:26:06 2017
>   write: io=6146.6MB, bw=795905KB/s, iops=1546, runt=  7908msec
>   cpu          : usr=2.07%, sys=34.00%, ctx=4490, majf=0, minf=1
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.3%, >=64=166.9%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
>      issued    : total=r=0/w=12230/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>   WRITE: io=6146.6MB, aggrb=795904KB/s, minb=795904KB/s, maxb=795904KB/s, mint=7908msec, maxt=7908msec
> 
> Disk stats (read/write):
>   xvdb: ios=54/228860, merge=0/2230616, ticks=16/5403048, in_queue=5409068, util=98.26%
> 
> The dom0 cpu usage for the relevant IOThread was ~60%
> 
> The same test with grant copy...
> 
> root@dhcp-237-70:~# fio --randrepeat=1 --ioengine=libaio --direct=0 --gtod_reduce=1 --name=test --filename=/dev/xvdb --bs=512k --iodepth=64 --size=10G --readwrite=randwrite --ramp_time=4
> test: (g=0): rw=randwrite, bs=512K-512K/512K-512K/512K-512K, ioengine=libaio, iodepth=64
> fio-2.16
> Starting 1 process
> Jobs: 1 (f=1): [w(1)] [70.6% done] [0KB/607.7MB/0KB /s] [0/1215/0 iops] [eta 00m:05s]
> test: (groupid=0, jobs=1): err= 0: pid=483: Wed Jun 21 06:35:14 2017
>   write: io=6232.0MB, bw=810976KB/s, iops=1575, runt=  7869msec
>   cpu          : usr=2.44%, sys=37.42%, ctx=3570, majf=0, minf=1
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.3%, >=64=164.6%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
>      issued    : total=r=0/w=12401/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>   WRITE: io=6232.0MB, aggrb=810975KB/s, minb=810975KB/s, maxb=810975KB/s, mint=7869msec, maxt=7869msec
> 
> Disk stats (read/write):
>   xvdb: ios=54/229583, merge=0/2235879, ticks=16/5409500, in_queue=5415080, util=98.27%
> 
> So, higher throughput and iops. The dom0 cpu usage was running at ~70%, so there is definitely more dom0 overhead by using grant copy. The usage of grant copy could probably be improved through since the current code issues an copy ioctl per ioreq. With some batching I suspect some, if not all, of the extra overhead could be recovered.

There's almost always going to be more CPU overhead with grant-copy,
since when using persistent grants QEMU can avoid all (or almost all)
of the ioctls to the grant device.

For the persistent-grants benchmark, did you warm up the grant cache
first? (ie: are those results from a first run of fio?)

In any case, I'm happy to use something different than persistent
grants as long as the performance is similar.

Roger.
