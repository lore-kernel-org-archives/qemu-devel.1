Received: from eggs.gnu.org ([2001:4830:134:3::10]:47772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyfAQ-0002nJ-Us
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyfAQ-0002Q8-33
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:52:11 -0400
Date: Thu, 13 Apr 2017 15:51:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170413135155.GD5095@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
	<w51poggv3xh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51poggv3xh.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.04.2017 um 15:21 hat Alberto Garcia geschrieben:
> This invariant is already broken by the very design of the qcow2 format,
> subclusters don't really add anything new there. For any given cluster
> size you can write 4k in every odd cluster, then do the same in every
> even cluster, and you'll get an equally fragmented image.

Because this scenario has appeared repeatedly in this thread: Can we
please use a more realistic one that shows an actual problem? Because
with 8k or more for the cluster size you don't get any qcow2
fragmentation with 4k even/odd writes (which is a pathological case
anyway), and the file systems are clever enough to cope with it, too.

Just to confirm this experimentally, I ran this short script:

----------------------------------------------------------------
#!/bin/bash
./qemu-img create -f qcow2 /tmp/test.qcow2 64M

echo even blocks
for i in $(seq 0 32767); do echo "write $((i * 8))k 4k"; done | ./qemu-io /tmp/test.qcow2 > /dev/null
echo odd blocks
for i in $(seq 0 32767); do echo "write $((i * 8 + 4))k 4k"; done | ./qemu-io /tmp/test.qcow2 > /dev/null

./qemu-img map /tmp/test.qcow2
filefrag -v /tmp/test.qcow2
----------------------------------------------------------------

And sure enough, this is the output:

----------------------------------------------------------------
Formatting '/tmp/test.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
even blocks
odd blocks
Offset          Length          Mapped to       File
0               0x4000000       0x50000         /tmp/test.qcow2
Filesystem type is: 58465342
File size of /tmp/test.qcow2 is 67436544 (16464 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      47:     142955..    143002:     48:            
   1:       48..      48:     143016..    143016:      1:     143003:
   2:       64..      79:     142868..    142883:     16:     143017:
   3:       80..     111:     155386..    155417:     32:     142884:
   4:      112..     303:     227558..    227749:    192:     155418:
   5:      304..     559:     228382..    228637:    256:     227750:
   6:      560..    1071:     455069..    455580:    512:     228638:
   7:     1072..    2095:     485544..    486567:   1024:     455581:
   8:     2096..    4143:     497978..    500025:   2048:     486568:
   9:     4144..    8239:     508509..    512604:   4096:     500026:
  10:     8240..   16431:     563122..    571313:   8192:     512605:
  11:    16432..   32815:     632969..    649352:  16384:     571314: eof
/tmp/test.qcow2: 12 extents found
----------------------------------------------------------------

That is, on the qcow2 level we have exactly 0% fragmentation, everything
is completely contiguous in a single chunk. XFS as the container of the
test image creates a few more extents, but as you can see, it uses
fairly large extent sizes in the end (and it would use even larger ones
if I wrote more than 64 MB).

Kevin
