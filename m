Received: from eggs.gnu.org ([2001:4830:134:3::10]:49643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyiKJ-0005ZR-3M
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyiKH-0000S1-Q2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:14:35 -0400
Date: Thu, 13 Apr 2017 19:42:51 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170413164250.GB14317@rkaganb.sw.ru>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
	<w51poggv3xh.fsf@maestria.local.igalia.com>
	<20170413135155.GD5095@noname.redhat.com>
	<w51k26ov1eq.fsf@maestria.local.igalia.com>
	<20170413142735.GF5095@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170413142735.GF5095@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Apr 13, 2017 at 04:27:35PM +0200, Kevin Wolf wrote:
> Am 13.04.2017 um 16:15 hat Alberto Garcia geschrieben:
> > On Thu 13 Apr 2017 03:51:55 PM CEST, Kevin Wolf wrote:
> > >> This invariant is already broken by the very design of the qcow2
> > >> format, subclusters don't really add anything new there. For any
> > >> given cluster size you can write 4k in every odd cluster, then do the
> > >> same in every even cluster, and you'll get an equally fragmented
> > >> image.
> > >
> > > Because this scenario has appeared repeatedly in this thread: Can we
> > > please use a more realistic one that shows an actual problem? Because
> > > with 8k or more for the cluster size you don't get any qcow2
> > > fragmentation with 4k even/odd writes (which is a pathological case
> > > anyway), and the file systems are clever enough to cope with it, too.
> > >
> > > Just to confirm this experimentally, I ran this short script:
> > >
> > > ----------------------------------------------------------------
> > > #!/bin/bash
> > > ./qemu-img create -f qcow2 /tmp/test.qcow2 64M
> > >
> > > echo even blocks
> > > for i in $(seq 0 32767); do echo "write $((i * 8))k 4k"; done | ./qemu-io /tmp/test.qcow2 > /dev/null
> > > echo odd blocks
> > > for i in $(seq 0 32767); do echo "write $((i * 8 + 4))k 4k"; done | ./qemu-io /tmp/test.qcow2 > /dev/null
> > >
> > > ./qemu-img map /tmp/test.qcow2
> > > filefrag -v /tmp/test.qcow2
> > > ----------------------------------------------------------------
> > 
> > But that's because while you're writing on every other 4k block the
> > cluster size is 64k, so you're effectively allocating clusters in
> > sequential order. That's why you get this:
> > 
> > > Offset          Length          Mapped to       File
> > > 0               0x4000000       0x50000         /tmp/test.qcow2
> > 
> > You would need to either have 4k clusters, or space writes even more.
> > 
> > Here's a simpler example, mkfs.ext4 on an empty drive gets you something
> > like this:
> > [...]
> 
> My point wasn't that qcow2 doesn't fragment, but that Denis and you were
> both using a really bad example. You were trying to construct an
> artificially bad image and you actually ended up constructing a perfect
> one.
> 
> > Now, I haven't measured the effect of this on I/O performance, but
> > Denis's point seems in principle valid to me.
> 
> In principle yes, but especially his fear of host file system
> fragmentation seems a bit exaggerated. If I use 64k even/odd writes in
> the script, I end up with a horribly fragmented qcow2 image, but still
> perfectly contiguous layout of the image file in the file system.
> 
> We can and probably should do something about the qcow2 fragmentation
> eventually (I guess a more intelligent cluster allocation strategy could
> go a long way there), but I wouldn't worry to much about the host file
> system.

I beg to disagree.  I didn't have QEMU with subcluster allocation
enabled (you did, didn't you?) so I went ahead with a raw file:

# truncate --size 64k bbb                                                                                                                                                          [14/14]
# filefrag -v bbb
Filesystem type is: ef53
File size of bbb is 65536 (16 blocks of 4096 bytes)
bbb: 0 extents found
# for i in {0..7}; do echo write $[(i * 2) * 4]k 4k; done | qemu-io bbb
...
# for i in {0..7}; do echo write $[(i * 2 + 1) * 4]k 4k; done | qemu-io bbb
...
# filefrag -v bbb
Filesystem type is: ef53
File size of bbb is 65536 (16 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       1:   65860793..  65860794:      2:
   1:        2..       2:   65859644..  65859644:      1:   65860795:
   2:        3..       3:   65859651..  65859651:      1:   65859645:
   3:        4..       4:   65859645..  65859645:      1:   65859652:
   4:        5..       5:   65859652..  65859652:      1:   65859646:
   5:        6..       6:   65859646..  65859646:      1:   65859653:
   6:        7..       7:   65859653..  65859653:      1:   65859647:
   7:        8..       8:   65859647..  65859647:      1:   65859654:
   8:        9..       9:   65859654..  65859654:      1:   65859648:
   9:       10..      10:   65859648..  65859648:      1:   65859655:
  10:       11..      11:   65859655..  65859655:      1:   65859649:
  11:       12..      12:   65859649..  65859649:      1:   65859656:
  12:       13..      13:   65859656..  65859656:      1:   65859650:
  13:       14..      14:   65859650..  65859650:      1:   65859657:
  14:       15..      15:   65859657..  65859657:      1:   65859651: last,eof
bbb: 15 extents found

So the host filesystem did a very poor job here (ext4 on top of two-way
raid0 on top of rotating disks).

Naturally, replacing truncate with fallocate in the above example gives
no fragmenation:

...
# filefrag -v bbb
Filesystem type is: ef53
File size of bbb is 65536 (16 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      15:  183616784.. 183616799:     16:             last,eof
bbb: 1 extent found

Roman.
