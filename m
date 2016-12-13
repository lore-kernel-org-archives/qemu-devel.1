Received: from eggs.gnu.org ([2001:4830:134:3::10]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGmlY-0007wm-GP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGmlQ-00054w-N4
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:05:08 -0500
Date: Tue, 13 Dec 2016 21:04:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161213130445.GA22156@lemon>
References: <cover.1481290956.git.berto@igalia.com>
	<468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
	<w51bmwhck1c.fsf@maestria.local.igalia.com>
	<756cfb05-61e1-7ee3-435b-93759438a52d@redhat.com>
	<20161213101635.GC2165@lemon>
	<20161213122900.GA3918@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213122900.GA3918@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 12/13 13:29, Kevin Wolf wrote:
> Am 13.12.2016 um 11:16 hat Fam Zheng geschrieben:
> > On Tue, 12/13 09:02, Max Reitz wrote:
> > > > Yes but the use case is that the qcow2 image is stored in a slow disk,
> > > > so things will be faster if we avoid having to read it too often.
> > > > 
> > > > But the data is there and it needs to be read, so we have three options:
> > > > 
> > > >   1) Read it everytime we need it. It slows things down.
> > > >   2) Keep (part of) it in memory. It can use a lot of memory.
> > > >   3) Keep it in a faster disk.
> > > > 
> > > > We're talking about 3) here, and this it not about creating new
> > > > structures, but about changing the storage backend of the existing L2
> > > > cache (disk rather than RAM).
> > > 
> > > I'm arguing that we already have an on-disk L2 structure and that is called
> > > simply the L1-L2 structure in the qcow2 file. The cache only makes sense
> > > because it is in RAM.
> > 
> > I am looking at this problem from a different angle:
> > 
> > Assume a qcow2 image created by a known version of QEMU with the option
> > preallocation=falloc, it is theoretically possible to do a hacky optimization in
> > qcow2 I/O path that, instead of looking up in L1/L2, we can calculate file
> > offset for any given virtual address, by adding the file offset of LBA 0.
> > 
> > If we make this optimization a header extention and add it to the spec, it is no
> > longer a hack, and it should offer nearly the same performance as raw in all
> > cases - if we say raw is doing "identical mapping" from LBA to file offset, this
> > new operation mode of qcow2 file is basically doing a "shift by constant" mapping.
> 
> Is this a scenario that matters in practice, though? If you want
> performance and you don't need COW functionality, just use raw images to
> begin with.

The intention is actually to combine the advantages of both: external snapshot
can be supported by an allocation status bitmap generated from scanning the
whole L1/L2 table, or even from loading a new type of qcow2 bitmap specifically
for making that efficient.

I share the same doubt as Stefan regarding the on disk format. Modern file
systems support sparse file quite well, so I wonder what advantages are still
there in using L1/L2 tables instead of a simple bitmap, if the user doesn't use
internal snapshot in the first place?

Fam
