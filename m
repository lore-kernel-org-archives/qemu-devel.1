Received: from eggs.gnu.org ([2001:4830:134:3::10]:33340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNd3V-0002bO-2A
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNd3T-0005ji-LP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:40:13 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 21 Jun 2017 10:40:00 +0000
Message-ID: <1559bb95198848fca36ccc2f911b899c@AMSPEX02CL03.citrite.net>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
	<20170620134756.9632-2-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
	<20170621091743.qyhzt52t35y5oxek@dhcp-3-128.uk.xensource.com>
	<29402ff135ee4ce38e97d4f40a63f969@AMSPEX02CL03.citrite.net>
In-Reply-To: <29402ff135ee4ce38e97d4f40a63f969@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Paul Durrant <Paul.Durrant@citrix.com>, Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Paul Durrant
> Sent: 21 June 2017 10:36
> To: Roger Pau Monne <roger.pau@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>
> Cc: Kevin Wolf <kwolf@redhat.com>; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Max Reitz <mreitz@redhat.com>; Anthony Perard
> <anthony.perard@citrix.com>; xen-devel@lists.xenproject.org
> Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize feature-
> persistent if grant copy is not available
>=20
> > -----Original Message-----
> > From: Roger Pau Monne
> > Sent: 21 June 2017 10:18
> > To: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Paul Durrant <Paul.Durrant@citrix.com>; xen-
> devel@lists.xenproject.org;
> > qemu-devel@nongnu.org; qemu-block@nongnu.org; Anthony Perard
> > <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz
> > <mreitz@redhat.com>
> > Subject: Re: [PATCH 1/3] xen-disk: only advertize feature-persistent if
> grant
> > copy is not available
> >
> > On Tue, Jun 20, 2017 at 03:19:33PM -0700, Stefano Stabellini wrote:
> > > On Tue, 20 Jun 2017, Paul Durrant wrote:
> > > > If grant copy is available then it will always be used in preferenc=
e to
> > > > persistent maps. In this case feature-persistent should not be
> advertized
> > > > to the frontend, otherwise it may needlessly copy data into persist=
ently
> > > > granted buffers.
> > > >
> > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > >
> > > CC'ing Roger.
> > >
> > > It is true that using feature-persistent together with grant copies i=
s a
> > > a very bad idea.
> > >
> > > But this change enstablishes an explicit preference of
> > > feature_grant_copy over feature-persistent in the xen_disk backend. I=
t
> > > is not obvious to me that it should be the case.
> > >
> > > Why is feature_grant_copy (without feature-persistent) better than
> > > feature-persistent (without feature_grant_copy)? Shouldn't we simply
> > > avoid grant copies to copy data to persistent grants?
> >
> > When using persistent grants the frontend must always copy data from
> > the buffer to the persistent grant, there's no way to avoid this.
> >
> > Using grant_copy we move the copy from the frontend to the backend,
> > which means the CPU time of the copy is accounted to the backend. This
> > is not ideal, but IMHO it's better than persistent grants because it
> > avoids keeping a pool of mapped grants that consume memory and make
> > the code more complex.
> >
> > Do you have some performance data showing the difference between
> > persistent grants vs grant copy?
> >
>=20
> No, but I can get some :-)
>=20
> For a little background... I've been trying to push throughput of fio run=
ning in
> a debian stretch guest on my skull canyon NUC. When I started out, I was
> getting ~100MBbs. When I finished, with this patch, the IOThreads one, th=
e
> multi-page ring one and a bit of hackery to turn off all the aio flushes =
that
> seem to occur even if the image is opened with O_DIRECT, I was getting
> ~960Mbps... which is about line rate for the SSD in the in NUC.
>=20
> So, I'll force use of persistent grants on and see what sort of throughpu=
t I
> get.

A quick test with grant copy forced off (causing persistent grants to be us=
ed)... My VM is debian stretch using a 16 page shared ring from blkfront. T=
he image backing xvdb is a fully inflated 10G qcow2.

root@dhcp-237-70:~# fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D0 -=
-gtod_reduce=3D1 --name=3Dtest --filename=3D/dev/xvdb --bs=3D512k --iodepth=
=3D64 --size=3D10G --readwrite=3Drandwrite --ramp_time=3D4
test: (g=3D0): rw=3Drandwrite, bs=3D512K-512K/512K-512K/512K-512K, ioengine=
=3Dlibaio, iodepth=3D64
fio-2.16
Starting 1 process
Jobs: 1 (f=3D1): [w(1)] [70.6% done] [0KB/539.4MB/0KB /s] [0/1078/0 iops] [=
eta 00m:05s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D633: Wed Jun 21 06:26:06 201=
7
  write: io=3D6146.6MB, bw=3D795905KB/s, iops=3D1546, runt=3D  7908msec
  cpu          : usr=3D2.07%, sys=3D34.00%, ctx=3D4490, majf=3D0, minf=3D1
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D0.=
3%, >=3D64=3D166.9%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.1%, >=3D64=3D0.0%
     issued    : total=3Dr=3D0/w=3D12230/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, =
drop=3Dr=3D0/w=3D0/d=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D64

Run status group 0 (all jobs):
  WRITE: io=3D6146.6MB, aggrb=3D795904KB/s, minb=3D795904KB/s, maxb=3D79590=
4KB/s, mint=3D7908msec, maxt=3D7908msec

Disk stats (read/write):
  xvdb: ios=3D54/228860, merge=3D0/2230616, ticks=3D16/5403048, in_queue=3D=
5409068, util=3D98.26%

The dom0 cpu usage for the relevant IOThread was ~60%

The same test with grant copy...

root@dhcp-237-70:~# fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D0 -=
-gtod_reduce=3D1 --name=3Dtest --filename=3D/dev/xvdb --bs=3D512k --iodepth=
=3D64 --size=3D10G --readwrite=3Drandwrite --ramp_time=3D4
test: (g=3D0): rw=3Drandwrite, bs=3D512K-512K/512K-512K/512K-512K, ioengine=
=3Dlibaio, iodepth=3D64
fio-2.16
Starting 1 process
Jobs: 1 (f=3D1): [w(1)] [70.6% done] [0KB/607.7MB/0KB /s] [0/1215/0 iops] [=
eta 00m:05s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D483: Wed Jun 21 06:35:14 201=
7
  write: io=3D6232.0MB, bw=3D810976KB/s, iops=3D1575, runt=3D  7869msec
  cpu          : usr=3D2.44%, sys=3D37.42%, ctx=3D3570, majf=3D0, minf=3D1
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D0.=
3%, >=3D64=3D164.6%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.1%, >=3D64=3D0.0%
     issued    : total=3Dr=3D0/w=3D12401/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, =
drop=3Dr=3D0/w=3D0/d=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D64

Run status group 0 (all jobs):
  WRITE: io=3D6232.0MB, aggrb=3D810975KB/s, minb=3D810975KB/s, maxb=3D81097=
5KB/s, mint=3D7869msec, maxt=3D7869msec

Disk stats (read/write):
  xvdb: ios=3D54/229583, merge=3D0/2235879, ticks=3D16/5409500, in_queue=3D=
5415080, util=3D98.27%

So, higher throughput and iops. The dom0 cpu usage was running at ~70%, so =
there is definitely more dom0 overhead by using grant copy. The usage of gr=
ant copy could probably be improved through since the current code issues a=
n copy ioctl per ioreq. With some batching I suspect some, if not all, of t=
he extra overhead could be recovered.

Cheers,

  Paul

>=20
> Cheers,
>=20
>   Paul
>=20
> > Roger.
