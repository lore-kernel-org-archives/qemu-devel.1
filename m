Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqLRK-0003eN-F9
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqLRF-0007vT-Hq
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:51862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eqLRF-0007uw-A8
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:15:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eqLRD-0003Tj-Ar
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 16:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3A59F2E80D8
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 16:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2018 16:08:16 -0000
From: Max Reitz <1751264@bugs.launchpad.net>
Reply-To: Bug 1751264 <1751264@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151939024836.30479.4933664010119224710.malonedeb@gac.canonical.com>
Message-Id: <151966129702.12023.7750287097674366749.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751264] Re: qemu-img convert issue in a tmpfs
 partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

This is a combination of (in our opinion) a bug in tmpfs (...and I think
maybe btrfs as well?), the fact that the vmdk block driver is not very
well optimized, and qemu-img convert assuming that the filesystem works
as it thinks it does or that at least the block driver can work around
this.

So what happens is that qemu-img convert tries to find out which data it
needs to copy.  For this, it queries which parts of the image are
allocated.  This involves querying both the format level (vmdk in this
case) and the protocol level (tmpfs in this case).

Now the vmdk block driver is not very well optimized, so it only allows
querying on cluster boundaries (64 kB by default, as far as I can tell).
qcow2 OTOH allows greater areas (I just created a 512 MB image and it
can query the whole image at once).

So the requests go down to the protocol level.  We expect that to
respond very quickly to an allocation request (the lseek() you are
seeing) -- but tmpfs (and I think btrfs, too) don't do that.  They take
a rather long time.

For an example, the attached program seeks through a file (in 64 kB steps) =
with SEEK_DATA/SEEK_HOLE.  This is what happens:
$ cd /tmp
$ gcc test.c -std=3Dc11 -Wall -Wextra -pedantic -O3
$ qemu-img create -f raw -o preallocation=3Dfalloc empty 512M
$ qemu-img create -f raw -o preallocation=3Dfalloc ~/empty 512M
$ time ./a.out empty
./a.out empty  0,01s user 23,10s system 99% cpu 23,166 total
$ time ./a.out ~/empty
./a.out ~/empty  0,01s user 0,03s system 96% cpu 0,041 total

So there's a huge difference and that is (in my opinion) a bug in tmpfs.

(When converting from qcow2 you don't notice this, because qcow2 allows
performing a single allocation request for the whole image, so it
doesn't matter much whether that's slow.)


There are three ways around this:
(1) tmpfs (and probably btrfs? -- although I can't reproduce it myself righ=
t now) should be fixed.  If they can't tell allocated areas quickly, they s=
hould just report the whole file as allocated.

(2) Our vmdk driver could be optimized.  Sure, but that wouldn't solve
the real issue and someone would have to do it first (and we don't have
a strong interest in this, because all format drivers but qcow2 and raw
are there mainly just for reading other formats and converting them to
qcow2).

(3a) qemu-img convert could poll for allocation information less
insistently.  One way would be to add a switch to disable this behavior
completely and force it to just read everything.  We already have -S 0
which could do this; but just reading all data and then doing zero
detection over it kind of defeats the purpose.  If read() + memcmp() is
faster than lseek(SEEK_DATA), then the FS is just doing something wrong.

(3b) Eric Blake has recently added support for a less insisting way to
query allocation status that should only go to the format layer (e.g.
vmdk) and ignore the protocol layer (e.g. tmpfs).  Maybe qemu-img
convert should use that.


But in any case, I claim the main issue is in tmpfs.

Max

** Attachment added: "test.c"
   https://bugs.launchpad.net/qemu/+bug/1751264/+attachment/5063575/+files/=
test.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751264

Title:
  qemu-img convert issue in a tmpfs partition

Status in QEMU:
  New

Bug description:
  qemu-img convert command is slow when the file to convert is located
  in a tmpfs formatted partition.

  v2.1.0 on debian/jessie x64, ext4: 10m14s
  v2.1.0 on debian/jessie x64, tmpfs: 10m15s

  v2.1.0 on debian/stretch x64, ext4: 11m9s
  v2.1.0 on debian/stretch x64, tmpfs: 10m21.362s

  v2.8.0 on debian/jessie x64, ext4: 10m21s
  v2.8.0 on debian/jessie x64, tmpfs: Too long (50min+)

  v2.8.0 on debian/stretch x64, ext4: 10m42s
  v2.8.0 on debian/stretch x64, tmpfs: Too long (50min+)

  It seems that the issue is caused by this commit :
  https://github.com/qemu/qemu/commit/690c7301600162421b928c7f26fd488fd8fa4=
64e

  In order to reproduce this bug :

  1/ mount a tmpfs partition : mount -t tmpfs tmpfs /tmp
  2/ get a vmdk file (we used a 15GB image) and put it on /tmp
  3/ run the 'qemu-img convert -O qcow2 /tmp/file.vmdk /path/to/destination=
' command

  When we trace the process, we can see that there's a lseek loop which
  is very slow (compare to outside a tmpfs partition).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751264/+subscriptions
