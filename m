Received: from eggs.gnu.org ([209.51.188.92]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1X6F-0002tT-Qt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1X6D-0007kn-TE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:00:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45014)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1X6D-0007i8-GL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:00:45 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20190304103353.GA6059@localhost.localdomain>
	<002b01d4d284$3109aa20$931cfe60$@ru>
	<20190305095238.GB5280@dhcp-200-226.str.redhat.com>
	<000901d4d343$3750f8b0$a5f2ea10$@ru>
	<20190305111207.GE5280@dhcp-200-226.str.redhat.com>
	<001201d4d3f7$38e82db0$aab88910$@ru>
	<20190306090927.GA6818@localhost.localdomain>
	<001301d4d3fd$a19b1970$e4d14c50$@ru>
	<20190306092951.GB6818@localhost.localdomain>
	<001401d4d400$2e22fb40$8a68f1c0$@ru>
	<20190306103324.GD6818@localhost.localdomain>
In-Reply-To: <20190306103324.GD6818@localhost.localdomain>
Date: Wed, 6 Mar 2019 17:00:44 +0300
Message-ID: <001901d4d424$fe2a1930$fa7e4b90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v13 19/25] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 06.03.2019 um 10:37 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 06.03.2019 um 10:18 hat Pavel Dovgalyuk geschrieben:
> > > > > Something like:
> > > > >
> > > > > -drive file=null-co://,if=none,id=null -device virtio-blk,drive=null
> > > >
> > > > And this drive should be destination of the copy operations, right?
> > >
> > > I don't know your exact benchmark, but this drive should be where the
> > > high I/O rates are, yes.
> >
> > Ok.
> >
> > > For getting meaningful numbers, you should have I/O only on the fast
> > > test disk (you're talking about a copy, where is source?),
> >
> > We used a qcow2 image as a source.
> 
> So the source is going to slow down the I/O and you won't actually test
> whether the possible maximum changes.
> 
> > > you should
> > > use direct I/O to get the page cache of the guest out of the way, and
> > > you should make sure that multiple requests are issued in parallel.
> >
> > Is this possible, if we have only conventional HDDs?
> 
> null-co:// doesn't access your disk at all, so if this is the only
> virtual disk that has I/O, the conventional HDD doesn't hurt. But you're
> right that you probably can't use your physical disk for high
> performance benchmarks then.
> 
> I'm going to suggest once more to use fio for storage testing. Actually,
> maybe I can find the time to do this myself on my system, too.

We've made some testing with the following fio configs:

[readtest]
blocksize=4k
filename=/dev/vda
rw=randread
direct=1
buffered=0
ioengine=libaio
iodepth=32

[writetest]
blocksize=4k
filename=/dev/vda
rw=randwrite
direct=1
buffered=0
ioengine=libaio
iodepth=32

One with read, one with write, and one with both.

master branch:
1  read : io=1024.0MB, bw=475545KB/s, iops=118886, runt=  2205msec

2  write: io=1024.0MB, bw=445444KB/s, iops=111361, runt=  2354msec

3  read : io=1024.0MB, bw=229850KB/s, iops=57462, runt=  4562msec
   write: io=1024.0MB, bw=227210KB/s, iops=56802, runt=  4615msec

rr branch:
1  read : io=1024.0MB, bw=479021KB/s, iops=119755, runt=  2189msec
2  write: io=1024.0MB, bw=440763KB/s, iops=110190, runt=  2379msec

3  read : io=1024.0MB, bw=230456KB/s, iops=57614, runt=  4550msec
   write: io=1024.0MB, bw=228548KB/s, iops=57136, runt=  4588msec

It seems that the difference can't be measured in our environment.

Pavel Dovgalyuk
